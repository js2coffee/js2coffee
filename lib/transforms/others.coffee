{ reservedWords, replace, quote } = require('../helpers')
TransformerBase = require('./base')

###
# Mangles the AST with various CoffeeScript tweaks.
###

module.exports = class extends TransformerBase

  FunctionExpression: (node, parent) ->
    super(node)
    node.params.forEach (param) =>
      @ctx.vars.push param.name if param.type is 'Identifier'
      @preventReservedWords(param)
    @preventReservedWords(node.id)
    @removeUndefinedParameter(node)

  CallExpression: (node) ->
    @parenthesizeCallee(node)

  Identifier: (node) ->
    @escapeUndefined(node)

  UnaryExpression: (node) ->
    @braceObjectBesideUnary(node)
    @updateVoidToUndefined(node)

  VariableDeclarator: (node) ->
    @preventReservedWords(node.id)
    @addShadowingIfNeeded(node)
    @addExplicitUndefinedInitializer(node)

  AssignmentExpression: (node) ->
    if @isReservedIdentifier(node.left)
      if @options.compat
        @escapeJs node
      else
        @preventReservedWords(node.left)

    else if node.left.type is 'Identifier' and @ctx.vars.indexOf(node.left.name) is -1
        if @options.compat
          @escapeJs node
        else
          @warn node, "Assignment of global variable '#{node.left.name}'"
          node

    else
      node

  ReturnStatement: (node) ->
    @parenthesizeObjectsInArgument(node)

  braceObjectBesideUnary: (node) ->
    if node.argument.type is 'ObjectExpression'
      node.argument._braced = true
    return

  ###
  # Catch usage of reserved words (eg, `off = 2`)
  ###

  preventReservedWords: (node) ->
    if @isReservedIdentifier(node)
      @syntaxError node, "'#{node.name}' is a reserved CoffeeScript keyword"

  isReservedIdentifier: (node) ->
    name = node?.name
    return name and ~reservedWords.indexOf(name)

  ###
  # Ensures that a ReturnStatement with an object ('return {a:1}') has a braced
  # expression.
  ###

  parenthesizeObjectsInArgument: (node) ->
    if node.argument
      if node.argument.type is 'ObjectExpression'
        node.argument._braced = true
    node

  ###
  # Adds a `var x` shadowing statement when encountering shadowed variables.
  # (See specs/shadowing/var_shadowing)
  ###

  addShadowingIfNeeded: (node) ->
    name = node.id.name
    if ~@ctx.vars.indexOf(name)
      @warn node, "Variable shadowing ('#{name}') is not fully supported in CoffeeScript"
      statement = replace node,
        type: 'ExpressionStatement'
        expression:
          type: 'CoffeeEscapedExpression'
          raw: "var #{name}"
      @scope.body = [ statement ].concat(@scope.body)
    else
      @ctx.vars.push name

  ###
  # For VariableDeclarator with no initializers (`var a`), add `undefined` as
  # the initializer.
  ###

  addExplicitUndefinedInitializer: (node) ->
    unless node.init?
      node.init = { type: 'Identifier', name: 'undefined' }
      @skip()
    node


  ###
  # Updates `void 0` UnaryExpressions to `undefined` Identifiers.
  ###

  updateVoidToUndefined: (node) ->
    if node.operator is 'void'
      replace node, type: 'Identifier', name: 'undefined'
    else
      node

  ###
  # Turn 'undefined' into '`undefined`'. This uses a new node type,
  # CoffeeEscapedExpression.
  ###

  escapeUndefined: (node) ->
    if node.name is 'undefined' and @options.compat
      replace node, type: 'CoffeeEscapedExpression', raw: 'undefined'
    else
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
            @syntaxError param,
              "'undefined' is not allowed in function parameters"
    node

  ###
  # In an IIFE, ensure that the function expression is parenthesized (eg,
  # `(($)-> x) jQuery`).
  ###

  parenthesizeCallee: (node) ->
    if node.callee.type is 'FunctionExpression'
      node.callee._parenthesized = true
      node
