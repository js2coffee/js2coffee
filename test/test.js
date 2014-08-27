var
  expect = require('chai').expect,
  path = require('path'),
  glob = require('glob'),
  fs = require('fs');

var js2coffee, name, input, output;
var groups = glob.sync(__dirname + '/../specs/*');

before(function () {
  js2coffee = require('../index');
});

groups.forEach(function (dirname) {
  var group = path.basename(dirname).replace(/_/g, ' ');

  describe(group, function () {
    var specs = glob.sync(dirname + '/*');

    specs.forEach(function (dirname) {
      var name = path.basename(dirname).replace(/_/g, ' ');

      var test = (~group.indexOf('pending')) ? xit : it;
      test(name, function () {
        var input = fs.readFileSync(dirname + '/input.js', 'utf-8');
        var output = fs.readFileSync(dirname + '/output.coffee', 'utf-8');
        var result = js2coffee(input);
        expect(result).eql(output);
      });
    });
  });
});
