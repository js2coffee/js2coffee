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
			require('child_process').spawn('./node_modules/.bin/cake', ['test'], {stdio:'inherit'}).on 'close', (code) ->
				if code isnt 0
					message = 'TESTS FAILED'
					docpad.log('warn', message)
				else
					message = 'Tests passed'
					docpad.log('info', message)

				# Notify
				delay -> docpad.notify(message)

				# Complete
				return next()