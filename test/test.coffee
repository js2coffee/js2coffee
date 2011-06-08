js2c  = require('../lib/js2coffee')
glob  = require('glob').globSync
fs    = require('fs')
_     = require('underscore')

build = js2c.build

files = glob('./test/features/*.js')
tests = {}


quote = (str) ->
  char = "     | "
  char + str.replace(/\n/g, "\n#{char}")

_.each files, (f) ->
  tests[f] = ->
    input   = fs.readFileSync(f).toString().trim()
    output  = build(input).trim()
    control = fs.readFileSync(f.replace('.js', '.coffee')).toString().trim()

    if output == control
      true
    else
      console.log "     Output:"
      console.log quote(output)
      console.log "     Expected:"
      console.log quote(control)
      false

_.each tests, (test, name) ->
  try
    result = test()
    if result
      console.log "[ OK ] #{name}"
    else
      console.log "[FAIL] #{name}"

  catch e
    console.log "[ERR ] #{name}"
    console.log e.message
