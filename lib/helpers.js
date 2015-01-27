(function() {
  var Code, CoffeeScript, blockTrim, coffeescript_reserved, exports, indentLines, isSingleLine, lexer, ltrim, p, paren, rtrim, strEscape, strEscapeSingleQuotes, strRepeat, trim, truthy, unreserve, unshift, word,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  CoffeeScript = require('coffee-script');

  if (CoffeeScript.RESERVED == null) {
    lexer = require('coffee-script/lib/coffee-script/lexer.js');
    CoffeeScript.RESERVED = lexer.RESERVED.filter(function(word) {
      return lexer.STRICT_PROSCRIBED.indexOf(word) < 0;
    });
  }

  Code = (function() {
    Code.INDENT = "  ";

    function Code() {
      this.code = '';
    }

    Code.prototype.add = function(str) {
      this.code += str.toString();
      return this;
    };

    Code.prototype.scope = function(str, level) {
      var indent;
      if (level == null) {
        level = 1;
      }
      indent = strRepeat(Code.INDENT, level);
      this.code = rtrim(this.code) + "\n";
      this.code += indent + rtrim(str).replace(/\n/g, "\n" + indent) + "\n";
      return this;
    };

    Code.prototype.toString = function() {
      return this.code;
    };

    return Code;

  })();

  paren = function(string) {
    var str;
    str = string.toString();
    if (str.substr(0, 1) === '(' && str.substr(-1, 1) === ')') {
      return str;
    } else {
      return "(" + str + ")";
    }
  };

  strRepeat = function(str, times) {
    var i;
    return ((function() {
      var _i, _results;
      _results = [];
      for (i = _i = 0; 0 <= times ? _i < times : _i > times; i = 0 <= times ? ++_i : --_i) {
        _results.push(str);
      }
      return _results;
    })()).join('');
  };

  ltrim = function(str) {
    return ("" + str).replace(/^\s*/g, '');
  };

  rtrim = function(str) {
    return ("" + str).replace(/\s*$/g, '');
  };

  blockTrim = function(str) {
    return ("" + str).replace(/^\s*\n|\s*$/g, '');
  };

  trim = function(str) {
    return ("" + str).replace(/^\s*|\s*$/g, '');
  };

  isSingleLine = function(str) {
    return trim(str).indexOf("\n") === -1;
  };

  unshift = function(str) {
    var m1, m2;
    str = "" + str;
    while (true) {
      m1 = str.match(/^/gm);
      m2 = str.match(/^ /gm);
      if (!m1 || !m2 || m1.length !== m2.length) {
        return str;
      }
      str = str.replace(/^ /gm, '');
    }
  };

  truthy = function(n) {
    return n.isA('true') || (n.isA('number') && parseFloat(n.src()) !== 0.0);
  };

  strEscape = function(str) {
    if (str.indexOf('#{') !== -1) {
      return strEscapeSingleQuotes(str);
    }
    return JSON.stringify("" + str);
  };

  strEscapeSingleQuotes = function(str) {
    var dq, esq, rdq;
    dq = JSON.stringify(str);
    rdq = dq.replace(/\\"/g, '"');
    esq = rdq.replace(/'/g, "\\\'");
    return "'" + esq.substr(1, esq.length - 2) + "'";
  };

  p = function(str) {
    if (str.constructor === String) {
      console.log(JSON.stringify(str));
    } else {
      console.log(str);
    }
    return '';
  };

  coffeescript_reserved = (function() {
    var _i, _len, _ref, _results;
    _ref = CoffeeScript.RESERVED;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      word = _ref[_i];
      if (word !== 'undefined') {
        _results.push(word);
      }
    }
    return _results;
  })();

  unreserve = function(str) {
    var _ref;
    if (_ref = "" + str, __indexOf.call(coffeescript_reserved, _ref) >= 0) {
      return "" + str + "_";
    } else {
      return "" + str;
    }
  };

  indentLines = function(indent, lines) {
    return indent + lines.replace(/\n/g, "\n" + indent);
  };

  this.Js2coffeeHelpers = exports = {
    Code: Code,
    p: p,
    strEscapeDoubleQuotes: strEscape,
    strEscapeSingleQuotes: strEscapeSingleQuotes,
    unreserve: unreserve,
    unshift: unshift,
    isSingleLine: isSingleLine,
    trim: trim,
    blockTrim: blockTrim,
    ltrim: ltrim,
    rtrim: rtrim,
    strRepeat: strRepeat,
    paren: paren,
    truthy: truthy,
    indentLines: indentLines
  };

  if (typeof module !== "undefined" && module !== null) {
    module.exports = exports;
  }

}).call(this);
