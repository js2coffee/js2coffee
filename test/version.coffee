require('./setup')

describe 'Version', ->
  it 'should exist', ->
    version = require('../package.json').version
    expect(js2coffee.version).eql version

  it 'should be semver-like', ->
    expect(js2coffee.version).match /^\d+\.\d+\.\d+/
