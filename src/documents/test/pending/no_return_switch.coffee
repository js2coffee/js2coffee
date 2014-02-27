switchWithReturn = ->
  switch day
    when "Mon" then work
    when "Tue" then relax
    else
      iceFishing
switchWithoutReturn = ->
  switch day
    when "Mon" then return work
    when "Tue" then relax
    else
      return iceFishing
  return
