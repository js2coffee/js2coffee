Esprima = require('esprima')
{SourceNode} = require("source-map")
{
  buildError
  commaDelimit
  delimit
  newline
  prependAll
  space
  inspect
} = require('./lib/helpers.coffee')

###*
# js2coffee() : js2coffee(source, [options])
# Converts to code.
#
#     output = js2coffee.build('alert("hi")');
#     output;
#     => 'alert "hi"'
###

module.exports = js2coffee = (source, options) ->
  js2coffee.build(source, options).code

###*
# build() : js2coffee.build(source, [options])
# builds.
#
#     output = js2coffee.build('a = 2', {});
#
#     output.code
#     output.ast
#     output.map
#
# All options are optional. Available options are:
#
# ~ filename (String): the filename, used in source maps and errors.
###

js2coffee.build = (source, options = {}) ->
  options.filename ?= 'input.js'
  options.source = source

  try
    ast = Esprima.parse(source, loc: true, range: true, comment: true)
  catch err
    throw buildError(err, source, options.filename)

  FunctionTransformer.run(ast, options)
  OtherTransformer.run(ast, options)

  {code, map} = new Builder(ast, options).get()
  {code, ast, map}

# ----------------------------------------------------------------------------

###*
# TransformerBase:
# Base class.
#
#     class MyTransform extends TransformBase
#       Program: (node) ->
#         return { replacementNodeHere }
#
#       FunctionDeclaration: (node) ->
#         ...
#
# From within the handlers, you can call some of the functions
#
#     @break()
#     @skip()
#     @syntaxError(node, "fail~)
#
# It also has a few hooks that you can override:
#
# ~ onScopeEnter: when scopes are entered (via `pushScope()`)
# ~ onScopeExit: when scopes are exited (via `popScope()`)
###

class TransformerBase
  @run: (ast, options) ->
    new this(ast, options).run()

  constructor: (@ast, @options) ->
    @scopes = []
    @ctx = { vars: [] }

  run: ->
    @recurse @ast

  recurse: (root) ->
    self = this
    depth = 0
    @estraverse().replace root,
      enter: (node, parent) ->
        self.controller = this
        self.node = node
        depth += 1
        fn = self["#{node.type}"]
        self.onBeforeEnter?(node, depth, fn, res)
        res = (fn.apply(self, [ node, parent ]) if fn)
        self.onEnter?(node, depth, fn, res)
        res
      leave: (node, parent) ->
        self.controller = this
        self.node = node
        depth -= 1
        fn = self["#{node.type}Exit"]
        self.onBeforeExit?(node, depth, fn, res)
        res = (fn.apply(self, [ node, parent ]) if fn)
        self.onExit?(node, depth, fn, res)
        res
    root

  skip: ->
    @controller?.skip()

  break: ->
    @controller?.break()

  ###*
  # estraverse():
  # Returns `estraverse`.
  ###

  estraverse: ->
    @_estraverse ?= do ->
      es = require('estraverse')
      es.VisitorKeys.CoffeeEscapedExpression = []
      es.VisitorKeys.CoffeeListExpression = []
      es.VisitorKeys.CoffeePrototypeExpression = []
      es

  ###*
  # pushStack() : @pushStack(node)
  # Pushes a scope to the scope stack.
  ###

  pushStack: (node) ->
    [ oldScope, oldCtx ] = [ @scope, @ctx ]
    # TODO remove @parent = @scope
    @scopes.push [ node, @ctx ]
    @ctx = clone(@ctx)
    @scope = node
    @onScopeEnter?(@scope, @ctx, oldScope, oldCtx)

  popStack: (node) ->
    [ oldScope, oldCtx ] = [ @scope, @ctx ]
    [ @scope, @ctx ] = @scopes.pop()
    # TODO remove @parent = if @scopes.length > 1 then @scopes[@scopes.length-2]
    @onScopeExit?(@scope, @ctx, oldScope, oldCtx)
    node

  ###*
  # syntaxError():
  # Throws a syntax error for the given `node`.
  #
  #     @syntaxError node, "Not supported"
  ###

  syntaxError: (node, description) ->
    err = buildError(
      lineNumber: node.loc?.start?.line,
      column: node.loc?.start?.column,
      description: description
    , @options.source, @options.filename)
    throw err


