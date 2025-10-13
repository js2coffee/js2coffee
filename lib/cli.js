/**
 * cli:
 * minimal command-line helper using Node's built-in util.parseArgs.
 *
 *     var args = require('../lib/cli')
 *       .helpfile(__dirname+'/../help.txt')
 *       .version(require('../package.json').version)
 *       .parseArgs({
 *         alias: { h: 'help', v: 'version' }
 *       });
 *
 *     // $ myapp --help
 *     // $ myapp --version
 */

var cli = module.exports = {};
var fs = require('fs');
var { parseArgs } = require('util');

/**
 * cmd() : cli.cmd()
 * Returns the command name.
 */

cli.cmd = function () {
  return require('path').basename(process.argv[1]);
};

/**
 * help() : cli.help([help])
 * Sets or prints the help text. If `help` is given, sets the help text to that.
 * If no arguments are given, the help text is printed.
 */

cli.help = function (str) {
  if (str) {
    cli._help = str;
    return this;
  } else {
    process.stdout.write((cli._help || '').replace(/\$0/g, cli.cmd()));
    return this;
  }
};

cli.helpfile = function (fname) {
  cli._help = fs.readFileSync(fname, 'utf-8');
  return this;
};

/**
 * version() : cli.version([ver])
 * Sets or prints the version. If `ver` is given, the version is set; if no
 * arguments are given, the version is printed.
 */

cli.version = function (ver) {
  if (ver)
    cli._version = ver;
  else
    console.log(cli._version);

  return this;
};

/**
 * parseArgs() : cli.parseArgs({ ... })
 * Parses arguments using Node's built-in util.parseArgs.
 */

cli.parseArgs = function (options) {
  cli._parseArgs(options);
  cli._run();
  return cli._args;
};

cli.minimist = cli.parseArgs;

cli._parseArgs = function (options) {
  if (cli._args) return cli;

  options = options || {};

  var parseArgsOptions = {
    options: {},
    allowPositionals: true,
    strict: false
  };

  if (options.boolean) {
    options.boolean.forEach(function(key) {
      parseArgsOptions.options[key] = { type: 'boolean' };
    });
  }

  if (options.string) {
    options.string.forEach(function(key) {
      parseArgsOptions.options[key] = { type: 'string' };
    });
  }

  if (options.alias) {
    for (var shortName in options.alias) {
      var longName = options.alias[shortName];
      if (parseArgsOptions.options[longName]) {
        parseArgsOptions.options[longName].short = shortName;
      } else {
        parseArgsOptions.options[longName] = { type: 'boolean', short: shortName };
      }
    }
  }

  try {
    var parsed = parseArgs(parseArgsOptions);
    cli._args = parsed.values;
    cli._args._ = parsed.positionals;
  } catch (err) {
    cli._args = { _: process.argv.slice(2) };
  }

  return cli;
};

cli._run = function () {
  var args = this._args;
  if (args.help) {
    cli.help();
    process.exit();
  }
  if (args.version) {
    cli.version();
    process.exit();
  }
};
