# <img src="http://js2.coffee/assets/logo-white.svg" width="250">

Compile JavaScript into CoffeeScript.

[![](http://js2.coffee/assets/screenshots/js2coffee.png)](http://js2.coffee)

[![Status](https://travis-ci.org/js2coffee/js2coffee.svg?branch=master)](https://travis-ci.org/js2coffee/js2coffee)  

This 2.0 release is a complete rewrite featuring a better parser ([Esprima]).
See **[what's new in 2.0](notes/New_in_2.0.md)** for an overview of new features
and consult the [migration guide](notes/Migration_guide.md) for info on
updating from 0.x.

<br>

## Install

Available on npm and bower.

```sh
npm install --global js2coffee
js2coffee --help
```

[![npm version](http://img.shields.io/npm/v/js2coffee.svg?style=flat)](https://npmjs.org/package/js2coffee "View this project on npm")

Also available via CDN (`window.js2coffee`):

> [](#version) `http://cdn.rawgit.com/js2coffee/js2coffee/v2.0.3/dist/js2coffee.js`

<br>

## Command line

The command line utility accepts both filenames or stdin.

```sh
$ js2coffee file.js [file2.js ...]
$ cat file.js | js2coffee
```

<br>

## JavaScript API

Available via npm (`require('js2coffee')`), or via CDN in the browser (as `window.js2coffee`):

```js
result = js2coffee.build(source);

result.code     // code string
result.ast      // transformed AST
result.map      // source map
result.warnings // array of warnings
```

Errors are in this format:

```js
catch (e) {
  e.message       // "index.js:3:1: Unexpected INDENT\n\n   3   var\n   ---^"
  e.description   // "Unexpected INDENT"
  e.start         // { line: 1, column: 4 }
  e.end           // { line: 1, column: 10 }
  e.sourcePreview // '...'
}
```

Warnings are in this format:

```js
result.warnings.forEach((warn) => {
  warn.description   // "Variable 'x' defined twice
  warn.start         // { line: 1, column: 4 }
  warn.end           // { line: 1, column: 9 }
  warn.filename      // "index.js"
})
```

<br>

## Docs

 - [Migration guide](notes/Migration_guide.md) - guide for migrating from 0.x.

 - [Hacking guide](notes/Hacking.md) - want to contribute? here are tips to get you started.

 - [AST format](notes/AST.md) - technical description of the CoffeeScript AST format.

 - [Special cases](notes/Special_cases.md) - a list of edge cases that js2coffee accounts for.

 - [Compatibility mode](notes/Special_cases.md#compatibilitymode) - list of tweaks that compatibility mode (`--compat`) addresses.

 - [Goals](notes/Goals.md) - outline of the project's goals.

 - [Specs](notes/Specs.md) - examples of how JavaScript compiles to CoffeeScript.

<br>

## Thanks

**js2coffee** © 2012+, Rico Sta. Cruz. Released under the [MIT] License.<br>
Authored by Rico Sta. Cruz with help from co-maintainers and contributors ([list][contributors]).

Maintainers:

 * Rico Sta. Cruz ([@rstacruz](https://github.com/rstacruz)) —
   [ricostacruz.com](http://ricostacruz.com) · twitter [@rstacruz](https://twitter.com/rstacruz)

 * Anton Wilhelm ([@timaschew](https://github.com/timaschew)) — twitter [@timaschew](https://twitter.com/timaschew)

 * Benjamin Lupton ([@balupton](https://github.com/balupton)) —
   [balupton.com](http://balupton.com) · twitter [@balupton](https://twitter.com/balupton)

[MIT]: http://mit-license.org/
[contributors]: http://github.com/rstacruz/js2coffee/contributors
[Esprima]: http://esprima.org/
