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
Node::left  = -> @children[0]
Node::right = -> @children[1]
Node::last  = -> @children[@children.length-1]

Node::clone = (hash) ->
  for i of @
    continue  if i in ['tokenizer', 'length', 'filename']
    hash[i] ?= @[i]

  new Node(@tokenizer, hash)

# `inspect()`  
# For debugging
Node::toHash = ->
  hash = {}

  toHash = (what) ->
    return null  unless what
    if what.toHash then what.toHash() else what

  hash.type = @typeName()
  hash.src  = @src()

  for i of @
    continue  if i in ['filename', 'length', 'type', 'start', 'end', 'tokenizer', 'lineno']
    continue  if typeof @[i] == 'function'
    continue  unless @[i]

    if @[i].constructor == Array
      hash[i] = _.map(@[i], (item) -> toHash(item))

    else
      hash[i] = toHash(@[i])

  hash

Node::inspect = ->
  JSON.stringify @toHash(), null, '  '

# `src()`  
# Returns the source for the node.
Node::src   = -> @tokenizer.source.substr(@start, @end-@start)

# `unsupported()`  
# Throws an unsupported error.
Node::unsupported = (msg) ->
  throw new UnsupportedError("Unsupported: #{msg}", @)

# `typeName()`  
# Returns the typename in lowercase. (eg, 'function')
Node::typeName = -> Types[@type]

# `isA()`  
# Typename check.
Node::isA = (what...) -> Types[@type] in what

# ## Main functions

# `build()`  
# This finds the appropriate builder function for `node` based on it's type,
# the passes the node onto that function.
#
# For instance, for a `function` node, it calls `Builders.function(node)`.
# It defaults to `Builders.other` if it can't find a function for it.
build = (node, opts={}) ->
  transform node

  name = 'other'
  name = node.typeName()  if node != undefined and node.typeName

  out = (Builders[name] or Builders.other).apply(node, [opts])

  if node.parenthesized then paren(out) else out

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

Types = do ->
  dict = {}
  last = 0
  for i of tokens
    if typeof tokens[i] == 'number'
      dict[tokens[i]] = i.toLowerCase()
      last = tokens[i]

  # Now extend it with a few more
  dict[++last] = 'call_statement'
  dict[++last] = 'existential'

  dict

# Inverse of Types
Typenames = do ->
  dict = {}
  for i of Types
    dict[Types[i]] = i

  dict

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

    # *Functions must always be declared first in a block.*
    _.each @functions,    (item) -> c.add build(item)
    _.each @nonfunctions, (item) -> c.add build(item)

    c.toString()

  # `property_identifier`  
  # A key in an object literal.

  'property_identifier': ->
    str = @value.toString()

    # **Caveat:**
    # *In object literals like `{ '#foo click': b }`, ensure that the key is
    # quoted if need be.*

    if str.match(/^([_\$a-z][_\$a-z0-9]*)$/i) or str.match(/^[0-9]+$/i)
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
    if not @value?
      "return\n"

    else
      "return #{build(@value)}\n"

  # `;` (aka, statement)  
  # A single statement.

  ';': ->
    # **Caveat:**
    # Some statements can be blank as some people are silly enough to use `;;`
    # sometimes. They should be ignored.
    unless @expression?
      ""

    else if @expression.typeName() == 'object_init'  # TODO: remove this
      src = re('object_init', @expression)
      if @parenthesized
        src
      else
        src = unshift(blockTrim(src))
        "#{src}\n"

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

  'debugger': -> "debugger\n"
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
  '<<':  -> re('binary_operator', @, '<<')
  '<=':  -> re('binary_operator', @, '<=')
  '>>':  -> re('binary_operator', @, '>>')
  '>=':  -> re('binary_operator', @, '>=')
  '!=':  -> re('binary_operator', @, '!=')
  '===': -> re('binary_operator', @, '==')
  '!==': -> re('binary_operator', @, '!=')

  '==':  ->
    re('binary_operator', @, '==') # CHANGEME: Yes, this is wrong

  '!=':  ->
    re('binary_operator', @, '!=') # CHANGEME: Yes, this is wrong

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

    # **Caveat:**
    # *If called as `x.prototype`, it should use double colons (`x::`).*

    left  = build @left()
    right = build @right()

    if @isThis and @isPrototype
      "@::"
    else if @isThis
      "@#{right}"
    else if @isPrototype
      "#{left}::"
    else if @left().isPrototype
      "#{left}#{right}"
    else
      "#{left}.#{right}"

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
      c.add "loop"

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

    keyword = if @positive then "while" else "until"
    c.add "#{keyword} #{build @condition}"
    c.scope body(@body)
    c

  'do': ->
    c = new Code

    c.add "loop"
    c.scope body(@body)
    c.scope "break unless #{build @condition}"  if @condition?

    c

  'if': ->
    c = new Code

    keyword = if @positive then "if" else "unless"

    c.add "#{keyword} #{build @condition}"
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

      c.scope body(item.statements), 2

      first = false

    c

  'existential': ->
    "#{build @left()}?"

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

  'object_init': (options={}) ->
    if @children.length == 0
      "{}"

    else if @children.length == 1
      build @children[0]

    else
      list = _.map @children, (item) -> build item

      c = new Code
      c.scope list.join("\n")
      c = "{#{c}}"  if options.brackets?
      c

  # `function`  
  # A function. Can be an anonymous function (`function () { .. }`), or a named
  # function (`function name() { .. }`).

  'function': ->
    c = new Code

    params = _.map @params, (str) ->
      if str.constructor == String
        re('id_param', str)
      else
        build str

    if @name
      c.add "#{@name} = "

    if @params.length > 0
      c.add "(#{params.join ', '}) ->"
    else
      c.add "->"

    c.scope body(@body)
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

