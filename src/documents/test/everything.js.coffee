js2c = require('../lib/js2coffee')
glob = require('glob').globSync or require('glob').sync
fs = require('fs')
_ = require('underscore')
joe = require('joe')
assert = require('assert')
ansidiff = require('ansidiff')

build = js2c.build

files = glob(__dirname+'/features/*.js')

joe.suite 'js2coffee', (suite,test) ->
  _.each files, (f) ->
    test f, ->

      ###
        to pass build options for you test, your first line should look like this:
        // OPTIONS: {"single_quotes": true}
      ###

      # default options
      options = {no_comments: true}
      optionsPattern = /^\/\/\s*OPTIONS:\s*(.*)/
      input = fs.readFileSync(f).toString().trim()
      matches = input.match optionsPattern
      if matches?
        try
          opts = JSON.parse(matches[1])
          _(options).extend opts # merge default options to parsed opts
        catch err
          console.error "Could not parse options for test file: #{f}"
          console.error err.message
          throw err

      output = build(input, options).trim()
      expected = fs.readFileSync(f.replace('.js', '.coffee')).toString().trim()

      if output isnt expected
        # show colored diff
        console.error ansidiff.lines output, expected

      assert.equal(output, expected)
