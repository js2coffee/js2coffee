i = 0
while i < 5
  if i is 2
    ++i
    continue
  alert i
  ++i
i = 0
while i < 5
  switch i
    when 1
      alert "one"
    when 2, 3
      ++i
      continue
    else
      alert i
  ++i