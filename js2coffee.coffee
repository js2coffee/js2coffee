Esprima = require('esprima')
{SourceNode} = require("source-map")
Walker = require('./lib/walker.coffee')
{
  buildError
  commaDelimit
  delimit
  newline
  prependAll
  space
} = require('./lib/helpers.coffee')

###*
# js2coffee() : js2coffee(source, [options])
# Converts to code.
#
#     output = js2coffee.parse('alert("hi")');
#     output;
#     => 'alert "hi"'
###

module.exports = js2coffee = (source, options) ->
  js2coffee.parse(source, options).code

###*
# parse() : js2coffee.parse(source, [options])
# Parses.
#
#     output = js2coffee.parse('a = 2', {});
#
#     output.code
#     output.ast
#     output.map
#
# All options are optional. Available options are:
#
# ~ filename (String): the filename, used in source maps and errors.
###

js2coffee.parse = (source, options = {}) ->
  options.filename ?= 'input.js'
  options.source = source

  try
    ast = Esprima.parse(source, loc: true, range: true, comment: true)
  catch err
    throw buildError(err, source, options.filename)

  builder = new Builder(ast, options)
  {code, map} = builder.get()

  {code, ast, map}

###*
# Builder : new Builder(ast, [options])
# Generates output based on a JavaScript AST.
#
#     s = new Builder(ast, { filename: 'input.js', source: '...' })
#     s.get()
#     => { code: '...', map: { ... } }
#
# The params `options` and `source` are optional. The source code is used to
# generate meaningful errors.
###

