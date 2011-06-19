ifChecks = ->
  yes  if x
  yes  unless x
ifNullChecks = ->
  yes  if not x?
  nah  if x == null
voidChecks = ->
  yes  if not x?
  nah  if x == undefined
  yes  if not x?
undefinedChecks = ->
  nah  if typeof x == "undefined"
edgeCase = ->
  nah  if not x == y
unlessChecks = ->
  yes  unless not x?
  nah  if x != null
  wat  unless typeof x == "undefined"
whileAndFor = ->
  while not x?
    yes
  while x == null
    yes
  a
  while not x?
    yes
    2
