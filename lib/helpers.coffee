# ## Code snippet helper
# A helper class to deal with building code.

codestyle = @codestyle or require('./codestyle')
CoffeeScript = @CoffeeScript or require 'coffee-script'

class Code
  constructor: ->
    @code = ''
    tabspacing = codestyle.tabspacing
    @tab_space = ('' for i in [0..tabspacing]).join(' ')

  add: (str) ->
    @code += str.toString()
    @

  scope: (str, level=1) ->
    indent = strRepeat(@tab_space, level)
    @code  = rtrim(@code) + "\n"
    @code += indent + rtrim(str).replace(/\n/g, "\n#{indent}") + "\n"
    @

  toString: ->
    @code

# ## String helpers
# These are functions that deal with strings.

# `paren()`
# Wraps a given string in parentheses.
# Examples:
#
#     paren 'hi'   => "(hi)"
#     paren '(hi)' => "(hi)"
#
paren = (string) ->
    str = string.toString()
    if str.substr(0, 1) == '(' and str.substr(-1, 1) == ')'
      str
    else
      "(#{str})"

# `strRepeat()`
# Repeats a string a certain number of times.
# Example:
#
#     strRepeat('.', 3) => "..."
#
strRepeat = (str, times) ->
    (str for i in [0...times]).join('')

# `trim()` *and friends*
# String trimming functions.

ltrim = (str) ->
  "#{str}".replace(/^\s*/g, '')

rtrim = (str) ->
  "#{str}".replace(/\s*$/g, '')

blockTrim = (str) ->
  "#{str}".replace(/^\s*\n|\s*$/g, '')

trim = (str) ->
  "#{str}".replace(/^\s*|\s*$/g, '')

isSingleLine = (str) ->
  trim(str).indexOf("\n") == -1

# `unshift()`
# Removes any unneccesary indentation from a code block string.
unshift = (str) ->
  str = "#{str}"

  while true
    m1 = str.match(/^/gm)
    m2 = str.match(/^ /gm)

    return str  if !m1 or !m2 or m1.length != m2.length
    str = str.replace(/^ /gm, '')

# `strEscape()`
# Escapes a string.
# Example:
#
#   * `hello "there"` turns to `"hello \"there\""`
#
strEscape = (str) ->
  JSON.stringify "#{str}"

# `p()`
# Debugging tool. Prints an object to the console.
# Not actually used, but here for convenience.
p = (str) ->
  if str.constructor == String
    console.log JSON.stringify(str)
  else
    console.log str
  ''

# `coffeescript_reserved`
# Array of reserved words from coffeescript,
# for use by `unreserve()`
coffeescript_reserved = ( word for word in CoffeeScript.RESERVED when word != 'undefined' )

# `unreserve()`
# Picks the next best thing for a reserved keyword.
# Example:
#
#     "in"    => "in_"
#     "hello" => "hello"
#     "off"   => "off"
#
unreserve = (str) ->
  if "#{str}" in coffeescript_reserved
    "#{str}_"
  else
    "#{str}"

@Js2coffeeHelpers = exports =
  {Code, p, strEscape, unreserve, unshift, isSingleLine, trim,
  blockTrim, ltrim, rtrim, strRepeat, paren}

module.exports = exports  if module?
