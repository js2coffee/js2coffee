js2coffee = require('./js2coffee')
_    = require('underscore')
fs   = require('fs')
path = require('path')

UnsupportedError = js2coffee.UnsupportedError

basename = path.basename
cmd      = basename(process.argv[1])

build_and_show = (fname) ->
  contents = fs.readFileSync(fname, 'utf-8')
  output   = js2coffee.build(contents)
  console.log "%s", output

runFiles = (proc) ->
  files = process.argv.slice(2)
  work  = proc or build_and_show

  try
    work '/dev/stdin'

  catch e
    throw e unless e.code == 'EAGAIN'

    if files.length == 0
      console.warn "Usage:"
      console.warn "  #{cmd} file.js"
      console.warn "  #{cmd} file.js > output.txt"
      console.warn "  cat file.js | #{cmd}"
      process.exit 1

    _.each files, (fname) -> work fname

module.exports =
  run: (args...) ->
    try
      runFiles.apply this, args

    catch e
      throw e  unless e.constructor in [UnsupportedError, SyntaxError]
      console.warn "Error: #{e.message}"
      console.warn "Cursor position: #{e.cursor}"
