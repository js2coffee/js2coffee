{
  buildError
  clone
} = require('./helpers')

extend = require('util')._extend

###**
# TransformerBase:
# Base class of all transformation steps, such as [FunctionTransforms] and
# [OtherTransforms]. This is a thin wrapper around *estraverse* to make things
# easier, as well as to add extra features like scope tracking and more.
#
#     class MyTransform extends TransformerBase
#       Program: (node) ->
#         return { replacementNodeHere }
#
#       FunctionDeclaration: (node) ->
#         ...
#
#     TransformerBase.run ast, options, [ MyTransform ]
#
# From within the handlers, you can call some utility functions:
#
#     @skip()
#     @break()
#     @syntaxError(node, "'with' is not supported")
#
# You have access to these variables:
#
# ~ @depth: The depth of the current node
# ~ @node: The current node.
# ~ @controller: The estraverse instance
#
# It also keeps track of scope. For every function body (eg:
# FunctionExpression.body) it traverses to, you get a `@ctx` variable that is
# only available from *within that scope* and the scopes below it.
#
# ~ @scope: the Node that is the current scope. This is usually a BlockStatement
#   or a Program.
# ~ @ctx: Context variables for the scope. You can store anything here and it
#   will be remembered for the current scope and the scopes below it.
#
# It also has a few hooks that you can override:
#
# ~ onScopeEnter: when scopes are entered (via `pushScope()`)
# ~ onScopeExit: when scopes are exited (via `popScope()`)
# ~ onEnter: enter of a node
# ~ onExit: exit of a node
# ~ onBeforeEnter: before the enter of a node
# ~ onBeforeExit: before the exit of a node
###

class TransformerBase
  @run: (ast, options, classes) ->
    Xformer = class extends TransformerBase
    
    classes.forEach (klass) ->
      extend(Xformer.prototype, klass.prototype)

    new Xformer(ast, options).run()

  constructor: (@ast, @options) ->
    @scopes = []
    @ctx = { vars: [] }

  ###*
  # run():
  # Runs estraverse on `@ast`, and invokes functions on enter and exit
  # depending on the node type. This is also in change of changing `@depth`,
  # `@node`, `@controller` (etc) every step of the way.
  #
  #     Transformer.run(ast)
  #     # roughly equivalent to: new Transformer(ast).run()
  ###

  run: ->
    @recurse @ast

  ###*
  # recurse():
  # Delegate function of `run()`. See [run()] for details.
  #
  # This is sometimes called on its own to recurse down a certain path which
  # will otherwise be skipped.
  ###

  recurse: (root) ->
    self = this
    @depth = 0

    runner = (direction, node, parent) =>
      @node   = node
      @depth += if direction is 'Enter' then +1 else -1
      fnName  = if direction is 'Enter' \
        then "#{node.type}" else "#{node.type}Exit"

      @["onBefore#{direction}"]?(node)
      result = @[fnName]?(node, parent)
      @["on#{direction}"]?(node)
      result

    @estraverse().replace root,
      enter: (node, parent) ->
        self.controller = this
        runner("Enter", node, parent)
      leave: (node, parent) ->
        runner("Exit", node, parent)

    root

  ###*
  # skip():
  # Skips a certain node from being parsed.
  #
  #     class MyTransform extends TransformerBase
  #       Identifier: ->
  #         @skip()
  ###

  skip: ->
    @controller?.skip()

  ###*
  # estraverse():
  # Returns `estraverse`.
  #
  #     @estraverse().replace ast, ...
  ###

  estraverse: ->
    @_estraverse ?= do ->
      es = require('estraverse')
      es.VisitorKeys.CoffeeEscapedExpression = []
      es.VisitorKeys.CoffeeListExpression = []
      es.VisitorKeys.CoffeePrototypeExpression = []
      es.VisitorKeys.CoffeeLoopStatement = []
      es.VisitorKeys.BlockComment = []
      es.VisitorKeys.LineComment = []
      es

  ###*
  # pushStack() : @pushStack(node)
  # Pushes a scope to the scope stack. Every time the scope changes, `@scope`
  # and `@ctx` gets changed.
  ###

  pushStack: (node) ->
    [ oldScope, oldCtx ] = [ @scope, @ctx ]
    @scopes.push [ node, @ctx ]
    @ctx = clone(@ctx)
    @scope = node
    @onScopeEnter?(@scope, @ctx, oldScope, oldCtx)

  popStack: () ->
    [ oldScope, oldCtx ] = [ @scope, @ctx ]
    [ @scope, @ctx ] = @scopes.pop()
    @onScopeExit?(@scope, @ctx, oldScope, oldCtx)

  ###*
  # syntaxError() : @syntaxError(node, message)
  # Throws a syntax error for the given `node` with a given `message`.
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

  ###*
  # Defaults: these are default handlers that will automatially change `@scope`.
  ###

  Program: (node) ->
    @pushStack node
    node

  ProgramExit: (node) ->
    @popStack()
    node

  FunctionExpression: (node) ->
    @pushStack node.body
    node

  FunctionExpressionExit: (node) ->
    @popStack()
    node

module.exports = TransformerBase
