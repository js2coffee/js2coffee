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

{parser} = @Narcissus or require('./narcissus_packed')

_ = @_ or require('underscore')

{Types, Typenames, Node, UnsupportedError} = @NodeExt or require('./node_ext')

{Code, p, strEscape, unreserve,
unshift, isSingleLine,
trim, blockTrim, ltrim,
rtrim, strRepeat, paren} = @Js2coffeeHelpers or require('./helpers')

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

# `transform()`  
# Perform a transformation on the node, if a transformation function is
# available.

transform = (node, args...) ->
  type = node.typeName()
  fn   = Transformers[type]

  fn.apply(node, args)  if fn

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
    "#{@src()}"

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

    else if @expression.typeName() == 'object_init'
      src = re('object_init', @expression)
      if @parenthesized
        src
      else
        "#{unshift(blockTrim(src))}\n"

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
  'in':  -> re('binary_operator', @, 'of')
  '<<':  -> re('binary_operator', @, '<<')
  '<=':  -> re('binary_operator', @, '<=')
  '>>':  -> re('binary_operator', @, '>>')
  '>=':  -> re('binary_operator', @, '>=')
  '!=':  -> re('binary_operator', @, '!=')
  '===': -> re('binary_operator', @, '==')
  '!==': -> re('binary_operator', @, '!=')

  '==':  ->
    # TODO: throw warning
    re('binary_operator', @, '==')

  '!=':  ->
    # TODO: throw warning
    re('binary_operator', @, '!=')

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

    left = paren(left)  if @left().isA('function')

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
    body_ = body(@block)
    return '' if trim(body_).length == 0

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
    body_   = body(@thenPart)

    if isSingleLine(body_) and !@elsePart?
      c.add "#{trim body_}  #{keyword} #{build @condition}\n"

    else
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

  'existence_check': ->
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

    body_ = body(@body)
    if trim(body_).length > 0
      c.scope body_
    else
      c.add "\n"
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
    # *Unwrap the `return`s.*
    @body.walk last: true, (parent, node) ->
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
      @children = [@clone(type: Typenames['existence_check'], children: [@left()])]

  '==': ->
    if @right().isA('null', 'void')
      @type     = Typenames['existence_check']
      @children = [@left()]

# ## Exports

@Js2coffee = exports =
  version: '0.0.5'
  build: buildCoffee
  UnsupportedError: UnsupportedError

module.exports = exports  if module?
