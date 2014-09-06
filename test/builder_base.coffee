require 'coffee-script/register'
require './setup'

describe 'BuilderBase', ->
  {BuilderBase} = require('../js2coffee')

  it 'works', ->
    ast =
      type: 'Program'
      body: { type: 'Identifier', value: 'hi' }

    class MyWalker extends BuilderBase
      Program: (node) -> @walk node.body
      Identifier: (node) -> node.value

    output = new MyWalker(ast).run()
    expect(output).eql 'hi'
