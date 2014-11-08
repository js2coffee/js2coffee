i = 0
while i < 2
  i++
  continue
  i++
i = 0
while i < 3
  if i is 2
    i++
    continue
  i++
i = 0
while i < 4
  alert i
  i++
  continue
  i++
i = 0
while i < 5
  if i is 2
    ++i
    continue
  alert i
  ++i
i = 0
while i < 6
  if i is 2
    i++
    continue
  j = 0
  while j < 6
    if i is j
      alert j
    else
      j++
      continue
    j++
  i++
i = 0
while i < 7
  switch i
    when 1
      alert "one"
    when 2, 3
      ++i
      continue
    else
      alert i
  ++i