{before} = require 'node:test'
assert = require 'node:assert/strict'

before ->
  global.js2coffee = require('../index')

  global.expect = (actual) ->
    self =
      actual: actual

      be:
        an: (type) ->
          actualType = if Array.isArray(actual) then 'array' else typeof actual
          assert.equal actualType, type, "Expected #{actual} to be an #{type}"
        a: (type) ->
          actualType = if Array.isArray(actual) then 'array' else typeof actual
          assert.equal actualType, type, "Expected #{actual} to be a #{type}"

      eql: (expected) ->
        actualPlain   = JSON.parse(JSON.stringify(actual))
        expectedPlain = JSON.parse(JSON.stringify(expected))

        assert.deepEqual actualPlain, expectedPlain

      eq: (expected) ->
        assert.equal actual, expected

      equals: (expected) ->
        assert.equal actual, expected

      include: (expected) ->
        assert.ok actual.includes(expected), "Expected '#{actual}' to include '#{expected}'"

      match: (regex) ->
        assert.match actual, regex

      have:
        length: (expected) ->
          assert.equal actual.length, expected, "Expected length #{expected}, got #{actual.length}"

      throw: (expected) ->
        threw = false
        thrownError = null
        try
          actual()
        catch err
          threw = true
          thrownError = err
          if expected
            if typeof expected == 'string'
              assert.ok err.message.includes(expected), "Expected error message to include '#{expected}', got: #{err.message}"
            else if expected instanceof RegExp
              assert.match err.message, expected

        assert.ok threw, "Expected function to throw"

      to:
        throw: (expected) ->
          self.throw(expected)

    Object.defineProperty self, 'exist',
      get: -> assert.ok actual?, "Expected #{actual} to exist"

    self
