
path = require('path')
glob = require('glob')
fs = require('fs')
groups = glob.sync("#{__dirname}/../specs/*")

toName = (dirname) ->
  s = path.basename(dirname).replace(/_/g, ' ').trim()
  s.substr(0,1).toUpperCase() + s.substr(1)

console.log """
  <table width='100%'>
  <thead>
    <tr>
      <th width='33%'>Example</th>
      <th width='33%'>JavaScript</th>
      <th width='33%'>CoffeeScript</th>
  </thead>
"""

for group in groups
  console.log """
    <tr><th colspan='3'>#{toName(group)}</th></tr>
  """

  specs = glob.sync("#{group}/*")
  for spec in specs

    name = toName(spec)
    isPending = ~group.indexOf('pending') or ~name.indexOf('pending')
    continue if isPending

    data = fs.readFileSync(spec, 'utf-8')
    [meta, input, output] = data.split('----\n')

    console.log """
      <tr>
      <th valign='top'>#{name}</th>
      <td valign='top'>
      <pre class='lang-js'>#{input}</pre>
      </td>
      <td width='50%' valign='top'>
      <pre class='lang-coffee'>#{output}</pre>
      </td>
      </tr>
    """

console.log """
  </table>
"""
