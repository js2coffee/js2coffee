# JS2Coffee
#### A JavaScript to CoffeeScript compiler.

    $ npm install js2coffee

Usage:

    $ js2coffee input_file.js
    $ js2coffee input_file.js > output.js
    $ cat input.js | js2coffee

### Development

Install dependencies:

    $ npm install
    $ npm install glob

Run tests:

    $ cake test

Build the browser version:

    # Uses ruby and the JSMin gem for now;
    # Run this then check dist/js2coffee.min.js

    $ gem install jsmin
    $ cake build

### Acknowledgements

Made possible thanks to the hard work of Js2coffee's dependency projects:

 * [Narcissus](https://github.com/mozilla/narcissus), Mozilla's JavaScript engine
 * [Node Narcissus](https://github.com/kuno/node-narcissus), the Node port of Narcissus
 * [Underscore.js](http://documentcloud.github.com/underscore)

And of course:

 * Jeremy Ashkenas's [CoffeeScript](jashkenas.github.com/coffee-script/)
