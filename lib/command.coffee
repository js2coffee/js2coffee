# The `js2coffee` utility.
# Handles command-line compilation of JavaScript into various forms:
# saved into `.coffee` files or printed to stdout

# External dependencies.
js2coffee = require './js2coffee'
_         = require 'underscore'
fs        = require 'fs'
path      = require 'path'
tty       = require 'tty'
file      = require 'file'
optparse  = require './optparse'

# The help banner that is printed when `js2coffee` is called without arguments.
BANNER =  """
     Usage: js2coffee [options] path/to/script.js

       js2coffee file.js
       js2coffee file.js > output.coffee
       cat file.js | js2coffee
"""

# The list of all the valid option flags that `js2coffee` knows how to handle.
SWITCHES = [
  # ['-b', '--batch', 'batch mode to convert all .js files in directory']
  # ['-o', '--output [OUTDIR]', 'set the output directory']
  # ['-r', '--recursive', 'recurse on all subdirectories']
  ['-v', '--version', 'Show js2coffee version']
  ['-V', '--verbose', 'Be verbose']
  ['-X', '--no_comments', 'Do not translate comments']
  ['-l', '--show_src_lineno', 'Show src lineno\'s as comments']
  ['-h', '--help', 'If you need help']
]

# Top-level objects shared by all the functions.
options  = {}
sources  = []

encoding = 'utf-8'
UnsupportedError = js2coffee.UnsupportedError
basename = path.basename
cmd      = basename(process.argv[1])

parseOptions = ->
  optionParser  = new optparse.OptionParser SWITCHES, BANNER
  options       = optionParser.parse process.argv.slice 2
  sources       = options.arguments

writeFile = (dir, currfile, coffee) ->
  outputdir = options.output || '.'
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
    (console.warn "writing %s ", newFile) if options.verbose
    fs.writeFileSync(newFile, coffee, encoding)
  catch e
    console.warn e

batch = () ->
  callback = (dirPath, dirs, files) ->
    for f in files
      try
        if ((f.split '.')[1] == 'js')
          readf = dirPath + '/' + f
          (console.warn "read file %s", readf) if options.verbose
          contents = fs.readFileSync(readf, encoding)
          output = js2coffee.build(contents,options)
          writeFile(dirPath, f, output)
      catch e
        console.warn e

  for i in sources
    try
      if fs.statSync(i).isDirectory()
        if options.recursive
          file.walkSync(i, callback)
        else
          list = []
          for v in fs.readdirSync(i)
            if fs.statSync(v).isFile()
              list.add v
          callback(i, '', list)
    catch e
      #console.warn e

# Compile a path, which could be a script or a directory. If a directory
# is passed, recursively compile all '.js' extension source files in it
# and all subdirectories.
compilePath = (source, topLevel, base) ->
  fs.stat source, (err, stats) ->
    throw err if err and err.code isnt 'ENOENT'
    if err?.code is 'ENOENT' # file does not exist
      if topLevel and source[-3..] isnt '.js'
        # retry with extension '.js' added
        source = "#{source}.coffee"
        return compilePath source, topLevel, base
      if topLevel
        console.error "File not found: #{source}"
        process.exit 1
      return

    if stats.isDirectory()
      # watchDir source, base if opts.watch
      fs.readdir source, (err, files) ->
        throw err if err and err.code isnt 'ENOENT'
        return if err?.code is 'ENOENT'
        # index = sources.indexOf source
        # sources[index..index] = (path.join source, file for file in files)
        # sourceCode[index..index] = files.map -> null
        for file in files when not hidden file
          compilePath (path.join source, file), no, base
    else if topLevel or path.extname(source) is '.js'
      compileScript source

# Test if file is hidden (starts with a dot)
hidden = (file) -> /^\.|~$/.test file

# Compile a single source script, containing the given code, according to the
# requested options and write it on output (currently stdout)
compileScript = ( fname ) ->
  try
    console.log "#### ---- #{fname}" if options.verbose
    code = fs.readFileSync fname
    compiled_code = js2coffee.build(code.toString(),options)
    console.log compiled_code
  catch err
    console.warn err instanceof Error and err.stack or "ERROR: #{err} while compiling #{file}"
    exit 1 if options.stop_on_error

compileFromStdin = ->
  contents = fs.readFileSync("/dev/stdin", encoding) # TODO: is this cross-platform?
  output   = js2coffee.build(contents,options)
  console.log output

usage = ->
  console.warn (new optparse.OptionParser SWITCHES, BANNER).help()
  process.exit 0

version = ->
  "js2coffee version #{js2coffee.VERSION}"

# Run `js2coffee` by parsing passed options and determining what action to take.
exports.run = ->
  parseOptions()

  return usage()                if options.help
  return console.log version()  if options.version
  console.log "#### "+version() if options.verbose

  if sources.length > 0
    for s in sources
      compilePath s
  else
    return compileFromStdin '/dev/stdin' if not tty.isatty process.stdin
    # if we come here there was nothing else to do
    return usage()
