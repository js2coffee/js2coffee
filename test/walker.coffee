require './setup'

describe 'Walker', ->
  Walker = require('../lib/walker')

  it 'works', ->
    ast =
      type: 'Program'
      body:
        type: 'Identifier'
        value: 'hi'

    class MyWalker extends Walker
      visitors:
        Program: (node) ->
          @walk node.body

        Identifier: (node) ->
          node.value

    output = new MyWalker(ast).run()
    expect(output).eql 'hi'
