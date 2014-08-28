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
