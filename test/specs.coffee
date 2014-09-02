require 'coffee-script/register'
require './setup'

{eachGroup} = require('../lib/specs_iterator')

eachGroup (group) ->
  run = if group.pending then xdescribe else describe

  run group.name, ->
    group.specs.forEach (spec) ->
      run = if spec.meta?.pending then xit else if spec.meta?.only then it.only else it
      run spec.name, do (spec) -> ->
        result = js2coffee(spec.input)
        try
          expect(result).eql(spec.output)
        catch e
          # this doesn't actually disable diffs, but rather it makes the diff
          # output look better. see: https://github.com/visionmedia/mocha/issues/1241
          e.showDiff = false
          e.stack = ''
          throw e
