ifChecks = ->
  yep  if x
  yep  unless x
  return
ifNullChecks = ->
  yep  unless x?
  nah  if x is null
  return
voidChecks = ->
  yep  unless x?
  nah  if x is undefined
  yep  unless x?
  return
undefinedChecks = ->
  nah  if typeof x is "undefined"
  return
edgeCase = ->
  nah  if not x is y
  return
unlessChecks = ->
  yep  if x?
  nah  if x isnt null
  wat  unless typeof x is "undefined"
  return
whileAndFor = ->
  yep  until x?
  yep  while x is null
  a
  while not x?
    yep
    2
  return
