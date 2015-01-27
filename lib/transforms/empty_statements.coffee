TransformerBase = require('./base')

###
# Remove `{type: 'EmptyStatement'}` from the body.
###

module.exports = class extends TransformerBase
  BlockStatementExit: (node) ->
    @removeEmptyStatementsFromBody(node)

  SwitchCaseExit: (node) ->
    @removeEmptyStatementsFromBody(node, 'consequent')

  SwitchStatementExit: (node) ->
    @removeEmptyStatementsFromBody(node, 'cases')

  ProgramExit: (node) ->
    @removeEmptyStatementsFromBody(node, 'body')

  removeEmptyStatementsFromBody: (node, body = 'body') ->
    node[body] = node[body].filter (n) ->
      n.type isnt 'EmptyStatement'
    node

