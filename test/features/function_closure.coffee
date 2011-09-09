foo = (bar) ->
  closed_over = undefined
  baz = (i) ->
    closed_over
  do_it()
