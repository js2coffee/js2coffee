all: \
	vendor.js \
	vendor.css

vendor.js: \
	vendor/codemirror.js \
	vendor/javascript.js \
	vendor/coffeescript.js \
	vendor/lint.js \
	vendor/simplescrollbars.js
	cat $^ | uglifyjs -m > $@

vendor.css: \
	vendor/codemirror.css \
	vendor/ambiance.css \
	vendor/lint.css \
	vendor/simplescrollbars.css
	cat $^ > $@

vendor/codemirror.css:
	wget "http://codemirror.net/lib/codemirror.css" -O $@
vendor/ambiance.css:
	wget "http://codemirror.net/theme/ambiance.css" -O $@
vendor/lint.css:
	wget "http://codemirror.net/addon/lint/lint.css" -O $@
vendor/codemirror.js:
	wget "http://codemirror.net/lib/codemirror.js" -O $@
vendor/javascript.js:
	wget "http://codemirror.net/mode/javascript/javascript.js" -O $@
vendor/coffeescript.js:
	wget "http://codemirror.net/mode/coffeescript/coffeescript.js" -O $@
vendor/lint.js:
	wget "http://codemirror.net/addon/lint/lint.js" -O $@
vendor/simplescrollbars.js:
	wget "http://codemirror.net/addon/scroll/simplescrollbars.js" -O $@
vendor/simplescrollbars.css:
	wget "http://codemirror.net/addon/scroll/simplescrollbars.css" -O $@
