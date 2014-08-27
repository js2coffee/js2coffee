var
  expect = require('chai').expect,
  path = require('path'),
  glob = require('glob'),
  fs = require('fs');

var js2coffee, name, input, output;
var specs = glob.sync(__dirname + '/../spec/*');

before(function () {
  js2coffee = require('../index');
});

describe('specs:', function () {
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
