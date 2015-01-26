{ replace } = require('../helpers')
TransformerBase = require('./base')

###
# Converts `function () {} ()` into `do ->`.
###

module.exports = class extends TransformerBase

  CallExpression: (node) ->
    isIife =
      node.callee?.type is 'FunctionExpression' and
      node.callee?.id is null

    return node unless isIife

    sameArgs =
      node.callee.params.map((p) -> p.name).join("/") is
      node.arguments.map((p) -> p.name).join("/")

    return node unless sameArgs

    replace node,
      type: 'CoffeeDoExpression'
      function: node.callee
      arguments: node.arguments