# ----------------------------------------------------------------------------

###*
# Transformer:
# Mangles the AST.
###

class OtherTransformer extends TransformerBase
  Program: (node) ->
    @pushStack node

  ProgramExit: (node) ->
    @popStack node

  BlockStatementExit: (node) ->
    @removeEmptyStatementsFromBody node

  FunctionDeclaration: (node, parent) ->
    throw new Error("FnDecl: Not supposed to happen") # it's supposed to be eaten by fixScope

  FunctionExpression: (node, parent) ->
    throw new Error("NamedFnExpr: Not supposed to happen") if node.id # fixScope should've gotten this case
    @pushStack node.body
    @removeUndefinedParameter node

  FunctionExpressionExit: (node) ->
    @popStack()

  SwitchStatement: (node) ->
    @consolidateCases node

  SwitchCase: (node) ->
    @removeBreaksFromConsequents(node)

  CallExpression: (node) ->
    @parenthesizeCallee(node)

  MemberExpression: (node) ->
    @transformThisToAtSign(node)
    @replaceWithPrototype(node) or
    @parenthesizeObjectIfFunction(node)

  CoffeePrototypeExpression: (node) ->
    @transformThisToAtSign(node)

  Identifier: (node) ->
    @escapeUndefined(node)

  BinaryExpression: (node) ->
    @updateBinaryExpression node

  UnaryExpression: (node) ->
    @updateVoidToUndefined node

  LabeledStatement: (node, parent) ->
    @warnAboutLabeledStatements node, parent

  WithStatement: (node) ->
    @syntaxError node, "'with' is not supported in CoffeeScript"

  VariableDeclarator: (node) ->
    @addShadowingIfNeeded(node)
    @addExplicitUndefinedInitializer(node)

  ###
  # Remove `{type: 'EmptyStatement'}` from the body.
  # Since estraverse doesn't support removing nodes from the AST, some filters
  # replace nodes with 'EmptyStatement' nodes. This cleans that up.
  ###

  removeEmptyStatementsFromBody: (node) ->
    node.body = node.body.filter (n) ->
      n.type isnt 'EmptyStatement'
    node

  ###
  # Adds a `var x` shadowing statement when encountering shadowed variables.
  # (See specs/shadowing/var_shadowing)
  ###

  addShadowingIfNeeded: (node) ->
    name = node.id.name
    if ~@ctx.vars.indexOf(name)
      statement = @replace node,
        type: 'ExpressionStatement'
        expression:
          type: 'CoffeeEscapedExpression'
          value: "var #{name}"
      @scope.body = [ statement ].concat(@scope.body)
    else
      @ctx.vars.push name

  ###
  # Converts `this.x` into `@x` for MemberExpressions.
  ###

  transformThisToAtSign: (node) ->
    if node.object.type is 'ThisExpression'
      node._prefixed = true
      node.object._prefix = true
    node

  ###
  # For VariableDeclarator with no initializers (`var a`), add `undefined` as the initializer.
  ###

  addExplicitUndefinedInitializer: (node) ->
    unless node.init?
      node.init = { type: 'Identifier', name: 'undefined' }
      @skip()
    node

  ###
  # Replaces `a.prototype.b` with `a::b` in a member expression.
  ###

  replaceWithPrototype: (node) ->
    isPrototype = node.computed is false and
      node.object.type is 'MemberExpression' and
      node.object.property.type is 'Identifier' and
      node.object.property.name is 'prototype'
    if isPrototype
      @recurse @replace node,
        type: 'CoffeePrototypeExpression'
        object: node.object.object
        property: node.property

  ###
  # Produce warnings when using labels. It may be a JSON string being pasted,
  # so produce a more helpful warning for that case.
  ###

  warnAboutLabeledStatements: (node, parent) ->
    @syntaxError node, "Labeled statements are not supported in CoffeeScirpt"

  ###
  # Updates `void 0` UnaryExpressions to `undefined` Identifiers.
  ###

  updateVoidToUndefined: (node) ->
    if node.operator is 'void'
      @replace node, type: 'Identifier', name: 'undefined'
    else
      node

  ###
  # Turn 'undefined' into '`undefined`'. This uses a new node type, CoffeeEscapedExpression.
  ###

  escapeUndefined: (node) ->
    if node.name is 'undefined'
      @replace node, type: 'CoffeeEscapedExpression', value: 'undefined'
    else
      node

  ###
  # Updates binary expressions to their CoffeeScript equivalents.
  ###

  updateBinaryExpression: (node) ->
    dict =
      '===': '=='
      '!==': '!='
    op = node.operator
    if dict[op] then node.operator = dict[op]
    node

  ###
  # Removes `undefined` from function parameters.
  # (`function (a, undefined) {}` => `(a) ->`)
  ###

  removeUndefinedParameter: (node) ->
    if node.params
      for param, i in node.params
        isLast = i is node.params.length - 1
        isUndefined = param.type is 'Identifier' and param.name is 'undefined'

        if isUndefined
          if isLast
            node.params.pop()
          else
            @syntaxError node, "undefined is not allowed in function parameters"
    node

  ###
  # Consolidates empty cases into the next case. The case tests will then be
  # made into a new node type, CoffeeListExpression, to represent
  # comma-separated values. (`case x: case y: z()` => `case x, y: z()`)
  ###

  consolidateCases: (node) ->
    list = []
    toConsolidate = []
    for kase, i in node.cases
      # .type .test .consequent
      toConsolidate.push(kase.test) if kase.test
      if kase.consequent.length > 0
        if kase.test
          kase.test = { type: 'CoffeeListExpression', expressions: toConsolidate }
        toConsolidate = []
        list.push kase

    node.cases = list
    node

  ###
  # Parenthesize function expressions if they're in the left-hand side of a
  # member expression (eg, `(-> x).toString()`).
  ###

  parenthesizeObjectIfFunction: (node) ->
    if node.object.type is 'FunctionExpression'
      node.object._parenthesized = true
    node

  ###
  # Removes `break` statements from consequents in a switch case.
  # (eg, `case x: a(); break;` gets break; removed)
  ###

  removeBreaksFromConsequents: (node) ->
    if node.test
      idx = node.consequent.length-1
      last = node.consequent[idx]
      if last?.type is 'BreakStatement'
        delete node.consequent[idx]
        node.consequent.length -= 1
      else if last?.type isnt 'ReturnStatement'
        @syntaxError node, "No break or return statement found in a case"
      node

  ###
  # In an IIFE, ensure that the function expression is parenthesized (eg,
  # `(($)-> x) jQuery`).
  ###

  parenthesizeCallee: (node) ->
    if node.callee.type is 'FunctionExpression'
      node.callee._parenthesized = true
      node

  ###*
  # replace() : @replace(node, newNode)
  # Fabricates a replacement node for `node` that maintains the same source
  # location.
  #
  #     node = { type: "FunctionExpression", range: [0,1], loc: { ... } }
  #     @replace(node, { type: "Identifier", name: "xxx" })
  ###

  replace: (node, newNode) ->
    newNode.range = node.range
    newNode.loc = node.loc
    newNode

