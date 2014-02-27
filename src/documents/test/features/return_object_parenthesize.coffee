parenthesized = ->
  return (
    a: 1
    b: 2
  )
  a()
  return
not_parenthesized = ->
  return a: 1
  a()
  return
parenthesized_b = ->
  if something()
    a: 1
    b: 2
parenthesized_c = ->
  if something()
    return (
      a: 1
      b: 2
    )
  a()
  return
