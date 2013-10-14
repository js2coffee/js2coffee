# Js2Coffee

[![Check this project's build status on TravisCI](https://secure.travis-ci.org/rstacruz/js2coffee.png?branch=master)](http://travis-ci.org/rstacruz/js2coffee)
[![View this project's NPM page](https://badge.fury.io/js/js2coffee.png)](https://npmjs.org/package/js2coffee)

A JavaScript to [CoffeeScript](http://coffeescript.org/) compiler


## Install

``` bash
npm install -g js2coffee
```


## Usage

``` bash
js2coffee input_file.js
js2coffee input_file.js > output.coffee
cat input.js | js2coffee
```

## API Usage

### build(content, option) ###
- **content** String - javascript source code
- **option** Object - option object
  - **no_comments** Boolean - ignore comments, if true
  - **show_src_lineno** Boolean - show source line numbers in each line as comment, if true
  - **indent** String - specify indent
  - **single_quotes** Boolean - use single quoted string literals instead of double quoted

``` javascript
js2coffee = require('js2coffee');
coffeeContent = js2coffee.build(jstContent, {show_src_lineno: true, indent: "    ");
```

## Development

Install dependencies:

``` bash
npm install
```

To compile and test changes as they happen:

``` bash
npm run-script watch
```

To compile and test manually:

``` bash
npm run-script compile
```

To test manually:

``` bash
npm test
```


## History
[You can discover the history inside the `HISTORY.md` file](https://github.com/rstacruz/js2coffee/blob/master/HISTORY.md#files)


## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright © 2011+ [Rico Sta. Cruz](http://ricostacruz.com) <hi@ricostacruz.com>


## Thanks

Made possible thanks to the hard work of Js2coffee's dependency projects:

- [Narcissus](https://github.com/mozilla/narcissus), Mozilla's JavaScript engine
- [Node Narcissus](https://github.com/kuno/node-narcissus), the Node port of Narcissus
- [Underscore.js](http://documentcloud.github.com/underscore)

And of course:

- Jeremy Ashkenas's [CoffeeScript](http://jashkenas.github.com/coffee-script/)
