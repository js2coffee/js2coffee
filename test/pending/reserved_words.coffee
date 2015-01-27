# the following wouldn't actually compile with the latest coffeescript, so I've commented it out

###
off = 2
window = 2
((window, undefined) ->
  console.log off
) window
###
