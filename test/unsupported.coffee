require './setup'

describe 'Unsupported', ->
  it 'throws unsupported errors for with', ->
    try
      js2coffee.parse('with(x){}')
    catch e
      expect(e.description).include 'is not supported'
      expect(e.lineNumber).eql 1
      expect(e.column).eql 0
