{ replace } = require('../helpers')
TransformerBase = require('./base')

###
# Performs transformations on `a.b` scope resolutions.
#
#     this.x            =>  @x
#     x.prototype.y     =>  x::y
#     this.prototype.y  =>  @::y
#     function(){}.y    =>  (->).y
###

module.exports = class extends TransformerBase

  MemberExpression: (node) ->
    @transformThisToAtSign(node)
    @braceObjectOnLeft(node)
    @replaceWithPrototype(node) or
    @parenthesizeObjectIfFunction(node)

  CoffeePrototypeExpression: (node) ->
    @transformThisToAtSign(node)

  ###
  # Converts `this.x` into `@x` for MemberExpressions.
  ###

  transformThisToAtSign: (node) ->
    if node.object.type is 'ThisExpression'
      node._prefixed = true
      node.object._prefix = true
    node

  braceObjectOnLeft: (node) ->
    if node.object.type is 'ObjectExpression'
      node.object._braced = true
    return

  ###
  # Replaces `a.prototype.b` with `a::b` in a member expression.
  ###

  replaceWithPrototype: (node) ->
    isPrototype = node.computed is false and
      node.object.type is 'MemberExpression' and
      node.object.property.type is 'Identifier' and
      node.object.property.name is 'prototype'

    if isPrototype
      @recurse replace node,
        type: 'CoffeePrototypeExpression'
        object: node.object.object
        property: node.property

  ###
  # Parenthesize function expressions if they're in the left-hand side of a
  # member expression (eg, `(-> x).toString()`).
  ###

  parenthesizeObjectIfFunction: (node) ->
    if node.object.type is 'FunctionExpression'
      node.object._parenthesized = true
    node
