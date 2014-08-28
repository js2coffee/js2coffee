Esprima = require('esprima')
{SourceNode} = require("source-map")
Walker = require('./lib/walker.coffee')
{delimit, prependAll} = require('./lib/helpers.coffee')

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
###

js2coffee.parse = (source, options = {}) ->
  ast = Esprima.parse(source, loc: true, range: true, comment: true)

  builder = new Builder(ast, options)
  {code, map} = builder.get()

  {code, ast, map}

###*
# Builder : new Builder(ast, [options])
# (private) Generates output based on a JavaScript AST.
#
#     s = new Builder(ast, {})
#     s.get()
#     => { code: '...', map: { ... } }
###

class Builder extends Walker

  constructor: ->
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

  ###
  # decorator():
  # Takes the output of each of the node visitors and turns them into
  # a SourceNode.
  ###

  decorator: (node, output) ->
    new SourceNode(
      node.loc.start.line,
      node.loc.start.column,
      'input.js',
      output)

  ###
  # onUnknownNode():
  # Invoked when the node is not known. Throw an error.
  ###

  onUnknownNode: (node, ctx) ->
    console.error node
    throw new Error("walk(): No handler for #{ctx?.type}")

  ###
  # visitors:
  # The visitors of each node.
  ###

  Program: (node) ->
    @BlockStatement(node)

  ExpressionStatement: (node) ->
    [ @walk(node.expression), "\n" ]

  AssignmentExpression: (node) ->
    [ @walk(node.left), ' = ', @walk(node.right) ]

  Identifier: (node) ->
    [ node.name ]

  UnaryExpression: (node) ->
    if node.operator is 'void'
      [ node.operator, ' ', @walk(node.argument) ]
    else
      [ node.operator, @walk(node.argument) ]

  # Operator (+)
  BinaryExpression: (node) ->
    [ @walk(node.left), ' ', node.operator, ' ', @walk(node.right) ]

  Literal: (node) ->
    [ node.raw ]

  MemberExpression: (node) ->
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
    callee = @walk(node.callee)
    list = delimit(node.arguments.map(@walk), ', ')

    hasArgs = list.length > 0
    isStatement = ctx.parent.type is 'ExpressionStatement'
      
    if isStatement and hasArgs
      [ callee, ' ', list ]
    else
      [ callee, '(', list, ')' ]

  IfStatement: (node) ->
    alt = node.alternate
    if alt?.type is 'IfStatement'
      els = @indent [ "else ", @walk(node.alternate, 'IfStatement') ]
    else if alt?
      els = @indent (i) => [ i, "else\n", @walk(node.alternate) ]
    else
      els = []

    @indent (i) =>
      test = @walk(node.test)
      consequent = @walk(node.consequent)
      if node.consequent.type isnt 'BlockStatement'
        consequent = @indent(consequent)

      [ 'if ', test, "\n", consequent, els ]

  BlockStatement: (node) ->
    prependAll(node.body.map(@walk), @indent())

  FunctionDeclaration: (node) ->
    params = @toParams(node.params)

    @indent (indent) =>
      [ @walk(node.id), ' = ', params, "->\n", @walk(node.body) ]

  ReturnStatement: (node) ->
    [
      "return ",
      @walk(node.argument),
      "\n"
    ]

  ObjectExpression: (node) ->
    props = @indent =>
      props = node.properties.map(@walk)
      prependAll(props, [ "\n", @indent() ])

    [ "{", props, "\n", @indent(), "}" ]

  Property: (node) ->
    if node.kind isnt 'init'
      throw new Error("Property: not sure about kind " + node.kind)

    [ @walk(node.key), ": ", @walk(node.value) ]

  VariableDeclaration: (node) ->
    node.declarations.map (d) =>
      [ @walk(d.id), ' = ', @walk(d.init), "\n" ]

  FunctionExpression: (node) ->
    params = @toParams(node.params)

    @indent (i) =>
      [ params, "->\n", @walk(node.body) ]

  EmptyStatement: (node) ->
    [ ]

  NewExpression: (node) ->
    callee = if node.callee?.type is 'Identifier'
      [ @walk(node.callee) ]
    else
      [ '(', @walk(node.callee), ')' ]

    args = if node.arguments?.length
      [ '(', delimit(node.arguments.map(@walk), ', '), ')' ]
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

  BreakStatement: (node) ->
    [ "break\n" ]

  ContinueStatement: (node) ->
    [ "continue\n" ]

  DebuggerStatement: (node) ->
    [ "debugger\n" ]

  ThrowStatement: (node) ->
    [ "throw ", @walk(node.argument), "\n" ]

  toParams: (params) ->
    if params.length
      [ '(', delimit(params.map(@walk), ', '), ') ']
    else
      []
