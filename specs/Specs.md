<table width='100%'>
<thead>
  <tr>
    <th width='33%'>Example</th>
    <th width='33%'>JavaScript</th>
    <th width='33%'>CoffeeScript</th>
</thead>
<tr><th colspan='3'>Makefile</th></tr>
<tr><th colspan='3'>Specs.md</th></tr>
<tr><th colspan='3'>Arrays</th></tr>
<tr>
<th valign='top'>Empty array</th>
<td valign='top'>
<pre class='lang-js'>a = []
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = []
</pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple items</th>
<td valign='top'>
<pre class='lang-js'>a = [ 1, 2, 3, 4 ]
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = [
  1
  2
  3
  4
]
</pre>
</td>
</tr>
<tr><th colspan='3'>Comments</th></tr>
<tr>
<th valign='top'>Block comments</th>
<td valign='top'>
<pre class='lang-js'>a();
/*
 * hello
 */
b();
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a()
###
# hello
###
b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Block comments with space</th>
<td valign='top'>
<pre class='lang-js'>a(); /* hi */
b();
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a()
### hi ###
b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Line comments</th>
<td valign='top'>
<pre class='lang-js'>a();
// hello
b();
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a()
# hello
b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Trailing line comment</th>
<td valign='top'>
<pre class='lang-js'>hello(); // there
world();
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>hello()
# there
world()
</pre>
</td>
</tr>
<tr><th colspan='3'>Errors</th></tr>
<tr>
<th valign='top'>No finally</th>
<td valign='top'>
<pre class='lang-js'>try {
  a();
} catch (e) {
  b();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>try
  a()
catch e
  b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Try catch finally</th>
<td valign='top'>
<pre class='lang-js'>try {
  a();
} catch (e) {
  b();
} finally {
  c();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>try
  a()
catch e
  b()
finally
  c()
</pre>
</td>
</tr>
<tr><th colspan='3'>Function calls</th></tr>
<tr>
<th valign='top'>Call with function expression</th>
<td valign='top'>
<pre class='lang-js'>run(function () {
  a();
  b();
});
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>run ->
  a()
  b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Call with function then object</th>
<td valign='top'>
<pre class='lang-js'>box.on('click', function () {
  go();
}, { delay: 500, silent: true })
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>box.on 'click', (->
  go()
),
  delay: 500
  silent: true
</pre>
</td>
</tr>
<tr>
<th valign='top'>Call with object</th>
<td valign='top'>
<pre class='lang-js'>box.on('click', { silent: true }, function () {
  go();
})
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>box.on 'click', silent: true, ->
  go()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Call with param after function</th>
<td valign='top'>
<pre class='lang-js'>setTimeout(function () {
  work();
}, 500);
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>setTimeout (->
  work()
), 500
</pre>
</td>
</tr>
<tr>
<th valign='top'>Chaining</th>
<td valign='top'>
<pre class='lang-js'>get().then(function () {
  a();
}).then(function () {
  b();
});
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>get().then(->
  a()
).then ->
  b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Expression with call</th>
<td valign='top'>
<pre class='lang-js'>(function () {
  go();
}).call(this);
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>(->
  go()
).call this
</pre>
</td>
</tr>
<tr>
<th valign='top'>Iife with different argument names</th>
<td valign='top'>
<pre class='lang-js'>(function($) {
  go();
})(jQuery);
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>(($) ->
  go()
) jQuery
</pre>
</td>
</tr>
<tr><th colspan='3'>Functions</th></tr>
<tr>
<th valign='top'>Multiple declarations</th>
<td valign='top'>
<pre class='lang-js'>function one() {
  a();
}
function two() {
  b();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>one = ->
  a()
two = ->
  b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple expressions</th>
<td valign='top'>
<pre class='lang-js'>obj.one = function () {
  return a();
};
obj.two = function () {
  return b();
};
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>obj.one = ->
  return a()
obj.two = ->
  return b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Nested declarations</th>
<td valign='top'>
<pre class='lang-js'>function a () {
  function b () {
    return c;
  }
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = ->
  b = ->
    return c
</pre>
</td>
</tr>
<tr>
<th valign='top'>Nested declares</th>
<td valign='top'>
<pre class='lang-js'>function a() {
  function b() {
    c();
  }
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = ->
  b = ->
    c()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Return statement</th>
<td valign='top'>
<pre class='lang-js'>function a () {
  return b;
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = ->
  return b
</pre>
</td>
</tr>
<tr>
<th valign='top'>With arguments</th>
<td valign='top'>
<pre class='lang-js'>function a(b, c) { d(); }
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = (b, c) ->
  d()
</pre>
</td>
</tr>
<tr><th colspan='3'>If</th></tr>
<tr>
<th valign='top'>Else if</th>
<td valign='top'>
<pre class='lang-js'>if (a) {
  x();
} else if (b) {
  y();
} else {
  z();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  x()
else if b
  y()
else
  z()
</pre>
</td>
</tr>
<tr>
<th valign='top'>If blocks</th>
<td valign='top'>
<pre class='lang-js'>if (a) {
  b();
  c();
  d();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  b()
  c()
  d()
</pre>
</td>
</tr>
<tr>
<th valign='top'>If statement</th>
<td valign='top'>
<pre class='lang-js'>if (a) b()
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>If with else</th>
<td valign='top'>
<pre class='lang-js'>if (a) { b(); }
else { c(); }
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  b()
else
  c()
</pre>
</td>
</tr>
<tr>
<th valign='top'>If with else if inside functions</th>
<td valign='top'>
<pre class='lang-js'>function fn() {
  if (a) { b(); }
  else if (b) { c(); }
  else { d(); }
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  if a
    b()
  else if b
    c()
  else
    d()
</pre>
</td>
</tr>
<tr>
<th valign='top'>If with else inside functions</th>
<td valign='top'>
<pre class='lang-js'>function fn() {
  if (a) { b(); } else { c(); }
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  if a
    b()
  else
    c()
</pre>
</td>
</tr>
<tr>
<th valign='top'>If with nesting</th>
<td valign='top'>
<pre class='lang-js'>if (a) {
  if (b) {
    c();
  }
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  if b
    c()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple else ifs</th>
<td valign='top'>
<pre class='lang-js'>if (a) {
  x();
} else if (b) {
  y();
} else if (b) {
  y();
} else if (b) {
  y();
} else if (b) {
  y();
} else {
  z();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  x()
else if b
  y()
else if b
  y()
else if b
  y()
else if b
  y()
else
  z()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Non block consequents</th>
<td valign='top'>
<pre class='lang-js'>function fn() {
  if (a) b();
  else c();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  if a
    b()
  else
    c()
</pre>
</td>
</tr>
<tr><th colspan='3'>Legacy</th></tr>
<tr>
<th valign='top'>Array literals</th>
<td valign='top'>
<pre class='lang-js'>var arr1 = [];
var arr2 = [1,3,4];
console.log(arr2[1][0] + [4]);
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>arr1 = []
arr2 = [
  1
  3
  4
]
console.log arr2[1][0] + [ 4 ]
</pre>
</td>
</tr>
<tr>
<th valign='top'>Assign</th>
<td valign='top'>
<pre class='lang-js'>a = 2;
a += 1;
a -= 1;
a *= 4;
a /= 2;
a %= 0;
a <<= 0;
a ^= 0;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = 2
a += 1
a -= 1
a *= 4
a /= 2
a %= 0
a <<= 0
a ^= 0
</pre>
</td>
</tr>
<tr>
<th valign='top'>Blank lines</th>
<td valign='top'>
<pre class='lang-js'>x = 2


y = 3</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>x = 2
y = 3
</pre>
</td>
</tr>
<tr>
<th valign='top'>Crlf</th>
<td valign='top'>
<pre class='lang-js'>var x = 3
var y = 2
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>x = 3
y = 2
</pre>
</td>
</tr>
<tr>
<th valign='top'>Debugger</th>
<td valign='top'>
<pre class='lang-js'>debugger;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>debugger
</pre>
</td>
</tr>
<tr>
<th valign='top'>Delete</th>
<td valign='top'>
<pre class='lang-js'>delete a[x];
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>delete a[x]
</pre>
</td>
</tr>
<tr>
<th valign='top'>Do</th>
<td valign='top'>
<pre class='lang-js'>var i = 0;
do {
  console.log(i);
  i++;
} while (i < 14);
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>i = 0
loop
  console.log i
  i++
  break unless i < 14
</pre>
</td>
</tr>
<tr>
<th valign='top'>Empty function</th>
<td valign='top'>
<pre class='lang-js'>(function($) {})()
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>(($) ->
)()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Empty semicolon</th>
<td valign='top'>
<pre class='lang-js'>2;;;3
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>2
3
</pre>
</td>
</tr>
<tr>
<th valign='top'>Floating point numbers</th>
<td valign='top'>
<pre class='lang-js'>0.094;
91;
9;
0;
-1;
-20.89889;
-424;
482934.00000001;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>0.094
91
9
0
-1
-20.89889
-424
482934.00000001
</pre>
</td>
</tr>
<tr>
<th valign='top'>Increment decrement</th>
<td valign='top'>
<pre class='lang-js'>a++;
++a;
--a;
a--;
a+++a;
a---a;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a++
++a
--a
a--
a++ + a
a-- - a
</pre>
</td>
</tr>
<tr>
<th valign='top'>Numbers</th>
<td valign='top'>
<pre class='lang-js'>var x = 1e3;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>x = 1e3
</pre>
</td>
</tr>
<tr>
<th valign='top'>Simple addition</th>
<td valign='top'>
<pre class='lang-js'>var a = 8+2+2;2
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = 8 + 2 + 2
2
</pre>
</td>
</tr>
<tr>
<th valign='top'>Single return</th>
<td valign='top'>
<pre class='lang-js'>(function() { return; });</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>->
  return
</pre>
</td>
</tr>
<tr>
<th valign='top'>Throw</th>
<td valign='top'>
<pre class='lang-js'>try {
throw 2;} catch(x) { alert (x); }
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>try
  throw 2
catch x
  alert x
</pre>
</td>
</tr>
<tr>
<th valign='top'>Unary</th>
<td valign='top'>
<pre class='lang-js'>-1;
+1;
+1 - 1;
+1 -1;
~2 - 2;
~2+-1;
a =~ 2;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>-1
+1
+1 - 1
+1 - 1
~2 - 2
~2 + -1
a = ~2
</pre>
</td>
</tr>
<tr>
<th valign='top'>Undefined</th>
<td valign='top'>
<pre class='lang-js'>undefined
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>`undefined`
</pre>
</td>
</tr>
<tr><th colspan='3'>Legacy pending</th></tr>
<tr><th colspan='3'>Loops</th></tr>
<tr>
<th valign='top'>Continue statement</th>
<td valign='top'>
<pre class='lang-js'>while (condition) {
  if (x) continue;
  a();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>while condition
  if x
    continue
  a()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Do while</th>
<td valign='top'>
<pre class='lang-js'>do {
  b();
} while (a)
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>loop
  b()
  break unless a
</pre>
</td>
</tr>
<tr>
<th valign='top'>Do while with other statements</th>
<td valign='top'>
<pre class='lang-js'>function fn() {
  before();
  do {
    b();
  } while (a);
  after();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  before()
  loop
    b()
    break unless a
  after()
</pre>
</td>
</tr>
<tr>
<th valign='top'>For with no arguments</th>
<td valign='top'>
<pre class='lang-js'>for (;;) {
  d();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>loop
  d()
</pre>
</td>
</tr>
<tr>
<th valign='top'>For with no body</th>
<td valign='top'>
<pre class='lang-js'>for(;;){}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>loop
  continue
</pre>
</td>
</tr>
<tr>
<th valign='top'>For with no init</th>
<td valign='top'>
<pre class='lang-js'>for (;b;c) {
  d();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>while b
  d()
  c
</pre>
</td>
</tr>
<tr>
<th valign='top'>For with no test</th>
<td valign='top'>
<pre class='lang-js'>for (a;;c) {
  d();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a
loop
  d()
  c
</pre>
</td>
</tr>
<tr>
<th valign='top'>For with no update</th>
<td valign='top'>
<pre class='lang-js'>for (a;b;) {
  d();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a
while b
  d()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Forever loop</th>
<td valign='top'>
<pre class='lang-js'>while (true) {
  a();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>loop
  a()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Simple for</th>
<td valign='top'>
<pre class='lang-js'>for (a;b;c) {
  d();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a
while b
  d()
  c
</pre>
</td>
</tr>
<tr>
<th valign='top'>While</th>
<td valign='top'>
<pre class='lang-js'>while (condition) { a(); }
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>while condition
  a()
</pre>
</td>
</tr>
<tr>
<th valign='top'>While with break</th>
<td valign='top'>
<pre class='lang-js'>while (condition) {
  if (x) break;
  a();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>while condition
  if x
    break
  a()
</pre>
</td>
</tr>
<tr><th colspan='3'>Members</th></tr>
<tr>
<th valign='top'>Identifier in brackets</th>
<td valign='top'>
<pre class='lang-js'>a[x]
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a[x]
</pre>
</td>
</tr>
<tr>
<th valign='top'>Identifiers</th>
<td valign='top'>
<pre class='lang-js'>a.b
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a.b
</pre>
</td>
</tr>
<tr><th colspan='3'>New</th></tr>
<tr>
<th valign='top'>New operator</th>
<td valign='top'>
<pre class='lang-js'>a = new B
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = new B
</pre>
</td>
</tr>
<tr>
<th valign='top'>New operator with arguments</th>
<td valign='top'>
<pre class='lang-js'>a = new B(x,y);
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = new B(x, y)
</pre>
</td>
</tr>
<tr>
<th valign='top'>New with complex callee</th>
<td valign='top'>
<pre class='lang-js'>a = new (require('foo'))(b)
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = new (require('foo'))(b)
</pre>
</td>
</tr>
<tr>
<th valign='top'>New with function expression</th>
<td valign='top'>
<pre class='lang-js'>a = new MyClass('left', function () {
  go();
})
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = new MyClass('left', ->
  go()
)
</pre>
</td>
</tr>
<tr>
<th valign='top'>New with function expression and string</th>
<td valign='top'>
<pre class='lang-js'>a = new MyClass(function () {
  go();
}, 'left')
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = new MyClass((->
  go()
), 'left')
</pre>
</td>
</tr>
<tr><th colspan='3'>Objects</th></tr>
<tr>
<th valign='top'>Arrray of objects</th>
<td valign='top'>
<pre class='lang-js'>list = [
  { a: 1, b: 1 },
  { a: 2, b: 2 },
]
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>list = [
  {
    a: 1
    b: 1
  }
  {
    a: 2
    b: 2
  }
]
</pre>
</td>
</tr>
<tr>
<th valign='top'>Call with object</th>
<td valign='top'>
<pre class='lang-js'>call({ a: 1, b: 2 })
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>call
  a: 1
  b: 2
</pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple properties</th>
<td valign='top'>
<pre class='lang-js'>a = { b: 2, c: 3 }
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a =
  b: 2
  c: 3
</pre>
</td>
</tr>
<tr>
<th valign='top'>Nested objects</th>
<td valign='top'>
<pre class='lang-js'>a = { b: { x: 3, y: 3 }, d: 4 }
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a =
  b:
    x: 3
    y: 3
  d: 4
</pre>
</td>
</tr>
<tr>
<th valign='top'>Object with arrays</th>
<td valign='top'>
<pre class='lang-js'>a = {
  empty: [],
  one: [ 1 ],
  many: [ 1, 2, 3 ]
};
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a =
  empty: []
  one: [ 1 ]
  many: [
    1
    2
    3
  ]
</pre>
</td>
</tr>
<tr>
<th valign='top'>Simple object</th>
<td valign='top'>
<pre class='lang-js'>a = { b: 2 }
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = b: 2
</pre>
</td>
</tr>
<tr>
<th valign='top'>Unusual identifiers</th>
<td valign='top'>
<pre class='lang-js'>object = {
    a: b,
    "a.a": b,
    "a#a": b,
    "a a": b,
    0: b,
    "0.a": b,
    $: b,
    $$: b,
    $a: b,
    "$a b": b
};
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>object =
  a: b
  "a.a": b
  "a#a": b
  "a a": b
  0: b
  "0.a": b
  $: b
  $$: b
  $a: b
  "$a b": b
</pre>
</td>
</tr>
<tr><th colspan='3'>Pending</th></tr>
<tr><th colspan='3'>Simple</th></tr>
<tr>
<th valign='top'>Booleans</th>
<td valign='top'>
<pre class='lang-js'>true;
false;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>true
false
</pre>
</td>
</tr>
<tr>
<th valign='top'>Call with function</th>
<td valign='top'>
<pre class='lang-js'>a(function() {
  b();
});
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a ->
  b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Debugger statement</th>
<td valign='top'>
<pre class='lang-js'>if (x) debugger;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if x
  debugger
</pre>
</td>
</tr>
<tr>
<th valign='top'>Delete</th>
<td valign='top'>
<pre class='lang-js'>delete x.y;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>delete x.y
</pre>
</td>
</tr>
<tr>
<th valign='top'>Empty statement</th>
<td valign='top'>
<pre class='lang-js'>;;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'></pre>
</td>
</tr>
<tr>
<th valign='top'>Empty statement with other statements</th>
<td valign='top'>
<pre class='lang-js'>a();;;b()
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a()
b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Function call</th>
<td valign='top'>
<pre class='lang-js'>alert("Hello world");
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>alert "Hello world"
</pre>
</td>
</tr>
<tr>
<th valign='top'>Function call with arguments</th>
<td valign='top'>
<pre class='lang-js'>a("hello", 2);
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a "hello", 2
</pre>
</td>
</tr>
<tr>
<th valign='top'>Increment</th>
<td valign='top'>
<pre class='lang-js'>a++
b--
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a++
b--
</pre>
</td>
</tr>
<tr>
<th valign='top'>Indented throw</th>
<td valign='top'>
<pre class='lang-js'>if (x) throw e
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if x
  throw e
</pre>
</td>
</tr>
<tr>
<th valign='top'>Index resolution</th>
<td valign='top'>
<pre class='lang-js'>a[2]
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a[2]
</pre>
</td>
</tr>
<tr>
<th valign='top'>Index resolution of expression</th>
<td valign='top'>
<pre class='lang-js'>a["node" + n]
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a["node" + n]
</pre>
</td>
</tr>
<tr>
<th valign='top'>Index resolution of strings</th>
<td valign='top'>
<pre class='lang-js'>a["a-b"]
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a["a-b"]
</pre>
</td>
</tr>
<tr>
<th valign='top'>Index resolution witH this</th>
<td valign='top'>
<pre class='lang-js'>this["#" + id]
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>@["#" + id]
</pre>
</td>
</tr>
<tr>
<th valign='top'>Inline assignment</th>
<td valign='top'>
<pre class='lang-js'>if (a = m = match) {
  m();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if a = m = match
  m()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Nested function calls</th>
<td valign='top'>
<pre class='lang-js'>a(b());
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a b()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Nesting if and assignment</th>
<td valign='top'>
<pre class='lang-js'>a.b = function (arg) {
  if (arg) cli.a = b;
};
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a.b = (arg) ->
  if arg
    cli.a = b
</pre>
</td>
</tr>
<tr>
<th valign='top'>Prefix increment</th>
<td valign='top'>
<pre class='lang-js'>++a;
--b;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>++a
--b
</pre>
</td>
</tr>
<tr>
<th valign='top'>Return nothing</th>
<td valign='top'>
<pre class='lang-js'>function fn () {
  return;
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  return
</pre>
</td>
</tr>
<tr>
<th valign='top'>Scientific notation</th>
<td valign='top'>
<pre class='lang-js'>a = -1.21e3;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = -1.21e3
</pre>
</td>
</tr>
<tr>
<th valign='top'>Sequence expression</th>
<td valign='top'>
<pre class='lang-js'>a,b,c
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a
b
c
</pre>
</td>
</tr>
<tr>
<th valign='top'>Sequence expression with indent</th>
<td valign='top'>
<pre class='lang-js'>if (x) {
  a,b,c;
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if x
  a
  b
  c
</pre>
</td>
</tr>
<tr>
<th valign='top'>Standalone this</th>
<td valign='top'>
<pre class='lang-js'>a = this;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = this
</pre>
</td>
</tr>
<tr>
<th valign='top'>Ternary operator</th>
<td valign='top'>
<pre class='lang-js'>a ? b : c
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if a then b else c
</pre>
</td>
</tr>
<tr>
<th valign='top'>Ternary operator nesting</th>
<td valign='top'>
<pre class='lang-js'>a ? b : c ? d : e
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>if a then b else if c then d else e
</pre>
</td>
</tr>
<tr>
<th valign='top'>This prefix</th>
<td valign='top'>
<pre class='lang-js'>this.run();
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>@run()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Throw</th>
<td valign='top'>
<pre class='lang-js'>throw e
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>throw e
</pre>
</td>
</tr>
<tr>
<th valign='top'>Unary void</th>
<td valign='top'>
<pre class='lang-js'>void 0
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>void 0
</pre>
</td>
</tr>
<tr>
<th valign='top'>Undefined</th>
<td valign='top'>
<pre class='lang-js'>undefined
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>`undefined`
</pre>
</td>
</tr>
<tr><th colspan='3'>Strings</th></tr>
<tr>
<th valign='top'>Empty string</th>
<td valign='top'>
<pre class='lang-js'>""
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>""
</pre>
</td>
</tr>
<tr>
<th valign='top'>Simple string</th>
<td valign='top'>
<pre class='lang-js'>"hello"
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>"hello"
</pre>
</td>
</tr>
<tr>
<th valign='top'>Single quotes</th>
<td valign='top'>
<pre class='lang-js'>'\n'
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>'\n'
</pre>
</td>
</tr>
<tr>
<th valign='top'>String with escapes</th>
<td valign='top'>
<pre class='lang-js'>"\n"
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>"\n"
</pre>
</td>
</tr>
<tr><th colspan='3'>Switch</th></tr>
<tr>
<th valign='top'>Case consolidation</th>
<td valign='top'>
<pre class='lang-js'>switch (a) {
  case one:
  case two:
    b();
    break;
  default:
    c();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>switch a
  when one, two
    b()
  else
    c()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Case consolidation with default</th>
<td valign='top'>
<pre class='lang-js'>switch (a) {
  case one:
    b();
    break;
  case two:
  default:
    c();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>switch a
  when one
    b()
  else
    c()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Switch</th>
<td valign='top'>
<pre class='lang-js'>switch (obj) {
  case 'one':
    a();
    break;
  case 'two':
    b();
    break;
  default:
    c();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>switch obj
  when 'one'
    a()
  when 'two'
    b()
  else
    c()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Switch with comments</th>
<td valign='top'>
<pre class='lang-js'>switch (obj) {
  // test
  case 'one':
    // test
    a();
    break;
  // test
  case 'two':
    // test
    b();
    break;
  default:
    c();
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>switch obj
  # test
  when 'one'
    # test
    a()
  # test
  when 'two'
    # test
    b()
  else
    c()
</pre>
</td>
</tr>
<tr>
<th valign='top'>Switch with return</th>
<td valign='top'>
<pre class='lang-js'>function fn () {
  switch (obj) {
    case 'one':
      return a();
    default:
      return b();
  }
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  switch obj
    when 'one'
      return a()
    else
      return b()
</pre>
</td>
</tr>
<tr><th colspan='3'>Var</th></tr>
<tr>
<th valign='top'>Mixed var declarations</th>
<td valign='top'>
<pre class='lang-js'>function fn() {
  var a = 1, b, c = 2, d;
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  a = 1
  b = undefined
  c = 2
  d = undefined
</pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple var declaration</th>
<td valign='top'>
<pre class='lang-js'>var a = 1, b = 2
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = 1
b = 2
</pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple var declarations with indent</th>
<td valign='top'>
<pre class='lang-js'>function fn() {
  var a = 1, b = 2;
}
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  a = 1
  b = 2
</pre>
</td>
</tr>
<tr>
<th valign='top'>Var declaration</th>
<td valign='top'>
<pre class='lang-js'>var a = 1
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = 1
</pre>
</td>
</tr>
<tr>
<th valign='top'>Var without initializer</th>
<td valign='top'>
<pre class='lang-js'>var a;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = undefined
</pre>
</td>
</tr>
</table>
