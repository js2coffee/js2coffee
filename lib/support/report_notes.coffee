###
# Generates spec notes (special_cases.md), invoked via a Makefile
###

{eachGroup} = require('./specs_iterator')

eachGroup (group) ->
  return if group.pending
  specs = group.specs.filter (s) -> s.meta?.notes
  return if specs.length is 0

  console.log "## #{group.name}\n"

  for spec in specs
    console.log "### #{spec.name}\n"
    console.log "#{spec.meta.notes}\n"
    console.log "```js\n// Input:\n#{spec.input}```\n"
    console.log "```coffee\n# Output:\n#{spec.output}```\n"
