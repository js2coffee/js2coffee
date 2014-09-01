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
<pre><code class='lang-js'>a = []
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = []
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple items</th>
<td valign='top'>
<pre><code class='lang-js'>a = [ 1, 2, 3, 4 ]
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = [
  1
  2
  3
  4
]
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Comments</th></tr>
<tr>
<th valign='top'>Block comments</th>
<td valign='top'>
<pre><code class='lang-js'>a();
/*
 * hello
 */
b();
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a()
###
# hello
###
b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Block comments with space</th>
<td valign='top'>
<pre><code class='lang-js'>a(); /* hi */
b();
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a()
### hi ###
b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Line comments</th>
<td valign='top'>
<pre><code class='lang-js'>a();
// hello
b();
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a()
# hello
b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Trailing line comment</th>
<td valign='top'>
<pre><code class='lang-js'>hello(); // there
world();
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>hello()
# there
world()
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Errors</th></tr>
<tr>
<th valign='top'>No finally</th>
<td valign='top'>
<pre><code class='lang-js'>try {
  a();
} catch (e) {
  b();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>try
  a()
catch e
  b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Try catch finally</th>
<td valign='top'>
<pre><code class='lang-js'>try {
  a();
} catch (e) {
  b();
} finally {
  c();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>try
  a()
catch e
  b()
finally
  c()
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Function calls</th></tr>
<tr>
<th valign='top'>Call with function expression</th>
<td valign='top'>
<pre><code class='lang-js'>run(function () {
  a();
  b();
});
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>run ->
  a()
  b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Call with function then object</th>
<td valign='top'>
<pre><code class='lang-js'>box.on('click', function () {
  go();
}, { delay: 500, silent: true })
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>box.on 'click', (->
  go()
),
  delay: 500
  silent: true
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Call with object</th>
<td valign='top'>
<pre><code class='lang-js'>box.on('click', { silent: true }, function () {
  go();
})
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>box.on 'click', silent: true, ->
  go()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Call with param after function</th>
<td valign='top'>
<pre><code class='lang-js'>setTimeout(function () {
  work();
}, 500);
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>setTimeout (->
  work()
), 500
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Chaining</th>
<td valign='top'>
<pre><code class='lang-js'>get().then(function () {
  a();
}).then(function () {
  b();
});
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>get().then(->
  a()
).then ->
  b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Expression with call</th>
<td valign='top'>
<pre><code class='lang-js'>(function () {
  go();
}).call(this);
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>(->
  go()
).call this
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Iife with different argument names</th>
<td valign='top'>
<pre><code class='lang-js'>(function($) {
  go();
})(jQuery);
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>(($) ->
  go()
) jQuery
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Functions</th></tr>
<tr>
<th valign='top'>Multiple declarations</th>
<td valign='top'>
<pre><code class='lang-js'>function one() {
  a();
}
function two() {
  b();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>one = ->
  a()
two = ->
  b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple expressions</th>
<td valign='top'>
<pre><code class='lang-js'>obj.one = function () {
  return a();
};
obj.two = function () {
  return b();
};
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>obj.one = ->
  return a()
obj.two = ->
  return b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Nested declarations</th>
<td valign='top'>
<pre><code class='lang-js'>function a () {
  function b () {
    return c;
  }
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = ->
  b = ->
    return c
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Nested declares</th>
<td valign='top'>
<pre><code class='lang-js'>function a() {
  function b() {
    c();
  }
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = ->
  b = ->
    c()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Return statement</th>
<td valign='top'>
<pre><code class='lang-js'>function a () {
  return b;
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = ->
  return b
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>With arguments</th>
<td valign='top'>
<pre><code class='lang-js'>function a(b, c) { d(); }
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = (b, c) ->
  d()
</code></pre>
</td>
</tr>
<tr><th colspan='3'>If</th></tr>
<tr>
<th valign='top'>Else if</th>
<td valign='top'>
<pre><code class='lang-js'>if (a) {
  x();
} else if (b) {
  y();
} else {
  z();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if a
  x()
else if b
  y()
else
  z()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>If blocks</th>
<td valign='top'>
<pre><code class='lang-js'>if (a) {
  b();
  c();
  d();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if a
  b()
  c()
  d()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>If statement</th>
<td valign='top'>
<pre><code class='lang-js'>if (a) b()
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if a
  b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>If with else</th>
<td valign='top'>
<pre><code class='lang-js'>if (a) { b(); }
else { c(); }
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if a
  b()
else
  c()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>If with else if inside functions</th>
<td valign='top'>
<pre><code class='lang-js'>function fn() {
  if (a) { b(); }
  else if (b) { c(); }
  else { d(); }
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  if a
    b()
  else if b
    c()
  else
    d()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>If with else inside functions</th>
<td valign='top'>
<pre><code class='lang-js'>function fn() {
  if (a) { b(); } else { c(); }
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  if a
    b()
  else
    c()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>If with nesting</th>
<td valign='top'>
<pre><code class='lang-js'>if (a) {
  if (b) {
    c();
  }
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if a
  if b
    c()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple else ifs</th>
<td valign='top'>
<pre><code class='lang-js'>if (a) {
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
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if a
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
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Non block consequents</th>
<td valign='top'>
<pre><code class='lang-js'>function fn() {
  if (a) b();
  else c();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  if a
    b()
  else
    c()
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Legacy</th></tr>
<tr>
<th valign='top'>Array literals</th>
<td valign='top'>
<pre><code class='lang-js'>var arr1 = [];
var arr2 = [1,3,4];
console.log(arr2[1][0] + [4]);
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>arr1 = []
arr2 = [
  1
  3
  4
]
console.log arr2[1][0] + [ 4 ]
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Assign</th>
<td valign='top'>
<pre><code class='lang-js'>a = 2;
a += 1;
a -= 1;
a *= 4;
a /= 2;
a %= 0;
a <<= 0;
a ^= 0;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = 2
a += 1
a -= 1
a *= 4
a /= 2
a %= 0
a <<= 0
a ^= 0
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Blank lines</th>
<td valign='top'>
<pre><code class='lang-js'>x = 2


y = 3</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>x = 2
y = 3
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Crlf</th>
<td valign='top'>
<pre><code class='lang-js'>var x = 3
var y = 2
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>x = 3
y = 2
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Debugger</th>
<td valign='top'>
<pre><code class='lang-js'>debugger;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>debugger
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Delete</th>
<td valign='top'>
<pre><code class='lang-js'>delete a[x];
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>delete a[x]
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Do</th>
<td valign='top'>
<pre><code class='lang-js'>var i = 0;
do {
  console.log(i);
  i++;
} while (i < 14);
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>i = 0
loop
  console.log i
  i++
  break unless i < 14
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Empty function</th>
<td valign='top'>
<pre><code class='lang-js'>(function($) {})()
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>(($) ->
)()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Empty semicolon</th>
<td valign='top'>
<pre><code class='lang-js'>2;;;3
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>2
3
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Floating point numbers</th>
<td valign='top'>
<pre><code class='lang-js'>0.094;
91;
9;
0;
-1;
-20.89889;
-424;
482934.00000001;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>0.094
91
9
0
-1
-20.89889
-424
482934.00000001
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Increment decrement</th>
<td valign='top'>
<pre><code class='lang-js'>a++;
++a;
--a;
a--;
a+++a;
a---a;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a++
++a
--a
a--
a++ + a
a-- - a
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Numbers</th>
<td valign='top'>
<pre><code class='lang-js'>var x = 1e3;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>x = 1e3
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Simple addition</th>
<td valign='top'>
<pre><code class='lang-js'>var a = 8+2+2;2
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = 8 + 2 + 2
2
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Single return</th>
<td valign='top'>
<pre><code class='lang-js'>(function() { return; });</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>->
  return
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Throw</th>
<td valign='top'>
<pre><code class='lang-js'>try {
throw 2;} catch(x) { alert (x); }
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>try
  throw 2
catch x
  alert x
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Unary</th>
<td valign='top'>
<pre><code class='lang-js'>-1;
+1;
+1 - 1;
+1 -1;
~2 - 2;
~2+-1;
a =~ 2;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>-1
+1
+1 - 1
+1 - 1
~2 - 2
~2 + -1
a = ~2
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Undefined</th>
<td valign='top'>
<pre><code class='lang-js'>undefined
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>`undefined`
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Legacy pending</th></tr>
<tr><th colspan='3'>Loops</th></tr>
<tr>
<th valign='top'>Continue statement</th>
<td valign='top'>
<pre><code class='lang-js'>while (condition) {
  if (x) continue;
  a();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>while condition
  if x
    continue
  a()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Do while</th>
<td valign='top'>
<pre><code class='lang-js'>do {
  b();
} while (a)
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>loop
  b()
  break unless a
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Do while with other statements</th>
<td valign='top'>
<pre><code class='lang-js'>function fn() {
  before();
  do {
    b();
  } while (a);
  after();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  before()
  loop
    b()
    break unless a
  after()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>For with no arguments</th>
<td valign='top'>
<pre><code class='lang-js'>for (;;) {
  d();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>loop
  d()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>For with no body</th>
<td valign='top'>
<pre><code class='lang-js'>for(;;){}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>loop
  continue
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>For with no init</th>
<td valign='top'>
<pre><code class='lang-js'>for (;b;c) {
  d();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>while b
  d()
  c
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>For with no test</th>
<td valign='top'>
<pre><code class='lang-js'>for (a;;c) {
  d();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a
loop
  d()
  c
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>For with no update</th>
<td valign='top'>
<pre><code class='lang-js'>for (a;b;) {
  d();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a
while b
  d()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Forever loop</th>
<td valign='top'>
<pre><code class='lang-js'>while (true) {
  a();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>loop
  a()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Simple for</th>
<td valign='top'>
<pre><code class='lang-js'>for (a;b;c) {
  d();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a
while b
  d()
  c
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>While</th>
<td valign='top'>
<pre><code class='lang-js'>while (condition) { a(); }
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>while condition
  a()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>While with break</th>
<td valign='top'>
<pre><code class='lang-js'>while (condition) {
  if (x) break;
  a();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>while condition
  if x
    break
  a()
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Members</th></tr>
<tr>
<th valign='top'>Identifier in brackets</th>
<td valign='top'>
<pre><code class='lang-js'>a[x]
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a[x]
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Identifiers</th>
<td valign='top'>
<pre><code class='lang-js'>a.b
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a.b
</code></pre>
</td>
</tr>
<tr><th colspan='3'>New</th></tr>
<tr>
<th valign='top'>New operator</th>
<td valign='top'>
<pre><code class='lang-js'>a = new B
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = new B
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>New operator with arguments</th>
<td valign='top'>
<pre><code class='lang-js'>a = new B(x,y);
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = new B(x, y)
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>New with complex callee</th>
<td valign='top'>
<pre><code class='lang-js'>a = new (require('foo'))(b)
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = new (require('foo'))(b)
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>New with function expression</th>
<td valign='top'>
<pre><code class='lang-js'>a = new MyClass('left', function () {
  go();
})
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = new MyClass('left', ->
  go()
)
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>New with function expression and string</th>
<td valign='top'>
<pre><code class='lang-js'>a = new MyClass(function () {
  go();
}, 'left')
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = new MyClass((->
  go()
), 'left')
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Objects</th></tr>
<tr>
<th valign='top'>Arrray of objects</th>
<td valign='top'>
<pre><code class='lang-js'>list = [
  { a: 1, b: 1 },
  { a: 2, b: 2 },
]
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>list = [
  {
    a: 1
    b: 1
  }
  {
    a: 2
    b: 2
  }
]
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Call with object</th>
<td valign='top'>
<pre><code class='lang-js'>call({ a: 1, b: 2 })
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>call
  a: 1
  b: 2
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple properties</th>
<td valign='top'>
<pre><code class='lang-js'>a = { b: 2, c: 3 }
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a =
  b: 2
  c: 3
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Nested objects</th>
<td valign='top'>
<pre><code class='lang-js'>a = { b: { x: 3, y: 3 }, d: 4 }
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a =
  b:
    x: 3
    y: 3
  d: 4
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Object with arrays</th>
<td valign='top'>
<pre><code class='lang-js'>a = {
  empty: [],
  one: [ 1 ],
  many: [ 1, 2, 3 ]
};
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a =
  empty: []
  one: [ 1 ]
  many: [
    1
    2
    3
  ]
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Simple object</th>
<td valign='top'>
<pre><code class='lang-js'>a = { b: 2 }
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = b: 2
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Unusual identifiers</th>
<td valign='top'>
<pre><code class='lang-js'>object = {
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
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>object =
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
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Pending</th></tr>
<tr><th colspan='3'>Simple</th></tr>
<tr>
<th valign='top'>Booleans</th>
<td valign='top'>
<pre><code class='lang-js'>true;
false;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>true
false
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Call with function</th>
<td valign='top'>
<pre><code class='lang-js'>a(function() {
  b();
});
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a ->
  b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Debugger statement</th>
<td valign='top'>
<pre><code class='lang-js'>if (x) debugger;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if x
  debugger
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Delete</th>
<td valign='top'>
<pre><code class='lang-js'>delete x.y;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>delete x.y
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Empty statement</th>
<td valign='top'>
<pre><code class='lang-js'>;;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'></code></pre>
</td>
</tr>
<tr>
<th valign='top'>Empty statement with other statements</th>
<td valign='top'>
<pre><code class='lang-js'>a();;;b()
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a()
b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Function call</th>
<td valign='top'>
<pre><code class='lang-js'>alert("Hello world");
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>alert "Hello world"
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Function call with arguments</th>
<td valign='top'>
<pre><code class='lang-js'>a("hello", 2);
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a "hello", 2
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Increment</th>
<td valign='top'>
<pre><code class='lang-js'>a++
b--
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a++
b--
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Indented throw</th>
<td valign='top'>
<pre><code class='lang-js'>if (x) throw e
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if x
  throw e
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Index resolution</th>
<td valign='top'>
<pre><code class='lang-js'>a[2]
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a[2]
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Index resolution of expression</th>
<td valign='top'>
<pre><code class='lang-js'>a["node" + n]
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a["node" + n]
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Index resolution of strings</th>
<td valign='top'>
<pre><code class='lang-js'>a["a-b"]
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a["a-b"]
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Index resolution witH this</th>
<td valign='top'>
<pre><code class='lang-js'>this["#" + id]
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>@["#" + id]
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Inline assignment</th>
<td valign='top'>
<pre><code class='lang-js'>if (a = m = match) {
  m();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if a = m = match
  m()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Nested function calls</th>
<td valign='top'>
<pre><code class='lang-js'>a(b());
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a b()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Nesting if and assignment</th>
<td valign='top'>
<pre><code class='lang-js'>a.b = function (arg) {
  if (arg) cli.a = b;
};
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a.b = (arg) ->
  if arg
    cli.a = b
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Prefix increment</th>
<td valign='top'>
<pre><code class='lang-js'>++a;
--b;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>++a
--b
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Return nothing</th>
<td valign='top'>
<pre><code class='lang-js'>function fn () {
  return;
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  return
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Scientific notation</th>
<td valign='top'>
<pre><code class='lang-js'>a = -1.21e3;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = -1.21e3
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Sequence expression</th>
<td valign='top'>
<pre><code class='lang-js'>a,b,c
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a
b
c
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Sequence expression with indent</th>
<td valign='top'>
<pre><code class='lang-js'>if (x) {
  a,b,c;
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if x
  a
  b
  c
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Standalone this</th>
<td valign='top'>
<pre><code class='lang-js'>a = this;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = this
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Ternary operator</th>
<td valign='top'>
<pre><code class='lang-js'>a ? b : c
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if a then b else c
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Ternary operator nesting</th>
<td valign='top'>
<pre><code class='lang-js'>a ? b : c ? d : e
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>if a then b else if c then d else e
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>This prefix</th>
<td valign='top'>
<pre><code class='lang-js'>this.run();
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>@run()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Throw</th>
<td valign='top'>
<pre><code class='lang-js'>throw e
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>throw e
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Unary void</th>
<td valign='top'>
<pre><code class='lang-js'>void 0
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>void 0
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Undefined</th>
<td valign='top'>
<pre><code class='lang-js'>undefined
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>`undefined`
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Strings</th></tr>
<tr>
<th valign='top'>Empty string</th>
<td valign='top'>
<pre><code class='lang-js'>""
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>""
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Simple string</th>
<td valign='top'>
<pre><code class='lang-js'>"hello"
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>"hello"
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Single quotes</th>
<td valign='top'>
<pre><code class='lang-js'>'\n'
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>'\n'
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>String with escapes</th>
<td valign='top'>
<pre><code class='lang-js'>"\n"
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>"\n"
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Switch</th></tr>
<tr>
<th valign='top'>Case consolidation</th>
<td valign='top'>
<pre><code class='lang-js'>switch (a) {
  case one:
  case two:
    b();
    break;
  default:
    c();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>switch a
  when one, two
    b()
  else
    c()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Case consolidation with default</th>
<td valign='top'>
<pre><code class='lang-js'>switch (a) {
  case one:
    b();
    break;
  case two:
  default:
    c();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>switch a
  when one
    b()
  else
    c()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Switch</th>
<td valign='top'>
<pre><code class='lang-js'>switch (obj) {
  case 'one':
    a();
    break;
  case 'two':
    b();
    break;
  default:
    c();
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>switch obj
  when 'one'
    a()
  when 'two'
    b()
  else
    c()
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Switch with comments</th>
<td valign='top'>
<pre><code class='lang-js'>switch (obj) {
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
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>switch obj
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
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Switch with return</th>
<td valign='top'>
<pre><code class='lang-js'>function fn () {
  switch (obj) {
    case 'one':
      return a();
    default:
      return b();
  }
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  switch obj
    when 'one'
      return a()
    else
      return b()
</code></pre>
</td>
</tr>
<tr><th colspan='3'>Var</th></tr>
<tr>
<th valign='top'>Mixed var declarations</th>
<td valign='top'>
<pre><code class='lang-js'>function fn() {
  var a = 1, b, c = 2, d;
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  a = 1
  b = undefined
  c = 2
  d = undefined
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple var declaration</th>
<td valign='top'>
<pre><code class='lang-js'>var a = 1, b = 2
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = 1
b = 2
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Multiple var declarations with indent</th>
<td valign='top'>
<pre><code class='lang-js'>function fn() {
  var a = 1, b = 2;
}
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  a = 1
  b = 2
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Var declaration</th>
<td valign='top'>
<pre><code class='lang-js'>var a = 1
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = 1
</code></pre>
</td>
</tr>
<tr>
<th valign='top'>Var without initializer</th>
<td valign='top'>
<pre><code class='lang-js'>var a;
</code></pre>
</td>
<td width='50%' valign='top'>
<pre><code class='lang-coffee'>a = undefined
</code></pre>
</td>
</tr>
</table>
