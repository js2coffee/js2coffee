newLine = /^\s*\n+\s*$/
###
# Strips spaces out of the SourceNode.
###

stripSpaces = (node) ->
  node = stripPre(node)
  node = stripPost(node)
  node = stripMid(node)
  node

###
# Strip beginning newlines.
###

stripPre = (node) ->
  replace node, {}, (n) ->
    if n.match(newLine)
      ""
    else
      @break()
      n

###
# Strip ending newlines.
###

stripPost = (node) ->
  replace node, reverse: true, (n) ->
    if n.match(newLine)
      ""
    else
      @break()
      "#{n}\n"

###
# Strip triple new lines.
###

stripMid = (node) ->
  streak = 0

  replace node, {}, (n) ->
    if n is "\n"
      streak += 1
    else if n.match(/^\s*$/)
      # pass
    else
      streak = 0

    if streak >= 3 then "" else n

###
# walk and replace
###

replace = (node, options = {}, fn) ->
  broken = false

  ctx =
    break: (str) ->
      broken = true

  walk = (node, options = {}, fn) ->
    range = if options.reverse
      [node.children.length-1..0]
    else
      [0...node.children.length]

    for i in range
      return node if broken
      child = node.children[i]

      if !child
        # pass

      else if child.children
        walk child, options, fn

      else if child isnt ''
        output = fn.call(ctx, child)
        node.children[i] = output

    node

  walk.call ctx, node, options, fn

module.exports = stripSpaces
