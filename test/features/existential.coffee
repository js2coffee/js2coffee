ifChecks = ->
  if x
    alert "if x"
  unless x
    alert "if !x"
ifNullChecks = ->
  if x?
    alert "x == null"
  if x?
    alert "x === null"
voidChecks = ->
  if x?
    alert "x == void 0"
  if x?
    alert "x === void 0"
  if x?
    alert "x == void 1"
undefinedChecks = ->
  if x?
    alert "typeof x == 'undefined'"
edgeCase = ->
  if not x == y
    alert "!x == y"
unlessChecks = ->
  unless x?
    alert "x != null"
  unless x?
    alert "x !== null"
  unless x?
    alert "typeof x != 'undefined'"
whileAndFor = ->
  while x?
    alert
  while x?
    alert
  a
  while x?
    alert
    2
