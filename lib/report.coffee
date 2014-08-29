
path = require('path')
glob = require('glob')
fs = require('fs')
groups = glob.sync("#{__dirname}/../specs/*")

toName = (dirname) ->
  path.basename(dirname).replace(/_/g, ' ').trim()

for group in groups
  console.log "## #{group}"
  console.log ""

  specs = glob.sync("#{group}/*")
  for spec in specs

    name = toName(spec)
    isPending = ~group.indexOf('pending') or ~name.indexOf('pending')
    continue if isPending

    data = fs.readFileSync(spec, 'utf-8')
    [meta, input, output] = data.split('----\n')

    console.log """
      ### #{name}

      <table width='100%'>
      <tr><th>JavaScript</th><th>CoffeeScript</th></tr>
      <tr><td width='50%' valign='top'>
      <pre class='lang-js'>#{input}</pre>
      </td><td width='50%' valign='top'>
      <pre class='lang-coffee'>#{output}</pre>
      </td></tr></table>

    """

