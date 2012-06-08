js2coffee = require('./js2coffee')
_    = require('underscore')
fs   = require('fs')
path = require('path')
tty  = require('tty')
file = require('file')
optparse = require './optparse'
encoding = 'utf-8'

UnsupportedError = js2coffee.UnsupportedError

basename = path.basename
cmd      = basename(process.argv[1])
opts     = {}
indirs   = []
BANNER = '''
    Usage: js2coffee --batch [options] rootdir
         '''


SWITCHES = [
    ['-b', '--batch', 'batch mode to convert all .js files in directory']
    ['-o', '--output [OUTDIR]', 'set the output directory']
    ['-r', '--recursive', 'recurse on all subdirectories']
    ['-v', '--verbose', 'See detailed output']
    ['-h', '--help', 'If you need help']
  ]

parseOptions = ->
    optionParser  = new optparse.OptionParser SWITCHES, BANNER
    o = opts      = optionParser.parse process.argv.slice 2
    indirs        = o.arguments
    return


writeFile = (dir, currfile, coffee) ->
  outputdir = opts.output || '.'
  try
    if (outputdir.search '/') == -1
      outputdir = outputdir.concat '/'
    newPath = outputdir + dir + '/'
    try
      fs.statSync(newPath).isDirectory()
    catch e
      file.mkdirsSync(newPath)
    currfile = (currfile.split '.')[0] + '.coffee'
    newFile = newPath + currfile
    (console.warn "writing %s ", newFile) if opts.verbose
    fs.writeFileSync(newFile, coffee, encoding);
  catch e
    console.warn e

batch = () ->

  callback = (dirPath, dirs, files) ->
    for f in files
      try
        if ((f.split '.')[1] == 'js')
          readf = dirPath + '/' + f
          (console.warn "read file %s", readf) if opts.verbose
          contents = fs.readFileSync(readf, encoding);
          output = js2coffee.build(contents)
          writeFile(dirPath, f, output)
      catch e
        console.warn e

  for i in indirs
    try
      if fs.statSync(i).isDirectory()
        if opts.recursive
          file.walkSync(i, callback)
        else
          list = []
          for v in fs.readdirSync(i)
            if fs.statSync(v).isFile()
              list.add v
          callback(i, '', list)
    catch e
      #console.warn e



build_and_show = (fname) ->
  contents = fs.readFileSync(fname, encoding)
  output   = js2coffee.build(contents)
  console.log "%s", output

runFiles = (proc) ->
  files = process.argv.slice(2)
  work  = proc or build_and_show

  if tty.isatty process.stdin
    # Nothing on stdin.
    if files.length == 0
      console.warn "Usage:"
      console.warn "  #{cmd} file.js"
      console.warn "  #{cmd} file.js > output.coffee"
      console.warn "  cat file.js | #{cmd}"
      process.exit 1

    _.each files, (fname) -> work fname

  else
    # Something was piped or redirected into stdin; use that instead of filenames.
    work '/dev/stdin'

module.exports =
  run: (args...) ->
    parseOptions()
    try
      if opts.batch
        batch.apply this
      else
        runFiles.apply this, args
      process.exit 0

    catch e
      throw e  unless e.constructor in [UnsupportedError, SyntaxError]
      console.warn "Error: #{e.message}"
      console.warn "Cursor position: #{e.cursor}"
      process.exit 1
