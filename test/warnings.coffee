require('./setup')

ast = undefined
warnings = undefined

describe 'Warnings', ->
  describe 'with no warnings', ->
    beforeEach ->
      {ast, warnings} = js2coffee.build('var a')

    it 'produces an array', ->
      expect(warnings).be.an 'array'

    it 'produces an empty array', ->
      expect(warnings).have.length 0

  describe 'with 1 warning', ->
    beforeEach ->
      opts = { filename: 'x.js' }
      {ast, warnings} = js2coffee.build('function add() { var add }', opts)

    it 'produces an array', ->
      expect(warnings).be.an 'array'

    it 'has 1 warning', ->
      expect(warnings).have.length 1

    it 'complains about shadowing', ->
      expect(warnings[0].description).match /'add'/
      expect(warnings[0].description).match /shadow/

    it 'has start marker', ->
      expect(warnings[0].start).eql line: 1, column: 21

    it 'has end marker', ->
      expect(warnings[0].end).eql line: 1, column: 24

    it 'has filename', ->
      expect(warnings[0].filename).eql 'x.js'
