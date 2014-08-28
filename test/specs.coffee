require 'coffee-script/register'
require './setup'

path = require('path')
glob = require('glob')
fs = require('fs')

groups = glob.sync("#{__dirname}/../specs/*")

toName = (dirname) ->
  path.basename(dirname).replace(/_/g, ' ').trim()

describe 'specs:', ->
  for group in groups
    describe toName(group), ->

      specs = glob.sync("#{group}/*")
      for spec in specs

        name = toName(spec)
        isPending = ~group.indexOf('pending')
        test = if isPending then xit else it

        test name, ((spec) ->
          ->
            if fs.statSync(spec).isDirectory()
              input  = fs.readFileSync("#{spec}/input.js", 'utf-8')
              output = fs.readFileSync("#{spec}/output.coffee", 'utf-8')
              result = js2coffee(input)
              expect(result).eql(output)
            else
              data = fs.readFileSync(spec, 'utf-8')
              [meta, input, output] = data.split("\n----\n\n")

              result = js2coffee(input)
              expect(result).eql(output)
        )(spec)
