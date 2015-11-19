## [v2.1.1] - Nov  19, 2015
- Require coffee-script 1.9.0 to support supports ES6 generators like the 'yield' keyword

## [v2.1.0] - Jul  3, 2015

- [#383] - Update Esprima version. ([@ariya])

[#383]: https://github.com/js2coffee/js2coffee/issues/383
[@ariya]: https://github.com/ariya
[v2.1.0]: https://github.com/js2coffee/js2coffee/compare/v2.0.4...v2.1.0

## [v2.0.4] - May 5, 2015

- Fix `a - (b + c)` incorrectly dropping parentheses ([#373])
- `if (x in y)` now translates to `x of y` instead of `in` ([@snowyu], [#355])
- Fix "Cannot read property 'line' of undefined" errors ([@snowyu], [#356])

## [v2.0.3] - Feb 14, 2015

- Remove 'coffee-script' as hard dependency, just use pre-built distribution ([#351])

## [v2.0.2] - Feb 13, 2015

- Fix nesting division operators (eg: `a / (b * c)`) ([#348])
- Add 'coffee-script' as a hard dependency ([#351])

## [v2.0.1] - February 10, 2015

- Upgrade from `esprima-harmony` to `esprima-fb` v10001.1.0 ([#343])
- Fix multiple unary operators not being spaced properly (eg: `a - - - b`) ([#339])
- Fix nesting subtraction operators (eg: `a - (b - c)`) ([#347])
- Fix nesting ternary operators (eg: `a ? (b ? c : d) e`) ([#345])

## v2.0.0 - February 2, 2015

Full rewrite that features the Esprima parser. This release resolves a lot of issues,
a lot of which are tracked with the ["fixed in 2.0"][fixed] label.

Check the [migration guide](notes/Migration_guide.md) for information on what's
changed from v0 to v2.0.

[fixed]: https://github.com/js2coffee/js2coffee/issues?q=label%3A%22fixed+in+2.0%22+is%3Aclosed

----

v0.3.5 - December 11, 2014
--------------------
- fix complex update statements for issue [#49](https://github.com/js2coffee/js2coffee/issues/49)
- move docpad-eco plugin to dev dependency [#327](https://github.com/js2coffee/js2coffee/issues/327)

v0.3.4 - December 01, 2014
--------------------
- fix missing newline after `throw` [#320](https://github.com/js2coffee/js2coffee/issues/320)
- fix `continue` within loops [#49](https://github.com/js2coffee/js2coffee/issues/49)

v0.3.3 - August 23, 2014
--------------------
- add error handling during conversion

v0.3.2 - August 23, 2014
--------------------
- online editor: fix scrolling for safari
- online editor: [add favicon](https://github.com/js2coffee/js2coffee/issues/274)
- online editor: [fix options usage](https://github.com/js2coffee/js2coffee/issues/296)
- [fix block comments](https://github.com/js2coffee/js2coffee/issues/309)
- [merge 275](https://github.com/js2coffee/js2coffee/pull/275) thanks to [liukun](https://github.com/liukun)
- [merge 276](https://github.com/js2coffee/js2coffee/pull/276) thanks to [liukun](https://github.com/liukun)
- [merge 184](https://github.com/js2coffee/js2coffee/pull/184) thanks to [Carl Fürstenberg](https://github.com/azatoth)
- [fix `x != undefined`](https://github.com/js2coffee/js2coffee/issues/301)
- [fix `for in`](https://github.com/js2coffee/js2coffee/issues/284)
- [fix CLI error code](https://github.com/js2coffee/js2coffee/issues/282)
- [show line numbers in errors](https://github.com/js2coffee/js2coffee/issues/158)

v0.3.1 - July 11, 2014
--------------------
- Update dependencies
- Fixed DocPad always being installed (only needed for dev)


v0.3.0 - May 17, 2014
--------------------
- Updated for CoffeeScript ~1.7.1 from ~1.6.3
- Browserify build no longer includes the entire `package.json` file
  - It was only used for the version number, which is now inserted automatically via our build script

v0.2.7 - Februrary 7, 2014
--------------------
- fix [merge [#233] swtich with >2 cases](https://github.com/js2coffee/js2coffee/pull/233)
thanks to [Tomasz Szatkowski](https://github.com/szatkus)

v0.2.6 - January 31, 2014
--------------------
- fix [fix [#252] install fails on unbutu](https://github.com/js2coffee/js2coffee/issues/252)

v0.2.5 - January 20, 2014
--------------------
- merged [Add implicit returns (mostly fixes [#48])](https://github.com/rstacruz/js2coffee/pull/168) thanks to [Dave Burt](https://github.com/dburt)

v0.2.4 - January 03, 2014
--------------------
- merged [fixes [#240]: treat unrecognised extensions as JS; support JSON](https://github.com/rstacruz/js2coffee/issues/241) thanks to [Michael Ficarra](https://github.com/michaelficarra)
- merged [Fix incorrect translation of unbracketed then/else (fixes [#141], [#182])](https://github.com/rstacruz/js2coffee/issues/226) fixes also [#108](https://github.com/rstacruz/js2coffee/issues/108) - thanks to [@nateschiffer](https://github.com/nateschiffer)
- merged [Parenthesize function expressions that are part of member expressions](https://github.com/rstacruz/js2coffee/issues/155) fixed [#222](https://github.com/rstacruz/js2coffee/issues/222), [#135](https://github.com/rstacruz/js2coffee/issues/135), [#55](https://github.com/rstacruz/js2coffee/issues/55), [#177](https://github.com/rstacruz/js2coffee/issues/177) thanks to [@karlbohlmark](https://github.com/karlbohlmark)
- merged [Support empty for loops. Closes [#116].](https://github.com/rstacruz/js2coffee/issues/120) thanks to [Ryunosuke Sato](https://github.com/tricknotes)

v0.2.3 - October 19, 2013
--------------------
- fixed nopt issue [issue #231](https://github.com/rstacruz/js2coffee/issues/231)

v0.2.2 - October 14, 2013
--------------------
- Replace option parser with nopt
  - add CLI option for indent [issue #143](https://github.com/rstacruz/js2coffee/issues/143)
  - add CLI option for single quoted string literals
  - use ansidiff in tests for colored assertion errors
  - you can pass build options as a JSON comment in test files:  
    `// OPTIONS:{"single_quotes":true}`

v0.2.0 - September 26, 2013
--------------------

- Nested objects and arrays are now easier to read
  - Thanks to [Anton Wilhelm](https://github.com/timaschew) for [issue #224](https://github.com/rstacruz/js2coffee/issues/224) and [pull request #227](https://github.com/rstacruz/js2coffee/pull/227)


v0.1.4 - June 7, 2013
--------------------

Thanks to [@balupton], [@tsantef], [@ForbesLindesay]

- [Fixed CoffeeScript version problems](https://github.com/rstacruz/js2coffee/issues/189)
  - [Use only compatible coffee-script version](https://github.com/rstacruz/js2coffee/pull/196)
  - [Defines RESERVED words if not defined](https://github.com/rstacruz/js2coffee/pull/194)
  - Rewrote to only use local coffee-script installation, rather than using global installation
- [Fixed global leak](https://github.com/rstacruz/js2coffee/pull/174)
- Tests now use the [Joe Test Runner](https://github.com/bevry/joe), instead of using nothing before
- Watched, compiled, bundled, and automatically tested with [DocPad](http://docpad.org/)
- Added [TravisCI](https://travis-ci.org/) support


v0.1.3 - January 6, 2012
--------------------

Small "emergency" bugfixes, thanks [@tricknotes].

### Fixed:
 * Exit when compilation completes in Node 0.6. ([#112])
 * Fix typo in the help text when typing `js2coffee`. ([#113])


v0.1.2 - October 15, 2011
---------------------

Thanks to [@Wisdom], [@nilbus], [@joelvh], [@gabipurcaru], [@michaelficarra], [@tricknotes],
[@eventualbuddha], [@clkao] for the contributions.

### Fixed:
  * Fix misspelling in package.json.
  * Object lookups using object literals (`o[{a:1, b:2}]`) are now supported.
  * Fixed `js2coffee file.js` not working in Linux. ([#90], [#54])
  * Returning from an if without curly braces are now supported. (`if (x) return
      y;`)) ([#50])
  * Returning object literals should now have the objects parenthesized
    properly.  ( `return {x:1, y:2}`) ([#52])
  * Always new-line objects to support `{ a: { b: c } }`. ([#96], [#94])
  * Reserved words are now allowed as property accessors. Fixes
    `object.on(...)`. ([#97], [#95], [#75])
  * Empty switch cases now get compiled correctly. ([#70], [#28])
  * The value `undefined` now gets compiled properly. ([#20], [#85])
  * Declaring `var x` will now translate to `x = undefined`. ([#79])
  * Updated reserved keywords list. ([#25], [#67])

### Changed:
  * Compile `!!` into `!!` instead of `not not`. ([#30])
  * Implement CRLF support. Closes ([#81], [#88])
  * `!!!x` now condenses to `not x`.
  * `==` and `===` now become `is`. ([#29])
  * `!(a instanceof b)` now becomes `a not instanceof b`. ([#29])
  * Doing `var x = y` will now have different behavior for reserved keywords.
    ([#79])

### Misc changes:
  * Fixed bad link in README. ([#63])
  * Make `npm test` run tests.
  * Running tests now shows less output.
  * Running tests now exits with an error code when it fails.


v0.1.1 - July 09, 2011
---------------------

### Fixed:
  * Invert the 'a == null' behavior. ([#19], [#51])
  * Fix the problem where passing an anonymous function as a parameter can
    sometimes lead to syntax errors. ([#55])


v0.1.0 - June 13, 2011
---------------------

Lots of refactoring and new improvements.

### Added:
  * Single line ifs. `if (x) continue;` will now compile to `continue if x`.
  * Hide empty catches. ([#32]).
    * `try { .. } catch (f) {}` now becomes `try ..` without a catch.
  * Omit returns more agressively. ([#42])
  * Omit many unneeded parentheses in certain cases. ([#31])

### Fixed:
  * Fix `x.prototype.y` to be `x::y` instead of `x::.y` ([#24])
  * The `in` operator now compiles to `of`. ([#46])
    * `a in b` now compiles to `a of b`.
  * Fix floating point numbers. ([#45])
  * Fix a problem with returning object literals. ([#47])

### Refactoring:
  * Lots and lots of refactoring.
  * `Builder` is now a class (to support warnings in the future, and more).
  * Implement a new `Transformer` class to do AST transformations before building the compiled source.
  * Recursive functions now use `Node::walk()`.
  * Move stuff into `js2coffee/helpers.coffee` and `js2coffee/node_ext.coffee`.


v0.0.5 - June 10, 2011
---------------------

Special thanks to [Michael Ficarra](http://github.com/michaelficarra) for agressively
reporting issues and suggesting numerous improvements.

### Added:
  * Account for negative existence checks (`if !x?`). ([#19])
    * Compile `if (x != null)` to `unless x?`
    * Compile `if (x === null)` to `if x?`
  * Ensure object literals with more than one property get surrounded by `({ .. })`. ([#8])
  * Support `debugger`. ([#27])
  * Support destructuring in functions. ([#17])
  * Use `loop` instead of `while true` in while and for loops. ([#35])
  * Use the `::` prototype operator. ([#24])
  * Use `unless` and `until` as the inverse of `if` and `while` respectively. ([#35])

### Fixed:
  * Keys in object literals now get quoted if needed. This fixes the erroneous
    compilation of objects such as `{ 'click #button': function() { ... } }`.


v0.0.4 - June 09, 2011
---------------------

### Changed:
  * Allow single-line JS comments without a newline in the end.
  * Enquote identifiers in object literals as needed. ([#16])
  * Ensure that percent interpolation (%i) don't get messed up in the Node version. ([#13])
  * Ensure that when anonymous functions are called, they are parenthesized. ([#14])

### Added:
  * more tests.

### Fixed:
  * `++b` is now no longer erroneously translated to `b++`.
  * Fixed an issue where `{ off: 2 }` erroneously becomes `{ off_: 2 }`.
  * Returning object literals should now not create invalid CoffeeScript. ([#15])

### Misc:
  * Annotate the source code.
  * Make a simpler (but less stringent) JS packing routine for `js2coffee.min.js`.


v0.0.3 - June 05, 2011
---------------------

### Fixed:
  * Narcissus to not go into an infinite loop in the browser.
  * Use `this` instead of `@` for better readability. ([#10])

### Changed:
  * Implement += and friends. ([#9])
  * Use 'cake' instead of 'make'.


v0.0.2 - June 4, 2011
---------------------

### Changed:
  * Better string escaping
  * Better handling of empty blocks
  * Support for commas (eg: `a = 2, b = 3`)
  * Returns and breaks are omitted when not needed
  * Switch/case now uses `switch` instead of `if`
  * Some other improvements


v0.0.1
------

Initial version.

[#373]: https://github.com/js2coffee/js2coffee/issues/373
[#351]: https://github.com/js2coffee/js2coffee/issues/351
[#348]: https://github.com/js2coffee/js2coffee/issues/348
[#343]: https://github.com/js2coffee/js2coffee/issues/343
[#339]: https://github.com/js2coffee/js2coffee/issues/339
[#347]: https://github.com/js2coffee/js2coffee/issues/347
[#345]: https://github.com/js2coffee/js2coffee/issues/345
[#233]: https://github.com/js2coffee/js2coffee/issues/233
[#252]: https://github.com/js2coffee/js2coffee/issues/252
[#48]: https://github.com/js2coffee/js2coffee/issues/48
[#240]: https://github.com/js2coffee/js2coffee/issues/240
[#141]: https://github.com/js2coffee/js2coffee/issues/141
[#182]: https://github.com/js2coffee/js2coffee/issues/182
[#116]: https://github.com/js2coffee/js2coffee/issues/116
[#112]: https://github.com/js2coffee/js2coffee/issues/112
[#113]: https://github.com/js2coffee/js2coffee/issues/113
[#90]: https://github.com/js2coffee/js2coffee/issues/90
[#54]: https://github.com/js2coffee/js2coffee/issues/54
[#50]: https://github.com/js2coffee/js2coffee/issues/50
[#52]: https://github.com/js2coffee/js2coffee/issues/52
[#96]: https://github.com/js2coffee/js2coffee/issues/96
[#94]: https://github.com/js2coffee/js2coffee/issues/94
[#97]: https://github.com/js2coffee/js2coffee/issues/97
[#95]: https://github.com/js2coffee/js2coffee/issues/95
[#75]: https://github.com/js2coffee/js2coffee/issues/75
[#70]: https://github.com/js2coffee/js2coffee/issues/70
[#28]: https://github.com/js2coffee/js2coffee/issues/28
[#20]: https://github.com/js2coffee/js2coffee/issues/20
[#85]: https://github.com/js2coffee/js2coffee/issues/85
[#79]: https://github.com/js2coffee/js2coffee/issues/79
[#25]: https://github.com/js2coffee/js2coffee/issues/25
[#67]: https://github.com/js2coffee/js2coffee/issues/67
[#30]: https://github.com/js2coffee/js2coffee/issues/30
[#81]: https://github.com/js2coffee/js2coffee/issues/81
[#88]: https://github.com/js2coffee/js2coffee/issues/88
[#29]: https://github.com/js2coffee/js2coffee/issues/29
[#63]: https://github.com/js2coffee/js2coffee/issues/63
[#19]: https://github.com/js2coffee/js2coffee/issues/19
[#51]: https://github.com/js2coffee/js2coffee/issues/51
[#55]: https://github.com/js2coffee/js2coffee/issues/55
[#32]: https://github.com/js2coffee/js2coffee/issues/32
[#42]: https://github.com/js2coffee/js2coffee/issues/42
[#31]: https://github.com/js2coffee/js2coffee/issues/31
[#24]: https://github.com/js2coffee/js2coffee/issues/24
[#46]: https://github.com/js2coffee/js2coffee/issues/46
[#45]: https://github.com/js2coffee/js2coffee/issues/45
[#47]: https://github.com/js2coffee/js2coffee/issues/47
[#8]: https://github.com/js2coffee/js2coffee/issues/8
[#27]: https://github.com/js2coffee/js2coffee/issues/27
[#17]: https://github.com/js2coffee/js2coffee/issues/17
[#35]: https://github.com/js2coffee/js2coffee/issues/35
[#16]: https://github.com/js2coffee/js2coffee/issues/16
[#13]: https://github.com/js2coffee/js2coffee/issues/13
[#14]: https://github.com/js2coffee/js2coffee/issues/14
[#15]: https://github.com/js2coffee/js2coffee/issues/15
[#10]: https://github.com/js2coffee/js2coffee/issues/10
[#9]: https://github.com/js2coffee/js2coffee/issues/9
[@balupton]: https://github.com/balupton
[@tsantef]: https://github.com/tsantef
[@ForbesLindesay]: https://github.com/ForbesLindesay
[@tricknotes]: https://github.com/tricknotes
[@Wisdom]: https://github.com/Wisdom
[@nilbus]: https://github.com/nilbus
[@joelvh]: https://github.com/joelvh
[@gabipurcaru]: https://github.com/gabipurcaru
[@michaelficarra]: https://github.com/michaelficarra
[@eventualbuddha]: https://github.com/eventualbuddha
[@clkao]: https://github.com/clkao
[v2.0.4]: https://github.com/js2coffee/js2coffee/compare/v2.0.3...v2.0.4
[v2.0.3]: https://github.com/js2coffee/js2coffee/compare/v2.0.2...v2.0.3
[v2.0.2]: https://github.com/js2coffee/js2coffee/compare/v2.0.1...v2.0.2
[v2.0.1]: https://github.com/js2coffee/js2coffee/compare/v2.0.0...v2.0.1
[#355]: https://github.com/js2coffee/js2coffee/issues/355
[#356]: https://github.com/js2coffee/js2coffee/issues/356
[@snowyu]: https://github.com/snowyu
