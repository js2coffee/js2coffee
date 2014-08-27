# js2coffee-redux

Small attempt at making a new js2coffee.

## Goals

 * __Use a new JS parser.__
   This means Esprima or Acorn.

 * __Cleaner repository.__
   [js2coffee/js2coffee] has way too much boilerplate and DocPad-related things 
   in it. There should be no Cakefiles or anything, just package.json.

 * __Be fully browserify-compatible with minimal cruft.__
   It should be possible to simply `browserify -t coffeeify index.js` and have 
   everything work with minimal fuzz.

## Why?

 - Maintainability.
 - More configurable options.
 - Better error messages, supporting line numbers and ranges.
 - Be scope-aware.
 - Be able to produce warnings for things that may break compatibility (such as 
     `==` being converted to `is`).
 - Source maps. Maybe.
 - Maybe ES6 support once CoffeeScript supports it!

These should be made configurable:

 - Turn implicit returns on/off.
 - Specify whether to use `&&` or `and`.

## API?

```js
js2coffee(source, {
  indent: 2
});
```

## How?

 - Still to be written in coffee-script. Just because.
 - Browserify builds should be invoked via `npm prepublish`.
 - Tests are still plain files (`spec/*` with `input.js`+`output.coffee`)
   but invoked with a Mocha test runner. This allows us to reuse the same specs
   as js2coffee almost as-is.
 - The stringifier class should be able to take an AST and produce a string 
 output with source maps.

[js2coffee/js2coffee]: https://github.com/js2coffee/js2coffee

## References

 - http://esprima.org/doc/index.html#ast
 - https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API
