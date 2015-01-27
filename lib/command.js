(function() {
  var BANNER, UnsupportedError, batch, cmd, compileFromStdin, compilePath, compileScript, description, encoding, fileUtil, fsUtil, hidden, inspect, js2coffee, knownOpts, nopt, options, parseOptions, pathUtil, shortHands, sources, tty, usage, version, writeFile;

  js2coffee = require('./js2coffee');

  fsUtil = require('fs');

  pathUtil = require('path');

  tty = require('tty');

  fileUtil = require('file');

  inspect = require('util').inspect;

  nopt = require('nopt');

  BANNER = "Usage: js2coffee [options] path/to/script.js\n\n  js2coffee file.js\n  js2coffee file.js > output.coffee\n  cat file.js | js2coffee";

  knownOpts = {
    version: Boolean,
    verbose: Boolean,
    no_comments: Boolean,
    show_src_lineno: Boolean,
    single_quotes: Boolean,
    help: Boolean,
    indent: String
  };

  shortHands = {
    v: ["--version"],
    V: ["--verbose"],
    X: ["--no_comments"],
    l: ["--show_src_lineno"],
    h: ["--help"],
    sq: ["--single_quotes"],
    i4: ["--indent", "    "],
    it: ["--indent", "\t"]
  };

  description = {
    version: 'Show js2coffee version',
    verbose: 'Be verbose',
    no_comments: 'Do not translate comments',
    show_src_lineno: 'Show src lineno\'s as comments',
    help: 'If you need help',
    single_quotes: "Use single quoted string literals - default double quoted",
    indent: 'Specify the indent character(s) - default 2 spaces'
  };

  options = {};

  sources = [];

  encoding = 'utf-8';

  UnsupportedError = js2coffee.UnsupportedError;

  cmd = pathUtil.basename(process.argv[1]);

  parseOptions = function() {
    var index, _base;
    options = nopt(knownOpts, shortHands, process.argv, 2);
    sources = (_base = options.argv).remain || (_base.remain = []);
    if (options.no_comments === true && options.show_src_lineno === true) {
      console.warn("You cannot combine -l and -X");
      return process.exit(1);
    }
    index = options.argv.cooked.indexOf("--indent");
    if (index !== -1 && options.argv.cooked.length >= index) {
      return options.indent = options.argv.cooked[index + 1];
    }
  };

  writeFile = function(dir, currfile, coffee) {
    var e, newFile, newPath, outputdir;
    outputdir = options.output || '.';
    try {
      if ((outputdir.search('/')) === -1) {
        outputdir = outputdir.concat('/');
      }
      newPath = outputdir + dir + '/';
      try {
        fsUtil.statSync(newPath).isDirectory();
      } catch (_error) {
        e = _error;
        fileUtil.mkdirsSync(newPath);
      }
      currfile = (currfile.split('.'))[0] + '.coffee';
      newFile = newPath + currfile;
      if (options.verbose) {
        console.log("writing %s ", newFile);
      }
      return fsUtil.writeFileSync(newFile, coffee, encoding);
    } catch (_error) {
      e = _error;
      return console.error(e);
    }
  };

  batch = function() {
    var callback, e, i, list, v, _i, _j, _len, _len1, _ref, _results;
    callback = function(dirPath, dirs, files) {
      var contents, e, f, output, readf, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = files.length; _i < _len; _i++) {
        f = files[_i];
        try {
          if ((f.split('.'))[1] === 'js') {
            readf = dirPath + '/' + f;
            if (options.verbose) {
              console.log("read file %s", readf);
            }
            contents = fsUtil.readFileSync(readf, encoding);
            output = js2coffee.build(contents, options);
            _results.push(writeFile(dirPath, f, output));
          } else {
            _results.push(void 0);
          }
        } catch (_error) {
          e = _error;
          _results.push(console.error(e));
        }
      }
      return _results;
    };
    _results = [];
    for (_i = 0, _len = sources.length; _i < _len; _i++) {
      i = sources[_i];
      try {
        if (fsUtil.statSync(i).isDirectory()) {
          if (options.recursive) {
            _results.push(fileUtil.walkSync(i, callback));
          } else {
            list = [];
            _ref = fsUtil.readdirSync(i);
            for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
              v = _ref[_j];
              if (fsUtil.statSync(v).isFile()) {
                list.add(v);
              }
            }
            _results.push(callback(i, '', list));
          }
        } else {
          _results.push(void 0);
        }
      } catch (_error) {
        e = _error;
      }
    }
    return _results;
  };

  compilePath = function(source, topLevel) {
    if (topLevel == null) {
      topLevel = true;
    }
    return fsUtil.stat(source, function(err, stats) {
      var _ref;
      if (err && err.code !== 'ENOENT') {
        throw err;
      }
      if ((err != null ? err.code : void 0) === 'ENOENT') {
        if (topLevel && source.slice(-3) !== '.js') {
          source = "" + source + ".js";
          return compilePath(source, topLevel);
        }
        if (topLevel) {
          console.error("File not found: " + source);
          process.exit(1);
        }
        return;
      }
      if (stats.isDirectory()) {
        return fsUtil.readdir(source, function(err, files) {
          var file, _i, _len, _results;
          if (err && err.code !== 'ENOENT') {
            throw err;
          }
          if ((err != null ? err.code : void 0) === 'ENOENT') {
            return;
          }
          _results = [];
          for (_i = 0, _len = files.length; _i < _len; _i++) {
            file = files[_i];
            if (!hidden(file)) {
              _results.push(compilePath(pathUtil.join(source, file), false));
            }
          }
          return _results;
        });
      } else if (topLevel || ((_ref = pathUtil.extname(source)) === '.js' || _ref === '.json')) {
        return compileScript(source);
      }
    });
  };

  hidden = function(file) {
    return /^\.|~$/.test(file);
  };

  compileScript = function(fname) {
    var code, compiled_code, err;
    try {
      if (options.verbose) {
        console.log("#### ---- " + fname);
      }
      code = fsUtil.readFileSync(fname);
      if ('.json' === pathUtil.extname(fname)) {
        code = "(" + code + ")";
      }
      compiled_code = js2coffee.build(code.toString(), options);
      return console.log(compiled_code);
    } catch (_error) {
      err = _error;
      console.warn(err instanceof Error && err.stack || ("ERROR: " + err + " while compiling " + fname));
      return process.exit(1);
    }
  };

  compileFromStdin = function() {
    var contents, output;
    contents = fsUtil.readFileSync("/dev/stdin", encoding);
    output = js2coffee.build(contents, options);
    return console.log(output);
  };

  usage = function() {
    var arg, long, short;
    console.warn(BANNER + "\n");
    console.warn("options:");
    for (arg in knownOpts) {
      console.warn("--" + arg + " # " + description[arg]);
    }
    console.warn("\nshorcuts:");
    for (short in shortHands) {
      long = shortHands[short];
      if (short === '___singles') {
        continue;
      }
      console.warn("-" + short + " = " + (inspect(long)));
    }
    return process.exit(0);
  };

  version = function() {
    return "js2coffee version " + js2coffee.VERSION;
  };

  exports.run = function() {
    var s, _i, _len, _results;
    parseOptions();
    if (options.help) {
      return usage();
    }
    if (options.version) {
      return console.log(version());
    }
    if (options.verbose) {
      console.log("#### " + version());
    }
    if (sources.length > 0) {
      _results = [];
      for (_i = 0, _len = sources.length; _i < _len; _i++) {
        s = sources[_i];
        _results.push(compilePath(s));
      }
      return _results;
    } else {
      if (!tty.isatty(process.stdin)) {
        return compileFromStdin('/dev/stdin');
      }
      return usage();
    }
  };

}).call(this);
