TransformerBase = require('./base.coffee')

###
# Updates `SwitchCase`s to a more coffee-compliant AST. This means having
# to remove `return`/`break` statements, and taking into account the
# correct way of consolidating empty ccases.
#
#     switch (x) { case a: b(); break; }
#
#     switch x
#       when a then b()
###

module.exports = class extends TransformerBase

  SwitchStatement: (node) ->
    @consolidateCases(node)
    @ensureLastCaseIsDefault(node)

  SwitchCase: (node) ->
    @removeBreaksFromConsequents(node)

  ###
  # Ensure that `default:` is only at the end.
  ###

  ensureLastCaseIsDefault: (node) ->
    cases = node.cases.filter (c) ->
      c.type is 'SwitchCase'

    last = cases.length
    for kase, i in cases
      isLast = (i is last-1)
      isDefault = not kase.test?

      if isDefault and not isLast
        @syntaxError kase, "default cases only allowed at the end"
    node

  ###
  # Consolidates empty cases into the next case. The case tests will then be
  # made into a new node type, CoffeeListExpression, to represent
  # comma-separated values. (`case x: case y: z()` => `case x, y: z()`)
  ###

  consolidateCases: (node) ->
    list = []
    toConsolidate = []
    for kase, i in node.cases
      # .type .test .consequent
      if kase.type is 'SwitchCase'
        toConsolidate.push(kase.test) if kase.test
        if kase.consequent.length > 0
          if kase.test
            kase.test =
              type: 'CoffeeListExpression'
              expressions: toConsolidate
          toConsolidate = []
          list.push kase
      else
        list.push kase

    node.cases = list
    node

  ###
  # Removes `break` statements from consequents in a switch case.
  # (eg, `case x: a(); break;` gets break; removed)
  ###

  removeBreaksFromConsequents: (node) ->
    if node.test
      idx = node.consequent.length-1
      last = node.consequent[idx]
      if last?.type is 'BreakStatement'
        delete node.consequent[idx]
        node.consequent.length -= 1
      else if last?.type is 'ContinueStatement'
        # pass
      else if last?.type isnt 'ReturnStatement'
        @syntaxError node, "No break or return statement found in a case"
      node
