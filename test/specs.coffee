require './setup'
path = require('path')
glob = require('glob')
fs = require('fs')

groups = glob.sync("#{__dirname}/../specs/*")

toName = (dirname) ->
  path.basename(dirname).replace(/_/g, ' ').trim()

describe 'specs:', ->
  groups.forEach (group) ->
    describe toName(group), ->

      specs = glob.sync("#{group}/*")
      specs.forEach (spec) ->

        name = toName(spec)
        isPending = ~group.indexOf('pending')
        test = if isPending then xit else it

        test name, ->
          input  = fs.readFileSync("#{spec}/input.js", 'utf-8')
          output = fs.readFileSync("#{spec}/output.coffee", 'utf-8')
          result = js2coffee(input)
          expect(result).eql(output)
