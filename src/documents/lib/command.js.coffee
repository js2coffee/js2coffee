# The `js2coffee` utility.
# Handles command-line compilation of JavaScript into various forms:
# saved into `.coffee` files or printed to stdout

# External dependencies.
js2coffee = require './js2coffee'
fsUtil    = require 'fs'
pathUtil  = require 'path'
tty       = require 'tty'
fileUtil  = require 'file'
{inspect} = require 'util'
nopt      = require 'nopt'

# The help banner that is printed when `js2coffee` is called without arguments.
BANNER =  """
     Usage: js2coffee [options] path/to/script.js

       js2coffee file.js
       js2coffee file.js > output.coffee
       cat file.js | js2coffee
"""

knownOpts =
  version: Boolean # show js2coffee version
  verbose: Boolean # be verbose
  no_comments: Boolean # do not translate comments
  show_src_lineno: Boolean # show src lineno's as comments
  single_quotes: Boolean # use single quoted string literals
  help: Boolean # if you need help
  indent: String # set indent character(s), default two spaces

shortHands =
  v: ["--version"]
  V: ["--verbose"]
  X: ["--no_comments"]
  l: ["--show_src_lineno"]
  h: ["--help"]
  sq: ["--single_quotes"]
  i4: ["--indent", "    "]
  it: ["--indent", "\t"]

# The list of all the valid option flags that `js2coffee` knows how to handle.
description =
  version: 'Show js2coffee version'
  verbose: 'Be verbose'
  no_comments: 'Do not translate comments'
  show_src_lineno: 'Show src lineno\'s as comments'
  help: 'If you need help'
  single_quotes: "Use single quoted string literals - default double quoted"
  indent: 'Specify the indent character(s) - default 2 spaces'

# Top-level objects shared by all the functions.
options  = {}
sources  = []

encoding = 'utf-8'
UnsupportedError = js2coffee.UnsupportedError
cmd      = pathUtil.basename(process.argv[1])

parseOptions = ->
  options = nopt knownOpts, shortHands, process.argv, 2
  sources = options.argv.remain or= []

  if options.no_comments is true and options.show_src_lineno is true
    console.warn "You cannot combine -l and -X"
    return process.exit 1

  # nopt trim string values, copy it manually from argv.cooked
  index = options.argv.cooked.indexOf "--indent"
  if index isnt -1 and options.argv.cooked.length >= index
    options.indent = options.argv.cooked[index+1]

writeFile = (dir, currfile, coffee) ->
  outputdir = options.output || '.'
  try
    if (outputdir.search '/') == -1
      outputdir = outputdir.concat '/'
    newPath = outputdir + dir + '/'
    try
      fsUtil.statSync(newPath).isDirectory()
    catch e
      fileUtil.mkdirsSync(newPath)
    currfile = (currfile.split '.')[0] + '.coffee'
    newFile = newPath + currfile
    (console.log "writing %s ", newFile) if options.verbose
    fsUtil.writeFileSync(newFile, coffee, encoding)
  catch e
    console.error e

batch = () ->
  callback = (dirPath, dirs, files) ->
    for f in files
      try
        if ((f.split '.')[1] == 'js')
          readf = dirPath + '/' + f
          (console.log "read file %s", readf) if options.verbose
          contents = fsUtil.readFileSync(readf, encoding)
          output = js2coffee.build(contents,options)
          writeFile(dirPath, f, output)
      catch e
        console.error e

  for i in sources
    try
      if fsUtil.statSync(i).isDirectory()
        if options.recursive
          fileUtil.walkSync(i, callback)
        else
          list = []
          for v in fsUtil.readdirSync(i)
            if fsUtil.statSync(v).isFile()
              list.add v
          callback(i, '', list)
    catch e
      #console.error e

# Compile a path, which could be a script or a directory. If a directory
# is passed, recursively compile all '.js' extension source files in it
# and all subdirectories.
compilePath = (source, topLevel = yes) ->
  fsUtil.stat source, (err, stats) ->
    throw err if err and err.code isnt 'ENOENT'
    if err?.code is 'ENOENT' # file does not exist
      if topLevel and source[-3..] isnt '.js'
        # retry with extension '.js' added
        source = "#{source}.js"
        return compilePath source, topLevel
      if topLevel
        console.error "File not found: #{source}"
        process.exit 1
      return

    if stats.isDirectory()
      fsUtil.readdir source, (err, files) ->
        throw err if err and err.code isnt 'ENOENT'
        return if err?.code is 'ENOENT'
        # index = sources.indexOf source
        # sources[index..index] = (pathUtil.join source, file for file in files)
        # sourceCode[index..index] = files.map -> null
        for file in files when not hidden file
          compilePath (pathUtil.join source, file), no
    else if topLevel or (pathUtil.extname source) in ['.js', '.json']
      compileScript source

# Test if file is hidden (starts with a dot)
hidden = (file) -> /^\.|~$/.test file

# Compile a single source script, containing the given code, according to the
# requested options and write it on output (currently stdout)
compileScript = ( fname ) ->
  try
    console.log "#### ---- #{fname}" if options.verbose
    code = fsUtil.readFileSync fname
    if '.json' is pathUtil.extname fname
      code = "(#{code})"
    compiled_code = js2coffee.build(code.toString(),options)
    console.log compiled_code
  catch err
    console.warn err instanceof Error and err.stack or "ERROR: #{err} while compiling #{fname}"
    exit 1 if options.stop_on_error

compileFromStdin = ->
  contents = fsUtil.readFileSync("/dev/stdin", encoding) # TODO: is this cross-platform?
  output   = js2coffee.build(contents,options)
  console.log output

usage = ->
  console.warn BANNER + "\n"
  console.warn "options:"
  for arg of knownOpts
    console.warn "--#{arg} # #{description[arg]}"
  console.warn "\nshorcuts:"
  for short, long of shortHands
    if short is '___singles'
      continue
    console.warn "-#{short} = #{inspect long}"
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
