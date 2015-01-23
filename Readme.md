# js2coffee-redux

Small attempt at making a new js2coffee.

[![Status](https://travis-ci.org/js2coffee/js2coffee-redux.svg?branch=master)](https://travis-ci.org/js2coffee/js2coffee-redux)  

## Goals

 * ✓ __Use a new JS parser.__<br>
   The new js2coffee is built upon Esprima, which uses the standardized 
   ECMAScript Parser API.

 * __Cleaner repository.__<br>
   [js2coffee/js2coffee] has way too much boilerplate and DocPad-related things 
   in it. There should be no Cakefiles or anything, just package.json.

 * ✓ __Be fully browserify-compatible with minimal cruft.__<br>
   Building a browesrify build is as easy as `browserify -t coffeeify .`.  
   Everything will work with minimal fuzz.

 * __More maintainable.__<br>
   Carefully think out the API and the structure of the repository so to 
   minimize boilerplates and dependencies.

## New features in js2coffee-redux

 - __Compatibility warnings.__<br>
   Give warnings for things that may break, such as `==` being converted to 
   `is`.
 
 - ✓ __Source maps.__<br>
   The new js2coffee website will feature a new editor that will allow you to 
   see what each point of the source compiles to.

 - __More configurable options.__<br>
   This will allow you to select if you would like `and` vs `&&`, or `is` vs
   `===`, and so on.

 - ✓ __Better error messages.__<br>
   Error messages now show a preview of the source where errors happen, such as 
   what you'd expect in CoffeeScriptRedux.

## Docs

 - [Specs](notes/Specs.md) - examples of how JavaScript compiles to CoffeeScript.

 - [AST format](notes/AST.md) - technical description of the CoffeeScript AST format.

 - [Special cases](notes/Special_cases.md) - a list of edge cases that js2coffee accounts for.

## Command line

The command line utility accepts both filenames or stdin.

```sh
$ js2c file.js [file2.js ...]
$ ... | js2c
```

## API

```js
try {
  result = js2coffee.build(source);

  result.code     // code string
  result.ast      // transformed AST
  result.map      // source map

} catch (e) {

  e.message       // "index.js:3:1: Unexpected INDENT\n\n   3   var\n   ---^"
  e.description   // "Unexpected INDENT"
  e.lineNumber    // 3
  e.column        // 1
  e.sourcePreview // '...'

}
```

## How?

 - Still to be written in coffee-script. Just because.
 - Browserify builds should be invoked via `npm prepublish`.
 - Tests are still plain files (`spec/*` with `input.js`+`output.coffee`)
   but invoked with a Mocha test runner. This allows us to reuse the same specs
   as js2coffee almost as-is.
 - The stringifier class should be able to take an AST and produce a string 
 output with source maps.

## Intentional deviations

Some differences from legacy js2coffee are to be intended:

 - Postfix `if` statements will not be supported by default
 - ...

[js2coffee/js2coffee]: https://github.com/js2coffee/js2coffee

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
