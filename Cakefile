{spawn, exec} = require 'child_process'

# Tasks
task 'test', 'Run tests', ->
  run 'coffee test/test.coffee'

task 'build', 'Builds the browser version', ->
  run 'mkdir -p dist'
  run '( cat lib/narcissus_packed.js; coffee -p lib/js2coffee.coffee ) >dist/js2coffee.js'
  run "cd dist && ruby -e \"require 'jsmin'; File.open('js2coffee.min.js','w') { |f| f.write JSMin.minify(File.read('js2coffee.js')) }\""

# Helpers
run = (cmd, callback, options={}) ->
  console.warn "$ #{cmd}"  unless options.quiet?

  exec cmd, (err, stdout, stderr) ->
    callback()  if typeof callback == 'function'
    console.warn stderr  if stderr
    console.log stdout   if stdout

