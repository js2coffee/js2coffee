Esprima = require('esprima')
{SourceNode} = require("source-map")
Walker = require('./lib/walker.coffee')
{delimit} = require('./lib/helpers.coffee')

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

###
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

  # Indents
  indent: (fn) ->
    if fn
      previous = @indent()
      @_indent += 1
      result = fn(previous)
      @_indent -= 1
      result
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
    node.body.map(@walk)

  ExpressionStatement: (node) ->
    [ @indent(), @walk(node.expression), "\n" ]

  AssignmentExpression: (node) ->
    [ @walk(node.left), ' = ', @walk(node.right) ]

  Identifier: (node) ->
    [ node.name ]

  # Operator (+)
  BinaryExpression: (node) ->
    [ @walk(node.left), ' ', node.operator, ' ', @walk(node.right) ]

  Literal: (node) ->
    [ node.raw ]

  MemberExpression: (node) ->
    [ @walk(node.object), '.', @walk(node.property) ]

  LogicalExpression: (node) ->
    [ @walk(node.left), ' ', node.operator, ' ', @walk(node.right) ]

  ThisExpression: (node) ->
    [ "this" ]

  CallExpression: (node) ->
    list = []
    callee = @walk(node.callee)
    list = delimit(node.arguments.map(@walk), ', ')
      
    [ callee, '(', list, ')' ]

  IfStatement: (node) ->
    @indent (i) =>
      test = @walk(node.test)
      consequent = @walk(node.consequent)
      if node.alternate?
        alternate = @walk(node.alternate)

      if alternate
        [ i, 'if ', test, "\n", consequent, i, "else\n", alternate ]
      else
        [ i, 'if ', test, "\n", consequent ]

  BlockStatement: (node) ->
    node.body.map(@walk)

  FunctionDeclaration: (node) ->
    params = @toParams(node.params)

    @indent (i) =>
      [ i, @walk(node.id), ' = ', params, "->\n", @walk(node.body) ]

  ReturnStatement: (node) ->
    [
      @indent(),
      "return ",
      @walk(node.argument),
      "\n"
    ]

  # everything below is just hastily-made and untested

  UnaryExpression: (node) ->
    [ node.operator, @walk(node.argument) ]

  VariableDeclaration: (node) ->
    node.declarations.map (d) =>
      [ @walk(d.id), ' = ', @walk(d.init), "\n" ]

  ObjectExpression: (node) ->
    [ "{", "...", "}" ]

  FunctionExpression: (node) ->
    params = @toParams(node.params)

    @indent (i) =>
      [ params, "->\n", @walk(node.body) ]

  toParams: (params) ->
    if params.length
      [ '(', delimit(params.map(@walk), ', '), ') ']
    else
      []
