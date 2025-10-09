require 'coffeescript/register'
require './setup'

describe.skip 'dist bundle (browser - future work)', ->
  distJs2coffee = require('../dist/js2coffee')

  describe 'ES.Next support via Babel', ->

    it 'transforms arrow functions', ->
      input = 'const fn = (x) => x * 2;'
      result = distJs2coffee.build(input)
      expect(result.code).include 'fn = '
      expect(result.code).include '->'

    it 'transforms template literals', ->
      input = 'const msg = `Hello ${name}`;'
      result = distJs2coffee.build(input)
      expect(result.code).include 'msg = '

    it 'transforms const/let to var', ->
      input = 'const x = 1; let y = 2;'
      result = distJs2coffee.build(input)
      expect(result.code).include 'x = 1'
      expect(result.code).include 'y = 2'

    it 'transforms optional chaining', ->
      input = 'const value = obj?.prop;'
      result = distJs2coffee.build(input)
      expect(result.code).include 'value = '

    it 'transforms nullish coalescing', ->
      input = 'const value = input ?? defaultValue;'
      result = distJs2coffee.build(input)
      expect(result.code).include 'value = '
