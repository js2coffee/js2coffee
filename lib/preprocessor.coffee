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
      # Require Babel from js2coffee's node_modules, not CWD
      babelPath   = require.resolve '@babel/core', paths: [__dirname + '/..']
      babel       = require babelPath
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
      # For other Babel errors (like module not found), log and return source
      if process.env.DEBUG_BABEL
        console.error '[preprocessor] Babel error:', err.message
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
    # Use absolute path to preset so it works regardless of CWD
    presetPath = require.resolve '@babel/preset-env', paths: [__dirname + '/..']
    [
      [
        presetPath
        targets:      { ie: '10' }
        modules:      false
        useBuiltIns:  false
        loose:        true
      ]
    ]
