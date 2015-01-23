###
# Debugging provisions. Run `before -> require('./lib/support/debug')` in tests
# to print out some debug information.
###

TransformerBase = require('../transformer_base')

TransformerBase::onBeforeEnter = (node) ->
  msg = "#{node.type}"
  fn = @[msg]?
  broken = isBroken(@ast) or ""
  print @depth, (if fn then "#{msg} *" else "#{msg}"), broken

TransformerBase::onBeforeExit = (node) ->
  msg = "#{node.type}Exit"
  fn = @[msg]?
  broken = isBroken(@ast) or ""
  print @depth+1, (if fn then "#{msg} *" else "#{msg}"), broken

# Prints the current node.
print = (depth, nodeType, message="") ->
  color = if (/\*$/.test(nodeType)) then 35 else 30
  prefix = "\u001b[#{color}m#{nodeType}\u001b[0m"
  indent = "\u001b[#{30 + (depth % 5)}m· \u001b[0m"

  console.log \
    Array(depth+1).join(indent) + prefix,
    message

# Checks if a certain AST is broken.
isBroken = (ast) ->
  output = require('util').inspect(ast, depth: 1000)
  if ~output.indexOf("[Circular]")
    "[Circular]"

