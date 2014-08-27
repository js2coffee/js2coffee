xdescribe 'parse()', ->
  it 'works', ->
    out = js2coffee.parse("// hi\na=2")
    expect(out.ast).be.an('object')
    expect(out.map).be.an('object')
    expect(out.code).be.a('string')
    # console.log(require('util').inspect(out, { depth: 1000 }))
