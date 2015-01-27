{ nonComments } = require('../helpers')
TransformerBase = require('./base')

###
# Ifs
###

module.exports = class extends TransformerBase

  IfStatement: (node) ->
    @handleBlankIfs(node)
    @parenthesizeConditionals(node.test)
    node

  ConditionalExpression: (node, parent) ->
    @parenthesizeFunctions(node, parent)

  ###
  # Ensure any functions inside a ternary is parenthesized
  ###

  parenthesizeFunctions: (node, parent) ->
    @estraverse().traverse node,
      enter: (node, parent) ->
        isFunction =
          node.type is 'FunctionDeclaration' or
          node.type is 'FunctionExpression'

        if isFunction
          node._parenthesized = true
    node

  ###
  # recurse into `test` and ensure any ConditionalExpression in it is
  # parenthesized. This prevents `if if a then b else c` from happening.
  ###

  parenthesizeConditionals: (node) ->
    specials = [
      'ConditionalExpression'
      'FunctionExpression'
    ]

    @estraverse().traverse node,
      enter: (subnode, parent) ->
        # Parenthesize the subnode itself
        # `if (a === b?c:d)` => `if a == (if b then c else d)`
        if ~specials.indexOf(subnode.type)
          subnode._parenthesized = true

  ###
  # Ensure that empty ifs (`if (x){}`) get an else block.
  ###

  handleBlankIfs: (node) ->
    if noBody(node) or emptyBodyBlock(node) and !node.alternate
      node.alternate =
        type: 'BlockStatement'
        body: []

    node

noBody = (node) ->
  ! node.consequent

emptyBodyBlock = (node) ->
  cons = node.consequent
  result =
    cons and
    cons.type is 'BlockStatement' and
    nonComments(cons.body).length is 0

