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

      var test = (~group.indexOf('pending') || name.match(/^ /)) ? xit : it;

      test(name.trim(), function () {
        var input = fs.readFileSync(dirname + '/input.js', 'utf-8');
        var output = fs.readFileSync(dirname + '/output.coffee', 'utf-8');
        var result = js2coffee(input);
        expect(result).eql(output);
      });
    });
  });
});

describe('parse()', function () {
  it('works', function () {
    var out = js2coffee.parse("// hi\na=2");
    expect(out.ast).be.an('object');
    expect(out.map).be.an('object');
    expect(out.code).be.a('string');
    // console.log(require('util').inspect(out, { depth: 1000 }));
  });
});
