(function() {
  var ansidiff, assert, build, files, fs, glob, joe, js2c, _;

  js2c = require('../lib/js2coffee');

  glob = require('glob').globSync || require('glob').sync;

  fs = require('fs');

  _ = require('underscore');

  joe = require('joe');

  assert = require('assert');

  ansidiff = require('ansidiff');

  build = js2c.build;

  files = glob(__dirname + '/features/*.js');

  joe.suite('js2coffee', function(suite, test) {
    return _.each(files, function(f) {
      return test(f, function() {

        /*
          to pass build options for you test, your first line should look like this:
          // OPTIONS: {"single_quotes": true}
         */
        var err, expected, input, matches, options, optionsPattern, opts, output;
        options = {
          no_comments: true,
          indent: "  "
        };
        optionsPattern = /^\/\/\s*OPTIONS:\s*(.*)/;
        input = fs.readFileSync(f).toString().trim();
        matches = input.match(optionsPattern);
        if (matches != null) {
          try {
            opts = JSON.parse(matches[1]);
            _(options).extend(opts);
          } catch (_error) {
            err = _error;
            console.error("Could not parse options for test file: " + f);
            console.error(err.message);
            throw err;
          }
        }
        output = build(input, options).trim();
        expected = fs.readFileSync(f.replace('.js', '.coffee')).toString().trim();
        if (output !== expected) {
          console.error(ansidiff.lines(output, expected));
        }
        return assert.equal(output, expected);
      });
    });
  });

}).call(this);
