###
# delimit() : delimit(list, joiner)
# Intersperses `joiner` into `list`. Used for things like adding indentations.
#
#     delimit( [a, b, c], X )
#     => [a, X, b, X, c]
###

exports.delimit = (list, joiner) ->
  newlist = []
  for item, i in list
    newlist.push(joiner) if i > 0
    newlist.push(item)
  newlist

###*
# commaDelimit() : commaDelimit(list)
# Turns an array of strings into a comma-separated list. Takes new lines into
# account.
#
#     commaDelimit( [ 'a', 'b', 'c' ] )
#     => 'a, b, c'
###
#
exports.commaDelimit = (list) ->
  newlist = []
  for item, i in list
    if i > 0
      if /^\n/.test(item.toString())
        newlist.push(',')
      else
        newlist.push(', ')

    newlist.push(item)
  newlist

###*
# prependAll():
# Prepends every item in the `list` with a given `prefix\`.
#
#     prependAll( [ 1, 2, 3 ], 'x' )
#     => [ 'x', 1, 'x', 2, 'x', 3 ]
###

exports.prependAll = (list, prefix) ->
  newlist = []
  for item, i in list
    newlist.push(prefix)
    newlist.push(item)
  newlist

###*
# buildError():
# Builds a syntax error message.
#
#     e =
#       description: "Unexpected indentifier"
#       start: { line: 3, column: 1 }
#       end: { line: 3, column: 5 }
#     err = buildError(e, code, "index.js")
#
# Or esprima-like:
#
#     e =
#       description: "Unexpected indentifier"
#       lineNumber: 3,
#       column: 1
#     err = buildError(e, code, "index.js")
#
# Output:
#
#     err.message       #=> "index.js:3:1: Unexpected indentifier\n..."
#     err.start         #=> { line: 3, column: 1 }
#     err.end           #=> { line: 3, column: 5 }
#     err.description   #=> "Unexpected identifier"
#     err.sourcePreview
###

exports.buildError = (err, source, file = '') ->
  if err.js2coffee then return err

  {description} = err
  line = err.start?.line ? err.lineNumber
  column = err.start?.column ? (err.column && (err.column - 1)) ? 0

  heading = "#{file}:#{line}:#{column}: #{description}"

  # Build a source preview.
  lines = source.split("\n")
  min = Math.max(line-3, 0)
  max = line-1
  digits = max.toString().length
  length = 1
  length = Math.max(err.end.column - err.start.column, 1) if err.end
  pad = (s) -> Array(1 + digits - s.toString().length).join(" ") + s
  source = lines[min..max].map (line, i) -> "#{pad(1+i+min)}  #{line}"
  source.push Array(digits + 3).join(" ") + Array(column+1).join(" ") + Array(length+1).join("^")
  source = source.join("\n")

  message = heading + "\n\n" + source

  _err = err
  err = new Error(message)
  err.filename      = file
  err.description   = _err.description
  err.start         = { line, column }
  err.end           = _err.end
  err.sourcePreview = source
  err.js2coffee     = true
  err

###*
# space():
# Delimit using spaces. This also accounts for times where one of the
# statements begin with a new line, such as in the case of function
# expressions and object expressions.
#
#     space [ 'a', '=', 'b' ]
#     => [ 'a', ' ', '=', ' ', 'b' ]
#     space [ 'a', '=', '\n  b: 2' ]
#     => [ 'a', ' ', '=', '\n  b: 2' ]
###

exports.space = (list) ->
  list.reduce ((newlist, item, i) ->
    if i is 0
      newlist.concat [ item ]
    else if item.toString().substr(0, 1) is "\n"
      newlist.concat [ item ]
    else
      newlist.concat [ ' ', item ]
  ), []

###*
# newline():
# Appends a new line to a given SourceNode (what `walk()` returns). If it
# already ends in a newline, it is left alone.
#
#     newline(@walk(node.body))
#     => [ node, "\n" ]
###

exports.newline = (srcnode) ->
  if (/\n$/).test(srcnode.toString())
    srcnode
  else
    [ srcnode, "\n" ]

###*
# inspect():
# For debugging.
###
exports.inspect = (node) ->
  "~~~~\n" +
  require('util').inspect(node, depth: 1000, colors: true) +
  "\n~~~~"

###*
# replace() : replace(node, newNode)
# Fabricates a replacement node for `node` that maintains the same source
# location.
#
#     node = { type: "FunctionExpression", range: [0,1], loc: { ... } }
#     @replace(node, { type: "Identifier", name: "xxx" })
###

exports.replace = (node, newNode) ->
  newNode.range = node.range
  newNode.loc = node.loc
  newNode

###*
# clone() : clone(object)
# Duplicates an object.
###

exports.clone = (obj) ->
  JSON.parse JSON.stringify obj

###*
# quote() : quote(string)
# Quotes a string with single quotes.
#
#     quote("hello")
#     => "'hello'"
###

