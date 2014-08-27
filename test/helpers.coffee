require './setup'

describe 'Helpers', ->
  {zipJoin} = require('../lib/helpers')

  it 'zipJoin', ->
    result = zipJoin(['a', 'b'], '-')
    expect(result).eql ['a', '-', 'b']