clone = (obj) ->
  JSON.parse JSON.stringify obj

# ----------------------------------------------------------------------------

###**
# FunctionTransformer:
# Yep
###

class FunctionTransformer extends TransformerBase
  onScopeEnter: (scope, ctx, oldScope, oldCtx) ->
    ctx.prebody = []

  onScopeExit: (scope, ctx, oldScope, oldCtx) ->
    if oldCtx.prebody.length
      scope.body = oldCtx.prebody.concat(scope.body)

  Program: (node) ->
    @pushStack node
    node

  ProgramExit: (node) ->
    @popStack()
    node

  FunctionDeclaration: (node) ->
    @ctx.prebody.push @buildFunctionDeclaration(node)
    @pushStack(node)
    return

  FunctionDeclarationExit: (node) ->
    @popStack(node)
    { type: 'EmptyStatement' }

  FunctionExpression: (node) ->
    return unless node.id?
    @ctx.prebody.push @buildFunctionDeclaration(node)
    @pushStack(node)
    return

  FunctionExpressionExit: (node) ->
    return unless node.id?
    @popStack(node)
    { type: 'Identifier', name: node.id.name }

  ###
  # Returns a `a = -> ...` statement out of a FunctionDeclaration node.
  ###

  buildFunctionDeclaration: (node) ->
    type: 'ExpressionStatement'
    expression:
      type: 'AssignmentExpression'
      operator: '='
      left: node.id
      right:
        type: 'FunctionExpression'
        params: node.params
        body: node.body

