## Comments

### Block comments

In block comments, CoffeeScript converts `#` into JavaDoc-style ` *`. Hence,
Js2coffee will transform ` *` inside block comments into the more
CoffeeScript-like `#`.

```js
// Input:
a();
/*
 * hello
 */
b();
```

```coffee
# Output:
a()
###
# hello
###
b()
```

## Function calls

### Call with multiple objects

Objects aren't usually braced unless necessary. This leads to ambiguous
constructions such as `one:1, two:2` where both objects are meant to be
separated.

```js
// Input:
a({ one: 1 }, { two: 2 })
```

```coffee
# Output:
a { one: 1 }, two: 2
```

### Named iife

Named function expressions should be extracted.
This pattern is seen in a browserify wrapper.

```js
// Input:
(function fn () {
  fn();
})(a);
```

```coffee
# Output:
fn = ->
  fn()
fn a
```

## Functions

### Return object

Having a return of an object without braces is ambiguous:

> ```
> return
>   a: 1
>   b: 2
> ```

CoffeeScript and CoffeeScriptRedux will both choke on this. Js2coffee will
put braces around the object to make it work.

```js
// Input:
function fn() {
  if (x)
    return { a: 1, b: 2 };
  return true
}
```

```coffee
# Output:
fn = ->
  if x
    return {
      a: 1
      b: 2
    }
  return true
```

## Loops

### Simple for

CoffeeScript has no `for` loop, so they are converted into `while` loops.

```js
// Input:
for (a;b;c) {
  d();
}
```

```coffee
# Output:
a
while b
  d()
  c
```

## Simple

### Nested function calls

CoffeeScript allows function calls without parentheses, such as `alert
"Hello"`. With this, you can do strange constructions such as `push new
Sidebar $ "left"` (that is: `push(new Sidebar($("#left")))`).

This is unreadable, however. Ruby has the same constructions, but Ruby
styleguides often advocate *not* omitting parentheses unless the call
expression is a statement.

Js2coffee takes the same convention into consideration.

```js
// Input:
a(b(c(d())));
```

```coffee
# Output:
a b(c(d()))
```

### Standalone this

CoffeeScript allows `this` as `@`. In fact, js2coffee compiles `this.x` into `@x`.

Using a standalone `@` was once allowed in CoffeeScript, but was removed in
future versions. Hence, standalone JavaScript `this` expressions compile into
the same thing, `this`.

```js
// Input:
a = this;
```

```coffee
# Output:
a = this
```

### Ternary operator nesting

This is previously broken in js2coffee 0.x since Narcissus didn't handle this
case properly.

```js
// Input:
a ? b : c ? d : e
```

```coffee
# Output:
if a then b else if c then d else e
```

### This prefix

When using `this` on the left-side of a `.`, it gets converted into
CoffeeScript-style `@` prefixes.

When `this` is used on its own (such as in the case of the 2nd `this` in the
example), it is left alone as using a standalone `@` is discouraged.

```js
// Input:
this.run(this);
```

```coffee
# Output:
@run this
```

### Undefined

It's possible for `undefined` to be redefined in JavaScript, eg, `var
undefined = 2`. While this is undesirable and never recommended, Js2coffee
ensures that using `undefined` will use whatever `undefined` is defined as.

The backticks around it ensures that CoffeeScript will not compile
`undefined` into `void 0`.

```js
// Input:
undefined
```

```coffee
# Output:
`undefined`
```

### Void 0

CoffeeScript doesn't support the `void` operator. However, doing `void
(anything)` will always be identical to `void 0`, and CoffeeScript compiles
the `undefined` keyword into `void 0`. Hence, all `void XXX` expressions will
compile into `undefined`.

That is: `void 100 === void 0 === undefined`.

```js
// Input:
void 0
```

```coffee
# Output:
undefined
```

## Switch

### Case consolidation

CoffeeScript doesn't supprot adding `when` clauses that are empty, as you
probably would in JavaScript. Js2coffee will consolidate empty `case` clauses
together to make things more readable.

```js
// Input:
switch (a) {
  case one:
  case two:
    b();
    break;
  default:
    c();
}
```

```coffee
# Output:
switch a
  when one, two
    b()
  else
    c()
```

### Case consolidation with default

CoffeeScript doesn't supprot adding `when` clauses that are empty, as you
probably would in JavaScript. When an empty `case` is used just before
`default:`, it is effectively useless and is stripped away.

```js
// Input:
switch (a) {
  case one:
    b();
    break;
  case two:
  default:
    c();
}
```

```coffee
# Output:
switch a
  when one
    b()
  else
    c()
```

## Var

### Var without initializer

Doing `var a` in JavaScript will declare that the current
function scope has a variable `a` in it, preventing things like `alert(a)`
from getting the global `a`.

CoffeeScript has no such construct as `var`. However, since JavaScript
initializes all variables as `undefined`, doing an assignment to undefined
(`a = undefined`) will yield the same result.

```js
// Input:
var a;
```

```coffee
# Output:
a = undefined
```

