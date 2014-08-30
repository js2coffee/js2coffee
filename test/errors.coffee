require './setup'

describe 'Errors', ->
  err = null

  beforeEach ->
    try
      js2coffee('a\nb\nc\nd\nx())\ne\nf')
    catch e
      err = e

  it 'throws them properly', ->
    expect(err.message).include ':5:4: Unexpected token )'

describe 'Error cases', ->
  it 'happens on "with" statements', ->
    try
      js2coffee('with (x) { b(); }')
    catch err
      expect(err.description).match /'with' is not supported in CoffeeScript/

  it 'happens on break-less cases', ->
    try
      js2coffee('switch (x) { case "a": b(); case "b": c(); }')
    catch err
      expect(err.description).match /No break or return statement found in a case/
