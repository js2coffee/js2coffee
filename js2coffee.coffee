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
# Builder : new Stringifier(ast, [options])
# (private) Generates output based on a JavaScript AST.
#
#     s = new Stringifier(ast, {})
#     s.get()
#     => { code: '...', map: { ... } }
###

class Builder extends Walker

  constructor: ->
    super
    @_indent = 0

  addIndent: (fn) ->
    previous = @indent()
    @_indent += 1
    result = fn(previous)
    @_indent -= 1
    result

  indent: ->
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

  onUnknownNode: (node) ->
    console.error node
    throw new Error("walk(): No handler for #{node?.type}")

  ###
  # visitors:
  # The visitors of each node.
  ###

  visitors:
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

    CallExpression: (node) ->
      list = []
      callee = @walk(node.callee)
      list = delimit(node.arguments.map(@walk), ', ')
        
      [ callee, '(', list, ')' ]

    IfStatement: (node) ->
      i = @indent()
      @addIndent =>
        [
          i,
          'if ',
          @walk(node.test),
          "\n",
          @walk(node.consequent)
        ]

    BlockStatement: (node) ->
      node.body.map(@walk)

    FunctionDeclaration: (node) ->
      params =
        if node.params.length
          [ '(', delimit(node.params.map(@walk), ', '), ') ']
        else
          []

      i = @indent()
      @addIndent =>
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

    LogicalExpression: (node) ->
      [ @walk(node.left), ' ', node.operator, ' ', @walk(node.right) ]

    ThisExpression: (node) ->
      [ "this" ]

    VariableDeclaration: (node) ->
      node.declarations.map (d) =>
        [ @walk(d.id), ' = ', @walk(d.init), "\n" ]

    ObjectExpression: (node) ->
      [ "{", "...", "}" ]

    FunctionExpression: (node) ->
      @addIndent =>
        [ "->\n", @walk(node.body) ]
