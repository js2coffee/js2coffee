esprima = require('esprima')

module.exports = (source, options = {}) ->
  if (options.debug)
    console.log(esprima.parse(source))

  source
