# Number of spaces to use for each step of indent
tabspacing = 2

# Should function calls be parenthesized?
#   when set to false:
#       aMethodCall "value"
#    when set to true:
#       aMethodCall("value")
parenthesized_calls = false

# Should we use an explicit return?
#   when set to false:
#       fn = ->
#         "value"
#    when set to true:
#       fn = ->
#         return "value"
explicit_return = false

# Should we use unless?
#   when set to false:
#       fn = (val) ->
#         return true if val isnt 'value'
#    when set to true:
#       fn = (val) ->
#         return true unless val is 'value'
use_unless = true

# Should double space be used in inline statements?
#   when set to false:
#       fn = (val) ->
#         return unless val "value"
#    when set to true:
#       fn = (val) ->
#         return  unless val "value"
doublespacing_if = true

usePythonic = ->
  module.exports.tabspacing = 4
  module.exports.parenthesized_calls = true
  module.exports.explicit_return = true
  module.exports.use_unless = false
  module.exports.doublespacing_if = false

@codestyle = exports = {
  tabspacing
  usePythonic
  explicit_return
  use_unless
  doublespacing_if
}

module.exports = exports  if module?
