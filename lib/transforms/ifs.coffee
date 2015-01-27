TransformerBase = require('./base')

###
# Ifs
###

module.exports = class extends TransformerBase
  IfStatement: (node) ->
    @handleBlankIfs(node)
    @parenthesizeConditionals(node)

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
    @estraverse().traverse node.test,
      enter: (node, parent) ->
        if node.type is 'ConditionalExpression'
          node._parenthesized = true
    node

  ###
  # Ensure that empty ifs (`if (x){}`) get an else block.
  ###

  handleBlankIfs: (node) ->
    noBody = ->
      ! node.consequent

    emptyBodyBlock = ->
      cons = node.consequent
      result =
        cons and
        cons.type is 'BlockStatement' and
        cons.body.length is 0

    if (noBody() or emptyBodyBlock()) and !node.alternate
      node.alternate =
        type: 'BlockStatement'
        body: []

    node
