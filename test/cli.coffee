require 'coffeescript/register'
require './setup'
{ exec } = require 'child_process'
{ promisify } = require 'util'

execAsync = promisify exec

describe 'CLI', ->

  describe 'ES.Next support via Babel', ->

    it 'transforms arrow functions via stdin', (done) ->
      cmd = 'echo "const fn = (x) => x * 2;" | ./bin/js2coffee'
      execAsync(cmd).then ({stdout, stderr}) ->
        expect(stdout).include 'fn = '
        expect(stdout).include '->'
        done()
      .catch done

    it 'transforms const to var via stdin', (done) ->
      cmd = 'echo "const x = 1;" | ./bin/js2coffee'
      execAsync(cmd).then ({stdout, stderr}) ->
        expect(stdout).include 'x = 1'
        done()
      .catch done

    it 'transforms template literals via stdin', (done) ->
      cmd = 'echo \'const msg = `Hello ${name}`;' + "' | ./bin/js2coffee"
      execAsync(cmd).then ({stdout, stderr}) ->
        expect(stdout).include 'msg = '
        done()
      .catch done

    it 'transforms optional chaining via stdin', (done) ->
      cmd = 'echo "const value = obj?.prop;" | ./bin/js2coffee'
      execAsync(cmd).then ({stdout, stderr}) ->
        expect(stdout).include 'value = '
        done()
      .catch done
