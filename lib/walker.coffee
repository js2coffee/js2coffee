# Generic walker class.
module.exports = class Walker
  constructor: (@root, @options) ->
    @path = []

  run: ->
    @walk(@root)

  walk: (node) =>
    oldLength = @path.length
    @path.push(node)

    type = node.type
    fn = @nodes[type]

    if fn
      out = fn.call(this, node)
      out = @decorator(node, out)  if @decorator?
    else
      out = @nodes.Default.call(this, node)

    @path.splice(oldLength)
    out

