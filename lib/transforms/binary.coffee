TransformerBase = require('./base')

###
# Mangles the AST with various CoffeeScript tweaks.
###

module.exports = class extends TransformerBase

  BinaryExpression: (node) ->
    @warnAboutEquals(node)
    @updateEquals(node)
    @escapeEqualsForCompatibility(node)

  ###
  # Updates equals to their CoffeeScript equivalents.
  ###

  updateEquals: (node) ->
    dict =
      '===': '=='
      '!==': '!='

    op = node.operator
    if dict[op] then node.operator = dict[op]
    node

  escapeEqualsForCompatibility: (node) ->
    isIncompatible =
      node.operator is '==' or
      node.operator is '!='

    if @options.compat and isIncompatible
      @escapeJs node
    else
      node

  ###
  # Fire warnings when '==' is used
  ###

  warnAboutEquals: (node) ->
    op = node.operator
    replacements = { '==': '===', '!=': '!==' }

    if op is '==' or op is '!='
      repl = replacements[op]
      @warn node, "Operator '#{op}' is not supported in CoffeeScript, " +
        "use '#{repl}' instead"

    node
