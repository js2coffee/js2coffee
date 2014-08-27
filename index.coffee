esprima = require('esprima')
SourceNode = require("source-map").SourceNode
Walker = require('./lib/walker')

###
# Generates output based on a JavaScript AST.
#
#     s = new Stringifier(ast, {})
#     s.get()
#     => { code: '...', map: { ... } }
###

class Stringifier extends Walker
  get: ->
    @run().toStringWithSourceMap()

  ###
  # decorator():
  # (private) takes the output of each of the node visitors and turns them into
  # a SourceNode.
  ###

  decorator: (node, output) ->
    new SourceNode(
      node.loc.start.line,
      node.loc.start.column,
      'input.js',
      output)

  nodes:
    # A file
    Program: (node) ->
      node.body.map(@walk)

    # Assignment (a = b)
    AssignmentExpression: (node) ->
      [@walk(node.left), ' = ', @walk(node.right)]

    # A statement that ends in a semicolon
    ExpressionStatement: (node) ->
      [@walk(node.expression), "\n"]

    # variable identifier
    Identifier: (node) ->
      [node.name]

    # Operator (+)
    # (.left, .operator, .right)
    BinaryExpression: (node) ->
      [@walk(node.left), ' ', node.operator, ' ', @walk(node.right)]

    # Literal, like numbers (20)
    # (.raw, .value)
    Literal: (node) ->
      [node.raw]

    # Calls (alert("Hi"))
    CallExpression: (node) ->
      list = []
      callee = @walk(node.callee)
      for arg, i in node.arguments
        list.push ', ' if i > 0
        list.push @walk(arg)
        
      [callee, '('].concat(list).concat([')'])

    # Default, when nothing else can do
    Default: (type, node) ->
      console.error node
      throw new Error("walk(): No handler for #{type}")

###
# Performs transformations on the AST.
#
#     ast = esprima.parse(...);
#     new Transformer(ast, {}).run();
#     ast; //= this is changed now
###

class Transformer
  constructor: (@ast, @options = {}) ->
  run: -> @ast

###*
# parse():
# Parses.
###

parse = (source, options = {}) ->
  ast = esprima.parse(source, loc: true, range: true, comment: true)

  xformer = new Transformer(ast, options)
  newAst = xformer.run()

  builder = new Stringifier(newAst, options)
  {code, map} = builder.get()
  {code, ast, map}

js2coffee = (source, options) ->
  parse(source, options).code

module.exports = js2coffee
module.exports.parse = parse