# ----------------------------------------------------------------------------

###
# Walker:
# Traverses a JavaScript AST.
#
#     class MyWalker extends Walker
#
#     w = new MyWalker(ast)
#     w.run()
#
###

class BuilderBase
  constructor: (@root, @options) ->
    @path = []

  run: ->
    @walk(@root)

  walk: (node, type) =>
    oldLength = @path.length
    @path.push(node)

    type = undefined if typeof type isnt 'string'
    type or= node.type
    @ctx = { path: @path, type: type, parent: @path[@path.length-2] }

    # check for a filter first
    filters = @filters?[type]
    if filters?
      node = filter(node) for filter in filters

    # check for the main visitor
    fn = this[type]
    if fn
      out = fn.call(this, node, @ctx)
      out = @decorator(node, out) if @decorator?
    else
      out = @onUnknownNode(node, @ctx)

    @path.splice(oldLength)
    out


###*
# Builder : new Builder(ast, [options])
# Generates output based on a JavaScript AST.
#
#     s = new Builder(ast, { filename: 'input.js', source: '...' })
#     s.get()
#     => { code: '...', map: { ... } }
#
# The params `options` and `source` are optional. The source code is used to
# generate meaningful errors.
###

class Builder extends BuilderBase

  constructor: (ast, options={}) ->
    super
    @_indent = 0

  ###*
  # indent():
  # Indentation utility with 3 different functions.
  #
  # - `@indent(-> ...)` - adds an indent level.
  # - `@indent([ ... ])` - adds indentation.
  # - `@indent()` - returns the current indent level as a string.
  #
  # When invoked with a function, the indentation level is increased by 1, and
  # the function is invoked. This is similar to escodegen's `withIndent`.
  #
  #     @indent =>
  #       [ '...' ]
  #
  # The past indent level is passed to the function as the first argument.
  #
  #     @indent (indent) =>
  #       [ indent, 'if', ... ]
  #
  # When invoked with an array, it will indent it.
  #
  #     @indent [ 'if...' ]
  #     #=> [ '  ', [ 'if...' ] ]
  #
  # When invoked without arguments, it returns the current indentation as a string.
  #
  #     @indent()
  ###

  indent: (fn) ->
    if typeof fn is "function"
      previous = @indent()
      @_indent += 1
      result = fn(previous)
      @_indent -= 1
      result
    else if fn
      [ @indent(), fn ]
    else
      Array(@_indent + 1).join("  ")

  ###*
  # get():
  # Returns the output of source-map.
  ###

  get: ->
    @run().toStringWithSourceMap()

  ###*
  # decorator():
  # Takes the output of each of the node visitors and turns them into
  # a `SourceNode`.
  ###

  decorator: (node, output) ->
    new SourceNode(
      node?.loc?.start?.line,
      node?.loc?.start?.column,
      @options.filename,
      output)

  ###*
  # onUnknownNode():
  # Invoked when the node is not known. Throw an error.
  ###

  onUnknownNode: (node, ctx) ->
    @syntaxError(node, "#{node.type} is not supported")

  syntaxError: TransformerBase::syntaxError

  ###
  # visitors:
  # The visitors of each node.
  ###

  Program: (node) ->
    @comments = node.comments
    @BlockStatement(node)

  ExpressionStatement: (node) ->
    newline @walk(node.expression)

  AssignmentExpression: (node) ->
    space [ @walk(node.left), node.operator, @walk(node.right) ]

  Identifier: (node) ->
    [ node.name ]

  UnaryExpression: (node) ->
    if (/^[a-z]+$/i).test(node.operator)
      [ node.operator, ' ', @walk(node.argument) ]
    else
      [ node.operator, @walk(node.argument) ]

  # Operator (+)
  BinaryExpression: (node) ->
    space [ @walk(node.left), node.operator, @walk(node.right) ]

  Literal: (node) ->
    [ node.raw ]

  MemberExpression: (node) ->
    right = if node.computed
      [ '[', @walk(node.property), ']' ]
    else if node._prefixed
      [ @walk(node.property) ]
    else
      [ '.', @walk(node.property) ]

    [ @walk(node.object), right ]

  LogicalExpression: (node) ->
    [ @walk(node.left), ' ', node.operator, ' ', @walk(node.right) ]

  ThisExpression: (node) ->
    if node._prefix
      [ "@" ]
    else
      [ "this" ]

  CallExpression: (node, ctx) ->
    callee = @walk(node.callee)
    list = @makeSequence(node.arguments)
    node._isStatement = ctx.parent.type is 'ExpressionStatement'

    hasArgs = list.length > 0

    if node._isStatement and hasArgs
      space [ callee, list ]
    else
      [ callee, '(', list, ')' ]

  IfStatement: (node) ->
    alt = node.alternate
    if alt?.type is 'IfStatement'
      els = @indent [ "else ", @walk(node.alternate, 'IfStatement') ]
    else if alt?.type is 'BlockStatement'
      els = @indent (i) => [ i, "else\n", @walk(node.alternate) ]
    else if alt?
      els = @indent (i) => [ i, "else\n", @indent(@walk(node.alternate)) ]
    else
      els = []

    @indent (i) =>
      test = @walk(node.test)
      consequent = @walk(node.consequent)
      if node.consequent.type isnt 'BlockStatement'
        consequent = @indent(consequent)

      [ 'if ', test, "\n", consequent, els ]

  BlockStatement: (node) ->
    @makeStatements(node, node.body)

  makeStatements: (node, body) ->
    body = injectComments(@comments, node, body)
    prependAll(body.map(@walk), @indent())

  # Line comments
  Line: (node) ->
    [ "#", node.value, "\n" ]

  # Block comments
  Block: (node) ->
    lines = node.value.split("\n")
    lines = lines.map (line, i) ->
      isTrailingSpace = i is lines.length-1 and line.match(/^\s*$/)
      isSingleLine = i is 0 and lines.length is 1

      if isTrailingSpace
        ''
      else if isSingleLine
        line
      else
        line = line.replace(/^ \*/, '#')
        line + "\n"
    [ "###", lines, "###\n" ]

  FunctionDeclaration: (node) ->
    params = @makeParams(node.params)

    @indent (indent) =>
      [ @walk(node.id), ' = ', params, "->\n", @walk(node.body) ]

  ReturnStatement: (node) ->
    if node.argument
      if node.argument.type is 'ObjectExpression'
        node.argument._braced = true

      space [
        "return",
        [ @walk(node.argument), "\n" ]
      ]
    else
      [ "return\n" ]

  parenthesizeObjectsInElements: (node) ->
    for item in node.elements
      if item.type is 'ObjectExpression'
        item._braced = true

  ArrayExpression: (node, ctx) ->
    @parenthesizeObjectsInElements(node)
    items = node.elements.length
    isSingleLine = items is 1

    if items is 0
      [ "[]" ]
    else if isSingleLine
      space [ "[", node.elements.map(@walk), "]" ]
    else
      @indent (indent) =>
        prefix = [ "\n", @indent() ]
        contents = prependAll(node.elements.map(@walk), prefix)
        [ "[", contents, "\n", indent, "]" ]

  ObjectExpression: (node, ctx) ->
    props = node.properties.length
    isBraced = node._braced or
      (props > 1 and
      ctx.parent.type is 'CallExpression' and
      ctx.parent._isStatement)

    # Empty
    if props is 0
      [ "{}" ]

    # Simple ({ a: 2 })
    else if props is 1
      props = node.properties.map(@walk)
      if isBraced
        space [ "{", props, "}" ]
      else
        [ props ]

    else
      props = @indent =>
        props = node.properties.map(@walk)
        prependAll(props, [ "\n", @indent() ])

      if isBraced
        [ "{", props, "\n", @indent(), "}" ]
      else
        [ props ]

  Property: (node) ->
    if node.kind isnt 'init'
      throw new Error("Property: not sure about kind " + node.kind)

    space [ [@walk(node.key), ":"], @walk(node.value) ]

  VariableDeclaration: (node) ->
    declarators = node.declarations.map(@walk)
    delimit(declarators, @indent())

  VariableDeclarator: (node) ->
    [ @walk(node.id), ' = ', @walk(node.init), "\n" ]

  FunctionExpression: (node, ctx) ->
    params = @makeParams(node.params)

    expr = @indent (i) =>
      [ params, "->\n", @walk(node.body) ]

    if node._parenthesized
      [ "(", expr, @indent(), ")" ]
    else
      expr

  EmptyStatement: (node) ->
    [ ]

  SequenceExpression: (node) ->
    exprs = node.expressions.map (expr) =>
      [ @walk(expr), "\n" ]

    delimit(exprs, @indent())

  NewExpression: (node) ->
    callee = if node.callee?.type is 'Identifier'
      [ @walk(node.callee) ]
    else
      [ '(', @walk(node.callee), ')' ]

    args = if node.arguments?.length
      [ '(', @makeSequence(node.arguments), ')' ]
    else
      []

    [ "new ", callee, args ]

  WhileStatement: (node) ->
    isLoop = not node.test? or
      (node.test?.type is 'Literal' and node.test?.value is true)

    looper = if isLoop
      [ "loop" ]
    else
      [ "while ", @walk(node.test) ]

    [ looper, "\n", @makeLoopBody(node.body) ]

  DoWhileStatement: (node) ->
    @indent =>
      breaker = @indent [ "break unless ", @walk(node.test), "\n" ]
      [ "loop", "\n", @walk(node.body), breaker ]

  BreakStatement: (node) ->
    [ "break\n" ]

  ContinueStatement: (node) ->
    [ "continue\n" ]

  DebuggerStatement: (node) ->
    [ "debugger\n" ]

  TryStatement: (node) ->
    # block, guardedHandlers, handlers [], finalizer
    _try = @indent => [ "try\n", @walk(node.block) ]
    _catch = prependAll(node.handlers.map(@walk), @indent())
    _finally = if node.finalizer?
      @indent (indent) => [ indent, "finally\n", @walk(node.finalizer) ]
    else
      []

    [ _try, _catch, _finally ]

  CatchClause: (node) ->
    @indent => [ "catch ", @walk(node.param), "\n", @walk(node.body) ]

  ThrowStatement: (node) ->
    [ "throw ", @walk(node.argument), "\n" ]

  # Ternary operator (`a ? b : c`)
  ConditionalExpression: (node) ->
    space [
      "if", @walk(node.test),
      "then", @walk(node.consequent),
      "else", @walk(node.alternate)
    ]

  # Increment (`a++`)
  UpdateExpression: (node) ->
    if node.prefix
      [ node.operator, @walk(node.argument) ]
    else
      [ @walk(node.argument), node.operator ]

  SwitchStatement: (node) ->
    body = @indent => @makeStatements(node, node.cases)
    item = @walk(node.discriminant)

    if node.discriminant.type is 'ConditionalExpression'
      item = [ "(", item, ")" ]

    [ "switch ", item, "\n", body ]

  # Custom node type for comma-separated expressions (`when a, b`)
  CoffeeListExpression: (node) ->
    @makeSequence(node.expressions)

  SwitchCase: (node) ->
    left = if node.test
      [ "when ", @walk(node.test) ]
    else
      [ "else" ]

    right = @indent => @makeStatements(node, node.consequent)

    [ left, "\n", right ]

  ForStatement: (node) ->
    # init, test, update, body
    @injectUpdateIntoBody(node)

    init = if node.init
      [ @walk(node.init), "\n", @indent() ]
    else
      []

    [ init, @WhileStatement(node) ]

  ForInStatement: (node) ->
    if node.left.type isnt 'VariableDeclaration'
      # @syntaxError node, "Using 'for..in' loops without 'var' can produce unexpected results"
      # node.left.name += '_'
      id = @walk(node.left)
      propagator = {
        type: 'ExpressionStatement'
        expression: { type: 'CoffeeEscapedExpression', value: "#{id} = #{id}" }
      }
      node.body.body = [ propagator ].concat(node.body.body)
    else
      id = @walk(node.left.declarations[0].id)

    body = @makeLoopBody(node.body)

    [ "for ", id, " of ", @walk(node.right), "\n", body ]

  makeLoopBody: (body) ->
    isBlock = body?.type is 'BlockStatement'
    if not body or (isBlock and body.body.length is 0)
      @indent => [ @indent(), "continue\n" ]
    else if isBlock
      @indent => @walk(body)
    else
      @indent => [ @indent(), @walk(body) ]

  CoffeeEscapedExpression: (node) ->
    [ '`', node.value, '`' ]

  CoffeePrototypeExpression: (node) ->
    if node.computed
      [ @walk(node.object), '::[', @walk(node.property), ']' ]
    else
      [ @walk(node.object), '::', @walk(node.property) ]

  ###*
  # makeSequence():
  # Builds a comma-separated sequence of nodes.
  ###

  makeSequence: (list) ->
    for arg, i in list
      isLast = i is (list.length-1)
      if not isLast
        if arg.type is "FunctionExpression"
          arg._parenthesized = true
        else if arg.type is "ObjectExpression"
          arg._braced = true

    commaDelimit(list.map(@walk))

  ###*
  # makeParams():
  # Builds parameters for a function list.
  ###

  makeParams: (params) ->
    if params.length
      [ '(', delimit(params.map(@walk), ', '), ') ']
    else
      []

  ###
  # In a call expression, ensure that non-last function arguments get
  # parenthesized (eg, `setTimeout (-> x), 500`).
  ###

  parenthesizeArguments: (node) ->
    for arg, i in node.arguments
      isLast = i is (node.arguments.length-1)
      if arg.type is "FunctionExpression"
        if not isLast
          arg._parenthesized = true

  ###
  # Injects a ForStatement's update (eg, `i++`) into the body.
  ###

  injectUpdateIntoBody: (node) ->
    if node.update
      statement =
        type: 'ExpressionStatement'
        expression: node.update

      # Ensure that the body is a BlockStatement with a body
      if not node.body?
        node.body ?= { type: 'BlockStatement', body: [] }
      else if node.body.type isnt 'BlockStatement'
        old = node.body
        node.body = { type: 'BlockStatement', body: [ old ] }

      node.body.body = node.body.body.concat([statement])
      delete node.update

