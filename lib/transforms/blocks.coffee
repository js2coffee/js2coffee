TransformerBase = require('./base')

###
# Flattens nested `BlockStatements`.
###

module.exports =
class BlockTransforms extends TransformerBase
  BlockStatement: (node, parent) ->
    if parent.type is 'BlockStatement'
      parent.body.splice parent.body.indexOf(node), 1, node.body...
      return

