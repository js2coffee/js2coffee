###
# Walker:
# Traverses a JavaScript AST.
#
#     class MyWalker extends Walker
#
#     w = new MyWalker(ast)
#     w.run()
#
###

module.exports = class Walker
  constructor: (@root, @options) ->
    @path = []

  run: ->
    @walk(@root)

  walk: (node, type) =>
    oldLength = @path.length
    @path.push(node)

    type = undefined if typeof type isnt 'string'
    type or= node.type

    # check for a filter first
    filters = @filters?[type]
    if filters?
      node = filter(node) for filter in filters

    fn = this[type]

    if fn
      out = fn.call(this, node, { path: @path, type: type })
      out = @decorator(node, out) if @decorator?
    else
      out = @onUnknownNode(node, { path: @path, type: type })

    @path.splice(oldLength)
    out

