require 'coffee-script/register'
require './setup'

describe 'build()', ->
  it 'works', ->
    out = js2coffee.build("// hi\na=2")
    expect(out.ast).be.an('object')
    expect(out.map).be.an('object')
    expect(out.code).be.a('string')

  it 'indents nested blocks correctly', ->
    out = js2coffee """
while (true) {
  {
    {
      var a = 0;
      var b = 1;
    }
  }
}
"""
    expected = """
loop
  a = 0
  b = 1

"""
    expect(out).equals(expected)

