# FILENAME: { js2coffee/lib/preprocessor.coffee }

{ buildError } = require './helpers'

###*
# Babel Preprocessor
#
# Transpiles modern JavaScript (ES.Next) down to ES5/ES6 subset
# that Esprima 2.5 can parse and js2coffee can transform.
###

module.exports = class Preprocessor

  @preprocess: (source, options = {}) ->
    return source unless @shouldPreprocess source, options

    try
      babel       = require '@babel/core'
      babelConfig = @getBabelConfig options

      result = babel.transformSync source,
        filename:    options.filename ? 'input.js'
        babelrc:     babelConfig.useBabelrc
        configFile:  babelConfig.useConfigFile
        presets:     babelConfig.presets
        comments:    true
        sourceMaps:  true
        retainLines: true

      return result.code if result?.code
      source

    catch err
      # If Babel fails, return original source and let Esprima handle it
      if err.code is 'BABEL_PARSE_ERROR'
        throw buildError err, source, options.filename
      # For other Babel errors, just return the source
      source

  @shouldPreprocess: (source, options) ->
    return false if options.babel is false
    return true  if options.babel is true

    @detectModernSyntax source

  @detectModernSyntax: (source) ->
    MODERN_FEATURES = [
      /\bconst\s+/                  # const keyword
      /\blet\s+/                    # let keyword
      /=>/                          # Arrow functions
      /`[^`]*`/                     # Template literals
      /\bclass\s+/                  # Class syntax
      /\?\?/                        # Nullish coalescing
      /\?\.(?!\d)/                  # Optional chaining (not decimal)
      /\*\*/                        # Exponentiation operator
      /\*\*=/                       # Exponentiation assignment
      /\basync\s+/                  # Async functions
      /\bawait\s+/                  # Await keyword
      /\.\.\./                      # Spread/rest operator
      /\bimport\s+/                 # ES6 imports
      /\bexport\s+/                 # ES6 exports
      /for\s*await/                 # Async iteration
      /BigInt/                      # BigInt literal
      /\d+n\b/                      # BigInt number literal
    ]

    MODERN_FEATURES.some (pattern) -> pattern.test source

  @getBabelConfig: (options) ->
    if options.babelConfig
      useBabelrc:    false
      useConfigFile: false
      presets:       options.babelConfig.presets ? @getDefaultPresets()
    else
      useBabelrc:    true
      useConfigFile: true
      presets:       @getDefaultPresets()

  @getDefaultPresets: ->
    [
      [
        '@babel/preset-env'
        targets:      { ie: '10' }
        modules:      false
        useBuiltIns:  false
        loose:        true
      ]
    ]
