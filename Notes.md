### References

- [Esprima docs]
- [Parser API spec]
- [Esprima demo]

[Esprima docs]: http://esprima.org/doc/index.html#ast
[Parser API spec]: https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API
[Esprima demo]: http://esprima.org/demo/parse.html# 

### Big to do

 - [ ] Test Walker
 - [ ] Add support for filters

### Types

 - [x] Program
 - [ ] EmptyStatement
 - [x] BlockStatement
 - [x] ExpressionStatement
 - [x] IfStatement
 - [ ] LabeledStatement
 - [ ] BreakStatement
 - [ ] ContinueStatement
 - [ ] WithStatement
 - [ ] SwitchStatement
 - [x] ReturnStatement
 - [ ] ThrowStatement
 - [ ] TryStatement
 - [ ] WhileStatement
 - [ ] DoWhileStatement
 - [ ] ForStatement
 - [ ] ForInStatement
 - [ ] ForOfStatement
 - [ ] LetStatement
 - [ ] DebuggerStatement
 - [x] FunctionDeclaration
 - [ ] VariableDeclaration
 - [ ] VariableDeclarator
 - [ ] ThisExpression
 - [ ] ArrayExpression
 - [ ] ObjectExpression
 - [ ] FunctionExpression
 - [ ] SequenceExpression
 - [ ] UnaryExpression
 - [x] BinaryExpression
 - [ ] AssignmentExpression
 - [ ] UpdateExpression
 - [ ] LogicalExpression
 - [ ] ConditionalExpression
 - [ ] NewExpression
 - [x] CallExpression
 - [x] MemberExpression
 - [ ] ObjectPattern
 - [ ] ArrayPattern
 - [ ] SwitchCase
 - [ ] CatchClause
 - [x] Identifier
 - [x] Literal

 ES6:

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
