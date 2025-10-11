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
      if err.code is 'BABEL_PARSE_ERROR'
        throw buildError err, source, options.filename

      throw new Error "Babel preprocessing failed: #{err.message}"

  @shouldPreprocess: (source, options) ->
    return false if options.babel is false
    return true  if options.babel is true

    @detectModernSyntax source

  @detectModernSyntax: (source) ->
    MODERN_FEATURES = [
      /// \b const         \s+ ///
      /// \b let           \s+ ///
      /// \b class         \s+ ///
      /// \b async         \s+ ///
      /// \b await         \s+ ///
      /// \b import        \s+ ///
      /// \b export        \s+ ///

      ///    BigInt            ///
      ///    \d+ n          \b ///

      ///    for \s* await     ///
      ///    ` [^`]* `         ///

      ///    =>                ///
      ///    \?\?              ///
      ///    \? \. (?!\d)      ///
      ///    \*\*              ///
      ///    \*\*=             ///
      ///    \.\.\.            ///
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
