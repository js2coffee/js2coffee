esprima = require('esprima')
SourceNode = require("source-map").SourceNode

class Walker
  constructor: (@root, @options) ->
  run: ->
    @walk(@root)

  walk: (node) ->
    type = node.type
    fn = @nodes[type]
    if fn
      out = fn.call(this, node)
      out
    else
      @nodes.Default.apply(this, node)

  push: (node, value) ->
    new SourceNode(node.loc.start.line, node.loc.start.column, 'input.js', value)

class Stringifier extends Walker
  nodes:
    Default: (type, node) ->
      console.error node
      throw new Error("walk(): No handler for #{type}")

    Program: (node) ->
      blocks = node.body.map (node) => @walk node
      @push node, blocks

    # Assignment (a = b)
    AssignmentExpression: (node) ->
      @push node, [@walk(node.left), ' = ', @walk(node.right)]

    ExpressionStatement: (node) ->
      @push node, [@walk(node.expression), "\n"]

    # variable identifier
    Identifier: (node) ->
      @push node, node.name

    # Operator (+)
    # (.left, .operator, .right)
    BinaryExpression: (node) ->
      @push node, [@walk(node.left), ' ', node.operator, ' ', @walk(node.right)]

    # Literal, like numbers (20)
    # (.raw, .value)
    Literal: (node) ->
      @push node, node.raw

    # Calls (alert("Hi"))
    CallExpression: (node) ->
      list = []
      for arg, i in node.arguments
        list.push ', ' if i > 0
        list.push @walk(arg)
        
      callee = @walk(node.callee)
      @push node, [callee, '('].concat(list).concat([')'])

class Transformer
  constructor: (@ast, @options = {}) ->
  run: -> @ast

parse = (source, options = {}) ->
  ast = esprima.parse(source, loc: true, range: true, comment: true)

  xformer = new Transformer(ast, options)
  newAst = xformer.run()

  builder = new Stringifier(newAst, options)
  str = builder.run().toString()

  { output: str, ast: ast }

js2coffee = (source, options) ->
  parse(source, options).output

module.exports = js2coffee
module.exports.parse = parse
