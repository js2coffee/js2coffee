{ nextNonComment, replace } = require('../helpers')
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

module.exports =
class FunctionTransforms extends TransformerBase
  onScopeEnter: (scope, ctx) ->
    # Keep a list of things to be prepended before the body
    ctx.prebody = []

  onScopeExit: (scope, ctx, subscope, subctx) ->
    # prepend the functions back into the body
    if subctx.prebody.length
      scope.body = subctx.prebody.concat(scope.body)

  FunctionDeclaration: (node) ->
    @ctx.prebody.push @buildFunctionDeclaration(node)
    @pushStack(node.body)
    return

  FunctionDeclarationExit: (node) ->
    @popStack(node)
    { type: 'EmptyStatement' }

  LineComment: (node, parent) ->
    @moveFunctionComments(node, parent)

  BlockComment: (node, parent) ->
    @moveFunctionComments(node, parent)

  FunctionExpression: (node) ->
    if node.id
      @ctx.prebody.push @buildFunctionDeclaration(node)
    @pushStack(node.body)
    return

  FunctionExpressionExit: (node) ->
    @popStack()
    if node.id
      { type: 'Identifier', name: node.id.name }

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
      { type: 'EmptyStatement' }

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
          body: node.body
      ]

