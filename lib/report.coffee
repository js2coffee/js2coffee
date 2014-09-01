{eachGroup} = require('./specs_iterator')

eachGroup (group) ->
  return if group.pending
  console.log "## #{group.name}\n"

  for spec in group.specs
    console.log """
      <table>
      <tr>
      <th width='33%' valign='top'>#{spec.name}</th>
      <td width='33%' valign='top'>
      <pre><code class='lang-js'>#{spec.input}</code></pre>
      </td>
      <td width='33%' valign='top'>
      <pre><code class='lang-coffee'>#{spec.output}</code></pre>
      </td>
      </tr>
      </table>\n
    """

    notes = spec.meta?.notes
    if notes
      lines = notes.split("\n").map (l) -> "> #{l}"
      notes = lines.join("\n")
      console.log "#{notes}\n"
