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
sources  = []

BANNER =
   """
   Usage: #{cmd} [options] filename
   """

EXAMPLES =
   """
   Examples:
     #{cmd} file.js
     #{cmd} file.js > output.coffee
     cat file.js | #{cmd}
   """

SWITCHES = [
    ['-b', '--batch', 'batch mode to convert all .js files in directory']
    ['-o', '--output [OUTDIR]', 'set the output directory']
    ['-r', '--recursive', 'recurse on all subdirectories']
    ['-X', '--no_comments', 'do not translate comments']
    ['-v', '--verbose', 'See detailed output']
    ['-h', '--help', 'If you need help']
    ['-l', '--show_src_lineno', 'show src lineno\'s as comments']
  ]

parseOptions = ->
    optionParser  = new optparse.OptionParser SWITCHES, BANNER
    o = opts      = optionParser.parse process.argv.slice 2
    sources       = o.arguments
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
          output = js2coffee.build(contents,opts)
          writeFile(dirPath, f, output)
      catch e
        console.warn e

  for i in sources
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
  output   = js2coffee.build(contents,opts)
  console.log "#### ---- #{fname} translated by #{cmd} ---- ####"
  console.log output

runFiles = (proc) ->
  files = sources
  work  = proc or build_and_show

  if tty.isatty process.stdin
    # Nothing on stdin.
    if files.length == 0
      usage()
      process.exit 1

    _.each files, (fname) -> work fname

  else
    # Something was piped or redirected into stdin; use that instead of filenames.
    work '/dev/stdin'


usage = ->
  console.warn (new optparse.OptionParser SWITCHES, BANNER).help()
  console.warn EXAMPLES

module.exports =
  run: (args...) ->
    parseOptions()
    return usage() if opts.help
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
