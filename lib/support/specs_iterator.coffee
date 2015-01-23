coffee = require('coffee-script')
glob = require('glob')
path = require('path')
fs = require('fs')

exports.root = "#{__dirname}/../../specs"

exports.toName = (dirname) ->
  s = path.basename(dirname).replace(/_/g, ' ').trim()
  s = s.replace(/\.txt$/, '')
  s.substr(0,1).toUpperCase() + s.substr(1)

###
# eachGroup()
# Iterates through each spec group.
#
#     eachGroup (group) ->
#       group.name
#       group.pending
#       group.specs.forEach (spec) ->
#         spec.name
#         spec.input
#         spec.output
#         spec.meta
#         spec.pending
###

exports.eachGroup = (fn) ->
  groups = glob.sync("#{exports.root}/*")
  for group in groups
    specDirs = glob.sync("#{group}/*")
    specs = specDirs.map (spec) ->
      data = fs.readFileSync(spec, 'utf-8')
      name = exports.toName(spec)
      [meta, input, output] = data.split('----\n')
      meta = eval(coffee.compile(meta, bare: true)) if meta.length
      meta ?= {}

      { name, input, output, meta }

    if specs.length
      name = exports.toName(group)
      pending = ~group.indexOf('pending')

      fn { name, pending, specs }

