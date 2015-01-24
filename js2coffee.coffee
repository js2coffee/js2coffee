TransformerBase = require('./lib/transforms/base')
BuilderBase = require('./lib/builder/base')
Builder = require('./lib/builder')

{ buildError } = require('./lib/helpers')

###*
# # Js2coffee API
###

module.exports = js2coffee = (source, options) ->
  js2coffee.build(source, options).code

###*
# js2coffee() : js2coffee(source, [options])
# Compiles JavaScript into CoffeeScript.
#
#     output = js2coffee.build('a = 2', {});
#
#     output.code
#     output.ast
#     output.map
#     output.warnings
#
# All options are optional. Available options are:
#
# ~ filename (String): the filename, used in source maps and errors.
# ~ comments (Boolean): set to `false` to disable comments.
#
# How it works:
#
# 1. It uses Esprima to convert the input into a JavaScript AST.
# 2. It uses AST transformations (see [js2coffee.transform]) to mutate the AST
#    into a CoffeeScript AST.
# 3. It generates cofe (see [js2coffee.generate]) to compile the CoffeeScript
#    AST into CoffeeScript code.
###

js2coffee.build = (source, options = {}) ->
  options.filename ?= 'input.js'
  options.source = source

  ast = js2coffee.parseJS(source, options)
  {ast, warnings} = js2coffee.transform(ast, options)
  {code, map} = js2coffee.generate(ast, options)
  {code, ast, map, warnings}

###*
# parseJS() : js2coffee.parseJS(source, [options])
# Parses JavaScript code into an AST via Esprima.
#
#     try
#       ast = js2coffee.parseJS('var a = 2;')
#     catch err
#       ...
###

js2coffee.parseJS = (source, options = {}) ->
  try
    Esprima = require('esprima-harmony')
    Esprima.parse(source, loc: true, range: true, comment: true)
  catch err
    throw buildError(err, source, options.filename)

###*
# transform() : js2coffee.transform(ast, [options])
# Mutates a given JavaScript syntax tree `ast` into a CoffeeScript AST.
#
#     ast = js2coffee.parseJS('var a = 2;')
#     result = js2coffee.transform(ast)
#     result.ast
#
# This performs a few traversals across the tree using traversal classes
# (TransformerBase subclasses).
###

js2coffee.transform = (ast, options = {}) ->
  ctx = {}

  # Note that these transformations will need to be done in a few steps.
  # The earlier steps (function, comment, etc) will make drastic modifications
  # to the tree that the other transformations will need to pick up.
  run = (classes) ->
    TransformerBase.run(ast, options, classes, ctx)

  # Injects comments into the AST as BlockComment and LineComment nodes.
  unless options.comments is false
    run [ require('./lib/transforms/comments') ]

  # Moves named functions to the top of the scope.
  run [ require('./lib/transforms/functions') ]

  # Everything else -- these can be done in one step without any side effects.
  run [
    require('./lib/transforms/ifs')
    require('./lib/transforms/literals')
    require('./lib/transforms/loops')
    require('./lib/transforms/members')
    require('./lib/transforms/objects')
    require('./lib/transforms/others')
    require('./lib/transforms/precedence')
    require('./lib/transforms/returns')
    require('./lib/transforms/switches')
  ]
  run [
    require('./lib/transforms/blocks')
  ]

  { ast, warnings: ctx.warnings }

###*
# generate() : js2coffee.generate(ast, [options])
# Generates CoffeeScript code from a given CoffeeScript AST. Returns an object
# with `code` (CoffeeScript source code) and `map` (source mapping object).
#
#     ast = js2coffee.parse('var a = 2;')
#     ast = js2coffee.transform(ast)
#     {code, map} = generate(ast)
###

js2coffee.generate = (ast, options = {}) ->
  new Builder(ast, options).get()

###*
# version : js2coffee.version
# The version number
###

js2coffee.version = require('./package.json').version
