/**
 * cli:
 * minimal command-line helper on top of minimist.
 *
 *     var args = require('../lib/cli')
 *       .helpfile(__dirname+'/../help.txt')
 *       .version(require('../package.json').version)
 *       .args({
 *         alias: { h: 'help', v: 'version' }
 *       });
 *
 *     // $ myapp --help
 *     // $ myapp --version
 */

var cli = module.exports = {};
var fs = require('fs');

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
 * minimist() : cli.minimist({ ... })
 * Parses arguments using minimist.
 */

cli.minimist = function (options) {
  cli._parseArgs(options);
  cli._run();
  return cli._args;
};

cli._parseArgs = function (options) {
  if (!cli._args)
    cli._args = require('minimist')(process.argv.slice(2), options || {});
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
