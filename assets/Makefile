all: \
	vendor.js \
	vendor.css

vendor.js: \
	vendor/codemirror.js \
	vendor/javascript.js \
	vendor/coffeescript.js
	cat $^ | uglifyjs -m > $@

vendor.css: \
	vendor/codemirror.css \
	vendor/ambiance.css
	cat $^ > $@

vendor/codemirror.css:
	wget "http://codemirror.net/lib/codemirror.css" -O $@
vendor/ambiance.css:
	wget "http://codemirror.net/theme/ambiance.css" -O $@
vendor/codemirror.js:
	wget "http://codemirror.net/lib/codemirror.js" -O $@
vendor/javascript.js:
	wget "http://codemirror.net/mode/javascript/javascript.js" -O $@
vendor/coffeescript.js:
	wget "http://codemirror.net/mode/coffeescript/coffeescript.js" -O $@
