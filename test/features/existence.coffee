ifChecks = ->
  yes  if x
  yes  unless x
ifNullChecks = ->
  yes  unless x?
  nah  if x is null
voidChecks = ->
  yes  unless x?
  nah  if x is undefined
  yes  unless x?
undefinedChecks = ->
  nah  if typeof x is "undefined"
edgeCase = ->
  nah  if not x is y
unlessChecks = ->
  yes  if x?
  nah  if x isnt null
  wat  unless typeof x is "undefined"
whileAndFor = ->
  until x?
    yes
  while x is null
    yes
  a
  while not x?
    yes
    2
