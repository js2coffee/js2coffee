require 'coffee-script/register'
require './setup'

describe 'Helpers', ->
  {delimit} = require('../lib/helpers')

  it 'delimit', ->
    result = delimit(['a', 'b'], '-')
    expect(result).eql ['a', '-', 'b']
