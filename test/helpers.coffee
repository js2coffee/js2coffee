require 'coffee-script/register'
require './setup'

describe 'Helpers', ->
  {delimit, quote} = require('../lib/helpers')

  it 'delimit', ->
    result = delimit(['a', 'b'], '-')
    expect(result).eql ['a', '-', 'b']

    
  describe 'quote', ->
    test = (left, result) ->
      it left, ->
        expect(quote(left)).eql(result)

    test "hello", "'hello'"
    test "hello 'world'", "'hello \\'world\\''"
    test "\"hello\" 'world'", "'\"hello\" \\'world\\''"
