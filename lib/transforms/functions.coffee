{ isComment, nextNonComment, replace } = require('../helpers')
TransformerBase = require('./base')

###
# FunctionTransforms:
# Reorders functions.
#
# * Moves function definitions (`function x(){}`) to the top of the scope and
#   turns them into variable declarations (`x = -> ...`).
#
# * Moves named function expressions (`setTimeout(function tick(){})`) to the
#   top of the scope.
###

module.exports = class extends TransformerBase

  onScopeEnter: (scope, ctx) ->
    # Keep a list of things to be prepended before the body
    ctx.prebody = []

  onScopeExit: (scope, ctx, subscope, subctx) ->
    if subctx.prebody.length
      @prependIntoBody(subscope.body, subctx.prebody)

  # prepend the functions back into the body.
  # be sure to place them after variable declarations.
  prependIntoBody: (body, prebody) ->
    idx = firstNonVar(body)
    body.splice(idx, 0, prebody...)

  FunctionDeclaration: (node) ->
    @ctx.prebody.push @buildFunctionDeclaration(node)
    @pushStack(node.body)
    return

  FunctionDeclarationExit: (node) ->
    @popStack(node)
    @remove()

  LineComment: (node, parent) ->
    @moveFunctionComments(node, parent)

  BlockComment: (node, parent) ->
    @moveFunctionComments(node, parent)

  FunctionExpression: (node) ->
    @pushStack(node.body)
    return

  FunctionExpressionExit: (node) ->
    @popStack()
    if node.id
      if @options.compat
        @escapeJs node, parenthesized: true
      else
        @warn node, "Named function expressions are not supported in CoffeeScript"
        node
    else
      node

  ###
  # If a comment is adjacent to a function,
  # move them up as well together with the function.
  ###

  moveFunctionComments: (node, parent) ->
    return unless parent.body
    next = nextNonComment(parent.body, node)
    return unless next

    isFn = (next.type is 'FunctionExpression' and next.id)
    isFn ||= (next.type is 'FunctionDeclaration')

    if isFn
      @ctx.prebody.push node
      @remove()

  ###
  # Returns a `a = -> ...` statement out of a FunctionDeclaration node.
  ###

  buildFunctionDeclaration: (node) ->
    replace node,
      type: 'VariableDeclaration'
      declarations: [
        type: 'VariableDeclarator'
        id: node.id
        init:
          type: 'FunctionExpression'
          params: node.params
          defaults: node.defaults
          body: node.body
      ]

###
# Looks up the first non-variable-declaration in a body
###

firstNonVar = (body) ->
  i = 0
  for node, i in body
    if node.type isnt 'VariableDeclaration' and ! isComment(node)
      return i
  i
