{ getReturnStatements } = require('../helpers')
TransformerBase = require('./base')

###
# Does transformations pertaining to `return` statements.
###

module.exports = class extends TransformerBase

  onScopeExit: (scope, ctx, subscope, subctx) ->
    @unreturnify subscope

  ###
  # Removes return statements
  ###

  unreturnify: (node, body = 'body') ->
    if node[body].length > 0
      returns = getReturnStatements(node[body])

      # Prevent implicit returns by adding an extra `return`
      if returns.length is 0
        node[body].push
          type: 'ReturnStatement'

      # Unpack the return statements, mutate them into
      # expression statements if needed (`return x` => `x`)
      else
        returns.forEach (ret) ->
          if ret.argument
            ret.type = 'ExpressionStatement'
            ret.expression = ret.argument

    return

