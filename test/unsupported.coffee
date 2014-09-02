require './setup'

describe 'Unsupported', ->
  describe 'thowing unsupported errors', ->
    it 'happens for with()', ->
      try
        js2coffee.build('with(x){}')
      catch e
        expect(e.description).include 'is not supported'
        expect(e.lineNumber).eql 1
        expect(e.column).eql 0

    it 'happens with labelled statements', ->
      try
        js2coffee.build('a:\nhi')
      catch e
        expect(e.description).include 'Labeled statements are not supported'
        expect(e.lineNumber).eql 1
        expect(e.column).eql 0

    it 'happens with naked JSON objects', ->
      try
        js2coffee.build('{a:2}')
      catch e
        expect(e.description).include 'wrap your JSON'
        expect(e.lineNumber).eql 1
        expect(e.column).eql 1
