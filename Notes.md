Developer notes
===============

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
 - [ ] Move For loops to transformer
   - [ ] WhileStatement to CoffeeLoopStatement
   - [ ] DoWhileStatement to CoffeeLoopStatement
   - [ ] `unless` support for IfStatement
   - [ ] ForStatement as a transformation to WhileStatement
   - [ ] ForInStatement ?
   - [ ] add extra `continue` (makeLoopBody)

Critical for compatibility:

 - [x] Ensure correct function orders
 - [ ] Add `return` at the end as needed
 - [ ] `a(/=b/i)` should not compile to `a /=b/i`
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

### Types

These things are converted into CoffeeScript:

 - [ ] SequenceExpression
   - turned into a sequence of ExpressionStatements

Etc:

 - [x] Program

 - [x] EmptyStatement

 - [x] BlockStatement

 - [x] ExpressionStatement
   - `expression` : Expression

 - [x] IfStatement
   - `test` : Expression
   - `consequent` : BlockStatement
   - `alternate` : BlockStatement ?
 - [x] LabeledStatement
 - [x] BreakStatement
 - [x] ContinueStatement
 - [x] WithStatement
 - [x] SwitchStatement
 - [x] ReturnStatement
 - [x] ThrowStatement
   - `argument` : Expression
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

 - [x] UnaryExpression
   - `operator` : String (eg: 'void', '~')
   - `argument` : Expression

 - [x] BinaryExpression
   - `left` : Expression
   - `operator` : String (eg: `+`)
   - `right` : Expression

 - [x] AssignmentExpression
 - [x] UpdateExpression
   - `prefix` : Boolean
   - `operator` : String ('--' | '++')
   - `argument` : Identifier
 - [x] ConditionalExpression

 - [x] NewExpression

 - [x] CallExpression
   - `callee` : Identifier
   - `arguments` : Expression +
   - `_isStatement` : Boolean (true if it has no parentheses)

 - [x] MemberExpression
   - `computed` : Boolean (true if `a[b]`, false if `a.b`)
   - `object` : Expression (left side)
   - `property` : Expression (right side)

 - [x] SwitchCase
   - `type` : ??
   - `test` : Expression
   - `consquent` : BlockStatement

 - [x] CatchClause
   - `param` : Identifier
   - `body` : BlockStatement

 - [x] Identifier
   - `name` : String

 - [x] Literal
   - `raw` : raw code as a string (eg: `"\"hello\""`)
   - `value` : whatever the value is (eg: `hello`)

These are CoffeeScript-specific AST types:

 - [x] CoffeeListExpression - a comma-separated list (eg: `when a, b`)
    - `expressions` : Expression +

 - [x] CoffeeLoopStatement - a forever loop
   - `body` : BlockStatement

 - [x] CoffeeEscapedExpression - a backtick-wrapped JS expression
   - `value` : the raw value

### Precendence rules

 - all expressions (CallExpression, NewExpression, ObjectExpression, ...)
 - IfExpression
 - `* /`
 - `+ -`

> if (level of child > level of parent) then parenthesize();
