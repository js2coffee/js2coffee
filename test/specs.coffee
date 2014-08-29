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
    describe toName(group) + ":", ->

      specs = glob.sync("#{group}/*")
      for spec in specs

        name = toName(spec)
        isPending = ~group.indexOf('pending') or ~name.indexOf('pending')
        test = if isPending then xit else it

        fn = ((spec) ->
          ->
            data = fs.readFileSync(spec, 'utf-8')
            [meta, input, output] = data.split('----\n')

            # Export data for the reporter.
            fn.data = { input, output }

            result = js2coffee(input)
            expect(result).eql(output)
        )(spec)
        test name, fn
