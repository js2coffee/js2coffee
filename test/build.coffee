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

  it 'inserts var statements into correct scope', ->
    out = js2coffee """
var a = 0;
var foo = function () {
  var b = function () {
    return 0;
  };
  var a = 1;
};
"""

    expected = """
a = 0

foo = ->
  `var a`

  b = ->
    0

  a = 1
  return

"""

  it "doesn't drop loop init statements immediately after variable shadowing", ->
    out = js2coffee("""
var a, b = 0;
(function () {
  var a;
  for (b = 1;;) {
  }
})();
""")
    expected = """a = undefined
b = 0
do ->
  `var a`
  a = undefined
  b = 1
  loop
    continue
  return

"""
    expect(out).equals(expected)

  it "outputs correct unicode escape sequences", ->
    out = js2coffee("\"\\u0010\"\n")
    expected = "\'\\u0010\'\n"
    expect(out).equals(expected)
