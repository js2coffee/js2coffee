js2coffee = require('./js2coffee')
_    = require('underscore')
fs   = require('fs')
path = require('path')

basename = path.basename
cmd      = basename(process.argv[1])

work = (fname) ->
  contents = fs.readFileSync(fname, 'utf-8')
  output   = js2coffee.build(contents)
  console.log output

module.exports =
  run: ->
    files = process.argv.slice(2)

    try
      work '/dev/stdin'

    catch e
      throw e  if e.constructor == SyntaxError

      if files.length == 0
        console.warn "Usage:"
        console.warn "  #{cmd} file.js"
        console.warn "  #{cmd} file.js > output.txt"
        console.warn "  cat file.js | #{cmd}"
        process.exit 1

      _.each files, (fname) -> work fname
