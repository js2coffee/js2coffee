### js2coffee-redux

Small attempt at making a new js2coffee.

#### Goals:

 * Use a new JS parser.<br>
   This means Esprima or Acorn.

 * Cleaner repository.<br>
   [js2coffee/js2coffee] has way too much boilerplate and DocPad-related things 
   in it. There should be no Cakefiles or anything, just package.json.

 * Be fully browserify-compatible with minimal cruft.<br>
   It should be possible to simply `browserify -t coffeeify index.js` and have 
   everything work with minimal fuzz.

[js2coffee/js2coffee]: https://github.com/js2coffee/js2coffee

