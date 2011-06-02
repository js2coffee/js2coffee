js2c = require('./js2coffee')
build = js2c.build

tryit = (str) ->
  console.log '-----'
  console.log build(str)

tryit 'function z (a,b) { 2 + 2; return function() { 2 }; }'
tryit 'delete 2'
tryit '\'hi\''
tryit 'alert(\"hello\", 2)'
tryit 'console();'
tryit 'a.i'
tryit 'this.i'
tryit 'this.i = 4 - (2 / 5)'
tryit 'new Foo'
tryit 'new Foo(2)'
tryit 'new Foo(2,4)'
tryit '+2'
tryit '-2'
tryit 'a++'
tryit 'try { x; 2 + 2; } catch (e) { y } finally { oeu }'
tryit '~a'
tryit 'typeof 2'
tryit 'x[y]'
tryit '2.50'
tryit 'a ? b : c'
tryit 'if (a == 2) { x = 4; 4 + 4; }'
tryit 'if (a == 2) { x = 4; } else y = 2;'
tryit 'if (a == 2) { x = 4; } else if (true) { y = 2; } else if (false) { z = 4; } else { 2; }'
tryit 'function x() { return; }'
tryit 'for (a = 2; a < 10; a++) { console.log(a); }'
tryit 'for (;; a++) { console.log(forever); }'
tryit 'for (a in b) { b(); }'
tryit '2 / (2 + 4)'
tryit '2 + undefined'
tryit 'function x(a, undefined) { }'
tryit 'x = void 0;'
tryit 'x = / euoeu/g'
tryit 'x = / euoeu/'
tryit 'x = /euoeu/'
tryit 'while (true) { break; }'
tryit 'do { x } while (true);'
tryit "switch (foo) { case X: true; break; case Y: 234; break; default: 234; }"
tryit "switch (foo) { default: 2; }"
tryit "[2, 4]"
tryit "hash = { x: 2, y: 4 }"
tryit "throw x;"
tryit "/* hi */"
tryit "foo({ x: 2, y: function() { x + x; } })"
tryit "foo({ x: 2 })"
tryit "y = { x: 2 }"

#console.log build('var x = 2234; var y = function (a,b) { return x; }')
