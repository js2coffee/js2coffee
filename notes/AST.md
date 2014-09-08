Abstract Syntax Tree
====================

The CoffeeScript AST format is much pretty much exactly like JavaScript's. Only:
it has a few new node types, a few new properties in existing types, and some
unsupported ones are removed.

- New node types are always prefixed with *Coffee* (eg: `CoffeeLoopStatement`).

- New properties are always prefixed with underscore (eg: `_prefix` in
  `ThisExpression`).

- Types supported in JS but not Coffee are removed (eg, `WithStatement`).

Refer to the [Parser API spec] for the JavaScript version.

Nodes
-----

These are nodes seen in both CoffeeScript and JavaScript:

 - __Program__<br>
   the root node.

   - `body` : Statement +

 - __BlockStatement__<br>
   a sequence of statements. Usually belongs to a loop like WhileStatement, or 
   an IfStatement, or some other.

   - `body` : Statement +

 - __ExpressionStatement__<br>
   A statement with one expression in it.

   - `expression` : Expression

 - __Identifier__<br>
   Just an identifier.

   - `name` : String

 - __IfStatement__<br>
   A conditional. This encompasses both the `if` and `else` parts.

   - `test` : Expression
   - `consequent` : BlockStatement
   - `alternate` : BlockStatement ?

 - __BreakStatement__<br>
   Just `break`, for breaking out of loops. No properties.

 - __ContinueStatement__<br>
   Just `continue`, for breaking out of loops. No properties.

 - __SwitchStatement__

 - __ReturnStatement__<br>
   Can have its argument missing (eg: `return`).

   - `argument` : Expression ?

 - __ThrowStatement__
   - `argument` : Expression

 - __TryStatement__<br>
   A try block. Encompasses all `try`, `catch`, and `finally`.

   - `block` : BlockStatement (the `try`)
   - `handlers` : CatchClause * (the `catch`)
   - `finalizer` : BlockStatement ? (the `finally`)

 - __CatchClause__<br>
   - `param`
   - `body`

 - __WhileStatement__

 - __DoWhileStatement__

 - __ForStatement__

 - __ForInStatement__

 - __DebuggerStatement__
   - no properties

 - __ThisExpression__
   - `_prefix` : Boolean (true if rendered as `@`)

 - __ArrayExpression__
   - `elements` : Expression *

 - __ObjectExpression__
   - `properties` : Property *
   - `_braced` : Boolean (true if braced, eg `{ a: 1 }`)

 - __Property__<br>
   Inside ObjectExpression.

   - `kind` : "init" (not sure what this is)
   - `key` : Expression (usually Identifier or Literal)
   - `value` : Expression

 - __FunctionExpression__<br>
   (note: `id` is removed from function expressions.)

   - `params` : Identifier +
   - `body` : BlockStatement
   - `_parenthesized` : Boolean (true if parenthesized, eg `(-> ...)`)

 - __UnaryExpression__<br>
   A prefix expression. Note that this *operator* also be `not`, which is not
   available in JS.

   - `operator` : String (eg: "void", "!")
   - `argument` : Expression

 - __BinaryExpression__
   - `left` : Expression
   - `operator` : String (eg: "+")
   - `right` : Expression

 - __AssignmentExpression__<br>
   An assignment. Also covers shorthand like `+=`.

   - `left` : Expression
   - `operator` : String (eg: "+=")
   - `right` : Expression

 - __UpdateExpression__<br>
   An increment or decrement. (`a++`)

   - `prefix` : Boolean
   - `operator` : String (eg: `++`)
   - `argument` : Identifier (eg: `a`)

 - __ConditionalExpression__

 - __NewExpression__
   - `callee` : Expression (usually an Identifier)
   - `arguments` : Expression +

 - __CallExpression__
   - `callee` : Expression (usually an Identifier)
   - `arguments` : Expression +
   - `_isStatement` : Boolean (true if it has no parentheses)

 - __MemberExpression__
   - `computed` : Boolean (true if `a[b]`, false if `a.b`)
   - `object` : Expression (left side)
   - `property` : Expression (right side)

 - __SwitchCase__
   - `type` : ??
   - `test` : Expression
   - `consquent` : BlockStatement

 - __CatchClause__
   - `param` : Identifier
   - `body` : BlockStatement

 - __Identifier__
   - `name` : String

 - __Literal__
   - `raw` : raw code as a string (eg: `"\"hello\""`)
   - `value` : whatever the value is (eg: `hello`)

CoffeeScript-specific
---------------------

These are CoffeeScript-specific AST types:

 - __CoffeeListExpression__<br>
   a comma-separated list (eg: `when a, b`).

    - `expressions` : Expression +

 - __CoffeeLoopStatement__<br>
   a forever loop.

   - `body` : BlockStatement

 - __CoffeeEscapedExpression__<br>
   a backtick-wrapped JS expression.

   - `value` : the raw value

Only in JavaScript
------------------

These node types are not present in CoffeeScript ASTs, but are present in 
JavaScript ASTs.

 - __SequenceExpression__<br>
   turned into a sequence of ExpressionStatements.

 - __EmptyStatement__<br>
   removed from the tree.

 - __FunctionDeclaration__<br>
   converted into `a = ->` (assignment expression).

 - __VariableDeclaration__<br>
   converted into `a = ->` (assignment expression).

 - __VariableDeclarator__<br>
   converted into `a = ->` (assignment expression).

 - __WithStatement__<br>
   throws an error; unsupported in CoffeeScript.

 - __LabeledStatement__<br>
   throws an error; unsupported in CoffeeScript.

[Parser API spec]: https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API
