bundle := env BUNDLE_GEMFILE=./_/Gemfile bundle
uglifyjs := node_modules/.bin/uglifyjs

default: start

all: \
	assets/vendor.css \
	assets/vendor.js

start: bundle
	mkdir -p _site
	npm exec concurrently "${bundle} exec jekyll build --safe --drafts --watch" "npm exec serve _site"

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
