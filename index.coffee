esprima = require('esprima')
SourceNode = require("source-map").SourceNode
Walker = require('./lib/walker')

###*
# js2coffee() : js2coffee(source, [options])
# Converts to code.
#
#     output = js2coffee.parse('alert("hi")');
#     output;
#     => 'alert "hi"'
###

module.exports = js2coffee = (source, options) ->
  js2coffee.parse(source, options).code

###*
# parse() : js2coffee.parse(source, [options])
# Parses.
#
#     output = js2coffee.parse('a = 2', {});
#
#     output.code
#     output.ast
#     output.map
###

js2coffee.parse = (source, options = {}) ->
  ast = esprima.parse(source, loc: true, range: true, comment: true)

  xformer = new Transformer(ast, options)
  newAst = xformer.run()

  builder = new Stringifier(newAst, options)
  {code, map} = builder.get()

  {code, ast, map}

###
# Stringifier : new Stringifier(ast, [options])
# (private) Generates output based on a JavaScript AST.
#
#     s = new Stringifier(ast, {})
#     s.get()
#     => { code: '...', map: { ... } }
###

class Stringifier extends Walker

  indent: (n=1) ->
    "  "

  ###*
  # get():
  # Returns the output of source-map.
  ###

  get: ->
    @run().toStringWithSourceMap()

  ###
  # decorator():
  # (private) takes the output of each of the node visitors and turns them into
  # a SourceNode.
  ###

  decorator: (node, output) ->
    new SourceNode(
      node.loc.start.line,
      node.loc.start.column,
      'input.js',
      output)

  # Zip helper
  zipJoin: (list, joiner) ->
    newlist = []
    for item, i in list
      newlist.push(joiner) if i > 0
      newlist.push(item)
    newlist

  nodes:
    Program: (node) ->
      node.body.map(@walk)

    ExpressionStatement: (node) ->
      [ @walk(node.expression), "\n" ]

    AssignmentExpression: (node) ->
      [ @walk(node.left), ' = ', @walk(node.right) ]

    Identifier: (node) ->
      [ node.name ]

    # Operator (+)
    BinaryExpression: (node) ->
      [ @walk(node.left), ' ', node.operator, ' ', @walk(node.right) ]

    Literal: (node) ->
      [ node.raw ]

    MemberExpression: (node) ->
      [ @walk(node.object), '.', @walk(node.property) ]

    CallExpression: (node) ->
      list = []
      callee = @walk(node.callee)
      list = @zipJoin(node.arguments.map(@walk), ', ')
        
      [ callee, '(', list, ')' ]

    IfStatement: (node) ->
      [
        'if ',
        @walk(node.test),
        "\n",
        @indent(),
        @walk(node.consequent)
      ]

    BlockStatement: (node) ->
      list = @zipJoin(node.body.map(@walk), @indent())

    FunctionDeclaration: (node) ->
      params =
        if node.params.length
          [ '(', @zipJoin(node.params.map(@walk), ', '), ') ']
        else
          []

      [ @walk(node.id), ' = ', params, "->\n", @indent(), @walk(node.body) ]

    ReturnStatement: (node) ->
      [
        "return ",
        @walk(node.argument),
        "\n"
      ]

    # Default, when nothing else can do
    Default: (node) ->
      console.error node
      throw new Error("walk(): No handler for #{node?.type}")

###
# Performs transformations on the AST.
#
#     ast = esprima.parse(...);
#     new Transformer(ast, {}).run();
#     ast; //= this is changed now
###

class Transformer
  constructor: (@ast, @options = {}) ->
  run: -> @ast
