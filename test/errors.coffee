require './setup'

describe 'Errors', ->
  err = null

  beforeEach ->
    try
      js2coffee('a\nb\nc\nd\nx())\ne\nf')
    catch e
      err = e

  it 'throws them properly', ->
    expect(err.message).include ':5:3: Unexpected token )'

  it 'has context lines', ->
    expect(err.message).include '3  c'
    expect(err.message).include '4  d'

  it 'has error lines with highlight', ->
    expect(err.message).include """
      5  x())
            ^"""

  it 'has start line/column', ->
    expect(err.start.line).eql 5
    expect(err.start.column).eql 3
