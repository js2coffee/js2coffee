v0.0.4 - Jun 09, 2011
---------------------

### Changed:
  * Allow single-line JS comments without a newline in the end.
  * Enquote identifiers in object literals as needed. (#16)
  * Ensure that percent interpolation (%i) don't get messed up in the Node version. (#13)
  * Ensure that when anonymous functions are called, they are parenthesized. (#14)

### Added:
  * more tests.

### Fixed:
  * `++b` is now no longer erroneously translated to `b++`.
  * Fixed an issue where `{ off: 2 }` erroneously becomes `{ off_: 2 }`.
  * Returning object literals should now not create invalid CoffeeScript. (#15)

### Misc:
  * Annotate the source code.
  * Make a simpler (but less stringent) JS packing routine for `js2coffee.min.js`.

v0.0.3 - Jun 05, 2011
---------------------

### Fixed:
  * Narcissus to not go into an infinite loop in the browser.
  * Use `this` instead of `@` for better readability. (#10)

### Changed:
  * Implement += and friends. (#9)
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
