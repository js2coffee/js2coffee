{ getPrecedence } = require('../helpers')
TransformerBase = require('./base')

###
# Fixes operator precedences
###

module.exports = class extends TransformerBase

  onEnter: (node, parent) ->
    return unless parent

    # No need to parenthesize arguments in `a(...)` and `a[...]`
    type = parent.type
    return if type is 'CallExpression' and parent.arguments.indexOf(node) > -1
    return if type is 'NewExpression' and parent.arguments.indexOf(node) > -1
    return if type is 'MemberExpression' and parent.property is node

    # Ensure that we actually care about the precedence of this node
    prec = getPrecedence(node)
    return if prec is -1

    # Ensure that the precedence calls for it (eg, + inside a /).
    parenthesize =
      isIntransitiveOperation(parent, node) or
      nonTailingTernary(parent, node) or
      prec < getPrecedence(parent)

    if parenthesize
      node._parenthesized = true

# special case for intransitive operations (`a-(b-c)` vs `(a-b)-c`).
isIntransitiveOperation = (parent, node) ->
  isIntransitive(parent) and
  isIntransitive(node) and
  parent.right is node

# special case for ternary operators where `node` isn't the `else`.
# (`a?b?c:d:e` vs `a?b:c?d:e`)
isIntransitive = (node) ->
  op = node.operator
  node.type is 'BinaryExpression' and (op is '-' or op is '/')

nonTailingTernary = (parent, node) ->
  parent.type is 'ConditionalExpression' and
  node.type is 'ConditionalExpression' and
  parent.alternate isnt node
