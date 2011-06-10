ifChecks = ->
  yes  if x
  yes  unless x
ifNullChecks = ->
  yes  if x?
  nah  if x == null
voidChecks = ->
  yes  if x?
  nah  if x == undefined
  yes  if x?
undefinedChecks = ->
  nah  if typeof x == "undefined"
edgeCase = ->
  nah  if not x == y
unlessChecks = ->
  yes  unless x?
  nah  if x != null
  wat  unless typeof x == "undefined"
whileAndFor = ->
  while x?
    yes
  while x == null
    yes
  a
  while x?
    yes
    2
