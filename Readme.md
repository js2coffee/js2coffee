# js2coffee-redux

Small attempt at making a new js2coffee.

[![Status](https://travis-ci.org/rstacruz/js2coffee-redux.svg?branch=master)](https://travis-ci.org/rstacruz/js2coffee-redux)  

## Goals

 * ✓ __Use a new JS parser.__
   The new js2coffee is built upon Esprima, which uses the standardized 
   ECMAScript Parser API.

 * __Cleaner repository.__
   [js2coffee/js2coffee] has way too much boilerplate and DocPad-related things 
   in it. There should be no Cakefiles or anything, just package.json.

 * ✓ __Be fully browserify-compatible with minimal cruft.__
   Building a browesrify build is as easy as `browserify -t coffeeify 
   js2coffee.coffee`. Everything will work with minimal fuzz.

 * __More maintainable.__
   Carefully think out the API and the structure of the repository so to 
   minimize boilerplates and dependencies.

## New features in js2coffee-redux

 - __Compatibility warnings.__
   Give warnings for things that may break, such as `==` being converted to 
   `is`.
 
 - ✓ __Source maps.__
   The new js2coffee website will feature a new editor that will allow you to 
   see what each point of the source compiles to.

 - __More configurable options.__
   This will allow you to select if you would like `and` vs `&&`, or `is` vs
   `===`, and so on.

 - ✓ __Better error messages.__
   Error messages now show a preview of the source where errors happen, such as 
   what you'd expect in CoffeeScriptRedux.

These should be made configurable:

 - Toggle implicit returns.
 - Toggle trailing commas in multiline arrays/objects.
 - Specify whether to use `&&` or `and`.

## API?

```js
var result = js2coffee.parse(source, {
  indent: 2
});

result.code   // code string
result.map    // source map
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
