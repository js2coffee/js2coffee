# js2coffee-redux

Compiles JavaScript into CoffeeScript. This is a rewrite of js2coffee 0.x,
featuring a better parser ([Esprima]) and better features.

[![](http://js2coffee.github.io/js2coffee-redux/assets/preview.png)](http://js2coffee.github.io/js2coffee-redux)

[![Status](https://travis-ci.org/js2coffee/js2coffee-redux.svg?branch=master)](https://travis-ci.org/js2coffee/js2coffee-redux)  

## Docs

 - [Goals](notes/Goals.md) - outline of the project's goals.

 - [Specs](notes/Specs.md) - examples of how JavaScript compiles to CoffeeScript.

 - [AST format](notes/AST.md) - technical description of the CoffeeScript AST format.

 - [Special cases](notes/Special_cases.md) - a list of edge cases that js2coffee accounts for.

 - [Migration guide](notes/Migration_guide.md) - guide for migrating from 0.x.

## Command line

The command line utility accepts both filenames or stdin.

```sh
$ js2c file.js [file2.js ...]
$ cat file.js | js2c
```

## Programatic API

Available via npm (`require('js2coffee')`), or via CDN in the browser:

> [](#version) `http://cdn.rawgit.com/js2coffee/js2coffee-redux/v0.0.16/dist/js2coffee.js`

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
[js2coffee/js2coffee]: https://github.com/js2coffee/js2coffee
