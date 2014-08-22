i = 0
while i < 5
  continue  if i is 2
  alert i
  ++i
i = 0
while i < 5
  switch i
    when 1
      alert "one"
    when 2, 3
      continue
    else
      alert i
  ++i