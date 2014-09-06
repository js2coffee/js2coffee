exports.delimit = (list, joiner) ->
  newlist = []
  for item, i in list
    newlist.push(joiner) if i > 0
    newlist.push(item)
  newlist

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
#       lineNumber: 3
#       column: 1
#     err = buildError(e, code, "index.js")
#
#     err.message       #=> "index.js:3:1: Unexpected indentifier\n..."
#     err.lineNumber    #=> 3
#     err.column        #=> 1
#     err.description   #=> "Unexpected identifier"
#     err.sourcePreview
###

exports.buildError = (err, source, file = '') ->
  if err.js2coffee then return err

  {lineNumber, column, description} = err
  ln = lineNumber

  heading = "#{file}:#{ln}:#{column}: #{description}"

  # Build a source preview.
  lines = source.split("\n")
  min = Math.max(ln-3, 0)
  max = ln-1
  digits = max.toString().length
  pad = (s) -> Array(1 + digits - s.toString().length).join(" ") + s
  source = lines[min..max].map (ln, i) -> "#{pad(1+i+min)}  #{ln}"
  source.push Array(digits + 3).join(" ") + Array(column).join("-") + "^"
  source = source.join("\n")

  message = heading + "\n\n" + source

  err = new Error(message)
  err.lineNumber    = lineNumber
  err.column        = column
  err.description   = description
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
