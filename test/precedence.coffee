require './setup'

describe 'Precedence', ->
  {getPrecedence} = require '../lib/helpers'

  test = (js, level) ->
    it "[#{level}] #{js}", ->
      node = require('esprima-fb').parse(js).body[0].expression
      result = getPrecedence(node)
      if result isnt level
        console.log node
      expect(result).eq(level)

  test 'a * 2', 14
  test 'a + 2', 13
  test 'a << 2', 12
  test 'a >= b', 11
  test 'a instanceof b', 11
  test 'a != b', 10
  test 'a & b', 9
  test 'a ^ b', 8
  test 'a | b', 7
  test 'a && b', 6
  test 'a || b', 5
  test 'void 0', 15
  test '++a', 15
  test '--a', 15
  test 'a++', 16
  test 'a--', 16
  test 'a.b', 18
  # test 'a', 99
  # test '2', 99
