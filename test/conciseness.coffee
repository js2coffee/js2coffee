{ describe, it } = require 'node:test'
require './setup'

js2coffee = require '../'

describe 'Conciseness', ->

  checkShorter = (input, description) ->
    it description, ->
      result = js2coffee.build(input)
      output = result.code.trim()
      inputChars = input.trim().length
      outputChars = output.length

      expect(outputChars).toBeLessThan(inputChars)

  describe 'Function declarations', ->

    checkShorter '''
      function add(a, b) {
        return a + b;
      }
    ''', 'simple function with return'

    checkShorter '''
      function greet(name) {
        return "Hello, " + name;
      }
    ''', 'function with string concatenation'

    checkShorter '''
      var multiply = function(x, y) {
        return x * y;
      };
    ''', 'function expression'

  describe 'Control flow', ->

    checkShorter '''
      if (x > 5) {
        console.log('big');
      }
    ''', 'simple if statement'

    checkShorter '''
      if (x > 5) {
        console.log('big');
      } else {
        console.log('small');
      }
    ''', 'if-else statement'

    checkShorter '''
      for (var i = 0; i < 10; i++) {
        console.log(i);
      }
    ''', 'for loop'

    checkShorter '''
      while (x < 100) {
        x = x * 2;
      }
    ''', 'while loop'

  describe 'Objects and arrays', ->

    checkShorter '''
      var obj = {
        name: 'test',
        value: 42
      };
    ''', 'object literal'

    checkShorter '''
      var arr = [1, 2, 3, 4, 5];
    ''', 'array literal'

    checkShorter '''
      var person = {
        firstName: 'John',
        lastName: 'Doe',
        age: 30
      };
    ''', 'multi-property object'

  describe 'Method calls', ->

    checkShorter '''
      array.map(function(item) {
        return item * 2;
      });
    ''', 'array map with function'

    checkShorter '''
      array.filter(function(item) {
        return item > 5;
      });
    ''', 'array filter with function'

    checkShorter '''
      console.log('Hello, World!');
    ''', 'simple method call'

  describe 'Variable declarations', ->

    checkShorter '''
      var x = 10;
      var y = 20;
      var z = 30;
    ''', 'multiple var declarations'

    checkShorter '''
      var result = x + y;
    ''', 'var with expression'

  describe 'Operators', ->

    checkShorter '''
      var result = (a && b) || c;
    ''', 'logical operators'

    checkShorter '''
      var check = x !== undefined;
    ''', 'comparison operator'
