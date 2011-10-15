ifChecks = ->
  yep  if x
  yep  unless x
ifNullChecks = ->
  yep  unless x?
  nah  if x == null
voidChecks = ->
  yep  unless x?
  nah  if x == undefined
  yep  unless x?
undefinedChecks = ->
  nah  if typeof x == "undefined"
edgeCase = ->
  nah  if not x == y
unlessChecks = ->
  yep  if x?
  nah  if x != null
  wat  unless typeof x == "undefined"
whileAndFor = ->
  until x?
    yep
  while x == null
    yep
  a
  while not x?
    yep
    2
