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
  constructor: (@root, @options) ->
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
    node = stripPre(node)
    node = stripPost(node)
    node = stripMid(node)
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

###
# source node transformations
###

###
# strip beginning newlines
###

stripPre = (node) ->
  wreplace node, {}, (n) ->
    throw n unless n.match(/^\s*\n+\s*$/)
    ""

###
# strip ending newlines
###

stripPost = (node) ->
  wreplace node, reverse: true, (n) ->
    throw "#{n}\n" unless n.match(/^\s*\n+\s*$/)
    ""

###
# strip triple new lines
###

stripMid = (node) ->
  streak = 0

  wreplace node, {}, (n) ->
    if n is "\n"
      streak += 1
    else
      streak = 0

    if streak >= 3 then "" else n

###
# walk and replace
###

wreplace = (node, options = {}, fn) ->
  walk = (node, options = {}, fn) ->
    range = if options.reverse
      [node.children.length-1..0]
    else
      [0...node.children.length]

    for i in range
      child = node.children[i]
      if !child
      else if child.children
        walk child, options, fn
      else if child isnt ''
        try
          output = fn(child)
          node.children[i] = output
        catch e
          throw e unless typeof e is 'string'
          node.children[i] = e
          throw {break: true}
    node

  try
    walk node, options, fn
  catch e
    throw e unless e.break is true
    node

