## Setting up a local instance

All you need is Node.js.

```sh
git clone https://github.com/js2coffee/js2coffee
cd js2coffee
npm install
```

## Running tests

Once you start hacking, periodically run tests.

    npm test

If you want to run pending specs as well:

    ALL=1 npm test

If you'd like to isolate a spec, edit the spec file to add `only: true`:

    # specs/xxx/yyy.txt
    only: true
    ---
    x()
    ---
    x()

## Building distribution

The file `dist/js2coffee.js` is automatically built. Use `make` to build it.

    make

It is also ran as a pre-publish hook.

## New versions

    vim History.md
    bump *.json Readme.md
    npm publish && git release v0.1.2

## References

- [Esprima docs]
- [Parser API spec]
- [Esprima demo]

[Esprima docs]: http://esprima.org/doc/index.html#ast
[Parser API spec]: https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API
[Esprima demo]: http://esprima.org/demo/parse.html# 

# How it works

Check out comments in `js2coffee.js` for an overiew.

## Builder

To be documented, but see `lib/builder/base.coffee`.

## Transformations

To be documented, but see `lib/transformers/base.coffee`.
