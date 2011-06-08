# The JavaScript to CoffeeScript compiler.
# Common usage:
#
#
#     var src = "var square = function(n) { return n * n };"
#
#     js2coffee = require('js2coffee');
#     js2coffee.build(src);
#     //=> "square = (n) -> n * n"

# ## Requires
#
# Js2coffee relies on Narcissus's parser. (Narcissus is Mozilla's JavaScript
# engine written in JavaScript).

if window?
  narcissus = window.Narcissus
  _         = window._
else
  narcissus = require('./narcissus_packed')
  _         = require('underscore')

tokens = narcissus.definitions.tokens
parser = narcissus.parser
Node   = parser.Node

# ## Main entry point
# This is `require('js2coffee').build()`. It takes a JavaScript source
# string as an argument, and it returns the CoffeeScript version.
#
# 1. Ask Narcissus to break it down into Nodes (`parser.parse`). This
#    returns a `Node` object of type `script`.
#
# 2. This node is now passed onto `build()`.

buildCoffee = (str) ->
  scriptNode = parser.parse("#{str}\n")

  trim build(scriptNode)

# ## Narcissus node helpers
# Some extensions to the Node class to make things easier later on.

# `left() / right()`  
# These are aliases for the first and last child.
# Often helpful for things like binary operators.
Node.prototype.left  = -> @children[0]
Node.prototype.right = -> @children[1]

# `unsupported()`  
# Throws an unsupported error.
Node.prototype.unsupported = (msg) ->
  throw new UnsupportedError("Unsupported: #{msg}", @)

# `typeName()`  
# Returns the typename in lowercase. (eg, 'function')
Node.prototype.typeName = -> Types[@type]

# ## Main functions

# `build()`  
# This finds the appropriate builder function for `node` based on it's type,
# the passes the node onto that function.
#
# For instance, for a `function` node, it calls `Builders.function(node)`.
# It defaults to `Builders.other` if it can't find a function for it.
build = (node, opts={}) ->
  name = 'other'
  name = node.typeName()  if node != undefined and node.typeName

  out = (Builders[name] or Builders.other).apply(node, [opts])

  if node.parenthesized? then paren(out) else out

# `re()`  
# Works like `build()`, except it explicitly states which function should
# handle it. (essentially, *re*routing it to another builder)
re = (type, str, args...) ->
  Builders[type].apply str, args

# `body()`
# Works like `build()`, and is used for code blocks. It cleans up the returned
# code block by removing any extraneous spaces and such.
body = (item, opts={}) ->
  str = build(item, opts)
  str = blockTrim(str)
  str = unshift(str)

  if str.length > 0 then str else ""

# ## Types
# The `Types` global object contains a map of Narcissus type numbers to type
# names. It probably looks like:
#
#     Types = { ...
#       '42': 'script',
#       '43': 'block',
#       '44': 'label',
#       '45': 'for_in',
#       ...
#     }

Types = (->
  dict = {}
  for i of tokens
    dict[tokens[i]] = i.toLowerCase()  if typeof tokens[i] == 'number'

  dict
)()

# ## The builders
#
# Each of these functions are apply'd to a Node, and is expected to return
# a string representation of it CoffeeScript counterpart.
#
# These are invoked using `build()`.

