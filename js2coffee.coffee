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
      node.loc.start.line,
      node.loc.start.column,
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
      lineNumber: node.loc.start.line,
      column: node.loc.start.column,
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
    space [ @walk(node.left), '=', @walk(node.right) ]

  Identifier: (node) ->
    [ node.name ]

  UnaryExpression: (node) ->
    if node.operator is 'void'
      [ node.operator, ' ', @walk(node.argument) ]
    else
      [ node.operator, @walk(node.argument) ]

  # Operator (+)
  BinaryExpression: (node) ->
    space [ @walk(node.left), node.operator, @walk(node.right) ]

  Literal: (node) ->
    [ node.raw ]

  MemberExpression: (node) ->
    @parenthesizeObjectIfFunction(node)

    isThis = (node.object.type is 'ThisExpression')
    isIdentifier = (node.property.type is 'Identifier')

    left = if isThis
      [ '@' ]
    else
      [ @walk(node.object) ]

    right = if not isIdentifier
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
    @parenthesizeArguments(node)
    @parenthesizeCallee(node)

    callee = @walk(node.callee)
    list = commaDelimit(node.arguments.map(@walk))

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
    @renderStatements(node, node.body)

  renderStatements: (node, body) ->
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
    params = @toParams(node.params)

    @indent (indent) =>
      [ @walk(node.id), ' = ', params, "->\n", @walk(node.body) ]

  ReturnStatement: (node) ->
    space [
      "return",
      [ @walk(node.argument), "\n" ]
    ]

  ArrayExpression: (node, ctx) ->
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
    isBraced = props > 1 and ctx.parent.type is 'CallExpression' and ctx.parent._isStatement

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
    params = @toParams(node.params)

    expr = @indent (i) =>
      [ params, "->\n", @walk(node.body) ]

    if node._parenthesized
      [ "(", expr, ")" ]
    else
      expr

  EmptyStatement: (node) ->
    [ ]

  NewExpression: (node) ->
    @parenthesizeArguments(node)

    callee = if node.callee?.type is 'Identifier'
      [ @walk(node.callee) ]
    else
      [ '(', @walk(node.callee), ')' ]

    args = if node.arguments?.length
      [ '(', commaDelimit(node.arguments.map(@walk)), ')' ]
    else
      []

    [ "new ", callee, args ]

  WhileStatement: (node) ->
    isLoop = node.test?.type is 'Literal' and node.test?.value is true

    left = if isLoop
      [ "loop" ]
    else
      [ "while ", @walk(node.test) ]
    @indent => [ left, "\n", @walk(node.body) ]

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
    _catch = node.handlers.map(@walk)
    _finally = if node.finalizer?
      @indent => [ "finally\n", @walk(node.finalizer) ]
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
    body = @indent => @renderStatements(node, node.cases)
    [ "switch ", @walk(node.discriminant), "\n", body ]

  SwitchCase: (node) ->
    @removeBreaksFromConsequents(node)

    left = if node.test
      [ "when ", @walk(node.test) ]
    else
      [ "else" ]

    right = @indent => @renderStatements(node, node.consequent)

    [ left, "\n", right ]

  toParams: (params) ->
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
    newComments = comments.filter (c) ->
      c.range[0] >= left and c.range[1] <= item.range[0]
    list = list.concat(newComments)
    list.push item
    left = item.range[1]
  list
