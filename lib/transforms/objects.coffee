TransformerBase = require('./base')

###
# Mangles the AST with various CoffeeScript tweaks.
###

module.exports =
class ObjectTransforms extends TransformerBase
  ArrayExpression: (node) ->
    @braceObjectsInElements(node)

  ObjectExpression: (node, parent) ->
    @braceObjectInExpression(node, parent)

  ###
  # Braces an object
  ###

  braceObjectInExpression: (node, parent) ->
    if parent.type is 'ExpressionStatement'
      isLastInScope = @scope.body?[@scope.body?.length-1] is parent

      if isLastInScope
        node._last = true
      else
        node._braced = true
    return

  ###
  # Ensures that an Array's elements objects are braced.
  ###

  braceObjectsInElements: (node) ->
    for item in node.elements
      if item.type is 'ObjectExpression'
        item._braced = true
    node

