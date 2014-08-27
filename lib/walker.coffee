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

  walk: (node) =>
    oldLength = @path.length
    @path.push(node)

    type = node.type
    fn = @visitors[type]

    if fn
      out = fn.call(this, node)
      out = @decorator(node, out)  if @decorator?
    else
      out = @visitors.Default.call(this, node)

    @path.splice(oldLength)
    out

