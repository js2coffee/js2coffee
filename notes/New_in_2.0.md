# What's new in 2.0

**[Js2coffee] 2.0** is a complete rewrite of js2coffee v0.3 started in 2014. It was
released February 1, 2015 and features a new parser, [Esprima], replacing the
aging Narcissus build that has been in use since 2011.

## New features

## Warnings and errors

![](http://js2.coffee/assets/screenshots/warnings.png)

Constructs that are not available in CoffeeScript are marked with errors, such as:

 * Reassignment of global variables
 * `==` and `!=` operators
 * Variable shadowing

See this
[demo](http://js2.coffee/#try:alert%28function%20namedExpr%28%29{}%29%3B%0A%0Afunction%20fn%28%29%20{%0A%20%20if%20%28a%20%3D%3D%20b%29%20{%0A%20%20%20%20a%20%3D%20false%3B%0A%20%20}%0A})
for a few more.

### Compatibility mode

Js2coffee now features a *compatibility mode* (`--compat`) to improve
reliability over generated CoffeeScript code (at the slight expense of elegance).
see the [Compatibility mode] documentation.

Try this
[demo](http://js2.coffee/#try:alert%28function%20cube%28n%29{%0A%20%20return%20Math.pow%28n%2C%203%29%3B%0A}%29%3B)
— toggle the *compatibility mode* checkbox and see what happens.

### Tons of bugfixes

The 2.0 release closes a [lot of bugs][issues], including:

 * `npm install js2coffee` not working ([#324])
 * Empty if statements fail ([#265])
 * Variable scoping issues ([#219])
 * and many [more][issues]

## New web editor

![](http://js2.coffee/assets/screenshots/js2coffee.png)

The editor has been rebuilt and redesigned. It now features a new easy-to-use
editor based on [CodeMirror].

It also now lives in a new URL, [js2.coffee](http://js2.coffee), migrating away
from the old `js2coffee.org`.

### Linking and sharing

![](http://js2.coffee/assets/screenshots/linking.png)

You can show share your JavaScript and CoffeeScript snippets—perfect for
collaborating with coworkers or answering at StackOverflow.

[Esprima]: http://esprima.org/
[CodeMirror]: http://codemirror.net/
[issues]: https://github.com/js2coffee/js2coffee/issues?q=label%3A%22fixed+in+2.0%22+is%3Aclosed
[Js2coffee]: http://js2.coffee/
[Compatibility mode]: https://github.com/js2coffee/js2coffee/blob/master/notes/Special_cases.md#compatibilitymode
[#324]: https://github.com/js2coffee/js2coffee/issues/324
[#265]: https://github.com/js2coffee/js2coffee/issues/265
[#219]: https://github.com/js2coffee/js2coffee/issues/219
