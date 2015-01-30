require 'coffee-script/register'
require './setup'

describe 'BuilderBase', ->
  ast = undefined
  output = undefined
  BuilderBase = require('../lib/builder/base')

  beforeEach ->
    ast =
      type: 'Program'
      body: { type: 'Identifier', value: 'hi' }

    class MyWalker extends BuilderBase
      Program: (node) -> @walk node.body
      Identifier: (node) -> node.value

    output = new MyWalker(ast).run()

  it 'works', ->
    expect(output.toString()).eql 'hi'

  it 'spits out a SourceNode', ->
    expect(output.children).be.array
