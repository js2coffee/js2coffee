TransformerBase = require('./base')

###
# Mangles the AST with various CoffeeScript tweaks.
###

module.exports = class extends TransformerBase

  ArrayExpression: (node) ->
    @braceObjectsInElements(node)
    @catchEmptyArraySlots(node)

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
      if item?.type is 'ObjectExpression'
        item._braced = true
    node

  catchEmptyArraySlots: (node) ->
    if hasNullIn(node.elements)
      if @options.compat
        @escapeJs node
      else
        @syntaxError node, 'Empty array slots are not supported in CoffeeScript'

hasNullIn = (elements) ->
  for node in elements
    if node is null
      return true
  false
