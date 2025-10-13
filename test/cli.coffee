require 'coffeescript/register'
{describe, it} = require 'node:test'
require './setup'
{ exec } = require 'child_process'
{ promisify } = require 'util'

execAsync = promisify exec

describe 'CLI', ->

  describe 'ES.Next support via Babel', ->

    it 'transforms arrow functions via stdin', ->
      cmd = 'echo "const fn = (x) => x * 2;" | ./bin/js2coffee'
      {stdout, stderr} = await execAsync(cmd)
      expect(stdout).include 'fn = '
      expect(stdout).include '->'

    it 'transforms const to var via stdin', ->
      cmd = 'echo "const x = 1;" | ./bin/js2coffee'
      {stdout, stderr} = await execAsync(cmd)
      expect(stdout).include 'x = 1'

    it 'transforms template literals via stdin', ->
      cmd = 'echo \'const msg = `Hello ${name}`;' + "' | ./bin/js2coffee"
      {stdout, stderr} = await execAsync(cmd)
      expect(stdout).include 'msg = '

    it 'transforms optional chaining via stdin', ->
      cmd = 'echo "const value = obj?.prop;" | ./bin/js2coffee'
      {stdout, stderr} = await execAsync(cmd)
      expect(stdout).include 'value = '
