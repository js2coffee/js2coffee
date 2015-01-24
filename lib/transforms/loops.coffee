{ replace } = require('../helpers')
TransformerBase = require('./base')

###
# Provides transformations for `while`, `for` and `do`.
###

module.exports =
class LoopTransforms extends TransformerBase
  ForStatement: (node) ->
    @injectUpdateIntoBody(node)
    @convertForToWhile(node)

  WhileStatement: (node) ->
    @convertToLoopStatement(node)

  DoWhileStatement: (node) ->
    block = node.body
    body = block.body

    body.push replace node.test,
      type: 'IfStatement'
      _postfix: true
      _negative: true
      test: node.test
      consequent:
        type: 'BreakStatement'

    replace node,
      type: 'CoffeeLoopStatement'
      body: block

  ###
  # Converts a `for (x;y;z) {a}` to `x; while(y) {a; z}`.
  # Returns a `BlockStatement`.
  ###

  convertForToWhile: (node) ->
    node.type = 'WhileStatement'
    block =
      type: 'BlockStatement'
      body: [ node ]

    if node.init
      block.body.unshift
        type: 'ExpressionStatement'
        expression: node.init

    return block

  ###
  # Converts a `while (true)` to a CoffeeLoopStatement.
  ###

  convertToLoopStatement: (node) ->
    isLoop = not node.test? or
      (node.test?.type is 'Literal' and node.test?.value is true)

    if isLoop
      replace node,
        type: 'CoffeeLoopStatement'
        body: node.body
    else
      node

  ###*
  # Injects a ForStatement's update (eg, `i++`) into the body.
  ###

  injectUpdateIntoBody: (node) ->
    if node.update
      statement =
        type: 'ExpressionStatement'
        expression: node.update

      # Ensure that the body is a BlockStatement with a body
      if not node.body?
        node.body ?= { type: 'BlockStatement', body: [] }
      else if node.body.type isnt 'BlockStatement'
        old = node.body
        node.body = { type: 'BlockStatement', body: [ old ] }

      node.body.body = node.body.body.concat([statement])
      delete node.update
