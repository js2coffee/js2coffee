{spawn, exec} = require 'child_process'

# Tasks
task 'test', 'Run tests', ->
  run 'coffee test/test.coffee'

task 'build', 'Builds the browser version', ->
  {pack} = require('packer')
  {readFileSync, writeFileSync} = require('fs')

  run 'mkdir -p dist'
  run '( cat lib/narcissus_packed.js; coffee -p lib/js2coffee.coffee ) >dist/js2coffee.js', {}, quiet: true
  console.log '* dist/js2coffee.js'

  input = readFileSync('dist/js2coffee.js')
  writeFileSync 'dist/js2coffee.min.js', input

  console.log '* dist/js2coffee.min.js'

# Helpers
run = (cmd, callback, options={}) ->
  console.warn "$ #{cmd}"  unless options.quiet?

  exec cmd, (err, stdout, stderr) ->
    callback()  if typeof callback == 'function'
    console.warn stderr  if stderr
    console.log stdout   if stdout

