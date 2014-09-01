Developer notes
===============

### Roadmap

 - [ ] Implement all expression/statement types.
 - [x] Implement comments.
 - [ ] Ensure that all JSON looks good.
 - [ ] Make underscore.js compile and pass.

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
 - [ ] Take care of operator precedence
 - [ ] Transform `.prototype.`
 - [ ] Ensure correct function orders
 - [x] Warn about json being pasted
 - [ ] `Math.pow(a,b)` => `a ** b`
 - [ ] `Math.floor(a / b)` => `a // b`
 - [ ] `function() { a }.bind(this)` => `=> a`

Edge cases:

 - [x] A `case` without any code
 - [ ] Sequence of objects
 - [ ] Array of functions
 - [ ] Add `return` at the end as needed
 - [ ] `a(/=b/i)` should not compile to `a /=b/i`

## Edge cases

### Types

 - [x] Program
 - [x] EmptyStatement
 - [x] BlockStatement
 - [x] ExpressionStatement
 - [x] IfStatement
 - [x] LabeledStatement
 - [x] BreakStatement
 - [x] ContinueStatement
 - [x] WithStatement
 - [x] SwitchStatement
 - [x] ReturnStatement
 - [x] ThrowStatement
 - [x] TryStatement
 - [x] WhileStatement
 - [x] DoWhileStatement
 - [x] ForStatement
 - [x] ForInStatement
 - [x] DebuggerStatement
 - [x] FunctionDeclaration
 - [x] VariableDeclaration
 - [x] VariableDeclarator
 - [x] ThisExpression
 - [x] ArrayExpression
 - [x] ObjectExpression
 - [x] FunctionExpression
 - [x] SequenceExpression
 - [x] UnaryExpression
 - [x] BinaryExpression
 - [x] AssignmentExpression
 - [x] UpdateExpression
 - [ ] LogicalExpression
 - [x] ConditionalExpression
 - [x] NewExpression
 - [x] CallExpression
 - [x] MemberExpression
 - [x] SwitchCase
 - [x] CatchClause
 - [x] Identifier
 - [x] Literal

### Precendence rules

 - all expressions (CallExpression, NewExpression, ObjectExpression, ...)
 - IfExpression
 - `* /`
 - `+ -`

> if (level of child > level of parent) then parenthesize();
