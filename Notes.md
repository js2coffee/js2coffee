### References

- [Esprima docs]
- [Parser API spec]
- [Esprima demo]

[Esprima docs]: http://esprima.org/doc/index.html#ast
[Parser API spec]: https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API
[Esprima demo]: http://esprima.org/demo/parse.html# 

### Features to do

 - [x] Test Walker
 - [x] Add support for filters
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
 - [ ] SwitchStatement
 - [x] ReturnStatement
 - [x] ThrowStatement
 - [x] TryStatement
 - [x] WhileStatement
 - [x] DoWhileStatement
 - [ ] ForStatement
 - [ ] ForInStatement
 - [ ] ForOfStatement
 - [x] DebuggerStatement
 - [x] FunctionDeclaration
 - [x] VariableDeclaration
 - [x] VariableDeclarator
 - [x] ThisExpression
 - [ ] ArrayExpression
 - [ ] ObjectExpression
 - [x] FunctionExpression
 - [ ] SequenceExpression
 - [x] UnaryExpression
 - [x] BinaryExpression
 - [x] AssignmentExpression
 - [ ] UpdateExpression
 - [ ] LogicalExpression
 - [ ] ConditionalExpression
 - [x] NewExpression
 - [x] CallExpression
 - [x] MemberExpression
 - [ ] ObjectPattern
 - [ ] ArrayPattern
 - [ ] SwitchCase
 - [x] CatchClause
 - [x] Identifier
 - [x] Literal
