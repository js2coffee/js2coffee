require './setup'

describe 'Unsupported', ->
  describe 'thowing unsupported errors', ->
    it 'happens for with()', ->
      try
        js2coffee.build('with(x){}')
      catch e
        expect(e.description).include 'is not supported'
        expect(e.start.line).eql 1
        expect(e.start.column).eql 0

    it 'happens with labelled statements', ->
      try
        js2coffee.build('a:\nhi')
      catch e
        expect(e.description).include 'Labeled statements are not supported'
        expect(e.start.line).eql 1
        expect(e.start.column).eql 0
