exports.delimit = (list, joiner) ->
  newlist = []
  for item, i in list
    newlist.push(joiner) if i > 0
    newlist.push(item)
  newlist

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
#     err.lineNumber #=> 3
#     err.column     #=> 1
#     err.description
#     err.sourcePreview
#     err.message    # => "index.js:3:1: Unexpected indentifier\n..."
###

exports.buildError = (err, source, file = '') ->
  {lineNumber, column, description} = err
  ln = lineNumber

  heading = "#{file}:#{ln}:#{column}: #{description}"

  # Build a source preview.
  lines = source.split("\n")
  min = Math.max(ln-3, 0)
  max = ln-1
  source = lines[min..max].map (ln, i) -> "#{1+i+min}   #{ln}"
  source.push "    " + Array(column).join("-") + "^"
  source = source.join("\n")

  message = heading + "\n\n" + source

  err = new Error(message)
  err.lineNumber    = lineNumber
  err.column        = column
  err.description   = description
  err.sourcePreview = source
  err

