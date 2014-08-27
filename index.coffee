esprima = require('esprima')

class Builder
  constructor: (@root, @options) ->

  toString: ->
    str = @walk(@root)

  walk: (node) ->
    type = node.type
    fn = @nodes[type]
    if fn
      out = fn.call(this, node)
    else
      console.error node
      throw new Error("walk(): No handler for #{type}")

  nodes:
    Program: (node) ->
      blocks = node.body.map (node) =>
        @walk node
      blocks.join("")

    # Assignment (a = b)
    AssignmentExpression: (node) ->
      "#{@walk node.left} = #{@walk node.right}"

    ExpressionStatement: (node) ->
      "#{@walk node.expression}\n"

    # variable identifier
    Identifier: (node) ->
      node.name

    # Operator (+)
    BinaryExpression: (node) ->
      "#{@walk node.left} #{node.operator} #{@walk node.right}"

    # Literal, like numbers (20)
    Literal: (node) ->
      node.raw

module.exports = (source, options = {}) ->
  ast = esprima.parse(source)
  builder = new Builder(ast, options)
  builder.toString()
