{ replace, quote } = require('../helpers')
TransformerBase = require('./base')

###
# Transforms strings, regexes, etc
###

module.exports = class extends TransformerBase

  Literal: (node) ->
    @unpackRegexpIfNeeded(node)

  ###
  # Accounts for regexps that start with an equal sign or space.
  ###

  unpackRegexpIfNeeded: (node) ->
    return unless node.value instanceof RegExp
    m = node.value.toString().match(/^\/([\s\=].*)\/([a-z]*)$/)
    if m
      node = replace node,
        type: 'CallExpression'
        callee: { type: 'Identifier', name: 'RegExp' },
        arguments: [
          type: 'Literal'
          value: m[1]
          raw: quote(m[1])
        ]

      if m[2]
        node.arguments.push
          type: 'Literal'
          value: m[2]
          raw: quote(m[2])

      node

