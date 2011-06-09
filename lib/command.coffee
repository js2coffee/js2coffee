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
  #console.log "%s", output

# Check whether file name is passed or folder
# if file then return the file name only
# else needs to return all the js file inside it
retrieve_js_files_if_folder = (fname,done) ->
  if is_folder fname[0]
    walk fname[0], (results) ->
      done results
  else
    done fname

# check whether the fname passed is folder or not
# stat function will return stat object there we can
# check wither it is file or directory
is_folder = (fname) ->
  return (fs.statSync fname).isDirectory()

# if file ends with .js then return true or return false
is_js = (fname) ->
  if fname.substr(-3) == '.js'
    true
  else
    false

#return the list of files inside the folder
walk = (dir, done) ->
  results = [  ]
  i = 0
  done(results) unless is_folder dir

  list = fs.readdirSync dir
  if not list
      return done(results)
  list.forEach (f) ->
    if is_folder dir + "/" +f
      walk dir + "/" + f, (r) ->
        results = results.concat(r)
        if ++i is list.length
          done results
    else
      if is_js f
        results.push dir + "/" + f
      if ++i is list.length
        done results

runFiles = (proc) ->
  # slice returns new array
  # slice(2) starting index 2 (array index starts from 0)
  files = process.argv.slice(2)
  retrieve_js_files_if_folder files,(files) ->
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

      _.each files, (fname) -> 
        output = work fname
        # for debuggin comment writing output to file
        fs.writeFile(fname.replace(".js",".coffee"),output,"utf-8")

module.exports =
  run: (args...) ->
    try
      runFiles.apply this, args

    catch e
      throw e  unless e.constructor in [UnsupportedError, SyntaxError]
      console.warn "Error: #{e.message}"
      console.warn "Cursor position: #{e.cursor}"
