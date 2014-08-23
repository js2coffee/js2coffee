# js2coffee

<!-- BADGES/ -->

[![Build Status](http://img.shields.io/travis-ci/js2coffee/js2coffee.png?branch=master)](http://travis-ci.org/js2coffee/js2coffee "Check this project's build status on TravisCI")
[![NPM version](http://badge.fury.io/js/js2coffee.png)](https://npmjs.org/package/js2coffee "View this project on NPM")
[![Dependency Status](https://david-dm.org/js2coffee/js2coffee.png?theme=shields.io)](https://david-dm.org/js2coffee/js2coffee)
[![Development Dependency Status](https://david-dm.org/js2coffee/js2coffee/dev-status.png?theme=shields.io)](https://david-dm.org/js2coffee/js2coffee#info=devDependencies)<br/>

<!-- /BADGES -->


A JavaScript to [CoffeeScript](http://coffeescript.org/) compiler


<!-- INSTALL/ -->

## Install

### [NPM](http://npmjs.org/)
- Use: `require('js2coffee')`
- Install: `npm install --save js2coffee`

### [Browserify](http://browserify.org/)
- Use: `require('js2coffee')`
- Install: `npm install --save js2coffee`
- CDN URL: `//wzrd.in/bundle/js2coffee@0.3.1`

### [Ender](http://ender.jit.su/)
- Use: `require('js2coffee')`
- Install: `ender add js2coffee`

<!-- /INSTALL -->


### Command Line Interface
- Install: `npm install -g js2coffee`


## Usage

### CLI

- Use:

	``` bash
	js2coffee input_file.js
	js2coffee input_file.js > output.coffee
	cat input.js | js2coffee
	```

	You can pass some options:

	``` bash
	--version           # Show js2coffee version
	--verbose           # Be verbose
	--no_comments       # Do not translate comments
	--show_src_lineno   # Show src lineno's as comments
	--single_quotes     # Use single quoted string literals - default double quoted
	--help              # If you need help
	--indent            # Specify the indent character(s) - default 2 spaces
	```


### API

``` javascript
js2coffee = require('js2coffee');
coffeeContent = js2coffee.build(jstContent, {show_src_lineno: true, indent: "    "});
```

- `require('js2coffee').build(content, options)`, arguments:
	- **content** String - javascript source code
	- **options** Object - options object, available options:
		- **no_comments** Boolean - ignore comments, if true
		- **show_src_lineno** Boolean - show source line numbers in each line as comment, if true
		- **indent** String - specify indent
		- **single_quotes** Boolean - use single quoted string literals instead of double quoted

## Known issues

Js2coffee has some kown issues

- switch statements have always implict returns at the end of a function - [#250](https://github.com/rstacruz/js2coffee/pull/250)
- some switch statements fail - [switch](https://github.com/rstacruz/js2coffee/issues?direction=desc&labels=switch-case&page=1&sort=updated&state=open)
- CoffeeScript keywords become converted with an trailing underscore - [keywords](https://github.com/rstacruz/js2coffee/issues?direction=desc&labels=keywords&page=1&sort=updated&state=open)
- Narcissus fails to parse JavaScript keywords as object properties - [narcissus](https://github.com/rstacruz/js2coffee/issues?direction=desc&labels=narcissus&page=1&sort=updated&state=open)
- some IIFE syntaxes fail - [#190](https://github.com/rstacruz/js2coffee/issues/190) 
- Empty function declrations within if statements fail - [#162](https://github.com/rstacruz/js2coffee/issues/162)


## Try out in the browser
[js2coffee.org](http://js2coffee.org)  
You can swtich the mode (JS -> Coffee and Coffee -> JS) at the top in the center.


<!-- HISTORY/ -->

## History
[Discover the change history by heading on over to the `HISTORY.md` file.](https://github.com/js2coffee/js2coffee/blob/master/HISTORY.md#files)

<!-- /HISTORY -->


<!-- CONTRIBUTE/ -->

## Contribute

[Discover how you can contribute by heading on over to the `CONTRIBUTING.md` file.](https://github.com/js2coffee/js2coffee/blob/master/CONTRIBUTING.md#files)

<!-- /CONTRIBUTE -->


<!-- BACKERS/ -->

## Backers

### Maintainers

These amazing people are maintaining this project:

- Rico Sta. Cruz <hi@ricostacruz.com> (http://ricostacruz.com)
- Benjamin Lupton <b@lupton.cc> (https://github.com/balupton)
- Anton Wilhelm <timaschew@gmail.com> (https://github.com/timaschew)

### Sponsors

No sponsors yet! Will you be the first?

### Contributors

These amazing people have contributed code to this project:

- [Anton Wilhelm](https://github.com/timaschew) <timaschew@gmail.com> — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=timaschew)
- [Benjamin Lupton](https://github.com/balupton) <b@lupton.cc> — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=balupton)
- [clkao](https://github.com/clkao) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=clkao)
- [codelahoma](https://github.com/codelahoma) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=codelahoma)
- [dburt](https://github.com/dburt) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=dburt)
- [ForbesLindesay](https://github.com/ForbesLindesay) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=ForbesLindesay)
- [gabipurcaru](https://github.com/gabipurcaru) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=gabipurcaru)
- [grandquista](https://github.com/grandquista) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=grandquista)
- [joelvh](https://github.com/joelvh) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=joelvh)
- [karlbohlmark](https://github.com/karlbohlmark) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=karlbohlmark)
- [MichaelBlume](https://github.com/MichaelBlume) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=MichaelBlume)
- [michaelficarra](https://github.com/michaelficarra) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=michaelficarra)
- [MissingHandle](https://github.com/MissingHandle) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=MissingHandle)
- [nateschiffer](https://github.com/nateschiffer) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=nateschiffer)
- [nilbus](https://github.com/nilbus) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=nilbus)
- [rstacruz](https://github.com/rstacruz) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=rstacruz)
- [thoka](https://github.com/thoka) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=thoka)
- [tricknotes](https://github.com/tricknotes) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=tricknotes)
- [tsantef](https://github.com/tsantef) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=tsantef)
- [twilson63](https://github.com/twilson63) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=twilson63)
- [wlaurance](https://github.com/wlaurance) — [view contributions](https://github.com/js2coffee/js2coffee/commits?author=wlaurance)

[Become a contributor!](https://github.com/js2coffee/js2coffee/blob/master/CONTRIBUTING.md#files)

<!-- /BACKERS -->


<!-- LICENSE/ -->

## License

Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT license](http://creativecommons.org/licenses/MIT/)

Copyright &copy; 2011+ Rico Sta. Cruz <hi@ricostacruz.com> (http://ricostacruz.com)

<!-- /LICENSE -->


## Thanks

Made possible thanks to the hard work of Js2coffee's dependency projects:

- [Narcissus](https://github.com/mozilla/narcissus), Mozilla's JavaScript engine
- [Node Narcissus](https://github.com/kuno/node-narcissus), the Node port of Narcissus
- [Underscore.js](http://documentcloud.github.com/underscore)

And of course:

- Jeremy Ashkenas's [CoffeeScript](http://jashkenas.github.com/coffee-script/)
