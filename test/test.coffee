require './setup'
path = require('path')
glob = require('glob')
fs = require('fs')

groups = glob.sync("#{__dirname}/../specs/*")

groups.forEach (dirname) ->
  group = path.basename(dirname).replace(/_/g, ' ')

  describe group, ->
    specs = glob.sync("#{dirname}/*")

    specs.forEach (dirname) ->
      name = path.basename(dirname).replace(/_/g, ' ')

      isPending = (~group.indexOf('pending') or name.match(/^ /))
      test = if isPending then xit else it

      test name.trim(), ->
        input  = fs.readFileSync(dirname + '/input.js', 'utf-8')
        output = fs.readFileSync(dirname + '/output.coffee', 'utf-8')
        result = js2coffee(input)
        expect(result).eql(output)
