require './setup'
coffee = require 'coffee-script'
vm = require 'vm'

describe 'Addition grouping', ->
  cases = [
    '"text" + (1 + 2)'
    '"Chapter " + (5 + 1)'
    '"text" + (5 - 1)'
    '1 + (2 + "3")'
    '1e16 + (-1e16 + 1)'
    '"text" + (1 + (2 + 3))'
    '("text" + 1) + 2'
    '"text" + 1 * 2'
  ]

  for expression in cases
    do (expression) ->
      it "preserves the value of #{expression}", ->
        source = "result = #{expression};"
        original = {}
        converted = {}
        vm.runInNewContext source, original
        output = coffee.compile(js2coffee.build(source).code, bare: true)
        vm.runInNewContext output, converted
        expect(converted.result).eql(original.result)

  it 'preserves the order of primitive conversions', ->
    source = '''
      var calls = [];
      function value(name, n) {
        return { valueOf: function () { calls.push(name); return n; } };
      }
      result = value("a", "text") + (value("b", 1) + value("c", 2));
      order = calls.join(",");
    '''
    original = {}
    converted = {}
    vm.runInNewContext source, original
    output = coffee.compile(js2coffee.build(source).code, bare: true)
    vm.runInNewContext output, converted
    expect(converted.result).eq(original.result)
    expect(converted.order).eq(original.order)
