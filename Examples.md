### comments: trailing line comment

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

### errors: try catch finally

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

### functions: with arguments

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

### if: non block consequents

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

### loops: while with break

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

### new: new with complex callee

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = new (require('foo'))(b)
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = new (require('foo'))(b)
</pre>
</td></tr></table>

### objects: simple object

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>a = { b: 2 }
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = b: 2
</pre>
</td></tr></table>

### simple: unary void

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>void 0
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>void 0
</pre>
</td></tr></table>

### strings: string with escapes

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>"\n"
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>"\n"
</pre>
</td></tr></table>

### var: var without initializer

<table width='100%'>
<tr><th>JavaScript</th><th>CoffeeScript</th></tr>
<tr><td width='50%' valign='top'>
<pre class='lang-js'>var a;
</pre>
</td><td width='50%' valign='top'>
<pre class='lang-coffee'>a = undefined
</pre>
</td></tr></table>

