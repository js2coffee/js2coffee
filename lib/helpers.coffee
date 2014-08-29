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

# dirty
exports.buildError = (err, source, file) ->
  ln = err.lineNumber
  column = err.column
  desc = err.description

  lines = source.split("\n")
  heading = "#{file}:#{ln}:#{column}: #{desc}"

  min = ln-1
  max = ln+1

  source = lines[min..max].map (ln, i) -> "#{i+min}   #{ln}"

  message = [heading].concat([""]).concat(source)

  new Error(message.join("\n"))

