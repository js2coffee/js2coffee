<table width='100%'>
<thead>
  <tr>
    <th width='33%'>Example</th>
    <th width='33%'>JavaScript</th>
    <th width='33%'>CoffeeScript</th>
</thead>
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
<tr><th colspan='3'>Functions</th></tr>
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
<pre class='lang-js'>if (a) { b(); } else { c(); }
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
<tr><th colspan='3'>Loops</th></tr>
<tr>
<th valign='top'>Continue statement</th>
<td valign='top'>
<pre class='lang-js'>while (condition) { if (x) continue; a(); }
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
<tr><th colspan='3'>Objects</th></tr>
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
<tr><th colspan='3'>Pending</th></tr>
<tr><th colspan='3'>Simple</th></tr>
<tr>
<th valign='top'>Assignments</th>
<td valign='top'>
<pre class='lang-js'>a = b + 1;
z = 2;
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a = b + 1
z = 2
</pre>
</td>
</tr>
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
<th valign='top'>Scope resolution</th>
<td valign='top'>
<pre class='lang-js'>a.b
</pre>
</td>
<td width='50%' valign='top'>
<pre class='lang-coffee'>a.b
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
