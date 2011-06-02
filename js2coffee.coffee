tokens = require('narcissus').definitions.tokens
parser = require('narcissus').parser
_      = require('underscore')

parser.Node.prototype.left  = -> @children[0]
parser.Node.prototype.right = -> @children[1]

# Returns the typename in lowercase. (eg, 'function')
parser.Node.prototype.typeName = -> Types[@type]

# Build a given thing
build = (item) ->
  (Tokens[item.typeName()] or Tokens.other).apply(item)

# Builds a body
body = (item) ->
  str = build(item).trim()
  if str.length > 0 then str else "true"

# Returns the list of tokens as an array.
getTokens = ->
  dict = {}
  for i of tokens
    dict[tokens[i]] = i.toLowerCase()  if typeof tokens[i] == 'number'

  dict

# Reroute to another token handler
re = (type, str, args...) ->
  Tokens[type].apply str, args

Types = getTokens()

# The builders
# Each of these functions are apply'd to a Node, and is expected to return
# a string representation of it CoffeeScript counterpart.
Tokens =
  'script': ->
    c = new Code

    _.each(@varDecls, (decl) -> c.add build(decl))  if @varDecls?
    _.each(@children, (decl) -> c.add build(decl))  if @children?

    c.toString()

  'identifier': ->
    @value

  'number': ->
    "#{@value}"

  'id': ->
    @

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

  '++':     -> "#{build @left()}++"
  '--':     -> "#{build @left()}--"
  '=':      -> "#{build @left()} = #{build @right()}"
  '~':      -> "~#{build @left()}"
  'typeof': -> "typeof #{build @left()}"
  'index':  -> "#{build @left()}[#{build @right()}]"

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

  'string': ->
    str = @value
    str = str.replace(/"/g, '\"')

    "\"#{@value}\""

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
    str = "#{build @left()} #{sign} #{build @right()}"
    if @parenthesized? then "(#{str})" else str

  '.': ->
    if @left().typeName() == 'this'
      "@#{build @right()}"
    else
      "#{build @left()}.#{build @right()}"

  'try': ->
    c = new Code
    c.add 'try'
    c.scope body(@tryBlock)

    _.each @catchClauses, (clause) =>
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

  'block': ->
    statements = _.map(@children, (item) -> build(item))
    statements.join("")

  'function': ->
    c = new Code

    params = _.map(@params, (str) -> re('id', str))

    if @name
      c.add "#{@name} = "

    if @params
      c.add "(#{params.join ', '}) ->"
    else
      c.add "->"

    c.scope body(@body)
    c

  'other': ->
    "/* #{@typeName()} */"

#
# Code snippet helper
#
class Code
  constructor: ->
    @code = ''

  add: (str) ->
    @code += str.toString()
    @

  scope: (str) ->
    @code  = @code.replace(/\s*$/, '') + "\n"
    @code += "  " + str.toString().trim().replace(/\n/g, "\n  ") + "\n"
    @

  toString: ->
    @code


# Debugging tool
p = (str) ->
  delete str.tokenizer  if str.tokenizer?
  console.log str
  ''

module.exports =
  build: (str) ->
    build(parser.parse(str)).trim()
