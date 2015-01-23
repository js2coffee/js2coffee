Developer notes
===============

### Running tests

    npm test

If you want to run pending specs as well:

    ALL=1 npm test

If you'd like to isolate a spec, edit the spec file to add `only: true`:

    # specs/xxx/yyy.txt
    only: true
    ---
    x()
    ---
    x()

### References

- [Esprima docs]
- [Parser API spec]
- [Esprima demo]

[Esprima docs]: http://esprima.org/doc/index.html#ast
[Parser API spec]: https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API
[Esprima demo]: http://esprima.org/demo/parse.html# 

### Features to do

 - [x] Really think indentation through
 - [x] Put groundwork on comment generation
 - [x] Throw useful Esprima errors (like coffeescriptredux)
 - [x] Move Comments to transformer
 - [x] Move For loops to transformer
   - [x] WhileStatement to CoffeeLoopStatement
   - [ ] DoWhileStatement to CoffeeLoopStatement
   - [ ] `unless` support for IfStatement
   - [x] ForStatement as a transformation to WhileStatement
   - [ ] ForInStatement ?
   - [ ] add extra `continue` (makeLoopBody)

Critical for compatibility:

 - [x] Ensure correct function orders
 - [ ] Add `return` at the end as needed
 - [ ] Remove extraneous `return`
 - [x] `a(/=b/i)` should not compile to `a /=b/i`
 - [ ] Take care of operator precedence
 - [ ] Renaming variables in case of shadowing
 - [ ] Empty while
 - [ ] Continue in `for` loop

 Niceness:

 - [x] Transform `.prototype.`
 - [ ] `Math.pow(a,b)` => `a ** b`
 - [ ] `Math.floor(a / b)` => `a // b`
 - [ ] `function() { a }.bind(this)` => `=> a`
 - [x] Support a `case` without any code
 - [ ] Sequence of objects (`a('ok', {a:b}, ->)`)
 - [ ] Array of functions

### Precendence rules

 - all expressions (CallExpression, NewExpression, ObjectExpression, ...)
 - IfExpression
 - `* /`
 - `+ -`
