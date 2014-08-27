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
 - More configurable options (like tabs, comment styles, turning off features, 
     and so on).
 - Better warnings and errors.
 - Source maps... maybe.
 - Maybe ES6 support once CoffeeScript supports it!

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

[js2coffee/js2coffee]: https://github.com/js2coffee/js2coffee