exports.quote = (str) ->
  if typeof str is 'string'
    # escape quotes
    re = str
      .replace(/\\/g, '\\\\')
      .replace(/'/g, "\\'")
      .replace(/\\"/g, '"')
      .replace(/\n/g, '\\n')
      .replace(/[\u0000-\u0019\u00ad\u200b\u2028\u2029\ufeff]/g,
        (x) -> "\\u#{x.charCodeAt(0).toString(16)}")
    "'#{re}'"

  else
    JSON.stringify(str)

###*
# getPrecedence() : getPrecedence(node)
# Returns the precedence level. If a node's precedence level is greater that
# its parent, it has to be parenthesized.
#
#     getPrecedence({ type: 'BinaryExpression', operator: '&' })
#     => 8
###

exports.getPrecedence = (node) ->
  type = node.type

  isOper = (ops) ->
    ops.indexOf(node.operator) > -1

  binExpressions =
      '**': 17 # coffee-only
      '*': 14
      '/': 14
      '%': 14
      '+': 13
      '-': 13
      '<<':  12
      '>>':  12
      '>>>': 12
      '<': 11
      '>': 11
      '<=':  11
      '>=':  11
      'in': 11
      'instanceof': 11
      '==': 10
      '===': 10
      '!=': 10
      '!==': 10
      '&': 9
      '^': 8
      '|': 7
    
    logExpressions =
      '&&': 6
      '||': 5

  switch type
    when 'Literal', 'Identifier'
      99
    when 'MemberExpression', 'CallExpression'
      18
    when 'NewExpression'
      if node.arguments.length is 0 then 17 else 18
    when 'UpdateExpression'
      if node.prefix then 15 else 16
    when 'UnaryExpression'
      15
    when 'BinaryExpression'
      binExpressions[node.operator]
    when 'LogicalExpression'
      logExpressions[node.operator]
    when 'ConditionalExpression'
      4
    when 'AssignmentExpression'
      3
    when 'SequenceExpression'
      0
    else
      -1

###*
# lastStatement() : lastStatement(body)
###

exports.lastStatement = (body) ->
  for i in [(body.length-1)..0]
    node = body[i]
    continue unless node
    if ! exports.isComment(node)
      return node

###*
# getReturnStatements():
# Returns the final return statements in a body.
###

exports.getReturnStatements = (body) ->
  {getReturnStatements, lastStatement} = exports

  # Find the last pertinent statement
  if !body
    return
  else if body.length
    node = lastStatement(body)
  else
    node = body

  # See what it is, recurse as needed
  if !node
    [ ]
  else if node.type is 'ReturnStatement'
    [ node ]
  else if node.type is 'BlockStatement'
    getReturnStatements node.body
  else if node.type is 'IfStatement' and node.consequent and node.alternate
    cons = getReturnStatements(node.consequent)
    alt  = getReturnStatements(node.alternate)

    if cons.length > 0 and alt.length > 0
      cons.concat(alt)
    else
      [ ]
  else
    [ ]

###*
# joinLines() : joinLines(properties, indent)
# Joins multiple tokens as lines. Takes trailing newlines into
# account.
#
#     joinLines(["a\n", "b", "c"], "  ")
#     => [ "  ", "a\n", "  ", "b", "\n", "  ", "c" ]
###

exports.joinLines = (props, indent) ->
  newlist = []

  for item, i in props
    newlist.push(indent)
    newlist.push(item)

    isLast = (i isnt props.length-1)
    if !item.toString().match(/\n$/) and isLast
      newlist.push "\n"

  newlist

###*
# reservedWords
###

exports.reserved =
  # taken from COFFEE_KEYWORDS (lexer.coffee)
  # (also, don't check for 'undefined' because it's already explicitly
  # accounted for elsewhere)
  keywords: [
    'then', 'unless', 'until', 'loop', 'of', 'by', 'when' ]

  # taken from RESERVED (lexer.coffee)
  reserved: [
    'case', 'default', 'function', 'var', 'void', 'with', 'const', 'let', 'enum'
    'export', 'import', 'native', '__hasProp', '__extends', '__slice', '__bind'
    '__indexOf', 'implements', 'interface', 'package', 'private', 'protected'
    'public', 'static', 'yield' ]

  # taken from COFFEE_ALIAS_MAP (lexer.coffee)
  aliases: [
    'and', 'or', 'is', 'isnt', 'not', 'yes', 'no', 'on', 'off' ]

exports.reservedWords =
  exports.reserved.keywords.concat \
  exports.reserved.reserved.concat \
  exports.reserved.aliases

###*
# Next until
###

exports.nextUntil = (body, node, fn) ->
  idx = body.indexOf(node)
  for i in [idx+1..body.length]
    next = body[i]
    return next if next?.type and fn(next)

###*
# Next until a non-comment node
###

exports.nextNonComment = (body, node) ->
  exports.nextUntil(body, node, (n) ->
    n.type isnt 'BlockComment' and
    n.type isnt 'LineComment')

###
# isLoop() : isLoop(node)
# Checks if a loop is forever
###

exports.isLoop = (node) ->
  not node.test? or exports.isTruthy(node.test)

###
# isTruthy() : isTruthy(node)
# Checks if a given node is truthy
###

exports.isTruthy = (node) ->
  (node.type is 'Literal' and node.value)

###
# escapeJs()
###

exports.escapeJs = (node) ->
  exports.replace node,
    type: 'CoffeeEscapedExpression'
    raw: require('escodegen').generate(node)

exports.nonComments = (body) ->
  body.filter (n) ->
    ! exports.isComment(n)

exports.isComment = (node) ->
  node.type is 'LineComment' or
  node.type is 'BlockComment'

exports.toIndent = (ind) ->
  if ind is 'tab' or ind is 't'
    "\t"
  else if typeof ind is 'string' and "#{+ind}" isnt ind
    ind
  else
    Array(+ind + 1).join " "
