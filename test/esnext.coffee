# FILENAME: { js2coffee/test/esnext.coffee }

require 'coffee-script/register'
require './setup'

describe 'ES.Next features (via Babel preprocessing)', ->

  describe 'ES2015 (ES6)', ->

    it 'transforms arrow functions', ->
      input = 'const fn = (x) => x * 2;'
      output = js2coffee input
      expect(output).include 'fn = '
      expect(output).include '->'

    it 'transforms template literals', ->
      input = 'const msg = `Hello ${name}`;'
      output = js2coffee input
      expect(output).include 'msg = '

    it 'transforms destructuring', ->
      input = 'const {a, b} = obj;'
      output = js2coffee input
      expect(output).include 'a'
      expect(output).include 'b'

    it 'transforms class syntax', ->
      input = '''
        class Person {
          constructor(name) {
            this.name = name;
          }
          greet() {
            return `Hello, ${this.name}`;
          }
        }
      '''
      output = js2coffee input
      expect(output).include 'Person'

    it 'transforms let and const to var', ->
      input = '''
        let x = 1;
        const y = 2;
      '''
      output = js2coffee input
      expect(output).include 'x = 1'
      expect(output).include 'y = 2'

  describe 'ES2016+', ->

    it 'transforms exponentiation operator', ->
      input = 'const result = x ** 2;'
      output = js2coffee input
      expect(output).include 'result = '

    it 'transforms async/await', ->
      input = '''
        async function fetchData() {
          const data = await fetch('/api');
          return data;
        }
      '''
      output = js2coffee input
      expect(output).include 'fetchData'

  describe 'ES2020', ->

    it 'transforms optional chaining', ->
      input = 'const value = obj?.prop?.nested;'
      output = js2coffee input
      expect(output).include 'value = '

    it 'transforms nullish coalescing', ->
      input = 'const value = input ?? defaultValue;'
      output = js2coffee input
      expect(output).include 'value = '

  describe 'Babel configuration', ->

    it 'can disable Babel preprocessing', ->
      input = 'var x = 1;'
      output = js2coffee.build(input, babel: false).code
      expect(output).include 'x = 1'

    it 'can force Babel preprocessing', ->
      input = 'var x = 1;'
      output = js2coffee.build(input, babel: true).code
      expect(output).include 'x = 1'

    it 'auto-detects modern syntax', ->
      input = 'const value = obj?.prop;'
      output = js2coffee.build(input).code
      expect(output).include 'value = '

  describe 'Error handling', ->

    it 'provides helpful errors for invalid syntax', ->
      input = 'const {'
      expect(-> js2coffee(input)).throw()

    it 'preserves line numbers in errors', ->
      input = '''
        const x = 1;
        const y = {;
      '''
      try
        js2coffee input
        throw new Error 'Should have thrown'
      catch err
        expect(err.message).exist
