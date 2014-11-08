for(i = 0; i < 2; i++) continue;

for(i = 0; i < 3; i++) if(i == 2) continue;

for(i = 0; i < 4; i++) {
  alert(i);
  continue;
}

for(i = 0; i < 5; ++i) {
  if(i == 2) {
    continue;
  }
  alert(i);
}

for(i = 0; i < 6; i++) {
  if(i == 2) continue;
  for(j = 0; j < 6; j++) {
    if(i == j) {
      alert(j);
    } else {
      continue;
    }
  }
}

for(i = 0; i < 7; ++i) {
  switch(i) {
  case 1:
    alert("one");
  break;
  case 2:
  case 3:
    continue;
  break;
  default:
    alert(i);
  }
}