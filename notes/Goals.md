# Goals

js2coffee 2.0 (aka js2coffee-redux) aims to have these improvements over the
js2coffee 0.x series:

 * ✓ __Use a new JS parser.__<br>
   The new js2coffee is built upon Esprima, which uses the standardized 
   ECMAScript Parser API.

 * ✓ __Cleaner repository.__<br>
   [js2coffee/js2coffee] has way too much boilerplate and DocPad-related things 
   in it. There should be no Cakefiles or anything, just package.json.

 * ✓ __Be fully browserify-compatible with minimal cruft.__<br>
   Building a browesrify build is as easy as `browserify -t coffeeify .`.  
   Everything will work with minimal fuzz.

 * ✓ __More maintainable.__<br>
   Carefully think out the API and the structure of the repository so to 
   minimize boilerplates and dependencies.

## New features

 - ✓ __Compatibility warnings.__<br>
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

[js2coffee/js2coffee]: https://github.com/js2coffee/js2coffee
