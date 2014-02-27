# Export
docpadConfig =
	###
	environments:
		development:
			plugins:
				uglify:
					enabled: true
	###

	renderPasses: 2

	prompts: false

	templateData:
		package: require('./package.json')

# Export
module.exports = docpadConfig