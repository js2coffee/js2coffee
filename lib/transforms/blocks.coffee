TransformerBase = require('./base')

###
# Flattens nested `BlockStatements`.
###

module.exports =
class BlockTransforms extends TransformerBase
  BlockStatement: (node, parent) ->
    @consolidateBlockIntoParent(node, parent)

  ###
  # Melds a block into a parent's body
  ###

  consolidateBlockIntoParent: (node, parent) ->
    skipped = false
    consolidateIf = (type, body) =>
      if parent.type is type and parent[body]?.indexOf
        idx = parent[body].indexOf(node)
        if parent[body] and ~idx
          parent[body].splice idx, 1, node.body...
          skipped = true
          true

    consolidateIf('BlockStatement', 'body') or
    consolidateIf('SwitchCase', 'consequent') or
    consolidateIf('IfStatement', 'consequent') or
    consolidateIf('IfStatement', 'alternate')

    if skipped then @skip() else node
