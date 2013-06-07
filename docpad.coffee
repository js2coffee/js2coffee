# Prepare
delay = (next) -> setTimeout(next,500)

# Export
module.exports =
	renderPasses: 2

	prompts: false

	plugins:
		uglify:
			all: false

	events:
		generateAfter: (opts,next) ->
			# Prepare
			docpad = @docpad

			# Test
			require('bal-util').spawn 'npm test', {output:true}, (err) ->
				if err
					message = 'TESTS FAILED'
					docpad.log('warn', message)
				else
					message = 'Tests passed'
					docpad.log('info', message)

				# Notify
				delay -> docpad.notify(message)

				# Complete
				return next()