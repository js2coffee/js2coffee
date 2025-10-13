###*
# read-input replacement using native Node.js
# Reads from files or stdin, compatible with the original read-input API
###

fs = require 'fs'

read = (files, callback) ->
  if typeof files is 'function'
    callback = files
    files = []

  files = files or []

  promise = new Promise (resolve, reject) ->
    if files.length is 0
      readStdin (err, data) ->
        if err
          result = new Result [{ stdin: true, error: err }]
          resolve result
        else
          result = new Result [{ stdin: true, data: data }]
          resolve result
    else
      filesData = files.map (fname) ->
        try
          data = fs.readFileSync fname, 'utf-8'
          { name: fname, data: data }
        catch err
          { name: fname, error: err }

      resolve new Result filesData

  if callback
    promise
      .then (res) -> callback null, res
      .catch (err) -> callback err

  promise

readStdin = (callback) ->
  chunks = []

  process.stdin.setEncoding 'utf-8'

  process.stdin.on 'data', (chunk) ->
    chunks.push chunk

  process.stdin.on 'end', ->
    callback null, chunks.join('')

  process.stdin.on 'error', (err) ->
    callback err

  if process.stdin.isTTY
    callback new Error 'No input provided'

Result = (files) ->
  @files = files
  @successes = files.filter (f) -> not f.error
  @failures = files.filter (f) -> f.error

  if files.length is 1
    @data = files[0].data
    @error = files[0].error
    @stdin = files[0].stdin or false

  return

read.stdin = readStdin

module.exports = read
