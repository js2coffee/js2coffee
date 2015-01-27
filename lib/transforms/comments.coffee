TransformerBase = require('./base')

###
# Injects comments as nodes in the AST. This takes the comments in the
# `Program` node, finds list of expressions in bodies (eg, a BlockStatement's
# `body`), and injects the comment nodes wherever relevant.
#
# Comments will be injected as `BlockComment` and `LineComment` nodes.
###

module.exports = class extends TransformerBase
  # Disable the stack-tracking for now
  ProgramExit: null
  FunctionExpression: null
  FunctionExpressionExit: null

  Program: (node) ->
    @comments = node.comments
    @updateCommentTypes()
    node.body = @addCommentsToList([0,Infinity], node.body)
    node

  BlockStatement: (node) ->
    @injectComments(node, 'body')

  SwitchStatement: (node) ->
    @injectComments(node, 'cases')

  SwitchCase: (node) ->
    @injectComments(node, 'consequent')

  BlockComment: (node) ->
    @convertCommentPrefixes(node)

  ###
  # Updates comment `type` as needed. It changes *Block* to *BlockComment*, and
  # *Line* to *LineComment*. This makes it play nice with the rest of the AST,
  # because "Block" and "Line" are ambiguous.
  ###

  updateCommentTypes: ->
    for c in @comments
      switch c.type
        when 'Block' then c.type = 'BlockComment'
        when 'Line'  then c.type = 'LineComment'

  ###
  # Injects comment nodes into a node list.
  ###

  injectComments: (node, body = 'body') ->
    node[body] = @addCommentsToList(node.range, node[body])
    node

  ###
  # Delegate of `injectComments()`.
  #
  # Checks out the `@comments` list for any relevants comments, and injects
  # them into the correct places in the given `body` Array. Returns the
  # transformed `body` array.
  ###

  addCommentsToList: (range, body) ->
    return body unless range?

    list = []
    left = range[0]
    right = range[1]

    findComments = (left, right) =>
      @comments.filter (c) ->
        c.range[0] >= left and c.range[1] <= right

    if body.length > 0
      # look for comments in left..item.range[0]
      # (ie, before each item)
      for item, i in body
        if item.range
          newComments = findComments(left, item.range[0])
          list = list.concat(newComments)

        list.push item

        if item.range
          left = item.range[1]

    # look for the final one (also accounts for empty bodies)
    newComments = findComments(left, right)
    list = list.concat(newComments)

    list

  ###
  # Changes JS block comments into CoffeeScript block comments.
  # This involves changing prefixes like `*` into `#`.
  ###

  convertCommentPrefixes: (node) ->
    lines = node.value.split("\n")
    inLevel = node.loc.start.column

    lines = lines.map (line, i) ->
      isTrailingSpace = i is lines.length-1 and line.match(/^\s*$/)
      isSingleLine = i is 0 and lines.length is 1

      # If the first N characters are spaces, strip them
      predent = line.substr(0, inLevel)
      if predent.match(/^\s+$/)
        line = line.substr(inLevel)

      if isTrailingSpace
        ''
      else if isSingleLine
        line
      else
        line = line.replace(/^ \*/, '#')
        line + "\n"
    node.value = lines.join("")
    node
