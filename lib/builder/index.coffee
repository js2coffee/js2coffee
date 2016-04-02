{
  prependAll
  quote
  newline
  space
  delimit
  commaDelimit
  toIndent
  joinLines
} = require('../helpers')

TransformerBase = require('../transforms/base')
BuilderBase = require('./base')

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

module.exports =
class Builder extends BuilderBase

  constructor: (ast, options={}) ->
    super
    @_indent = 0

  ###*
  # visitors:
  # The visitors of each node.
  ###

  Program: (node) ->
    @comments = node.comments
    @BlockStatement(node)

  ExpressionStatement: (node) ->
    newline @walk(node.expression)

  AssignmentExpression: (node) ->
    re = @paren space [
      @walk(node.left)
      node.operator
      @walk(node.right)
    ]

    # Space out 'a = ->'
    if node.right.type is 'FunctionExpression'
      re = [ "\n", @indent(), re, "\n" ]

    re

  Identifier: (node) ->
    [ node.name ]

  UnaryExpression: (node) ->
    isNestedUnary = -> node.argument.type is 'UnaryExpression'
    isWord = -> (/^[a-z]+$/i).test(node.operator)

    if isNestedUnary() or isWord()
      @paren [ node.operator, ' ', @walk(node.argument) ]
    else
      @paren [ node.operator, @walk(node.argument) ]

  # Operator (+)
  BinaryExpression: (node) ->
    operator = node.operator
    operator = 'of' if operator is 'in'
    @paren space [ @walk(node.left), operator, @walk(node.right) ]

  Literal: (node) ->
    if typeof node.value is 'string'
      [ quote(node.value) ]
    else
      [ node.raw ]

  MemberExpression: (node) ->
    right = if node.computed
      [ '[', @walk(node.property), ']' ]
    else if node._prefixed
      [ @walk(node.property) ]
    else
      [ '.', @walk(node.property) ]

    @paren [ @walk(node.object), right ]

  LogicalExpression: (node) ->
    opers =
      '||': 'or'
      '&&': 'and'

    oper = opers[node.operator]
    @paren [ @walk(node.left), ' ', oper, ' ', @walk(node.right) ]

  ThisExpression: (node) ->
    if node._prefix
      [ "@" ]
    else
      [ "this" ]

  CallExpression: (node, ctx) ->
    callee = @walk(node.callee)
    list = @makeSequence(node.arguments)
    node._isStatement = ctx.parent.type is 'ExpressionStatement'

    hasArgs = list.length > 0

    if node._isStatement and hasArgs
      space [ callee, list ]
    else
      [ callee, @paren(list, true) ]

  IfStatement: (node) ->
    alt = node.alternate
    if alt?.type is 'IfStatement'
      els = @indent [ "else ", @walk(node.alternate, 'IfStatement') ]
    else if alt?.type is 'BlockStatement'
      els = @indent (i) => [ i, "else", "\n", @walk(node.alternate) ]
    else if alt?
      els = @indent (i) => [ i, "else", "\n", @indent(@walk(node.alternate)) ]
    else
      els = []

    @indent (i) =>
      test = @walk(node.test)
      consequent = @walk(node.consequent)
      if node.consequent.type isnt 'BlockStatement'
        consequent = @indent(consequent)

      word = if node._negative then 'unless' else 'if'

      [ word, ' ', test, "\n", consequent, els ]

  BlockStatement: (node) ->
    @makeStatements(node, node.body)

  makeStatements: (node, body) ->
    walked = body.map(@walk)
    ret = []
    for item, i in walked
      if body[i].type isnt "BlockStatement"
        ret.push @indent()
      ret.push item
    ret

  LineComment: (node) ->
    [ "#", node.value, "\n" ]

  BlockComment: (node) ->
    lines = ('###' + node.value + '###').split("\n")
    output = [ delimit(lines, [ "\n", @indent() ]), "\n" ]

    [ "\n", @indent(), output, "\n" ]

  ReturnStatement: (node) ->
    if node.argument
      space [ "return", [ @walk(node.argument), "\n" ] ]
    else
      [ "return", "\n" ]

  ArrayExpression: (node) ->
    items = node.elements.length
    isSingleLine = items is 1

    if items is 0
      [ "[]" ]
    else if isSingleLine
      space [ "[", node.elements.map(@walk), "]" ]
    else
      @indent (indent) =>
        elements = node.elements.map (e) => newline @walk(e)
        contents = prependAll(elements, @indent())
        [ "[", "\n", contents, indent, "]" ]

  ObjectExpression: (node, ctx) ->
    props = node.properties.length
    isBraced = node._braced

    # Empty
    if props is 0
      [ "{}" ]

    # Single prop ({ a: 2 })
    else if props is 1
      props = node.properties.map(@walk)
      if isBraced
        @paren space [ "{", props, "}" ]
      else
        @paren [ props ]

    # Last expression in scope (`function() { ({a:2}); }`)
    else if node._last
      props = node.properties.map(@walk)
      return delimit(props, [ "\n", @indent() ])

    # Multiple props ({ a: 2, b: 3 })
    else
      props = @indent =>
        props = node.properties.map(@walk)
        [ "\n", joinLines(props, @indent()) ]

      if isBraced
        @paren [ "{", props, "\n", @indent(), "}" ]
      else
        @paren [ props ]

  Property: (node) ->
    if node.kind isnt 'init'
      throw new Error("Property: not sure about kind " + node.kind)

    space [ [@walk(node.key), ":"], @walk(node.value) ]

  # TODO: convert VariableDeclaration into AssignmentExpression
  VariableDeclaration: (node) ->
    declarators = node.declarations.map(@walk)
    delimit(declarators, @indent())

  VariableDeclarator: (node) ->
    re = [ @walk(node.id), ' = ', newline(@walk(node.init)) ]

    # Space out 'a = ->'
    if node.init.type is 'FunctionExpression'
      re = [ "\n", @indent(), re, "\n" ]

    re

  FunctionExpression: (node, ctx) ->
    params = @makeParams(node.params, node.defaults)

    expr = @indent (i) =>
      [ params, "->", "\n", @walk(node.body) ]

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

    @paren [ "new ", callee, args ]

  WhileStatement: (node) ->
    [ "while ", @walk(node.test), "\n", @makeLoopBody(node.body) ]

  CoffeeLoopStatement: (node) ->
    [ "loop", "\n", @makeLoopBody(node.body) ]

  BreakStatement: (node) ->
    [ "break", "\n" ]

  ContinueStatement: (node) ->
    [ "continue", "\n" ]

  DebuggerStatement: (node) ->
    [ "debugger", "\n" ]

  TryStatement: (node) ->
    # block, handler, finalizer
    _try = @indent => [ "try", "\n", @walk(node.block) ]
    _catch = @indent (indent) => [ indent, @walk(node.handler) ]
    _finally = if node.finalizer?
      @indent (indent) => [ indent, "finally", "\n", @walk(node.finalizer) ]
    else
      []

    [ _try, _catch, _finally ]

  CatchClause: (node) ->
    [ "catch ", @walk(node.param), "\n", @walk(node.body) ]

  ThrowStatement: (node) ->
    [ "throw ", @walk(node.argument), "\n" ]

  # Ternary operator (`a ? b : c`)
  ConditionalExpression: (node) ->
    @paren space [
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
    body = @indent => @makeStatements(node, node.cases)
    item = @walk(node.discriminant)

    if node.discriminant.type is 'ConditionalExpression'
      item = [ "(", item, ")" ]

    [ "switch ", item, "\n", body ]

  # Custom node type for comma-separated expressions (`when a, b`)
  CoffeeListExpression: (node) ->
    @makeSequence(node.expressions)

  SwitchCase: (node) ->
    left = if node.test
      [ "when ", @walk(node.test) ]
    else
      [ "else" ]

    right = @indent => @makeStatements(node, node.consequent)

    [ left, "\n", right ]

  ForInStatement: (node) ->
    if node.left.type isnt 'VariableDeclaration'
      id = @walk(node.left)

      # TODO: move this transformation to the lib/transforms/
      propagator = {
        type: 'ExpressionStatement'
        expression: { type: 'CoffeeEscapedExpression', raw: "#{id} = #{id}" }
      }
      node.body.body = [ propagator ].concat(node.body.body)
    else
      id = @walk(node.left.declarations[0].id)

    body = @makeLoopBody(node.body)

    [ "for ", id, " of ", @walk(node.right), "\n", body ]

  makeLoopBody: (body) ->
    isBlock = body?.type is 'BlockStatement'

    # TODO: move this transformation to the lib/transforms/
    if not body or (isBlock and body.body.length is 0)
      @indent => [ @indent(), "continue", "\n" ]
    else if isBlock
      @indent => @walk(body)
    else
      @indent => [ @indent(), @walk(body) ]

  CoffeeEscapedExpression: (node) ->
    if node._parenthesized
      [ '(`', node.raw, '`)' ]
    else
      [ '`', node.raw, '`' ]

  CoffeePrototypeExpression: (node) ->
    if node.computed
      [ @walk(node.object), '::[', @walk(node.property), ']' ]
    else
      [ @walk(node.object), '::', @walk(node.property) ]

  CoffeeDoExpression: (node) ->
    space [ 'do', @walk(node.function) ]
    
  ###*
  # makeSequence():
  # Builds a comma-separated sequence of nodes.
  # TODO: turn this into a transformation
  ###

  makeSequence: (list) ->
    for arg, i in list
      isLast = i is (list.length-1)
      if not isLast
        if arg.type is "FunctionExpression"
          arg._parenthesized = true
        else if arg.type is "ObjectExpression"
          arg._braced = true

    commaDelimit(list.map(@walk))

  ###*
  # makeParams():
  # Builds parameters for a function list.
  ###

  makeParams: (params, defaults) ->
    list = []

    # Account for defaults ("function fn(a = b)")
    for param, i in params
      if defaults[i]
        def = @walk(defaults[i])
        list.push [@walk(param), ' = ', def]
      else
        list.push @walk(param)

    if params.length
      [ '(', delimit(list, ', '), ') ']
    else
      []

  ###*
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
  # Utilities
  ###

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
  # When invoked without arguments, it returns the current indentation as a
  # string.
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
      tab = toIndent(@options.indent)
      Array(@_indent + 1).join(tab)

  ###*
  # paren():
  # Parenthesizes if the node's parenthesize flag is on (or `parenthesized` is
  # true)
  ###

  paren: (output, parenthesized) ->
    parenthesized ?= @path[@path.length-1]?._parenthesized
    isBlock = output.toString().match /\n$/

    if parenthesized
      if isBlock
        [ '(', output, @indent(), ')' ]
      else
        [ '(', output, ')' ]
    else
      output

  ###*
  # onUnknownNode():
  # Invoked when the node is not known. Throw an error.
  ###

  onUnknownNode: (node, ctx) ->
    @syntaxError(node, "#{node.type} is not supported")

  syntaxError: TransformerBase::syntaxError
