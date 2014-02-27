noReturn = ->
  f()
  return
noReturnIf1 = ->
  if condition
    doSomething()
    1
  else
    doSomethingElse()
  return
noReturnIf2 = ->
  if condition
    doSomething()
  else
    doSomethingElse()
    2
  return
