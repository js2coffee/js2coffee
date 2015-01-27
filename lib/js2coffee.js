(function() {
  var Builder, Code, Node, Transformer, Typenames, Types, UnsupportedError, blockTrim, buildCoffee, exports, indentLines, isSingleLine, ltrim, p, paren, parser, pkg, rtrim, strEscape, strEscapeDoubleQuotes, strEscapeSingleQuotes, strRepeat, trim, truthy, unreserve, unshift, _, _ref, _ref1,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
    __slice = [].slice,
    __hasProp = {}.hasOwnProperty;

  pkg = require('../../package.json');

  _ = require('underscore');

  parser = require('./narcissus_packed').parser;

  _ref = require('./node_ext'), Types = _ref.Types, Typenames = _ref.Typenames, Node = _ref.Node;

  _ref1 = require('./helpers'), Code = _ref1.Code, p = _ref1.p, strEscapeDoubleQuotes = _ref1.strEscapeDoubleQuotes, strEscapeSingleQuotes = _ref1.strEscapeSingleQuotes, unreserve = _ref1.unreserve, unshift = _ref1.unshift, isSingleLine = _ref1.isSingleLine, trim = _ref1.trim, blockTrim = _ref1.blockTrim, ltrim = _ref1.ltrim, rtrim = _ref1.rtrim, strRepeat = _ref1.strRepeat, paren = _ref1.paren, truthy = _ref1.truthy, indentLines = _ref1.indentLines;

  strEscape = void 0;

  buildCoffee = function(str, opts) {
    var builder, comments, err, errorLine, indent, keepLineNumbers, l, line, minline, output, precomments, res, scriptNode, srclines, text, _i, _len, _ref2;
    if (opts == null) {
      opts = {};
    }
    str = str.replace(/\r/g, '');
    str += "\n";
    if (opts.indent != null) {
      Code.INDENT = opts.indent;
    }
    if ((opts.single_quotes != null) && opts.single_quotes === true) {
      console.log(opts.single_quotes);
      strEscape = strEscapeSingleQuotes;
    } else {
      strEscape = strEscapeDoubleQuotes;
    }
    builder = new Builder(opts);
    try {
      scriptNode = parser.parse(str);
    } catch (_error) {
      err = _error;
      line = err.source.substr(0, err.cursor).split("\n").length;
      console.log("narcissus error: " + err.message + " in line " + line);
      errorLine = err.source.substr(err.cursor);
      console.log("at position: " + (errorLine.split('\n')[0]));
      throw new Error("" + err.message + " in line " + line);
    }
    try {
      output = trim(builder.build(scriptNode));
    } catch (_error) {
      err = _error;
      console.log("error during conversion: " + err.message);
      throw new Error("error after line: " + builder.lastLine);
    }
    if (opts.no_comments === true) {
      return ((function() {
        var _i, _len, _ref2, _results;
        _ref2 = output.split('\n');
        _results = [];
        for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
          line = _ref2[_i];
          _results.push(rtrim(line));
        }
        return _results;
      })()).join('\n');
    } else {
      keepLineNumbers = opts.show_src_lineno;
      res = [];
      _ref2 = output.split("\n");
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        l = _ref2[_i];
        srclines = [];
        text = l.replace(/\uFEFE([0-9]+).*?\uFEFE/g, function(m, g) {
          srclines.push(parseInt(g));
          return "";
        });
        srclines = _.sortBy(_.uniq(srclines), function(i) {
          return i;
        });
        text = rtrim(text);
        indent = text.match(/^\s*/);
        if (srclines.length > 0) {
          minline = _.last(srclines);
          precomments = builder.commentsNotDoneTo(minline);
          if (precomments) {
            res.push(indentLines(indent, precomments));
          }
        }
        if (text) {
          if (keepLineNumbers) {
            text = text + "#" + srclines.join(",") + "#  ";
          }
          res.push(rtrim(text + " " + ltrim(builder.lineComments(srclines))));
        } else {
          res.push("");
        }
      }
      comments = builder.commentsNotDoneTo(1e10);
      if (comments) {
        res.push(comments);
      }
      return res.join("\n");
    }
  };

  Builder = (function() {
    function Builder(options) {
      this.options = options != null ? options : {};
      this.transformer = new Transformer;
      this.lastLine = 0;
    }

    Builder.prototype.l = function(n) {
      this.lastLine = n.lineno;
      if (this.options.no_comments === true) {
        return '';
      }
      if (n && n.lineno) {
        return "\uFEFE" + n.lineno + "\uFEFE";
      } else {
        return "";
      }
    };

    Builder.prototype.makeComment = function(comment) {
      var c, line;
      if (comment.type === "BLOCK_COMMENT") {
        c = comment.value.split("\n");
        if (c.length > 0 && c[0].length > 0 && c[0][0] === "*") {
          c = (function() {
            var _i, _len, _results;
            _results = [];
            for (_i = 0, _len = c.length; _i < _len; _i++) {
              line = c[_i];
              _results.push(line.replace(/^[\s\*]*/, ''));
            }
            return _results;
          })();
          c = (function() {
            var _i, _len, _results;
            _results = [];
            for (_i = 0, _len = c.length; _i < _len; _i++) {
              line = c[_i];
              _results.push(line.replace(/[\s]*$/, ''));
            }
            return _results;
          })();
          while (c.length > 0 && c[0].length === 0) {
            c.shift();
          }
          while (c.length > 0 && c[c.length - 1].length === 0) {
            c.pop();
          }
          c.unshift('###*');
          c.push('###');
        } else {
          c = (function() {
            var _i, _len, _results;
            _results = [];
            for (_i = 0, _len = c.length; _i < _len; _i++) {
              line = c[_i];
              _results.push("#" + line);
            }
            return _results;
          })();
        }
      } else {
        c = ['#' + comment.value];
      }
      if (comment.nlcount > 0) {
        c.unshift('');
      }
      return c.join('\n');
    };

    Builder.prototype.commentsNotDoneTo = function(lineno) {
      var c, res;
      res = [];
      while (true) {
        if (this.comments.length === 0) {
          break;
        }
        c = this.comments[0];
        if (c.lineno < lineno) {
          res.push(this.makeComment(c));
          this.comments.shift();
          continue;
        }
        break;
      }
      return res.join("\n");
    };

    Builder.prototype.lineComments = function(linenos) {
      var c, selection;
      selection = (function() {
        var _i, _len, _ref2, _ref3, _results;
        _ref2 = this.comments;
        _results = [];
        for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
          c = _ref2[_i];
          if (_ref3 = c.lineno, __indexOf.call(linenos, _ref3) >= 0) {
            _results.push(c);
          }
        }
        return _results;
      }).call(this);
      this.comments = _.difference(this.comments, selection);
      return ((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = selection.length; _i < _len; _i++) {
          c = selection[_i];
          _results.push(this.makeComment(c));
        }
        return _results;
      }).call(this)).join("\n");
    };

    Builder.prototype.build = function() {
      var args, fn, name, node, out;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      node = args[0];
      if (this.comments == null) {
        this.comments = _.sortBy(node.tokenizer.comments, function(n) {
          return n.start;
        });
      }
      this.transform(node);
      name = 'other';
      if (node !== void 0 && node.typeName) {
        name = node.typeName();
      }
      fn = this[name] || this.other;
      out = fn.apply(this, args);
      if (node.parenthesized) {
        return paren(out);
      } else {
        return out;
      }
    };

    Builder.prototype.transform = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return this.transformer.transform.apply(this.transformer, args);
    };

    Builder.prototype.body = function(node, opts) {
      var str;
      if (opts == null) {
        opts = {};
      }
      str = this.build(node, opts);
      str = blockTrim(str);
      str = unshift(str);
      if (str.length > 0) {
        return str;
      } else {
        return "";
      }
    };

    Builder.prototype['script'] = function(n, opts) {
      var c;
      if (opts == null) {
        opts = {};
      }
      c = new Code;
      _.each(n.functions, (function(_this) {
        return function(item) {
          return c.add(_this.build(item));
        };
      })(this));
      _.each(n.nonfunctions, (function(_this) {
        return function(item) {
          return c.add(_this.build(item));
        };
      })(this));
      return c.toString();
    };

    Builder.prototype['property_identifier'] = function(n) {
      var str;
      str = n.value.toString();
      if (str.match(/^([_\$a-z][_\$a-z0-9]*)$/i) || str.match(/^[0-9]+$/i)) {
        return this.l(n) + str;
      } else {
        return this.l(n) + strEscape(str);
      }
    };

    Builder.prototype['identifier'] = function(n) {
      if (n.value === 'undefined') {
        return this.l(n) + '`undefined`';
      } else if (n.property_accessor) {
        return this.l(n) + n.value.toString();
      } else {
        return this.l(n) + unreserve(n.value.toString());
      }
    };

    Builder.prototype['number'] = function(n) {
      return this.l(n) + ("" + (n.src().toLowerCase()));
    };

    Builder.prototype['id'] = function(n) {
      if (n.property_accessor) {
        return this.l(n) + n;
      } else {
        return this.l(n) + unreserve(n);
      }
    };

    Builder.prototype['id_param'] = function(n) {
      var _ref2;
      if ((_ref2 = n.toString()) === 'undefined') {
        return this.l(n) + ("" + n + "_");
      } else {
        return this.l(n) + this.id(n);
      }
    };

    Builder.prototype['return'] = function(n) {
      if (n.value == null) {
        return this.l(n) + "return\n";
      } else {
        return this.l(n) + ("return " + (this.build(n.value)) + "\n");
      }
    };

    Builder.prototype[';'] = function(n) {
      var src;
      if (n.expression == null) {
        return "";
      } else if (n.expression.typeName() === 'object_init') {
        src = this.object_init(n.expression);
        if (n.parenthesized) {
          return src;
        } else {
          return "" + (unshift(blockTrim(src))) + "\n";
        }
      } else {
        return this.build(n.expression) + "\n";
      }
    };

    Builder.prototype['new'] = function(n) {
      return this.l(n) + ("new " + (this.build(n.left())));
    };

    Builder.prototype['new_with_args'] = function(n) {
      return this.l(n) + ("new " + (this.build(n.left())) + "(" + (this.build(n.right())) + ")");
    };

    Builder.prototype['unary_plus'] = function(n) {
      return "+" + (this.build(n.left()));
    };

    Builder.prototype['unary_minus'] = function(n) {
      return "-" + (this.build(n.left()));
    };

    Builder.prototype['this'] = function(n) {
      return this.l(n) + 'this';
    };

    Builder.prototype['null'] = function(n) {
      return this.l(n) + 'null';
    };

    Builder.prototype['true'] = function(n) {
      return this.l(n) + 'true';
    };

    Builder.prototype['false'] = function(n) {
      return this.l(n) + 'false';
    };

    Builder.prototype['void'] = function(n) {
      return this.l(n) + 'undefined';
    };

    Builder.prototype['debugger'] = function(n) {
      return this.l(n) + "debugger\n";
    };

    Builder.prototype['break'] = function(n) {
      return this.l(n) + "break\n";
    };

    Builder.prototype['continue'] = function(n) {
      return this.l(n) + "continue\n";
    };

    Builder.prototype['~'] = function(n) {
      return "~" + (this.build(n.left()));
    };

    Builder.prototype['typeof'] = function(n) {
      return this.l(n) + ("typeof " + (this.build(n.left())));
    };

    Builder.prototype['index'] = function(n) {
      var right;
      right = this.build(n.right());
      if (_.any(n.children, function(child) {
        return child.typeName() === 'object_init' && child.children.length > 1;
      })) {
        right = "{" + right + "}";
      }
      return this.l(n) + ("" + (this.build(n.left())) + "[" + right + "]");
    };

    Builder.prototype['throw'] = function(n) {
      return this.l(n) + ("throw " + (this.build(n.exception)) + "\n");
    };

    Builder.prototype['!'] = function(n) {
      var negations, target;
      target = n.left();
      negations = 1;
      while ((target.isA('!')) && (target = target.left())) {
        ++negations;
      }
      if ((negations & 1) && target.isA('==', '!=', '===', '!==', 'in', 'instanceof')) {
        target.negated = !target.negated;
        return this.build(target);
      }
      return this.l(n) + ("" + (negations & 1 ? 'not ' : '!!') + (this.build(target)));
    };

    Builder.prototype["in"] = function(n) {
      return this.binary_operator(n, 'of');
    };

    Builder.prototype['+'] = function(n) {
      return this.binary_operator(n, '+');
    };

    Builder.prototype['-'] = function(n) {
      return this.binary_operator(n, '-');
    };

    Builder.prototype['*'] = function(n) {
      return this.binary_operator(n, '*');
    };

    Builder.prototype['/'] = function(n) {
      return this.binary_operator(n, '/');
    };

    Builder.prototype['%'] = function(n) {
      return this.binary_operator(n, '%');
    };

    Builder.prototype['>'] = function(n) {
      return this.binary_operator(n, '>');
    };

    Builder.prototype['<'] = function(n) {
      return this.binary_operator(n, '<');
    };

    Builder.prototype['&'] = function(n) {
      return this.binary_operator(n, '&');
    };

    Builder.prototype['|'] = function(n) {
      return this.binary_operator(n, '|');
    };

    Builder.prototype['^'] = function(n) {
      return this.binary_operator(n, '^');
    };

    Builder.prototype['&&'] = function(n) {
      return this.binary_operator(n, 'and');
    };

    Builder.prototype['||'] = function(n) {
      return this.binary_operator(n, 'or');
    };

    Builder.prototype['<<'] = function(n) {
      return this.binary_operator(n, '<<');
    };

    Builder.prototype['<='] = function(n) {
      return this.binary_operator(n, '<=');
    };

    Builder.prototype['>>'] = function(n) {
      return this.binary_operator(n, '>>');
    };

    Builder.prototype['>='] = function(n) {
      return this.binary_operator(n, '>=');
    };

    Builder.prototype['==='] = function(n) {
      return this.binary_operator(n, 'is');
    };

    Builder.prototype['!=='] = function(n) {
      return this.binary_operator(n, 'isnt');
    };

    Builder.prototype['>>>'] = function(n) {
      return this.binary_operator(n, '>>>');
    };

    Builder.prototype["instanceof"] = function(n) {
      return this.binary_operator(n, 'instanceof');
    };

    Builder.prototype['=='] = function(n) {
      return this.binary_operator(n, 'is');
    };

    Builder.prototype['!='] = function(n) {
      return this.binary_operator(n, 'isnt');
    };

    Builder.prototype['binary_operator'] = (function() {
      var INVERSIONS, k, v;
      INVERSIONS = {
        is: 'isnt',
        "in": 'not in',
        of: 'not of',
        "instanceof": 'not instanceof'
      };
      for (k in INVERSIONS) {
        if (!__hasProp.call(INVERSIONS, k)) continue;
        v = INVERSIONS[k];
        INVERSIONS[v] = k;
      }
      return function(n, sign) {
        if (n.negated) {
          sign = INVERSIONS[sign];
        }
        return this.l(n) + ("" + (this.build(n.left())) + " " + sign + " " + (this.build(n.right())));
      };
    })();

    Builder.prototype['--'] = function(n) {
      return this.increment_decrement(n, '--');
    };

    Builder.prototype['++'] = function(n) {
      return this.increment_decrement(n, '++');
    };

    Builder.prototype['increment_decrement'] = function(n, sign) {
      if (n.postfix) {
        return this.l(n) + ("" + (this.build(n.left())) + sign);
      } else {
        return this.l(n) + ("" + sign + (this.build(n.left())));
      }
    };

    Builder.prototype['='] = function(n) {
      var sign;
      sign = n.assignOp != null ? Types[n.assignOp] + '=' : '=';
      return this.l(n) + ("" + (this.build(n.left())) + " " + sign + " " + (this.build(n.right())));
    };

    Builder.prototype[','] = function(n) {
      var list;
      list = _.map(n.children, (function(_this) {
        return function(item) {
          return _this.l(item) + _this.build(item) + "\n";
        };
      })(this));
      return list.join('');
    };

    Builder.prototype['regexp'] = function(n) {
      var begins_with, flag, m, value;
      m = n.value.toString().match(/^\/(.*)\/([a-z]?)/);
      value = m[1];
      flag = m[2];
      begins_with = value[0];
      if (begins_with === ' ' || begins_with === '=') {
        if (flag.length > 0) {
          return this.l(n) + ("RegExp(" + (strEscape(value)) + ", \"" + flag + "\")");
        } else {
          return this.l(n) + ("RegExp(" + (strEscape(value)) + ")");
        }
      } else {
        return this.l(n) + ("/" + value + "/" + flag);
      }
    };

    Builder.prototype['string'] = function(n) {
      return this.l(n) + strEscape(n.value);
    };

    Builder.prototype['call'] = function(n) {
      if (n.right().children.length === 0) {
        return ("" + (this.build(n.left())) + "()") + this.l(n);
      } else {
        return ("" + (this.build(n.left())) + "(" + (this.build(n.right())) + ")") + this.l(n);
      }
    };

    Builder.prototype['call_statement'] = function(n) {
      var left;
      left = this.build(n.left());
      if (n.left().isA('function')) {
        left = paren(left);
      }
      if (n.right().children.length === 0) {
        return ("" + left + "()") + this.l(n);
      } else {
        return ("" + left + " " + (this.build(n.right()))) + this.l(n);
      }
    };

    Builder.prototype['list'] = function(n, options) {
      var list;
      if (options == null) {
        options = {};
      }
      list = _.map(n.children, (function(_this) {
        return function(item) {
          var c, raw;
          if (n.children.length > 1) {
            item.is_list_element = true;
          }
          if (options.array === true && n.children.length > 0) {
            raw = _this[item.typeName()](item);
            c = new Code(_this, item);
            c.scope(raw);
            c = trim(c + Code.INDENT);
            if (item.typeName() === 'object_init') {
              c = "{\n" + Code.INDENT + Code.INDENT + c + "\n" + Code.INDENT + "}";
            }
            return c;
          } else {
            return _this.build(item);
          }
        };
      })(this));
      if (options.array === true && n.children.length > 0) {
        return this.l(n) + ("\n" + Code.INDENT + (list.join('\n' + Code.INDENT)));
      } else {
        return this.l(n) + list.join(", ");
      }
    };

    Builder.prototype['delete'] = function(n) {
      var ids;
      ids = _.map(n.children, (function(_this) {
        return function(el) {
          return _this.build(el);
        };
      })(this));
      ids = ids.join(', ');
      return this.l(n) + ("delete " + ids + "\n");
    };

    Builder.prototype['.'] = function(n) {
      var left, right, right_obj;
      left = this.build(n.left());
      right_obj = n.right();
      right_obj.property_accessor = true;
      right = this.build(right_obj);
      if (n.isThis && n.isPrototype) {
        return this.l(n) + "@::";
      } else if (n.isThis) {
        return this.l(n) + ("@" + right);
      } else if (n.isPrototype) {
        return this.l(n) + ("" + left + "::");
      } else if (n.left().isPrototype) {
        return this.l(n) + ("" + left + right);
      } else {
        return this.l(n) + ("" + left + "." + right);
      }
    };

    Builder.prototype['try'] = function(n) {
      var c;
      c = new Code;
      c.add('try');
      c.scope(this.body(n.tryBlock));
      _.each(n.catchClauses, (function(_this) {
        return function(clause) {
          return c.add(_this.build(clause));
        };
      })(this));
      if (n.finallyBlock != null) {
        c.add("finally");
        c.scope(this.body(n.finallyBlock));
      }
      return this.l(n) + c;
    };

    Builder.prototype['catch'] = function(n) {
      var body_, c;
      body_ = this.body(n.block);
      if (trim(body_).length === 0) {
        return '';
      }
      c = new Code;
      if (n.varName != null) {
        c.add("catch " + n.varName);
      } else {
        c.add('catch');
      }
      c.scope(this.body(n.block));
      return this.l(n) + c;
    };

    Builder.prototype['?'] = function(n) {
      return this.l(n) + ("(if " + (this.build(n.left())) + " then " + (this.build(n.children[1])) + " else " + (this.build(n.children[2])) + ")");
    };

    Builder.prototype['for'] = function(n) {
      var c, insertUpdate;
      c = new Code;
      if (n.setup != null) {
        c.add("" + (this.build(n.setup)) + "\n");
      }
      if (n.condition != null) {
        c.add("while " + (this.build(n.condition)) + "\n");
      } else {
        c.add("loop");
      }
      insertUpdate = function(self, parent, i) {
        var branch, child, children, cs, expr, _i, _j, _k, _len, _len1, _len2, _ref2, _ref3, _results, _results1, _results2;
        if (self.isA('continue')) {
          if (!n.update.isA(',')) {
            expr = new n.constructor({}, {
              type: Typenames[';'],
              value: ';',
              expression: n.update
            });
          } else {
            expr = n.update;
          }
          if (i == null) {
            _ref2 = ['thenPart', 'elsePart', 'body'];
            _results = [];
            for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
              branch = _ref2[_i];
              if (self === parent[branch]) {
                _results.push(parent[branch] = new n.constructor({}, {
                  type: Typenames['block'],
                  value: '{',
                  children: [expr, parent[branch]]
                }));
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          } else {
            return parent.children.splice(i, 0, expr);
          }
        } else if (self.isA('switch')) {
          _ref3 = self.cases;
          _results1 = [];
          for (_j = 0, _len1 = _ref3.length; _j < _len1; _j++) {
            cs = _ref3[_j];
            _results1.push(insertUpdate(cs.statements, cs));
          }
          return _results1;
        } else if (self.isA('if')) {
          if (self.thenPart != null) {
            insertUpdate(self.thenPart, self);
          }
          if (self.elsePart != null) {
            return insertUpdate(self.elsePart, self);
          }
        } else {
          children = self.children.slice();
          _results2 = [];
          for (i = _k = 0, _len2 = children.length; _k < _len2; i = ++_k) {
            child = children[i];
            _results2.push(insertUpdate(child, self, i));
          }
          return _results2;
        }
      };
      if (n.update != null) {
        insertUpdate(n.body, n);
      }
      c.scope(this.body(n.body));
      if (n.update != null) {
        c.scope(this.body(n.update));
      }
      return this.l(n) + c;
    };

    Builder.prototype['for_in'] = function(n) {
      var c;
      c = new Code;
      c.add("for " + (this.build(n.iterator)) + " of " + (this.build(n.object)));
      if (n.body.children.length > 0 || (n.body.expression != null)) {
        c.scope(this.body(n.body));
      } else {
        c.scope("continue");
      }
      return this.l(n) + c;
    };

    Builder.prototype['while'] = function(n) {
      var body_, c, keyword, statement;
      c = new Code;
      keyword = n.positive ? "while" : "until";
      body_ = this.body(n.body);
      if (truthy(n.condition)) {
        statement = "loop";
      } else {
        statement = "" + keyword + " " + (this.build(n.condition));
      }
      if (isSingleLine(body_) && statement !== "loop") {
        c.add("" + (trim(body_)) + Code.INDENT + statement + "\n");
      } else {
        c.add(statement);
        c.scope(body_);
      }
      return this.l(n) + c;
    };

    Builder.prototype['do'] = function(n) {
      var c;
      c = new Code;
      c.add("loop");
      c.scope(this.body(n.body));
      if (n.condition != null) {
        c.scope("break unless " + (this.build(n.condition)));
      }
      return this.l(n) + c;
    };

    Builder.prototype['if'] = function(n) {
      var body_, c, keyword;
      c = new Code;
      keyword = n.positive ? "if" : "unless";
      body_ = this.body(n.thenPart);
      n.condition.parenthesized = false;
      if (n.thenPart.isA('block') && n.thenPart.children.length === 0 && (n.elsePart == null)) {
        console.log(n.thenPart);
        c.add("" + (this.build(n.condition)) + "\n");
      } else if (isSingleLine(body_) && (n.elsePart == null)) {
        c.add("" + (trim(body_)) + Code.INDENT + keyword + " " + (this.build(n.condition)) + "\n");
      } else {
        c.add("" + keyword + " " + (this.build(n.condition)));
        c.scope(this.body(n.thenPart));
        if (n.elsePart != null) {
          if (n.elsePart.typeName() === 'if') {
            c.add("else " + (this.build(n.elsePart).toString()));
          } else {
            c.add(this.l(n.elsePart) + "else\n");
            c.scope(this.body(n.elsePart));
          }
        }
      }
      return this.l(n) + c;
    };

    Builder.prototype['switch'] = function(n) {
      var c, fall_through;
      c = new Code;
      c.add("switch " + (this.build(n.discriminant)) + "\n");
      fall_through = false;
      _.each(n.cases, (function(_this) {
        return function(item) {
          var first;
          if (item.value === 'default') {
            c.scope(_this.l(item) + "else");
          } else {
            if (fall_through === true) {
              c.add(_this.l(item) + (", " + (_this.build(item.caseLabel))));
            } else {
              c.add(_this.l(item) + ("" + Code.INDENT + "when " + (_this.build(item.caseLabel))));
            }
          }
          if (_this.body(item.statements).length === 0) {
            fall_through = true;
          } else {
            fall_through = false;
            c.add("\n");
            c.scope(_this.body(item.statements), 2);
          }
          return first = false;
        };
      })(this));
      return this.l(n) + c;
    };

    Builder.prototype['existence_check'] = function(n) {
      return this.l(n) + ("" + (this.build(n.left())) + "?");
    };

    Builder.prototype['array_init'] = function(n) {
      var options;
      options = {
        array: true
      };
      if (n.children.length === 0) {
        return this.l(n) + "[]";
      } else if (n.children.length > 1) {
        return this.l(n) + ("[" + (this.list(n, options)) + "\n]");
      } else {
        return this.l(n) + ("[" + (this.list(n)) + "]");
      }
    };

    Builder.prototype['property_init'] = function(n) {
      var left, right;
      left = n.left();
      right = n.right();
      right.is_property_value = true;
      return "" + (this.property_identifier(left)) + ": " + (this.build(right));
    };

    Builder.prototype['object_init'] = function(n, options) {
      var c, list;
      if (options == null) {
        options = {};
      }
      if (n.children.length === 0) {
        return this.l(n) + "{}";
      } else if (n.children.length === 1 && !(n.is_property_value || n.is_list_element)) {
        return this.build(n.children[0]);
      } else {
        list = _.map(n.children, (function(_this) {
          return function(item) {
            return _this.build(item);
          };
        })(this));
        c = new Code(this, n);
        c.scope(list.join("\n"));
        if (options.brackets != null) {
          c = "{" + c + "}";
        }
        return c;
      }
    };

    Builder.prototype['function'] = function(n) {
      var body, c, params;
      c = new Code;
      params = _.map(n.params, (function(_this) {
        return function(str) {
          if (str.constructor === String) {
            return _this.id_param(str);
          } else {
            return _this.build(str);
          }
        };
      })(this));
      if (n.name) {
        c.add("" + n.name + " = ");
      }
      if (n.params.length > 0) {
        c.add("(" + (params.join(', ')) + ") ->");
      } else {
        c.add("->");
      }
      body = this.body(n.body);
      if (trim(body).length > 0) {
        c.scope(body);
      } else {
        c.add("\n");
      }
      return this.l(n) + c;
    };

    Builder.prototype['var'] = function(n) {
      var list;
      list = _.map(n.children, (function(_this) {
        return function(item) {
          return "" + (unreserve(item.value)) + " = " + (item.initializer != null ? _this.build(item.initializer) : 'undefined');
        };
      })(this));
      return this.l(n) + _.compact(list).join("\n") + "\n";
    };

    Builder.prototype['other'] = function(n) {
      return this.unsupported(n, "" + (n.typeName()) + " is not supported yet");
    };

    Builder.prototype['getter'] = function(n) {
      return this.unsupported(n, "getter syntax is not supported; use __defineGetter__");
    };

    Builder.prototype['setter'] = function(n) {
      return this.unsupported(n, "setter syntax is not supported; use __defineSetter__");
    };

    Builder.prototype['label'] = function(n) {
      return this.unsupported(n, "labels are not supported by CoffeeScript");
    };

    Builder.prototype['const'] = function(n) {
      return this.unsupported(n, "consts are not supported by CoffeeScript");
    };

    Builder.prototype['block'] = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return this.script.apply(this, args);
    };

    Builder.prototype['unsupported'] = function(node, message) {
      throw new UnsupportedError("Unsupported: " + message, node);
    };

    return Builder;

  })();

  Transformer = (function() {
    function Transformer() {}

    Transformer.prototype.transform = function() {
      var args, fn, node, type;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      node = args[0];
      if (node.transformed != null) {
        return;
      }
      type = node.typeName();
      fn = this[type];
      if (fn) {
        fn.apply(this, args);
        return node.transformed = true;
      }
    };

    Transformer.prototype['script'] = function(n) {
      var last;
      n.functions = [];
      n.nonfunctions = [];
      _.each(n.children, (function(_this) {
        return function(item) {
          if (item.isA('function')) {
            return n.functions.push(item);
          } else {
            return n.nonfunctions.push(item);
          }
        };
      })(this));
      last = null;
      return _.each(n.nonfunctions, (function(_this) {
        return function(item) {
          var expr;
          if (item.expression != null) {
            expr = item.expression;
            if ((last != null ? last.isA('object_init') : void 0) && expr.isA('object_init')) {
              item.parenthesized = true;
            } else {
              item.parenthesized = false;
            }
            return last = expr;
          }
        };
      })(this));
    };

    Transformer.prototype['.'] = function(n) {
      if (n.left().isA('function')) {
        n.left().parenthesized = true;
      }
      n.isThis = n.left().isA('this');
      return n.isPrototype = n.right().isA('identifier') && n.right().value === 'prototype';
    };

    Transformer.prototype[';'] = function(n) {
      if (n.expression != null) {
        n.expression.parenthesized = false;
        if (n.expression.isA('call')) {
          n.expression.type = Typenames['call_statement'];
          return this.call_statement(n);
        }
      }
    };

    Transformer.prototype['function'] = function(n) {
      var nonreturns, transform_switch;
      nonreturns = 0;
      transform_switch = this["switch"];
      n.body.walk({
        last: true
      }, function(parent, node, list) {
        var lastNode;
        if (node.isA('switch')) {
          transform_switch(node);
        }
        lastNode = list ? parent[list] : parent.children[parent.children.length - 1];
        if (node.value && lastNode) {
          if (node.isA('return')) {
            lastNode.type = Typenames[';'];
            return lastNode.expression = lastNode.value;
          } else if (lastNode.isA('if', 'switch', 'block')) {

          } else {
            return nonreturns += 1;
          }
        }
      });
      if (nonreturns > 0) {
        return n.body.children.push({
          type: 'return',
          typeName: function() {
            return this.type;
          },
          isA: function(t) {
            return t === this.type;
          }
        });
      }
    };

    Transformer.prototype['switch'] = function(n) {
      return _.each(n.cases, (function(_this) {
        return function(item) {
          var block, ch, _ref2;
          block = item.statements;
          ch = block.children;
          if ((_ref2 = block.last()) != null ? _ref2.isA('break') : void 0) {
            return delete ch[ch.length - 1];
          }
        };
      })(this));
    };

    Transformer.prototype['call_statement'] = function(n) {
      if (n.children[1]) {
        return _.each(n.children[1].children, function(child, i) {
          if (child.isA('function') && i !== n.children[1].children.length - 1) {
            return child.parenthesized = true;
          }
        });
      }
    };

    Transformer.prototype['return'] = function(n) {
      if (n.value && n.value.isA('object_init') && n.value.children.length > 1) {
        return n.value.parenthesized = true;
      }
    };

    Transformer.prototype['block'] = function(n) {
      return this.script(n);
    };

    Transformer.prototype['if'] = function(n) {
      var _ref2;
      if (n.thenPart.isA('block') && n.thenPart.children.length === 0 && (!n.elsePartisA('block') || ((_ref2 = n.elsePart) != null ? _ref2.children.length : void 0) > 0)) {
        n.positive = false;
        n.thenPart = n.elsePart;
        delete n.elsePart;
      }
      return this.inversible(n);
    };

    Transformer.prototype['while'] = function(n) {
      if (n.body.children.length === 0) {
        n.body.children.push(n.clone({
          type: Typenames['continue'],
          value: 'continue',
          children: []
        }));
      }
      return this.inversible(n);
    };

    Transformer.prototype['inversible'] = function(n) {
      var positive;
      this.transform(n.condition);
      positive = n.positive != null ? n.positive : true;
      if (n.condition.isA('!=')) {
        n.condition.type = Typenames['=='];
        return n.positive = !positive;
      } else if (n.condition.isA('!')) {
        n.condition = n.condition.left();
        return n.positive = !positive;
      } else {
        return n.positive = positive;
      }
    };

    Transformer.prototype['=='] = function(n) {
      var right;
      right = n.right();
      if (right.isA('null', 'void') || right.type === 60 && right.value === 'undefined') {
        n.type = Typenames['!'];
        return n.children = [
          n.clone({
            type: Typenames['existence_check'],
            children: [n.left()]
          })
        ];
      }
    };

    Transformer.prototype['!='] = function(n) {
      var right;
      right = n.right();
      if (right.isA('null', 'void') || right.type === 60 && right.value === 'undefined') {
        n.type = Typenames['existence_check'];
        return n.children = [n.left()];
      }
    };

    return Transformer;

  })();

  UnsupportedError = (function() {
    function UnsupportedError(str, src) {
      this.message = str;
      this.cursor = src.start;
      this.line = src.lineno;
      this.source = src.tokenizer.source;
    }

    UnsupportedError.prototype.toString = function() {
      return this.message;
    };

    return UnsupportedError;

  })();

  this.Js2coffee = exports = {
    VERSION: pkg.version,
    build: buildCoffee,
    UnsupportedError: UnsupportedError
  };

  if (typeof module !== "undefined" && module !== null) {
    module.exports = exports;
  }

}).call(this);
