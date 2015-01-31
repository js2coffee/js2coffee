## v0.0.17

* Documentation
* Fix indentation of closing parenthesis
* Add global variable assignment warnings
* Escape global variable assignments in compat mode

## v0.0.16 - January 31, 2015

* Add spaces around block comments
* Implement `--indent`
* Support empty array slots (`[,0]`)

## v0.0.15 - January 27, 2015

* Transform `undefined` in compatibility mode
* Add more reserved keywords
* Handle blank ifs (`if (x){}`)
* Escape fuctions in tests (`if (function(){}){}`)

## v0.0.14 - January 27, 2015

* Implement `--compat` compatibility mode
* Escape `==` on compatibility mode
* Implement function defaults (`function x(a=b){}`)

## v0.0.13 - January 26, 2015

* Implement exponents (`Math.pow(a,b)` => `a ** b`)
* Implement IIFEs (`(function(){k})()` => `do -> k`)

## v0.0.12 - January 25, 2015

* Fix `continue` inside a switch case

## v0.0.11 - January 25, 2015

* Fix `continue` in `for` loop without initializer

## v0.0.10 - January 25, 2015

* Warn in `for..in` loops without var
* Fix `continue` inside `for` loops with update statements (#4)
* Big refactors
* Refactor some looping stuff
* Update estraverse

## v0.0.9 - January 24, 2015

Pre-release update (better esprima.parse error reporting).

## v0.0.8 - January 24, 2015

Pre-release update (reserved keywords).

## v0.0.7 - January 24, 2015

Pre-release update (improved comments support).

## v0.0.6 - January 24, 2015

Pre-release update (more warnings).

## v0.0.5 - January 24, 2015

Pre-release update (warnings support).

## v0.0.4 - January 23, 2015

Pre-release update (improve errors).

## v0.0.3 - January 23, 2015

Pre-release update (add `js2coffee.version`).

## v0.0.2 - January 23, 2015

Pre-release update (implement more edge cases).

## v0.0.1 - January 23, 2015

Initial release.

