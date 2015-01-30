newLine = /^\s*\n+\s*$/
###
# Strips spaces out of the SourceNode.
###

stripSpaces = (node) ->
  node = stripPre(node)
  node = stripPost(node)
  node = stripMid(node)
  node = stripIndents(node)
  node

###
# Strip lines that only have indents
###

stripIndents = (node) ->
  step = 0
  indent = null

  replace node, {}, (str) ->
    # Wait for "\n"
    if step is 0 or step is 1 and str.match(newLine)
      step = 1
      str

    # Followed by spaces (supress it)
    else if step is 1 and str.match(/^[ \t]+$/)
      indent = str
      step = 2
      ""

    # Then merge the spaces into the next tode
    else if step is 2
      step = 1
      if str.match(newLine)
        str
      else
        indent + str

    else
      step = 0
      str

###
# Strip beginning newlines.
###

stripPre = (node) ->
  replace node, {}, (str) ->
    if str.match(newLine)
      ""
    else
      @break()
      str

###
# Strip ending newlines.
###

stripPost = (node) ->
  replace node, reverse: true, (str) ->
    if str.match(newLine)
      ""
    else
      @break()
      "#{str}\n"

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
# Walk and replace.
#
#     replace node, {}, (str) ->
#       if str is "true"
#         "replacement"
#       else
#         str
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