###
# injectComments():
# Injects comment nodes into a node list.
###

injectComments = (comments, node, body) ->
  range = node.range
  return body unless range?

  list = []
  left = range[0]
  right = range[1]

  # look for comments in left..node.range[0]
  for item, i in body
    if item.range
      newComments = comments.filter (c) ->
        c.range[0] >= left and c.range[1] <= item.range[0]
      list = list.concat(newComments)

    list.push item

    if item.range
      left = item.range[1]
  list

# ----------------------------------------------------------------------------

###
# Export for testing
###

js2coffee.Builder = Builder
js2coffee.BuilderBase = BuilderBase

# ----------------------------------------------------------------------------

###
# Debugging provisions
###

js2coffee.debug = ->
  isDead = (ast) ->
    output = require('util').inspect(ast, depth: 1000)
    if ~output.indexOf("[Circular]")
      "[CIRCULAR]"
    else
      ""

  TransformerBase::onBeforeEnter = (node, depth, fn) ->
    console.log Array(depth+1).join("  "), node.type, (if fn then "*" else ""), isDead(@ast)

  TransformerBase::onBeforeExit = (node, depth, fn) ->
    console.log Array(depth+1).join("  "), ""+node.type+"Exit", (if fn then "*" else ""), isDead(@ast)

# js2coffee.debug()
