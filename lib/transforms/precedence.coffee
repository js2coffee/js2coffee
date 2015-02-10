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
      isIntransitiveSubtraction(parent, node) or
      isIntransitiveDivision(parent, node) or
      nonTailingTernary(parent, node) or
      prec < getPrecedence(parent)

    if parenthesize
      node._parenthesized = true

# special case for subtraction intransitivity (`a-(b-c)` vs `(a-b)-c`).
isIntransitiveSubtraction = (parent, node) ->
  isOperation(parent, '-') and
  isOperation(node, '-') and
  parent.right is node

# special case for division intransitivity (`a*(b/c)` vs `(a*b)/c`).
isIntransitiveDivision = (parent, node) ->
  isOperation(parent, '/') and
  (isOperation(node, '/') or isOperation(node, '*')) and
  parent.right is node

# special case for ternary operators where `node` isn't the `else`.
# (`a?b?c:d:e` vs `a?b:c?d:e`)
isOperation = (node, op) ->
  node.type is 'BinaryExpression' and node.operator is op

nonTailingTernary = (parent, node) ->
  parent.type is 'ConditionalExpression' and
  node.type is 'ConditionalExpression' and
  parent.alternate isnt node
