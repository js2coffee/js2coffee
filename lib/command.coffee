js2coffee = require('./js2coffee')
_  = require('underscore')
fs = require('fs')

run = ->
  files = process.argv.slice(2)
  _.each files, (file) ->
    contents = fs.readFileSync(file, 'utf-8')
    output   = js2coffee.build(contents)
    console.log output

run()

