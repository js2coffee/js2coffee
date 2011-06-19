ifChecks = ->
  yes  if x
  yes  unless x
ifNullChecks = ->
  yes  unless x?
  nah  if x == null
voidChecks = ->
  yes  unless x?
  nah  if x == undefined
  yes  unless x?
undefinedChecks = ->
  nah  if typeof x == "undefined"
edgeCase = ->
  nah  if not x == y
unlessChecks = ->
  yes  if x?
  nah  if x != null
  wat  unless typeof x == "undefined"
whileAndFor = ->
  until x?
    yes
  while x == null
    yes
  a
  while not x?
    yes
    2
