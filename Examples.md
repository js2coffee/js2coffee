## Comments

### Block comments

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

### Block comments with space

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

### Line comments

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

### Trailing line comment

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

## Errors

### No finally

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

### Try catch finally

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

## Functions

### Nested declarations

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

### Nested declares

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

### Return statement

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

### With arguments

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

## If

### Else if

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

### If blocks

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

### If statement

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

### If with else

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

### If with else if inside functions

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

### If with else inside functions

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

### If with nesting

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

### Multiple else ifs

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

### Non block consequents

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

## Loops

### Continue statement

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

### Do while

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

### Do while with other statements

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

### Forever loop

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

### While

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

### While with break

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

## New

### New operator

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = new B
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = new B
</pre>
</td></tr></table>

### New operator with arguments

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = new B(x,y);
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = new B(x, y)
</pre>
</td></tr></table>

### New with complex callee

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = new (require('foo'))(b)
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = new (require('foo'))(b)
</pre>
</td></tr></table>

## Objects

### Call with object

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

### Multiple properties

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

### Nested objects

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

### Simple object

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = { b: 2 }
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = b: 2
</pre>
</td></tr></table>

## Pending

## Simple

### Assignments

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

### Booleans

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

### Debugger statement

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

### Empty statement

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>;;
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'></pre>
</td></tr></table>

### Empty statement with other statements

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

### Function call

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>alert("Hello world");
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>alert "Hello world"
</pre>
</td></tr></table>

### Function call with arguments

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a("hello", 2);
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a "hello", 2
</pre>
</td></tr></table>

### Indented throw

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

### Index resolution

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a[2]
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a[2]
</pre>
</td></tr></table>

### Index resolution of expression

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a["node" + n]
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a["node" + n]
</pre>
</td></tr></table>

### Index resolution of strings

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a["a-b"]
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a["a-b"]
</pre>
</td></tr></table>

### Index resolution witH this

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>this["#" + id]
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>@["#" + id]
</pre>
</td></tr></table>

### Inline assignment

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

### Nested function calls

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a(b());
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a b()
</pre>
</td></tr></table>

### Nesting if and assignment

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

### Scope resolution

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a.b
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a.b
</pre>
</td></tr></table>

### Standalone this

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = this;
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = this
</pre>
</td></tr></table>

### This prefix

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>this.run();
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>@run()
</pre>
</td></tr></table>

### Throw

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>throw e
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>throw e
</pre>
</td></tr></table>

### Unary void

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>void 0
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>void 0
</pre>
</td></tr></table>

## Strings

### Empty string

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>""
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>""
</pre>
</td></tr></table>

### Simple string

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>"hello"
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>"hello"
</pre>
</td></tr></table>

### Single quotes

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>'\n'
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>'\n'
</pre>
</td></tr></table>

### String with escapes

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>"\n"
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>"\n"
</pre>
</td></tr></table>

## Var

### Mixed var declarations

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

### Multiple var declaration

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

### Multiple var declarations with indent

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

### Var declaration

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>var a = 1
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = 1
</pre>
</td></tr></table>

### Var without initializer

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>var a;
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = undefined
</pre>
</td></tr></table>

