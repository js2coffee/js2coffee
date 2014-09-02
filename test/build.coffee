require 'coffee-script/register'
require './setup'

describe 'build()', ->
  it 'works', ->
    out = js2coffee.build("// hi\na=2")
    expect(out.ast).be.an('object')
    expect(out.map).be.an('object')
    expect(out.code).be.a('string')
