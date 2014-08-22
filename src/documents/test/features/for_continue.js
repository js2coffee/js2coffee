for(i = 0; i <5; ++i) {
   if(i == 2) {
       continue;
   }
   alert(i);
}

for(i = 0; i <5; ++i) {
   switch(i) {
   case 1:
       alert("one");
       break;
   case 2:
   case 3:
       continue
       break;
   default:
       alert(i);
   }
}