# Prepare
delay = (next) -> setTimeout(next,500)

# Export
module.exports =
	renderPasses: 2

	prompts: false

	templateData:
		package: require('./package.json')

	environments:
		development:
			plugins:
				uglify:
					enabled: true