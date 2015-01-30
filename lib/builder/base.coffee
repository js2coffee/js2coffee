stripSpaces = require('./strip_spaces')

###
# BuilderBase:
# Traverses a JavaScript AST.
#
# Provides an easy way to define visitors for each node type. Each visitor will
# return an array of strings that the node is compiled into.
#
#     class MyBuilder extends BuilderBase
#       BinaryExpression: (node) ->
#         [ @walk(node.left), node.operator, @walk(node.right) ]
#
#       Literal: (node) ->
#         [ node.raw ]
#
#     w = new MyBuilder(ast)
#     w.run()
#
# If a `decorator` method is present, the results are wrapped in it first. This
# is used to implement source maps.
#
#     class MyBuilder extends BuilderBase
#       decorator: (result) ->
#         dostuffwith(result)
###

class BuilderBase
  constructor: (@root, @options={}) ->
    @path = []

  run: ->
    @walk(@root)

  walk: (node, type) =>
    oldLength = @path.length
    @path.push(node)

    type = undefined if typeof type isnt 'string'
    type or= node.type
    @ctx = { path: @path, type: type, parent: @path[@path.length-2] }

    # check for a filter first -- not really necessary anymore
    # filters = @filters?[type]
    # if filters?
    #   node = filter(node) for filter in filters

    # check for the main visitor
    fn = this[type]
    if fn
      out = fn.call(this, node, @ctx)
      out = @decorator(node, out) if @decorator?
    else
      out = @onUnknownNode(node, @ctx)

    @path.splice(oldLength)
    out

  ###*
  # get():
  # Returns the output of source-map.
  ###

  get: ->
    node = @run()
    node = stripSpaces(node)
    node.toStringWithSourceMap()

  ###*
  # decorator():
  # Takes the output of each of the node visitors and turns them into
  # a `SourceNode`.
  ###

  decorator: (node, output) ->
    {SourceNode} = require("source-map")
    new SourceNode(
      node?.loc?.start?.line,
      node?.loc?.start?.column,
      @options.filename,
      output)

module.exports = BuilderBase
