js2c = require('../lib/js2coffee')
glob = require('glob').globSync or require('glob').sync
fs = require('fs')
_ = require('underscore')
joe = require('joe')
assert = require('assert')

build = js2c.build

files = glob(__dirname+'/features/*.js')

joe.suite 'js2coffee', (suite,test) ->
  _.each files, (f) ->
    test f, ->
      input = fs.readFileSync(f).toString().trim()
      output = build(input,no_comments:true).trim()
      expected = fs.readFileSync(f.replace('.js', '.coffee')).toString().trim()

      assert.equal(output, expected)
