## Arrays

<table width='100%'>
<tr>
<th width='33%' valign='top'>Empty array</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = []
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = []
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Multiple items</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = [ 1, 2, 3, 4 ]
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = [
  1
  2
  3
  4
]
</code></pre>
</td>
</tr>
</table>

## Comments

<table width='100%'>
<tr>
<th width='33%' valign='top'>After block comment</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function x() {
  return y;
  /*
   * hello
   */
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = ->
  y

  ###
  # hello
  ###
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Block comments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a();
/*
 * hello
 */
b();
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a()

###
# hello
###

b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Block comments in blocks</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (x) {
  /*
   * hello
   * world
   */
  y();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if x

  ###
  # hello
  # world
  ###

  y()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Block comments with space</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a(); /* hi */
b();
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a()

### hi ###

b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Comment before function</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a()
/*
 * comment
 */
function x() {
  return;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>###
# comment
###

x = ->
  return

a()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Comments in if blocks</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (true) {
  // yes
} else {
  // no
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if true
  # yes
else
  # no
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Indented jsdoc comments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (x) {
  /**
   * documentation here
   */
  y();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if x

  ###*
  # documentation here
  ###

  y()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Line comments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a();
// hello
b();
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a()
# hello
b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Line comments before function</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a()
// one
// two
// three
function x() {
  return;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'># one
# two
# three

x = ->
  return

a()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Multiple functions with multiple comments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a()
// one
// two
// three
function x() {
  return;
}
// four
// five
// six
function y() {
  return;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'># one
# two
# three

x = ->
  return

# four
# five
# six

y = ->
  return

a()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Program block comment after</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a();
/*
 * hello
 */
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a()

###
# hello
###
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Program block comment before</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>/*
 * hello
 */
a();
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>###
# hello
###

a()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Program block comment sole</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>/*
 * hello
 */
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>###
# hello
###
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Program with only comments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>// hi
// there
/* world */
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'># hi
# there

### world ###
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Sole block comment</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn() {
  /*
   * hello
   */
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->

  ###
  # hello
  ###

  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Trailing line comment</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>hello(); // there
world();
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>hello()
# there
world()
</code></pre>
</td>
</tr>
</table>

## Compatibility mode

<table width='100%'>
<tr>
<th width='33%' valign='top'>Assignment of reserved words</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>on = 2
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>`on = 2`
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Assignment of reserved words off</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>on = 2
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>Error:
/'on' is a reserved CoffeeScript keyword/</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Empty array slots</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>[, 0]
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>`[
  ,
  0
]`
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Empty array slots off</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>[, 0]
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>Error:
/Empty array slots are not supported in CoffeeScript/</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Equals</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (a == b(c + 2)) { run(); }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if `a == b(c + 2)`
  run()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Equals off</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (a == b(c + 2)) { run(); }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a == b(c + 2)
  run()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Named function expressions</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var x = function fn() {
  return fn;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = (`function fn() {
  return fn;
}`)
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Named function expressions off</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var x = function fn() {
  return fn;
};
alert(typeof x())
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = ->
  fn

alert typeof x()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Undefined</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>undefined
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>`undefined`
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Undefined off</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>undefined
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>undefined
</code></pre>
</td>
</tr>
</table>

## Default params

<table width='100%'>
<tr>
<th width='33%' valign='top'>Mixed params</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function greet(greeting, name = 'Bob') {
  return name;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>greet = (greeting, name = 'Bob') ->
  name
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Mixed params 2</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function greet(name = 'Bob', age) {
  return name;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>greet = (name = 'Bob', age) ->
  name
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>With defaults</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function greet(name = 'Bob') {
  return name;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>greet = (name = 'Bob') ->
  name
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>With non literal defaults</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn(param = (a + b())) {
  return true
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = (param = a + b()) ->
  true
</code></pre>
</td>
</tr>
</table>

## Errors

<table width='100%'>
<tr>
<th width='33%' valign='top'>Breakless switch</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>switch (x) {
  case 1:
    b();
  case 2:
    c();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>Error:
/No break or return statement found/</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Reserved keyword</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>off = 2
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>Error:
/'off' is a reserved CoffeeScript keyword/</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Reserved keyword in params</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function x(off) {}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>Error:
/'off' is a reserved CoffeeScript keyword/</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Reserved keyword in var</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var off = 2
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>Error:
/'off' is a reserved CoffeeScript keyword/</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Switch default cases</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>switch (x) {
  default:
    a();
  case b:
    c();
    break;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>Error:
/default cases only allowed at the end/</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>With</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>with (x) { a(); }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>Error:
/'with' is not supported/</code></pre>
</td>
</tr>
</table>

## Function calls

<table width='100%'>
<tr>
<th width='33%' valign='top'>Call with function expression</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>run(function () {
  a();
  b();
  return;
});
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>run ->
  a()
  b()
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Call with function indented</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (x) {
  setTimeout(function() { return go(); }, 300)
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if x
  setTimeout (->
    go()
  ), 300
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Call with function then object</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>box.on('click', function () {
  return go();
}, { delay: 500, silent: true })
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>box.on 'click', (->
  go()
),
  delay: 500
  silent: true
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Call with multiple objects</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a({ one: 1 }, { two: 2 })
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a { one: 1 }, two: 2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Call with object</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>box.on('click', { silent: true }, function () {
  return go();
})
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>box.on 'click', { silent: true }, ->
  go()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Call with param after function</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>setTimeout(function () {
  return work();
}, 500);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>setTimeout (->
  work()
), 500
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Chaining</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>get().then(function () {
  return a();
}).then(function () {
  return b();
});
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>get().then(->
  a()
).then ->
  b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Expression with call</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function () {
  return go();
}).call(this);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(->
  go()
).call this
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Iife with different argument names</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function($) {
  go();
  return;
})(jQuery);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(($) ->
  go()
  return
) jQuery
</code></pre>
</td>
</tr>
</table>

## Functions

<table width='100%'>
<tr>
<th width='33%' valign='top'>Dont unpack returns in incomplete ifs</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function a() {
  if (x)
    return b();
  else
    c();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = ->
  if x
    return b()
  else
    c()
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Function reordering</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>alert(name());
if (ok) {
  a();
  function name() {
    return "John";
  }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>name = ->
  'John'

alert name()
if ok
  a()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Functions after var</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn() {
  var x;
  function fn2() {
    return x = 2;
  }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  x = undefined

  fn2 = ->
    x = 2

  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Functions in ternaries</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>_.propertyOf = function(obj) {
  return obj === null ? (x && function(){}) : function(key) {
    return obj[key];
  };
};
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>_.propertyOf = (obj) ->
  if obj == null then x and (->
  ) else ((key) ->
    obj[key]
  )
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Multiple declarations</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function one() {
  return a();
}
function two() {
  return b();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>one = ->
  a()

two = ->
  b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Multiple expressions</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>obj.one = function () {
  return a();
};
obj.two = function () {
  return b();
};
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>obj.one = ->
  a()

obj.two = ->
  b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Named function expressions</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var x = function fn() {
  return fn;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = ->
  fn
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Nested declarations</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function a () {
  function b () {
    return c;
  }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = ->

  b = ->
    c

  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Nested functions in object</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>({
  a: function () {
    function b() { return c; }
    return b()
  }
})
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a: ->

  b = ->
    c

  b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Prevent implicit returns</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function a() {
  b();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = ->
  b()
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Return object</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn() {
  if (x)
    return { a: 1, b: 2 };
  return true;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  if x
    return {
      a: 1
      b: 2
    }
  true
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Return statement</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function a () {
  if (x) return b;
  return c;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = ->
  if x
    return b
  c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Undefined in function expression parameters</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>call(function (undefined) {
  return true;
});
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>call ->
  true
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Undefined in parameters</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn (undefined) {
  return true;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  true
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Unpacking returns</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function a() {
  return b;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = ->
  b
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Unpacking returns in ifs</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function a() {
  if (x)
    return b();
  else
    return c();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = ->
  if x
    b()
  else
    c()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Unpacking returns in ifs with elses</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function a() {
  if (x)
    return b();
  else if (y)
    return c();
  else
    return d();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = ->
  if x
    b()
  else if y
    c()
  else
    d()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Unpacking returns in nested ifs</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function returns() {
  if (x) {
    if (y) {
      return y
    } else {
      return x
    }
  } else {
    return z
  }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>returns = ->
  if x
    if y
      y
    else
      x
  else
    z
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>With arguments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function a(b, c) { d(); }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = (b, c) ->
  d()
  return
</code></pre>
</td>
</tr>
</table>

## Globals

<table width='100%'>
<tr>
<th width='33%' valign='top'>Global assignment</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn () {
  a = 2;
  return;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  a = 2
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Global assignment compat</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn () {
  a = 2;
  return;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  `a = 2`
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>In function params</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn(x) {
  x = 2;
  return
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = (x) ->
  x = 2
  return
</code></pre>
</td>
</tr>
</table>

## If

<table width='100%'>
<tr>
<th width='33%' valign='top'>Blank ifs</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (condition) {}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if condition
else
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Blank ifs with comments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (condition) {
  // pass
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if condition
  # pass
else
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Else if</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (a) {
  x();
} else if (b) {
  y();
} else {
  z();
}
</code></pre>
</td>
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>Escaping if functions</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (a === function(){ return x(); }) {
  b()
  c()
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a == (->
    x()
  )
  b()
  c()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Escaping if functions with indent</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (1) {
  if (2) {
    if (3) {
      if (a === function(){ return x(); }) {
        b()
        c()
      }
    }
  }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if 1
  if 2
    if 3
      if a == (->
          x()
        )
        b()
        c()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>If blocks</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (a) {
  b();
  c();
  d();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a
  b()
  c()
  d()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>If statement</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (a) b()
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a
  b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>If with else</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (a) { b(); }
else { c(); }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a
  b()
else
  c()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>If with else if inside functions</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn() {
  if (a) { b(); }
  else if (b) { c(); }
  else { d(); }
  return;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  if a
    b()
  else if b
    c()
  else
    d()
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>If with else inside functions</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn() {
  if (a) { b(); } else { c(); }
  return;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  if a
    b()
  else
    c()
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>If with nesting</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (a) {
  if (b) {
    c();
  }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a
  if b
    c()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Multiple else ifs</th>
<td width='33%' valign='top'>
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
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>Non block consequents</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn() {
  if (a) b();
  else c();
  return;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  if a
    b()
  else
    c()
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Ternary in if</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (a ? b : c) { d(); }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if (if a then b else c)
  d()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Ternary in if and binary</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (x && (a ? b : c)) { d(); }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if x and (if a then b else c)
  d()
</code></pre>
</td>
</tr>
</table>

## Iife

<table width='100%'>
<tr>
<th width='33%' valign='top'>Iife</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function(){ return true; })()
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>do ->
  true
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Iife as an expression</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>$((function() { return true; })())
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>$ do ->
  true
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Iife with arguments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function(jQuery){ return true; })(jQuery)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>do (jQuery) ->
  true
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Iife with multiple arguments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function(jQuery, window){ return true; })(jQuery, window)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>do (jQuery, window) ->
  true
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Iife with non matching arguments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function () {
  return true
})(a);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(->
  true
) a
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Iife with non matching literal arguments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function () {
  return true
})(2);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(->
  true
) 2
</code></pre>
</td>
</tr>
</table>

## Indent

<table width='100%'>
<tr>
<th width='33%' valign='top'>Spaces 4</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (condition) {
  consequent();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if condition
    consequent()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Spaces 8</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (condition) {
  consequent();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if condition
        consequent()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Tab</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (condition) {
  consequent();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if condition
	consequent()
</code></pre>
</td>
</tr>
</table>

## Legacy

<table width='100%'>
<tr>
<th width='33%' valign='top'>Anon invocation</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function ($) { return $; }(jQuery));
(function ($) { return $; }());
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(($) ->
  $
) jQuery
(($) ->
  $
)()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Array literals</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var arr1 = [];
var arr2 = [1,3,4];
console.log(arr2[1][0] + [4]);
</code></pre>
</td>
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>Assign</th>
<td width='33%' valign='top'>
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
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>Bitwise shift</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var value = ((value & 255) << 16) | (value & 65280) | ((value & 16711680) >>> 16);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>value = (value & 255) << 16 | value & 65280 | (value & 16711680) >>> 16
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Blank lines</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>x = 2


y = 3
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = 2
y = 3
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Block comments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>/**
API documentation
*/
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>###*
API documentation
###
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Call statement</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function x() {
  alert(2+2);
  alert(y(10));
}

$.get({
  ajax: true,
  url: 'foo'
});
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = ->
  alert 2 + 2
  alert y(10)
  return

$.get
  ajax: true
  url: 'foo'
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Crlf</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var x = 3
var y = 2
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = 3
y = 2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Debugger</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>debugger;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>debugger
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Delete</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>delete a[x];
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>delete a[x]
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Do</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var i = 0;
do {
  console.log(i);
  i++;
} while (i < 14);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>i = 0
loop
  console.log i
  i++
  unless i < 14
    break
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Dont unreserve property accessors</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>io.on('data', function() { console.log('Received'); });
this.on('data', function() { console.log('Received'); });
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>io.on 'data', ->
  console.log 'Received'
  return
@on 'data', ->
  console.log 'Received'
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Empty function</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function($) {})()
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(($) ->
)()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Empty function bodies</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>x = { v: function() { return 2; }, y: function(){}, z: function(){} };
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x =
  v: ->
    2
  y: ->
  z: ->
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Empty semicolon</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>2;;;3
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>2
3
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Equal regex</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var re = /=/;
console.log("a = b".match(re));
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>re = RegExp('=')
console.log 'a = b'.match(re)
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Floating point numbers</th>
<td width='33%' valign='top'>
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
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>For</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (x=0; !x<2; x++) { alert(1) }
for (; !x<2; ) { alert(1) }
for (;;++x) { alert(1) }
for (;;) { alert(1) }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = 0
while !x < 2
  alert 1
  x++
while !x < 2
  alert 1
loop
  alert 1
  ++x
loop
  alert 1
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For in</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (var x in y) { alert(1) }
for (var key in obj) {}
for (key in obj)
    single_liner()
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>for x of y
  alert 1
for key of obj
  continue
for key of obj
  single_liner()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Function order</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var x = function() {
    alert(y());
    var z = function() { return 3; }
    function y() { return 2; }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = ->

  y = ->
    2

  alert y()

  z = ->
    3

  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Function property</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function (){}.apa);
var f = function(){}.bind(this);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(->
).apa
f = (->
).bind(this)
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Function with keyword</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function x() {}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = ->
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Increment decrement</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a++;
++a;
--a;
a--;
a+++a;
a---a;
</code></pre>
</td>
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>Index</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a[x] = 2</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a[x] = 2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Numbers</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var x = 1e3;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = 1e3
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Or</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = 2 || {}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = 2 or {}
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Parenthesized new</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(new Date).getTime()
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(new Date).getTime()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Return function</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function() { return function() { return 2 }; })
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>->
  ->
    2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Simple addition</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = 8+2+2;2
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = 8 + 2 + 2
2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Single line else</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if ((x !== 2) && (2)) { 2;2 } else true
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if x != 2 and 2
  2
  2
else
  true
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Single return</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function() { return; });</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>->
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Switch</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>switch (x) { case 2: a; break; case 3: b; break; default: x; }
switch (x) { case 2: case 3: b; break; default: x; }</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>switch x
  when 2
    a
  when 3
    b
  else
    x
switch x
  when 2, 3
    b
  else
    x
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Ternary</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a?b:c
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a then b else c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>This attribute</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function() {
  return this.foo;
})

</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>->
  @foo
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>This keyword</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(function() {
  return this;
})

</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>->
  this
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Throw</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>try {
throw 2;} catch(x) { alert (x); }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>try
  throw 2
catch x
  alert x
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Unary</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>-1;
+1;
+1 - 1;
+1 -1;
~2 - 2;
~2+-1;
var a =~ 2;
</code></pre>
</td>
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>Var</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var x = 2;
var y;
var f = function() { return y };
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = 2
y = undefined

f = ->
  y
</code></pre>
</td>
</tr>
</table>

## Loops

<table width='100%'>
<tr>
<th width='33%' valign='top'>Continue statement</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>while (condition) {
  if (x) continue;
  a();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>while condition
  if x
    continue
  a()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Do while</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>do {
  b();
} while (a)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>loop
  b()
  unless a
    break
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Do while with other statements</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn() {
  before();
  do {
    b();
  } while (a);
  after();
  return;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  before()
  loop
    b()
    unless a
      break
  after()
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Empty while</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>while (a) {}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>while a
  continue
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For in with if</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (condition) {
  for (var a in b) if (c) d();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if condition
  for a of b
    if c
      d()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For in with var</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (var x in y) {
  z();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>for x of y
  z()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For with continue</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (a; b; update++) {
  if (x) continue;
  d()
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a
while b
  if x
    update++
    continue
  d()
  update++
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For with continue with switch</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (a; b; update++) {
  switch (x) {
    case 1:
      continue;
      break;
  }
  d()
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a
while b
  switch x
    when 1
      update++
      continue
  d()
  update++
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For with continue without init</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (;;c++) {
  if (true) continue;
  if (false) continue;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>loop
  if true
    c++
    continue
  if false
    c++
    continue
  c++
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For with if</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (condition)
  for (a;b;c) if (d) e();
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if condition
  a
  while b
    if d
      e()
    c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For with no arguments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (;;) {
  d();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>loop
  d()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For with no body</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for(;;){}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>loop
  continue
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For with no init</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (;b;c) {
  d();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>while b
  d()
  c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For with no test</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (a;;c) {
  d();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a
loop
  d()
  c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For with no update</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (a;b;) {
  d();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a
while b
  d()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Forever loop</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>while (true) {
  a();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>loop
  a()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Indented for</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (true) {
  for (a;b;c) { d; }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if true
  a
  while b
    d
    c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Simple for</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (a;b;c) {
  d();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a
while b
  d()
  c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>While</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>while (condition) { a(); }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>while condition
  a()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>While with break</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>while (condition) {
  if (x) break;
  a();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>while condition
  if x
    break
  a()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>While with no body</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (true) {
  while (a) {
  }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if true
  while a
    continue
</code></pre>
</td>
</tr>
</table>

## Members

<table width='100%'>
<tr>
<th width='33%' valign='top'>Identifier in brackets</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a[x]
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a[x]
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Identifiers</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a.b
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a.b
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Prototype</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a.prototype.b = {};
a.prototype;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a::b = {}
a.prototype
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>This prototype</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>this.prototype.a = 1;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>@::a = 1
</code></pre>
</td>
</tr>
</table>

## New

<table width='100%'>
<tr>
<th width='33%' valign='top'>New operator</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = new B
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = new B
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>New operator with arguments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = new B(x,y);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = new B(x, y)
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>New with complex callee</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = new (require('foo'))(b)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = new (require('foo'))(b)
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>New with function expression</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = new MyClass('left', function () {
  go();
  return;
})
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = new MyClass('left', ->
  go()
  return
)
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>New with function expression and string</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = new MyClass(function () {
  go();
  return;
}, 'left')
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = new MyClass((->
  go()
  return
), 'left')
</code></pre>
</td>
</tr>
</table>

## Objects

<table width='100%'>
<tr>
<th width='33%' valign='top'>Arrray of objects</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var list = [
  { a: 1, b: 1 },
  { a: 2, b: 2 },
]
</code></pre>
</td>
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>Call with object</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>call({ a: 1, b: 2 })
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>call
  a: 1
  b: 2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Multiple object expressions</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>({ a: 1, b: 2 });
({ c: 3, d: 4 });
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>{
  a: 1
  b: 2
}
c: 3
d: 4
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Multiple properties</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a = { b: 2, c: 3 }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a =
  b: 2
  c: 3
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Nested objects</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a = { b: { x: 3, y: 3 }, d: 4 }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a =
  b:
    x: 3
    y: 3
  d: 4
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Nesting into a single line</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var x = ({a: {b: {c: {d: e}}, f: {g: {h: i}}}})
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>x = a:
  b: c: d: e
  f: g: h: i
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Object with arrays</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a = {
  empty: [],
  one: [ 1 ],
  many: [ 1, 2, 3 ]
};
</code></pre>
</td>
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>Simple object</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = { b: 2 }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = b: 2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Single object expression</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>({ a: 1, b: 2 })
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a: 1
b: 2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Singleton with methods</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>App = {
  start: function () { go(); return; },
  stop: function () { halt(); return; }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>App =
  start: ->
    go()
    return
  stop: ->
    halt()
    return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Unusual identifiers</th>
<td width='33%' valign='top'>
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
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>object =
  a: b
  'a.a': b
  'a#a': b
  'a a': b
  0: b
  '0.a': b
  $: b
  $$: b
  $a: b
  '$a b': b
</code></pre>
</td>
</tr>
</table>

## Precedence

<table width='100%'>
<tr>
<th width='33%' valign='top'>Addition and multiplication</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(a + b) * c
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(a + b) * c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Binary expressions</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a | b ^ c & d
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a | b ^ c & d
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Binary expressions with parens</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>((a | b) ^ c) & d
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>((a | b) ^ c) & d
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Call expression</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a.b()
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a.b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Instanceof and function call</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(a instanceof b)(c)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(a instanceof b) c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Intransitive operations division</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a/b/c;

(a/b)/c;
(a*b)/c;
(a/b)*c;
(a*b)*c;

a/(b/c);
a/(b*c);
a*(b/c);
a*(b*c);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a / b / c
a / b / c
a * b / c
a / b * c
a * b * c
a / (b / c)
a / (b * c)
a * b / c
a * b * c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Intransitive operations subtraction</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a-b-c;

(a-b)-c;
(a+b)-c;
(a-b)+c;
(a+b)+c;

a-(b-c);
a-(b+c);
a+(b-c);
a+(b+c);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a - b - c
a - b - c
a + b - c
a - b + c
a + b + c
a - (b - c)
a - b + c
a + b - c
a + b + c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Logical operators</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(a || b) && (c || d)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(a or b) and (c or d)
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Nested new</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>new X(new Y)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>new X(new Y)
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Nested ternary</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a ? b : c ? d : e
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a then b else if c then d else e
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Nested ternary 2</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a ? b ? c : d : e
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a then (if b then c else d) else e
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Parenthesized classname in new</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>new (X())
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>new (X())
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Strip useless parens</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(a + b) + c + (d + e)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a + b + c + d + e
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Ternary and assignment</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a ? (b=c) : d
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a then (b = c) else d
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Typeof and member expression</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>(typeof x)[2]
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(typeof x)[2]
</code></pre>
</td>
</tr>
</table>

## Regexp

<table width='100%'>
<tr>
<th width='33%' valign='top'>Blank with flag</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>/ /g
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>RegExp ' ', 'g'
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Equals</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a(/=\s/)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a RegExp('=\\s')
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Equals with flag</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>/=/g
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>RegExp '=', 'g'
</code></pre>
</td>
</tr>
</table>

## Shadowing

<table width='100%'>
<tr>
<th width='33%' valign='top'>Var shadowing</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var val = 2;
var fn = function () {
  var val = 1;
  return;
}
fn();
assert(val === 2);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>val = 2

fn = ->
  `var val`
  val = 1
  return

fn()
assert val == 2
</code></pre>
</td>
</tr>
</table>

## Simple

<table width='100%'>
<tr>
<th width='33%' valign='top'>Array newlines</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>controller('name', [
  'a',
  'b',
  function (a, b) {
    alert('ok');
    return;
  },
  'z'
]);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>controller 'name', [
  'a'
  'b'
  (a, b) ->
    alert 'ok'
    return
  'z'
]
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Binary operators</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a << b;
a >> b;
a | b;
a ^ b;
a & b;
a ^ b & c | d;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a << b
a >> b
a | b
a ^ b
a & b
a ^ b & c | d
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Booleans</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>true;
false;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>true
false
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Call with function</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a(function() {
  b();
  return;
});
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a ->
  b()
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Debugger statement</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (x) debugger;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if x
  debugger
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Delete</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>delete x.y;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>delete x.y
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Empty statement</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>;;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'></code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Empty statement with other statements</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a();;;b()
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a()
b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Exponents</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>Math.pow(2, 8)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>2 ** 8
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Exponents precedence</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>Math.pow(1 * 2, 8)
Math.pow(!x, 8)
Math.pow(x++, 8)
Math.pow(++y, 8)
Math.pow(new X, 8)
Math.pow(new X(2), 8)
Math.pow(a < b, 8)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>(1 * 2) ** 8
(!x) ** 8
x++ ** 8
++y ** 8
new X ** 8
new X(2) ** 8
(a < b) ** 8
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Exponents with strange arguments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = Math.pow(2)
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = Math.pow(2)
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Function call</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>alert("Hello world");
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>alert 'Hello world'
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Function call with arguments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a("hello", 2);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a 'hello', 2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Function in switch</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for(var i = 0; i <5; ++i) {
   switch(i) {
     case 1:
       function foo() { return 2; }
       alert("one");
       break;
   }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>foo = ->
  2

i = 0
while i < 5
  switch i
    when 1
      alert 'one'
  ++i
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Increment</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a++
b--
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a++
b--
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Indentation of parentheses</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (w) {
  x(y(function() {
    return true
  }));
  z()
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if w
  x y(->
    true
  )
  z()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Indented throw</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (x) throw e
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if x
  throw e
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Index resolution</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a[2]
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a[2]
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Index resolution of expression</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a["node" + n]
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a['node' + n]
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Index resolution of strings</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a["a-b"]
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a['a-b']
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Index resolution with this</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>this["#" + id]
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>@['#' + id]
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Inline assignment</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a, m;
if (a = m = match) {
  m();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = undefined
m = undefined
if a = m = match
  m()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Logical expressions</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a || b;
c && d;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a or b
c and d
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Multiple unary operators</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>0 + - + - - 1
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>0 + - + - -1
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Nested function calls</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a(b(c(d())));
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a b(c(d()))
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Nesting if and assignment</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a.b = function (arg) {
  if (arg) cli.a = b;
  return;
};
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a.b = (arg) ->
  if arg
    cli.a = b
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Null check</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function ifNullChecks() {
  if (x===null) { yep() }
  return
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>ifNullChecks = ->
  if x == null
    yep()
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Prefix increment</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>++a;
--b;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>++a
--b
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Prototype</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a.prototype.b = 1
a.prototype = {}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a::b = 1
a.prototype = {}
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Recursing into new functions</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = x ? y : function () {
  return a === "b";
};
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = if x then y else (->
  a == 'b'
)
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Return nothing</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn () {
  return;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  return
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Scientific notation</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = -1.21e3;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = -1.21e3
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Sequence expression</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a,b,c
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a
b
c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Sequence expression with indent</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (x) {
  a,b,c;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if x
  a
  b
  c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Standalone this</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = this;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = this
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Ternary operator</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a ? b : c
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a then b else c
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Ternary operator nesting</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a ? b : c ? d : e
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if a then b else if c then d else e
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>This prefix</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>this.run(this);
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>@run this
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Throw</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>throw e
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>throw e
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Void 0</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>void 0
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>undefined
</code></pre>
</td>
</tr>
</table>

## Spacing

<table width='100%'>
<tr>
<th width='33%' valign='top'>Block comments</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>/*
 * hello
 */
there();
/*
 * world
 */
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>###
# hello
###

there()

###
# world
###
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Collapsing extra newlines</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>/*
 * hello
 */
/*
 * world
 */
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>###
# hello
###

###
# world
###
</code></pre>
</td>
</tr>
</table>

## Special cases

<table width='100%'>
<tr>
<th width='33%' valign='top'>Assignment in condition</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var options;
if ( (options = arguments[ i ]) !== null ) {
  for (var x in y) { z(); }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>options = undefined
if (options = arguments[i]) != null
  for x of y
    z()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Unary and object expression</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>+{ a: '2' }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>+{ a: '2' }
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Unary and object with call</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>!{ toString: null }.propertyIsEnumerable('string')
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>!{ toString: null }.propertyIsEnumerable('string')
</code></pre>
</td>
</tr>
</table>

## Strings

<table width='100%'>
<tr>
<th width='33%' valign='top'>Empty string</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>""
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>''
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Prevent interpolation</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>"#{a}"
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>'#{a}'
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Simple string</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>"hello"
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>'hello'
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Single quotes</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>'\n'
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>'\n'
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>String with escapes</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>"\n"
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>'\n'
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Unicode</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>'\u2028'
'\u2029'
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>'\u2028'
'\u2029'
</code></pre>
</td>
</tr>
</table>

## Switch

<table width='100%'>
<tr>
<th width='33%' valign='top'>Case consolidation</th>
<td width='33%' valign='top'>
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
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>switch a
  when one, two
    b()
  else
    c()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Case consolidation with default</th>
<td width='33%' valign='top'>
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
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>switch a
  when one
    b()
  else
    c()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Switch</th>
<td width='33%' valign='top'>
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
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>Switch with comments</th>
<td width='33%' valign='top'>
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
<td width='33%' valign='top'>
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
<th width='33%' valign='top'>Switch with conditional expression</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>switch (a?b:c) {
  case d:
    e();
    break;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>switch (if a then b else c)
  when d
    e()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Switch with continue</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>while (true) {
  switch (x) {
    case 1:
      continue;
  }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>loop
  switch x
    when 1
      continue
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Switch with return</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function fn () {
  switch (obj) {
    case 'one':
      return a();
    default:
      return b();
  }
  return
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>fn = ->
  switch obj
    when 'one'
      return a()
    else
      return b()
  return
</code></pre>
</td>
</tr>
</table>

## Try

<table width='100%'>
<tr>
<th width='33%' valign='top'>No finally</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>try {
  a();
} catch (e) {
  b();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>try
  a()
catch e
  b()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Try catch finally</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>try {
  a();
} catch (e) {
  b();
} finally {
  c();
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>try
  a()
catch e
  b()
finally
  c()
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Try with indent</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (x) {
  try { a(); }
  catch (e) { b(); }
  finally { c(); }
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if x
  try
    a()
  catch e
    b()
  finally
    c()
</code></pre>
</td>
</tr>
</table>

## Var

<table width='100%'>
<tr>
<th width='33%' valign='top'>Mixed var declarations</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (true) {
  var a = 1, b, c = 2, d;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if true
  a = 1
  b = undefined
  c = 2
  d = undefined
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Multiple var declaration</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = 1, b = 2
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = 1
b = 2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Multiple var declarations with indent</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>if (true) {
  var a = 1, b = 2;
}
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>if true
  a = 1
  b = 2
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Var declaration</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a = 1
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = 1
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Var without initializer</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>var a;
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a = undefined
</code></pre>
</td>
</tr>
</table>

## Warnings

<table width='100%'>
<tr>
<th width='33%' valign='top'>Equals</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>a == b
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>a == b
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>For in without var</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>for (x in y) { z }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>for x of y
  `x = x`
  z
</code></pre>
</td>
</tr>
<tr>
<th width='33%' valign='top'>Shadowing</th>
<td width='33%' valign='top'>
<pre><code class='lang-js'>function add () { var add = 2; return }
</code></pre>
</td>
<td width='33%' valign='top'>
<pre><code class='lang-coffee'>add = ->
  `var add`
  add = 2
  return
</code></pre>
</td>
</tr>
</table>

