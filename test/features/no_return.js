function noReturn() {
  f();
}

function noReturnIf1() {
  if (condition) {
    doSomething();
    return 1;
  }
  else {
    doSomethingElse();
  }
}

function noReturnIf2() {
  if (condition) {
    doSomething();
  }
  else {
    doSomethingElse();
    return 2;
  }
}
