PORT ?= 3000
bundle := env BUNDLE_GEMFILE=./_/Gemfile bundle
uglifyjs := node_modules/.bin/uglifyjs

all: \
	assets/vendor.css \
	assets/vendor.js

start: bundle
	${bundle} exec jekyll serve --safe --drafts --watch --port 92831 & ./node_modules/.bin/serveur _site -R -p ${PORT}

build: bundle
	${bundle} exec jekyll build --safe

bundle:
	${bundle}

assets/vendor.css: \
	node_modules/codemirror/lib/codemirror.css \
	node_modules/codemirror/theme/ambiance.css \
	node_modules/codemirror/addon/lint/lint.css \
	node_modules/codemirror/addon/scroll/simplescrollbars.css
	cat $^ > $@

assets/vendor.js: \
	node_modules/codemirror/lib/codemirror.js \
	node_modules/codemirror/mode/javascript/javascript.js \
	node_modules/codemirror/mode/coffeescript/coffeescript.js \
	node_modules/codemirror/addon/lint/lint.js \
	node_modules/codemirror/addon/edit/closebrackets.js \
	node_modules/codemirror/addon/edit/matchbrackets.js \
	node_modules/codemirror/addon/scroll/simplescrollbars.js
	cat $^ | $(uglifyjs) -m > $@
