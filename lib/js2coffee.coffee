if typeof module == 'undefined'
  narcissus = this.Narcissus
  _         = this._
else
  narcissus = require('./narcissus_packed')
  _         = require('underscore')

tokens = narcissus.definitions.tokens
parser = narcissus.parser

# Some helpers for Narcissus nodes
parser.Node.prototype.left  = -> @children[0]
parser.Node.prototype.right = -> @children[1]

# Returns the typename in lowercase. (eg, 'function')
parser.Node.prototype.typeName = -> Types[@type]

# Build a given item
build = (item, opts={}) ->
  name = 'other'
  name = item.typeName()  if item != undefined and item.typeName

  out = (Tokens[name] or Tokens.other).apply(item, [opts])

  if item.parenthesized? then "(#{out})" else out

# Builds a body
body = (item, opts={}) ->
  str = trim(build(item, opts))
  if str.length > 0 then str else "true"

# Returns the list of tokens as an array.
getTokens = ->
  dict = {}
  for i of tokens
    dict[tokens[i]] = i.toLowerCase()  if typeof tokens[i] == 'number'

  dict

strRepeat = (str, times) ->
  (str for i in [0...times]).join('')

# Reroute to another token handler
re = (type, str, args...) ->
  Tokens[type].apply str, args

trim = (str) ->
  str.replace(/^\s*|\s*$/g, '')

strEscape = (str) ->
  str = str.replace(/"/g, '\"')
  "\"#{str}\""

Types = getTokens()

# The builders
# Each of these functions are apply'd to a Node, and is expected to return
# a string representation of it CoffeeScript counterpart.
Tokens =
  'script': ->
    c = new Code

    _.each(@children, (decl) -> c.add build(decl))  if @children?

    c.toString()

  'identifier': ->
    @value

  'number': ->
    "#{@value}"

  'id': ->
    # Account for reserved keywords
    if @toString() in ['in', 'loop', 'off', 'on', 'when', 'not', 'until', '__bind', '__indexOf']
      # TODO: issue a warning
      "#{@}_"
    else
      @

  # Function parameters
  'id_param': ->
    if @toString() in ['undefined']
      "#{@}_"
    else
      re 'id', @

  'return': ->
    if @value?
      "return #{build(@value)}"  # id
    else
      "return"

  ';': ->
    # Optimize: "alert(2)" should be "alert 2" and omit extra
    # parentheses. Only do this if it's the main statement in
    # the line.
    if @expression.typeName() == 'call'
      re('call_statement', @expression) + "\n"

    else
      build(@expression) + "\n"

  'new':           -> "new #{build @left()}"
  'new_with_args': -> "new #{build @left()}(#{build @right()})"

  'unary_plus':  -> "+#{build @left()}"
  'unary_minus': -> "-#{build @left()}"

  'this':  -> '@'
  'null':  -> 'null'
  'true':  -> 'true'
  'false': -> 'false'
  'void':  -> 'undefined'

  'break':    -> "break\n"
  'continue': -> "continue\n"

  '++':     -> "#{build @left()}++"
  '--':     -> "#{build @left()}--"
  '=':      -> "#{build @left()} = #{build @right()}"
  '~':      -> "~#{build @left()}"
  'typeof': -> "typeof #{build @left()}"
  'index':  -> "#{build @left()}[#{build @right()}]"
  'throw':  -> "throw #{build @exception}"

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

  'regexp': ->
    m     = @value.toString().match(/^\/(.*)\/([a-z]?)/)
    value = m[1]
    flag  = m[2]

    begins_with = value[0]

    if begins_with in [' ', '=']
      if flag.length > 0
        "RegExp(#{strEscape value}, '#{flag}')"
      else
        "RegExp(#{strEscape value})"
    else
      "/#{value}/#{flag}"

  'string': ->
    strEscape @value

  'call': ->
    # Often (id, list)
    if @right().children.length == 0
      "#{build @left()}()"
    else
      "#{build @left()}(#{build @right()})"

  'call_statement': ->
    # Often (id, list)
    if @right().children.length == 0
      "#{build @left()}()"
    else
      "#{build @left()} #{build @right()}"

  'list': ->
    list = _.map(@children, (item) -> build(item))

    list.join(", ")

  'delete': ->
    ids = _.map(@children, (el) -> build(el))
    ids = ids.join(', ')
    "delete #{ids}\n"

  'binary_operator': (sign) ->
    "#{build @left()} #{sign} #{build @right()}"

  '.': ->
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

  '?': ->
    "if #{build @left()} then #{build @children[1]} else #{build @children[2]}"

  'label': ->
    throw "Not supported yo"

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
    list = re('list', @)
    "[ #{list} ]"

  'property_init': ->
    "#{build @left()}: #{build @right()}"

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

  'block': ->
    statements = _.map(@children, (item) -> build(item))
    statements.join("")

  'function': ->
    c = new Code

    params = _.map(@params, (str) -> re('id_param', str))

    if @name
      c.add "#{@name} = "

    if @params
      c.add "(#{params.join ', '}) ->"
    else
      c.add "->"

    c.scope body(@body)
    c

  'var': ->
    list = _.map @children, (item) ->
      "#{item.value} = #{build(item.initializer)}"  if item.initializer?

    _.compact(list).join("\n") + "\n"

  'other': -> "/* #{@typeName()}? */"
  'getter': -> throw new UnsupportedError("getter syntax is not supported; use __defineGetter__", @)
  'setter': -> throw new UnsupportedError("setter syntax is not supported; use __defineSetter__", @)
  'const':  -> throw new UnsupportedError("consts are not supported by CoffeeScript", @)

class UnsupportedError
  constructor: (str, src) ->
    @message = str
    @cursor  = src.start
    @line    = src.lineno
    @source  = src.tokenizer.source

#
# Code snippet helper
#
class Code
  constructor: ->
    @code = ''

  add: (str) ->
    @code += str.toString()
    @

  scope: (str, level=1) ->
    indent = strRepeat("  ", level)
    @code  = @code.replace(/\s*$/, '') + "\n"
    @code += indent + trim(str).replace(/\n/g, "\n#{indent}") + "\n"
    @

  toString: ->
    @code

# Debugging tool
p = (str) ->
  delete str.tokenizer  if str.tokenizer?
  console.log str
  ''

exports =
  build: (str) ->
    trim(build(parser.parse(str)))
  UnsupportedError: UnsupportedError

if typeof module == 'undefined'
  this.Js2coffee = exports
else
  module.exports = exports
