var expect = require('chai').expect;
var path = require('path');
var glob = require('glob');
var fs = require('fs');
var specs = glob.sync(__dirname + '/../spec/*');
var js2coffee;

before(function () {
  js2coffee = require('../index');
});

describe('spec:', function () {
  var name, input, output;

  specs.forEach(function (dirname) {
    var name = path.basename(dirname);

    it(name, function () {
      var input = fs.readFileSync(dirname + '/input.js', 'utf-8');
      var output = fs.readFileSync(dirname + '/output.coffee', 'utf-8');
      var result = js2coffee(input);
      expect(result).eql(output);
    });
  });
});
