### References

- [Esprima docs]
- [Parser API spec]
- [Esprima demo]

[Esprima docs]: http://esprima.org/doc/index.html#ast
[Parser API spec]: https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API
[Esprima demo]: http://esprima.org/demo/parse.html# 

### Big to do

 - [x] Test Walker
 - [x] Add support for filters
 - [ ] Really think indentation through
 - [ ] Put groundwork on comment generation
 - [ ] Throw useful Esprima errors (like coffeescriptredux)

### Types

 - [x] Program
 - [x] EmptyStatement
 - [x] BlockStatement
 - [x] ExpressionStatement
 - [x] IfStatement
 - [ ] LabeledStatement
 - [x] BreakStatement
 - [x] ContinueStatement
 - [ ] WithStatement
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
 - [ ] VariableDeclaration
 - [ ] VariableDeclarator
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
 - [ ] NewExpression
 - [x] CallExpression
 - [x] MemberExpression
 - [ ] ObjectPattern
 - [ ] ArrayPattern
 - [ ] SwitchCase
 - [x] CatchClause
 - [x] Identifier
 - [x] Literal

 ES6:

 - [ ] LetStatement
 - [ ] YieldExpression
 - [ ] ComprehensionExpression
 - [ ] GeneratorExpression
 - [ ] GraphExpression
 - [ ] GraphIndexExpression
 - [ ] ArrowExpression

 XML:

 - [ ] XMLDefaultDeclaration
 - [ ] XMLAnyName
 - [ ] XMLQualifiedIdentifier
 - [ ] XMLFunctionQualifiedIdentifier
 - [ ] XMLAttributeSelector
 - [ ] XMLFilterExpression
 - [ ] XMLElement
 - [ ] XMLList
 - [ ] XMLEscape
 - [ ] XMLText
 - [ ] XMLStartTag
 - [ ] XMLEndTag
 - [ ] XMLPointTag
 - [ ] XMLName
 - [ ] XMLAttribute
 - [ ] XMLCdata
 - [ ] XMLComment
 - [ ] XMLProcessingInstruction

### Features

 - [ ] Take care of operator precedence
 - [ ] Transform `.prototype.`
 - [ ] Ensure correct function orders
 - [ ] Warn about json being pasted
 - [ ] `Math.pow(a,b)` => `a ** b`
 - [ ] `Math.floor(a / b)` => `a // b`
 - [ ] `typeof x !== 'undefined'` => `x?`
 - [ ] `function() { a }.bind(this)` => `=> a`
