{ replace } = require('../helpers')
TransformerBase = require('./base')

###
# Transforms `Math.pow(2,8)` into `2 ** 8`
###

module.exports =
class ExponentTransforms extends TransformerBase
  CallExpression: (node) ->

    isExponent =
      node.callee?.type is 'MemberExpression' and
      node.callee?.object?.type is 'Identifier' and
      node.callee?.object?.name is 'Math' and
      node.callee?.property?.type is 'Identifier' and
      node.callee?.property?.name is 'pow'

    return node unless isExponent

    replace node,
      type: 'BinaryExpression'
      left: node.arguments[0]
      operator: '**'
      right: node.arguments[1]
