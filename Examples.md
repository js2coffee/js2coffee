## /Users/rsc/Projects/@incubate/js2coffee2/specs/comments

### block comments

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a();
/*
 * hello
 */
b();
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a()
###
# hello
###
b()
</pre>
</td></tr></table>

### block comments with space

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a(); /* hi */
b();
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a()
### hi ###
b()
</pre>
</td></tr></table>

### line comments

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a();
// hello
b();
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a()
# hello
b()
</pre>
</td></tr></table>

### trailing line comment

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>hello(); // there
world();
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>hello()
# there
world()
</pre>
</td></tr></table>

## /Users/rsc/Projects/@incubate/js2coffee2/specs/errors

### no finally

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>try {
  a();
} catch (e) {
  b();
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>try
  a()
catch e
  b()
</pre>
</td></tr></table>

### try catch finally

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>try {
  a();
} catch (e) {
  b();
} finally {
  c();
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>try
  a()
catch e
  b()
finally
  c()
</pre>
</td></tr></table>

## /Users/rsc/Projects/@incubate/js2coffee2/specs/functions

### nested declarations

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>function a () {
  function b () {
    return c;
  }
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = ->
  b = ->
    return c
</pre>
</td></tr></table>

### nested declares

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>function a() {
  function b() {
    c();
  }
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = ->
  b = ->
    c()
</pre>
</td></tr></table>

### return statement

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>function a () {
  return b;
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = ->
  return b
</pre>
</td></tr></table>

### with arguments

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>function a(b, c) { d(); }
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = (b, c) ->
  d()
</pre>
</td></tr></table>

## /Users/rsc/Projects/@incubate/js2coffee2/specs/if

### else if

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>if (a) {
  x();
} else if (b) {
  y();
} else {
  z();
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  x()
else if b
  y()
else
  z()
</pre>
</td></tr></table>

### if blocks

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>if (a) {
  b();
  c();
  d();
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  b()
  c()
  d()
</pre>
</td></tr></table>

### if statement

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>if (a) b()
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  b()
</pre>
</td></tr></table>

### if with else

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>if (a) { b(); } else { c(); }
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  b()
else
  c()
</pre>
</td></tr></table>

### if with else if inside functions

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>function fn() {
  if (a) { b(); }
  else if (b) { c(); }
  else { d(); }
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  if a
    b()
  else if b
    c()
  else
    d()
</pre>
</td></tr></table>

### if with else inside functions

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>function fn() {
  if (a) { b(); } else { c(); }
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  if a
    b()
  else
    c()
</pre>
</td></tr></table>

### if with nesting

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>if (a) {
  if (b) {
    c();
  }
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>if a
  if b
    c()
</pre>
</td></tr></table>

### multiple else ifs

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
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
</td><td width='50%' valign='top'>
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
</td></tr></table>

### non block consequents

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>function fn() {
  if (a) b();
  else c();
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  if a
    b()
  else
    c()
</pre>
</td></tr></table>

## /Users/rsc/Projects/@incubate/js2coffee2/specs/loops

### continue statement

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>while (condition) { if (x) continue; a(); }
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>while condition
  if x
    continue
  a()
</pre>
</td></tr></table>

### do while

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>do {
  b();
} while (a)
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>loop
  b()
  break unless a
</pre>
</td></tr></table>

### do while with other statements

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>function fn() {
  before();
  do {
    b();
  } while (a);
  after();
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  before()
  loop
    b()
    break unless a
  after()
</pre>
</td></tr></table>

### forever loop

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>while (true) {
  a();
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>loop
  a()
</pre>
</td></tr></table>

### while

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>while (condition) { a(); }
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>while condition
  a()
</pre>
</td></tr></table>

### while with break

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>while (condition) {
  if (x) break;
  a();
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>while condition
  if x
    break
  a()
</pre>
</td></tr></table>

## /Users/rsc/Projects/@incubate/js2coffee2/specs/new

### new operator

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = new B
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = new B
</pre>
</td></tr></table>

### new operator with arguments

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = new B(x,y);
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = new B(x, y)
</pre>
</td></tr></table>

### new with complex callee

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = new (require('foo'))(b)
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = new (require('foo'))(b)
</pre>
</td></tr></table>

## /Users/rsc/Projects/@incubate/js2coffee2/specs/objects

### call with object

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>call({ a: 1, b: 2 })
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>call
  a: 1
  b: 2

</pre>
</td></tr></table>

### multiple properties

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = { b: 2, c: 3 }
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a =
  b: 2
  c: 3

</pre>
</td></tr></table>

### nested objects

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = { b: { x: 3, y: 3 }, d: 4 }
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a =
  b:
    x: 3
    y: 3

  d: 4

</pre>
</td></tr></table>

### simple object

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = { b: 2 }
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = b: 2
</pre>
</td></tr></table>

## /Users/rsc/Projects/@incubate/js2coffee2/specs/pending

## /Users/rsc/Projects/@incubate/js2coffee2/specs/simple

### assignments

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = b + 1;
z = 2;
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = b + 1
z = 2
</pre>
</td></tr></table>

### booleans

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>true;
false;
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>true
false
</pre>
</td></tr></table>

### debugger statement

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>if (x) debugger;
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>if x
  debugger
</pre>
</td></tr></table>

### empty statement

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>;;
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'></pre>
</td></tr></table>

### empty statement with other statements

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a();;;b()
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a()
b()
</pre>
</td></tr></table>

### function call

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>alert("Hello world");
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>alert "Hello world"
</pre>
</td></tr></table>

### function call with arguments

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a("hello", 2);
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a "hello", 2
</pre>
</td></tr></table>

### indented throw

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>if (x) throw e
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>if x
  throw e
</pre>
</td></tr></table>

### index resolution

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a[2]
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a[2]
</pre>
</td></tr></table>

### index resolution of expression

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a["node" + n]
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a["node" + n]
</pre>
</td></tr></table>

### index resolution of strings

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a["a-b"]
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a["a-b"]
</pre>
</td></tr></table>

### index resolution witH this

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>this["#" + id]
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>@["#" + id]
</pre>
</td></tr></table>

### inline assignment

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>if (a = m = match) {
  m();
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>if a = m = match
  m()
</pre>
</td></tr></table>

### nested function calls

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a(b());
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a b()
</pre>
</td></tr></table>

### nesting if and assignment

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a.b = function (arg) {
  if (arg) cli.a = b;
};
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a.b = (arg) ->
  if arg
    cli.a = b

</pre>
</td></tr></table>

### scope resolution

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a.b
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a.b
</pre>
</td></tr></table>

### standalone this

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = this;
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = this
</pre>
</td></tr></table>

### this prefix

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>this.run();
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>@run()
</pre>
</td></tr></table>

### throw

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>throw e
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>throw e
</pre>
</td></tr></table>

### unary void

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>void 0
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>void 0
</pre>
</td></tr></table>

## /Users/rsc/Projects/@incubate/js2coffee2/specs/strings

### empty string

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>""
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>""
</pre>
</td></tr></table>

### simple string

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>"hello"
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>"hello"
</pre>
</td></tr></table>

### single quotes

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>'\n'
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>'\n'
</pre>
</td></tr></table>

### string with escapes

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>"\n"
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>"\n"
</pre>
</td></tr></table>

## /Users/rsc/Projects/@incubate/js2coffee2/specs/var

### mixed var declarations

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>function fn() {
  var a = 1, b, c = 2, d;
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  a = 1
  b = undefined
  c = 2
  d = undefined
</pre>
</td></tr></table>

### multiple var declaration

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>var a = 1, b = 2
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = 1
b = 2
</pre>
</td></tr></table>

### multiple var declarations with indent

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>function fn() {
  var a = 1, b = 2;
}
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>fn = ->
  a = 1
  b = 2
</pre>
</td></tr></table>

### var declaration

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>var a = 1
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = 1
</pre>
</td></tr></table>

### var without initializer

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>var a;
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = undefined
</pre>
</td></tr></table>

