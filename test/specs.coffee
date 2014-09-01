require 'coffee-script/register'
require './setup'

{eachGroup} = require('../lib/specs_iterator')

eachGroup (group) ->
  run = if group.pending then xdescribe else describe

  run group.name, ->
    group.specs.forEach (spec) ->
      it spec.name, do (spec) -> ->
        result = js2coffee(spec.input)
        try
          expect(result).eql(spec.output)
        catch e
          e.stack = ''
          throw e