Builders =
  # `script`  
  # This is the main entry point.
  'script': (opts={}) ->
    c = new Code

    len = @children.length

    if len > 0
      # *Omit returns if not needed.*
      if opts.returnable?
        @children[len-1].last = true

      # *CoffeeScript does not need `break` statements on `switch` blocks.*
      if opts.noBreak? and @children[len-1].typeName() == 'break'
        delete @children[len-1]

    # *Functions must always be declared first in a block.*
    if @children?
      _.each @children, (item) ->
        c.add build(item)  if item.typeName() == 'function'
      _.each @children, (item) ->
        c.add build(item)  if item.typeName() != 'function'

    c.toString()

  # `property_identifier`  
  # A key in an object literal.

  'property_identifier': ->
    str = @value.toString()

    # **Caveat:**
    # *In object literals like `{ '#foo click': b }`, ensure that the key is
    # quoted if need be.*

    if str.match(/^([_\$a-z][a-z0-9_]*)$/i) or str.match(/^[0-9]+/i)
      str
    else
      strEscape str

  # `identifier`  
  # Any object identifier like a variable name.

  'identifier': ->
    unreserve @value.toString()

  'number': ->
    "#{@value}"

  'id': ->
    unreserve @

  # `id_param`  
  # Function parameters. Belongs to `list`.
  'id_param': ->
    if @toString() in ['undefined']
      "#{@}_"
    else
      re 'id', @

  # `return`  
  # A return statement. Has `@value` of type `id`.

  'return': ->
    # **Caveat 1:**
    # *Empty returns need to always be `return`, regardless if it's the last
    # statement in the block or not.*
    if not @value?
      "return"

    # **Caveat 2:**
    # *If it's the last statement in the block, we can omit the 'return' keyword.*
    else if @last?
      build(@value)

    else
      "return #{build(@value)}"

  # `;` (aka, statement)  
  # A single statement.

  ';': ->
    # **Caveat:**
    # Some statements can be blank as some people are silly enough to use `;;`
    # sometimes. They should be ignored.
    if not @expression?
      ""

    # **Caveat 2:**
    # *If the statement only has one function call (eg, `alert(2);`), the
    # parentheses should be omitted (eg, `alert 2`).*
    else if @expression.typeName() == 'call'
      re('call_statement', @expression) + "\n"

    else
      build(@expression) + "\n"

  # `new` + `new_with_args`  
  # For `new X` and `new X(y)` respctively.

  'new':           -> "new #{build @left()}"
  'new_with_args': -> "new #{build @left()}(#{build @right()})"

  # ### Unary operators

  'unary_plus':  -> "+#{build @left()}"
  'unary_minus': -> "-#{build @left()}"

  # ### Keywords

  'this':  -> 'this'
  'null':  -> 'null'
  'true':  -> 'true'
  'false': -> 'false'
  'void':  -> 'undefined'

  'break':    -> "break\n"
  'continue': -> "continue\n"

  # ### Some simple operators

  '!':      -> "not #{build @left()}"
  '~':      -> "~#{build @left()}"
  'typeof': -> "typeof #{build @left()}"
  'index':  -> "#{build @left()}[#{build @right()}]"
  'throw':  -> "throw #{build @exception}"

  # ### Binary operators
  # All of these are rerouted to the `binary_operator` builder.

  '+':   -> re('binary_operator', @, '+')
  '-':   -> re('binary_operator', @, '-')
  '*':   -> re('binary_operator', @, '*')
  '/':   -> re('binary_operator', @, '/')
  '%':   -> re('binary_operator', @, '%')
  '>':   -> re('binary_operator', @, '>')
  '<':   -> re('binary_operator', @, '<')
  '&':   -> re('binary_operator', @, '&')
  '|':   -> re('binary_operator', @, '|')
  '^':   -> re('binary_operator', @, '^')
  '&&':  -> re('binary_operator', @, 'and')
  '||':  -> re('binary_operator', @, 'or')
  'in':  -> re('binary_operator', @, 'in')
  '==':  -> re('binary_operator', @, '==')
  '<<':  -> re('binary_operator', @, '<<')
  '<=':  -> re('binary_operator', @, '<=')
  '>>':  -> re('binary_operator', @, '>>')
  '>=':  -> re('binary_operator', @, '>=')
  '!=':  -> re('binary_operator', @, '!=')
  '===': -> re('binary_operator', @, 'is')
  '!==': -> re('binary_operator', @, 'isnt')

  'instanceof': -> re('binary_operator', @, 'instanceof')

  'binary_operator': (sign) ->
    "#{build @left()} #{sign} #{build @right()}"

  # ### Increments and decrements
  # For `a++` and `--b`.

  '--':     -> re('increment_decrement', @, '--')
  '++':     -> re('increment_decrement', @, '++')

  'increment_decrement': (sign) ->
    if @postfix
      "#{build @left()}#{sign}"
    else
      "#{sign}#{build @left()}"

  # `=` (aka, assignment)  
  # For `a = b` (but not `var a = b`: that's `var`).

  '=': ->
    sign = if @assignOp?
      Types[@assignOp] + '='
    else
      '='

    "#{build @left()} #{sign} #{build @right()}"

  # `,` (aka, comma)  
  # For `a = 1, b = 2'

  ',': ->
    list = _.map @children, (item) -> build(item) + "\n"
    list.join('')

  # `regexp`  
  # Regular expressions.
  #
  'regexp': ->
    m     = @value.toString().match(/^\/(.*)\/([a-z]?)/)
    value = m[1]
    flag  = m[2]

    # **Caveat:**
    # *If it begins with `=` or a space, the CoffeeScript parser will choke if
    # it's written as `/=/`. Hence, they are written as `new RegExp('=')`.*

    begins_with = value[0]

    if begins_with in [' ', '=']
      if flag.length > 0
        "RegExp(#{strEscape value}, \"#{flag}\")"
      else
        "RegExp(#{strEscape value})"
    else
      "/#{value}/#{flag}"

  'string': ->
    strEscape @value

  # `call`  
  # A Function call.
  # `@left` is an `id`, and `@right` is a `list`.

  'call': ->
    if @right().children.length == 0
      "#{build @left()}()"
    else
      "#{build @left()}(#{build @right()})"

  # `call_statement`  
  # A `call` that's on it's own line.

  'call_statement': ->
    left = build @left()

    # **Caveat:**
    # *When calling in this way: `function () { ... }()`,
    # ensure that there are parenthesis around the anon function
    # (eg, `(-> ...)()`).*

    left = paren(left)  if @left().typeName() == 'function'

    if @right().children.length == 0
      "#{left}()"
    else
      "#{left} #{build @right()}"

  # `list`  
  # A parameter list.

  'list': ->
    list = _.map(@children, (item) -> build(item))

    list.join(", ")

  'delete': ->
    ids = _.map(@children, (el) -> build(el))
    ids = ids.join(', ')
    "delete #{ids}\n"

  # `.` (scope resolution?)  
  # For instances such as `object.value`.

  '.': ->
    # **Caveat:**
    # *If called as `this.xxx`, it should use the at sign (`@xxx`).*

    if @left().typeName() == 'this'
      "@#{build @right()}"
    else
      "#{build @left()}.#{build @right()}"

  'try': ->
    c = new Code
    c.add 'try'
    c.scope body(@tryBlock)

    _.each @catchClauses, (clause) ->
      c.add build(clause)

    if @finallyBlock?
      c.add "finally"
      c.scope body(@finallyBlock)

    c

  'catch': ->
    c = new Code
    if @varName?
      c.add "catch #{@varName}"
    else
      c.add 'catch'

    c.scope body(@block)
    c

  # `?` (ternary operator)  
  # For `a ? b : c`. Note that these will always be parenthesized, as (I
  # believe) the order of operations in JS is different in CS.
  '?': ->
    "(if #{build @left()} then #{build @children[1]} else #{build @children[2]})"

  'for': ->
    c = new Code

    if @setup?
      c.add "#{build @setup}\n"

    if @condition?
      c.add "while #{build @condition}\n"
    else
      c.add "while true"

    c.scope body(@body)
    c.scope body(@update)  if @update?
    c

  'for_in': ->
    c = new Code

    c.add "for #{build @iterator} of #{build @object}"
    c.scope body(@body)
    c

  'while': ->
    c = new Code

    c.add "while #{build @condition}"
    c.scope body(@body)
    c

  'do': ->
    c = new Code

    c.add "while true"
    c.scope body(@body)
    c.scope "break unless #{build @condition}"  if @condition?

    c

  'if': ->
    c = new Code

    c.add "if #{build @condition}"
    c.scope body(@thenPart)

    if @elsePart?
      if @elsePart.typeName() == 'if'
        c.add "else #{build(@elsePart).toString()}"
      else
        c.add "else\n"
        c.scope body(@elsePart)

    c

  'switch': ->
    c = new Code

    c.add "switch #{build @discriminant}\n"

    _.each @cases, (item) ->

      if item.value == 'default'
        c.scope "else"
      else
        c.scope "when #{build item.caseLabel}\n"

      c.scope body(item.statements, noBreak: true), 2

      first = false

    c

  'array_init': ->
    if @children.length == 0
      "[]"
    else
      list = re('list', @)
      "[ #{list} ]"

  # `property_init`  
  # Belongs to `object_init`;
  # left is a `identifier`, right can be anything.

  'property_init': ->
    "#{re 'property_identifier', @left()}: #{build @right()}"

  # `object_init`  
  # An object initializer.
  # Has many `property_init`.

  'object_init': ->
    if @children.length == 0
      "{}"

    else if @children.length == 1
      build @children[0]

    else
      list = _.map @children, (item) -> build item

      c = new Code
      c.scope list.join("\n")
      c

  # `function`  
  # A function. Can be an anonymous function (`function () { .. }`), or a named
  # function (`function name() { .. }`).

  'function': ->
    c = new Code

    params = _.map(@params, (str) -> re('id_param', str))

    if @name
      c.add "#{@name} = "

    if @params.length > 0
      c.add "(#{params.join ', '}) ->"
    else
      c.add "->"

    c.scope body(@body, returnable: true)
    c

  'var': ->
    list = _.map @children, (item) ->
      "#{item.value} = #{build(item.initializer)}"  if item.initializer?

    _.compact(list).join("\n") + "\n"

  # ### Unsupported things
  #
  # Due to CoffeeScript limitations, the following things are not supported:
  #
  #  * New getter/setter syntax (`x.prototype = { get name() { ... } };`)
  #  * Break labels (`my_label: ...`)
  #  * Constants

  'other':  -> @unsupported "#{@typeName()} is not supported yet"
  'getter': -> @unsupported "getter syntax is not supported; use __defineGetter__"
  'setter': -> @unsupported "setter syntax is not supported; use __defineSetter__"
  'label':  -> @unsupported "labels are not supported by CoffeeScript"
  'const':  -> @unsupported "consts are not supported by CoffeeScript"

Builders.block = Builders.script

# ## Unsupported Error exception

class UnsupportedError
  constructor: (str, src) ->
    @message = str
    @cursor  = src.start
    @line    = src.lineno
    @source  = src.tokenizer.source

  toString: -> @message

# ## Code snippet helper
# A helper class to deal with building code.

class Code
  constructor: ->
    @code = ''

  add: (str) ->
    @code += str.toString()
    @

  scope: (str, level=1) ->
    indent = strRepeat("  ", level)
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
  if typeof str == 'object'
    delete str.tokenizer  if str.tokenizer?
    console.log str
  else if str.constructor == String
    console.log JSON.stringify(str)
  else
    console.log str
  ''

# `unreserve()`  
# Picks the next best thing for a reserved keyword.
# Example:
#
#     "in"    => "in_"
#     "hello" => "hello"
#     "off"   => "off"
#
unreserve = (str) ->
  if "#{str}" in ['in', 'loop', 'off', 'on', 'when', 'not', 'until', '__bind', '__indexOf']
    "#{str}_"
  else
    "#{str}"

# ## Exports

exports =
  version: '0.0.4'
  build: buildCoffee
  UnsupportedError: UnsupportedError

if window?
  window.Js2coffee = exports

if module?
  module.exports = exports
