###
# Generates spec notes (specs.md), invoked via a Makefile
###

{eachGroup} = require('./specs_iterator')

eachGroup (group) ->
  return if group.pending
  console.log "## #{group.name}\n"

  console.log "<table width='100%'>"

  for spec in group.specs
    continue if spec.meta.nodoc
    output = spec.output

    if spec.meta?.error
      output = "Error:\n#{spec.meta.error}"

    console.log """
      <tr>
      <th width='33%' valign='top'>#{spec.name}</th>
      <td width='33%' valign='top'>
      <pre><code class='lang-js'>#{spec.input}</code></pre>
      </td>
      <td width='33%' valign='top'>
      <pre><code class='lang-coffee'>#{output}</code></pre>
      </td>
      </tr>
    """

  console.log "</table>\n"