transform = (node, args...) ->
  type = node.typeName()
  fn   = Transformers[type]

  fn.apply(node, args)  if fn

# ## AST manipulation
# Manipulation of the abstract syntax tree happens here. All these are done on
# the `build()` step, done just before a node is passed onto `Builders`.

Transformers =
  'script': ->
    @functions    = []
    @nonfunctions = []

    _.each @children, (item) =>
      if item.isA('function')
        @functions.push item
      else
        @nonfunctions.push item

    last = null

    # *Statements don't need parens, unless they are consecutive object
    # literals.*
    _.each @nonfunctions, (item) =>
      if item.expression?
        expr = item.expression

        if last?.isA('object_init') and expr.isA('object_init')
          item.parenthesized = true
        else
          item.parenthesized = false

        last = expr

  '.': ->
    @isThis      = @left().isA('this')
    @isPrototype = (@right().isA('identifier') and @right().value == 'prototype')

  ';': ->
    if @expression?
      # *Statements don't need parens.*
      @expression.parenthesized = false

      # *If the statement only has one function call (eg, `alert(2);`), the
      # parentheses should be omitted (eg, `alert 2`).*
      if @expression.isA('call')
        @expression.type = Typenames['call_statement']

  'function': ->
    walk = (parent, node, fn) ->
      return  unless node

      fn parent, node  if parent

      walk node, node.last(), fn
      walk node, node.thenPart, fn
      walk node, node.elsePart, fn

    # *Unwrap the `return`s.*
    walk null, @body, (parent, node) ->
      if node.isA('return') and node.value
        parent.children[parent.children.length-1] = node.value

  'switch': ->
    _.each @cases, (item) =>
      block = item.statements
      ch    = block.children

      # *CoffeeScript does not need `break` statements on `switch` blocks.*
      delete ch[ch.length-1]  if block.last().isA('break')

  'block': ->
    Transformers.script.apply(@)

  'if': ->
    Transformers.inversible.apply(@)

  'while': ->
    Transformers.inversible.apply(@)

  'inversible': ->
    # *Invert a '!='. (`if (x != y)` => `unless x is y`)*
    if @condition.isA('!=')
      @condition.type = Typenames['==']
      @positive = false

    # *Invert a '!'. (`if (!x)` => `unless x`)*
    else if @condition.isA('!')
      @condition = @condition.left()
      @positive = false

    else
      @positive = true

  '!=': ->
    if @right().isA('null', 'void')
      @type     = Typenames['!']
      @children = [@clone(type: Typenames['existential'], children: [@left()])]

  '==': ->
    if @right().isA('null', 'void')
      @type     = Typenames['existential']
      @children = [@left()]

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

isSingleLine = (str) ->
  "\n" in trim(str)

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
  version: '0.0.5'
  build: buildCoffee
  UnsupportedError: UnsupportedError

if window?
  window.Js2coffee = exports

if module?
  module.exports = exports
