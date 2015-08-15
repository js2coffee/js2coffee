TransformerBase = require('./base')

module.exports = class extends TransformerBase

  ###
  # Produce warnings when using labels. It may be a JSON string being pasted.
  ###

  LabeledStatement: (node, parent) ->
    @syntaxError node, "Labeled statements are not supported in CoffeeScript"

  WithStatement: (node) ->
    @syntaxError node, "'with' is not supported in CoffeeScript"