class Builder extends Walker

  constructor: (ast, options={}) ->
    super
    @_indent = 0

  ###*
  # indent():
  # Indentation utility with 3 different functions.
  #
  # - `@indent(-> ...)` - adds an indent level.
  # - `@indent([ ... ])` - adds indentation.
  # - `@indent()` - returns the current indent level as a string.
  #
  # When invoked with a function, the indentation level is increased by 1, and
  # the function is invoked. This is similar to escodegen's `withIndent`.
  #
  #     @indent =>
  #       [ '...' ]
  #
  # The past indent level is passed to the function as the first argument.
  #
  #     @indent (indent) =>
  #       [ indent, 'if', ... ]
  #
  # When invoked with an array, it will indent it.
  #
  #     @indent [ 'if...' ]
  #     #=> [ '  ', [ 'if...' ] ]
  #
  # When invoked without arguments, it returns the current indentation as a string.
  #
  #     @indent()
  ###

  indent: (fn) ->
    if typeof fn is "function"
      previous = @indent()
      @_indent += 1
      result = fn(previous)
      @_indent -= 1
      result
    else if fn
      [ @indent(), fn ]
    else
      Array(@_indent + 1).join("  ")

  ###*
  # get():
  # Returns the output of source-map.
  ###

  get: ->
    @run().toStringWithSourceMap()

  ###*
  # decorator():
  # Takes the output of each of the node visitors and turns them into
  # a `SourceNode`.
  ###

  decorator: (node, output) ->
    new SourceNode(
      node?.loc?.start?.line,
      node?.loc?.start?.column,
      @options.filename,
      output)

  ###*
  # onUnknownNode():
  # Invoked when the node is not known. Throw an error.
  ###

  onUnknownNode: (node, ctx) ->
    @syntaxError(node, "#{ctx?.type} is not supported")

  ###*
  # syntaxError():
  # Throws a syntax error for the given `node`.
  #
  #     @syntaxError node, "Not supported"
  ###

  syntaxError: (node, description) ->
    err = buildError({
      lineNumber: node.loc?.start?.line,
      column: node.loc?.start?.column,
      description: description
    }, @options.source, @options.filename)
    throw err

  ###
  # visitors:
  # The visitors of each node.
  ###

  Program: (node) ->
    @comments = node.comments
    @BlockStatement(node)

  ExpressionStatement: (node) ->
    newline @walk(node.expression)

  AssignmentExpression: (node) ->
    space [ @walk(node.left), node.operator, @walk(node.right) ]

  Identifier: (node) ->
    if node.name is 'undefined'
      [ '`undefined`' ]
    else
      [ node.name ]

  UnaryExpression: (node) ->
    if node.operator is 'void'
      [ 'undefined' ]
    else if (/^[a-z]+$/i).test(node.operator)
      [ node.operator, ' ', @walk(node.argument) ]
    else
      [ node.operator, @walk(node.argument) ]

  # Operator (+)
  BinaryExpression: (node) ->
    dict =
      '===': '=='
      '!==': '!='
    op = node.operator
    if dict[op] then op = dict[op]

    space [ @walk(node.left), op, @walk(node.right) ]

  Literal: (node) ->
    [ node.raw ]

  MemberExpression: (node) ->
    @parenthesizeObjectIfFunction(node)

    isThis = (node.object.type is 'ThisExpression')

    left = if isThis
      [ '@' ]
    else
      [ @walk(node.object) ]

    right = if node.computed
      [ '[', @walk(node.property), ']' ]
    else if isThis
      [ @walk(node.property) ]
    else
      [ '.', @walk(node.property) ]

    [ left, right ]

  LogicalExpression: (node) ->
    [ @walk(node.left), ' ', node.operator, ' ', @walk(node.right) ]

  ThisExpression: (node) ->
    [ "this" ]

  CallExpression: (node, ctx) ->
    @parenthesizeCallee(node)

    callee = @walk(node.callee)
    list = @makeSequence(node.arguments)

    hasArgs = list.length > 0
    node._isStatement = ctx.parent.type is 'ExpressionStatement'

    if node._isStatement and hasArgs
      space [ callee, list ]
    else
      [ callee, '(', list, ')' ]

  IfStatement: (node) ->
    alt = node.alternate
    if alt?.type is 'IfStatement'
      els = @indent [ "else ", @walk(node.alternate, 'IfStatement') ]
    else if alt?.type is 'BlockStatement'
      els = @indent (i) => [ i, "else\n", @walk(node.alternate) ]
    else if alt?
      els = @indent (i) => [ i, "else\n", @indent(@walk(node.alternate)) ]
    else
      els = []

    @indent (i) =>
      test = @walk(node.test)
      consequent = @walk(node.consequent)
      if node.consequent.type isnt 'BlockStatement'
        consequent = @indent(consequent)

      [ 'if ', test, "\n", consequent, els ]

  BlockStatement: (node) ->
    @makeStatements(node, node.body)

  makeStatements: (node, body) ->
    body = injectComments(@comments, node, body)
    prependAll(body.map(@walk), @indent())

  # Line comments
  Line: (node) ->
    [ "#", node.value, "\n" ]

  # Block comments
  Block: (node) ->
    lines = node.value.split("\n")
    lines = lines.map (line, i) ->
      isTrailingSpace = i is lines.length-1 and line.match(/^\s*$/)
      isSingleLine = i is 0 and lines.length is 1

      if isTrailingSpace
        ''
      else if isSingleLine
        line
      else
        line = line.replace(/^ \*/, '#')
        line + "\n"
    [ "###", lines, "###\n" ]

  FunctionDeclaration: (node) ->
    params = @makeParams(node.params)

    @indent (indent) =>
      [ @walk(node.id), ' = ', params, "->\n", @walk(node.body) ]

  ReturnStatement: (node) ->
    if node.argument
      if node.argument.type is 'ObjectExpression'
        node.argument._braced = true

      space [
        "return",
        [ @walk(node.argument), "\n" ]
      ]
    else
      [ "return\n" ]

  parenthesizeObjectsInElements: (node) ->
    for item in node.elements
      if item.type is 'ObjectExpression'
        item._braced = true

  ArrayExpression: (node, ctx) ->
    @parenthesizeObjectsInElements(node)
    items = node.elements.length
    isSingleLine = items is 1

    if items is 0
      [ "[]" ]
    else if isSingleLine
      space [ "[", node.elements.map(@walk), "]" ]
    else
      @indent (indent) =>
        prefix = [ "\n", @indent() ]
        contents = prependAll(node.elements.map(@walk), prefix)
        [ "[", contents, "\n", indent, "]" ]

  ObjectExpression: (node, ctx) ->
    props = node.properties.length
    isBraced = node._braced or
      (props > 1 and
      ctx.parent.type is 'CallExpression' and
      ctx.parent._isStatement)

    # Empty
    if props is 0
      [ "{}" ]

    # Simple ({ a: 2 })
    else if props is 1
      props = node.properties.map(@walk)
      if isBraced
        space [ "{", props, "}" ]
      else
        [ props ]

    else
      props = @indent =>
        props = node.properties.map(@walk)
        prependAll(props, [ "\n", @indent() ])

      if isBraced
        [ "{", props, "\n", @indent(), "}" ]
      else
        [ props ]

  Property: (node) ->
    if node.kind isnt 'init'
      throw new Error("Property: not sure about kind " + node.kind)

    space [ [@walk(node.key), ":"], @walk(node.value) ]

  VariableDeclaration: (node) ->
    declarators = node.declarations.map(@walk)
    delimit(declarators, @indent())

  VariableDeclarator: (node) ->
    init = if node.init?
      @walk(node.init)
    else
      "undefined"

    [ @walk(node.id), ' = ', init, "\n" ]

  FunctionExpression: (node, ctx) ->
    params = @makeParams(node.params)

    expr = @indent (i) =>
      [ params, "->\n", @walk(node.body) ]

    if node._parenthesized
      [ "(", expr, @indent(), ")" ]
    else
      expr

  EmptyStatement: (node) ->
    [ ]

  SequenceExpression: (node) ->
    exprs = node.expressions.map (expr) =>
      [ @walk(expr), "\n" ]

    delimit(exprs, @indent())

  NewExpression: (node) ->
    callee = if node.callee?.type is 'Identifier'
      [ @walk(node.callee) ]
    else
      [ '(', @walk(node.callee), ')' ]

    args = if node.arguments?.length
      [ '(', @makeSequence(node.arguments), ')' ]
    else
      []

    [ "new ", callee, args ]

  WhileStatement: (node) ->
    isLoop = node.test?.type is 'Literal' and node.test?.value is true

    looper = if isLoop
      [ "loop" ]
    else
      [ "while ", @walk(node.test) ]

    [ looper, "\n", @makeLoopBody(node.body) ]

  DoWhileStatement: (node) ->
    @indent =>
      breaker = @indent [ "break unless ", @walk(node.test), "\n" ]
      [ "loop", "\n", @walk(node.body), breaker ]

  BreakStatement: (node) ->
    [ "break\n" ]

  ContinueStatement: (node) ->
    [ "continue\n" ]

  DebuggerStatement: (node) ->
    [ "debugger\n" ]

  TryStatement: (node) ->
    # block, guardedHandlers, handlers [], finalizer
    _try = @indent => [ "try\n", @walk(node.block) ]
    _catch = prependAll(node.handlers.map(@walk), @indent())
    _finally = if node.finalizer?
      @indent (indent) => [ indent, "finally\n", @walk(node.finalizer) ]
    else
      []

    [ _try, _catch, _finally ]

  CatchClause: (node) ->
    @indent => [ "catch ", @walk(node.param), "\n", @walk(node.body) ]

  ThrowStatement: (node) ->
    [ "throw ", @walk(node.argument), "\n" ]

  WithStatement: (node) ->
    @syntaxError node, "'with' is not supported in CoffeeScript"

  LabeledStatement: (node, ctx) ->
    if ctx.parent?.type is 'BlockStatement'
      @syntaxError node, "Labeled statements are not supported (wrap your JSON in parentheses)"
    else
      @syntaxError node, "Labeled statements are not supported in CoffeeScirpt"

  # Ternary operator (`a ? b : c`)
  ConditionalExpression: (node) ->
    space [
      "if", @walk(node.test),
      "then", @walk(node.consequent),
      "else", @walk(node.alternate)
    ]

  # Increment (`a++`)
  UpdateExpression: (node) ->
    if node.prefix
      [ node.operator, @walk(node.argument) ]
    else
      [ @walk(node.argument), node.operator ]

  SwitchStatement: (node) ->
    @consolidateCases(node)
    body = @indent => @makeStatements(node, node.cases)
    item = @walk(node.discriminant)

    if node.discriminant.type is 'ConditionalExpression'
      item = [ "(", item, ")" ]

    [ "switch ", item, "\n", body ]

  # Custom node type for comma-separated expressions (`when a, b`)
  CoffeeListExpression: (node) ->
    @makeSequence(node.expressions)

  SwitchCase: (node) ->
    @removeBreaksFromConsequents(node)

    left = if node.test
      [ "when ", @walk(node.test) ]
    else
      [ "else" ]

    right = @indent => @makeStatements(node, node.consequent)

    [ left, "\n", right ]

  ForStatement: (node) ->
    # init, test, update, body
    @injectUpdateIntoBody(node)

    body = @makeLoopBody(node.body)

    init = if node.init
      [ @walk(node.init), "\n", @indent() ]
    else
      []

    looper = if node.test
      [ "while ", @walk(node.test), "\n" ]
    else
      [ "loop", "\n" ]

    [ init, looper, body ]

  ForInStatement: (node) ->
    if node.left.type isnt 'VariableDeclaration'
      # @syntaxError node, "Using 'for..in' loops without 'var' can produce unexpected results"
      node.left.name += '_'
      id = @walk(node.left)
      propagator = { type: 'CoffeeEscapedExpression', value: "#{id} = #{id}_" }
      node.body.body = [ propagator ].concat(node.body.body)
    else
      id = @walk(node.left.declarations[0].id)

    body = @makeLoopBody(node.body)

    [ "for ", id, " of ", @walk(node.right), "\n", body ]

  makeLoopBody: (body) ->
    isBlock = body?.type is 'BlockStatement'
    if not body or (isBlock and body.body.length is 0)
      @indent => [ @indent(), "continue\n" ]
    else if isBlock
      @indent => @walk(body)
    else
      @indent => [ @indent(), @walk(body) ]

  CoffeeEscapedExpression: (node) ->
    [ '`', node.value, '`' ]

  ###*
  # makeSequence():
  # Builds a comma-separated sequence of nodes.
  ###

  makeSequence: (list) ->
    for arg, i in list
      isLast = i is (list.length-1)
      if arg.type is "FunctionExpression"
        if not isLast
          arg._parenthesized = true

    commaDelimit(list.map(@walk))

  ###*
  # makeParams():
  # Builds parameters for a function list.
  ###

  makeParams: (params) ->
    if params.length
      [ '(', delimit(params.map(@walk), ', '), ') ']
    else
      []

  ###
  # Removes `break` statements from consequents in a switch case.
  # (eg, `case x: a(); break;` gets break; removed)
  ###

  removeBreaksFromConsequents: (node) =>
    if node.test
      idx = node.consequent.length-1
      last = node.consequent[idx]
      if last?.type is 'BreakStatement'
        delete node.consequent[idx]
        node.consequent.length -= 1
      else if last?.type isnt 'ReturnStatement'
        @syntaxError node, "No break or return statement found in a case"

  ###
  # In an IIFE, ensure that the function expression is parenthesized (eg,
  # `(($)-> x) jQuery`).
  ###

  parenthesizeCallee: (node) ->
    if node.callee.type is 'FunctionExpression'
      node.callee._parenthesized = true

  ###
  # In a call expression, ensure that non-last function arguments get
  # parenthesized (eg, `setTimeout (-> x), 500`).
  ###

  parenthesizeArguments: (node) ->
    for arg, i in node.arguments
      isLast = i is (node.arguments.length-1)
      if arg.type is "FunctionExpression"
        if not isLast
          arg._parenthesized = true

  ###
  # Parenthesize function expressions if they're in the left-hand side of a
  # member expression (eg, `(-> x).toString()`).
  ###

  parenthesizeObjectIfFunction: (node) ->
    if node.object.type is 'FunctionExpression'
      node.object._parenthesized = true

  ###
  # Injects a ForStatement's update (eg, `i++`) into the body.
  ###

  injectUpdateIntoBody: (node) ->
    if node.update
      statement =
        type: 'ExpressionStatement'
        expression: node.update
      node.body ?= { type: 'BlockStatement', body: [] }
      node.body.body = node.body.body.concat([statement])
      delete node.update

  consolidateCases: (node) ->
    list = []
    toConsolidate = []
    for case_, i in node.cases
      # .type .test .consequent
      toConsolidate.push(case_.test) if case_.test
      if case_.consequent.length > 0
        if case_.test
          case_.test = { type: 'CoffeeListExpression', expressions: toConsolidate }
        toConsolidate = []
        list.push case_

    node.cases = list

###
# injectComments():
# Injects comment nodes into a node list.
###

injectComments = (comments, node, body) ->
  range = node.range
  list = []
  left = range[0]
  right = range[1]

  # look for comments in left..node.range[0]
  for item, i in body
    if item.range
      newComments = comments.filter (c) ->
        c.range[0] >= left and c.range[1] <= item.range[0]
      list = list.concat(newComments)

    list.push item

    if item.range
      left = item.range[1]
  list
