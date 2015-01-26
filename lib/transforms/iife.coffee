{ replace } = require('../helpers')
TransformerBase = require('./base')

###
# Converts `function () {} ()` into `do ->`.
###

module.exports = class extends TransformerBase

  CallExpression: (node) ->
    valid =
      isIife(node) and
      isAllIdentifiers(node.arguments) and
      sameArgs(node.callee.params, node.arguments)

    return node unless valid

    replace node,
      type: 'CoffeeDoExpression'
      function: node.callee
      arguments: node.arguments

###
# Helper: ensure all nodes in `args` are Identifiers
###

isAllIdentifiers = (args) ->
  for arg in args
    return false if arg.type isnt 'Identifier'
  true

###
# Helper: ensure a CallExpression is an IIFE
###

isIife = (node) ->
  node.callee?.type is 'FunctionExpression' and
  node.callee?.id is null

###
# Helper: ensure argument names are the same
###

sameArgs = (left, right) ->
  left.map((p) -> p.name).join("/") is
    right.map((p) -> p.name).join("/")

