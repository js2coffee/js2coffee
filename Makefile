all: dist/js2coffee.min.js demo

.PHONY: demo

dist/js2coffee.js: lib/*
	mkdir -p dist
	coffee -c lib/js2coffee.coffee
	( cat lib/narcissus_packed.js; cat lib/js2coffee.js ) > dist/js2coffee.js
	rm lib/js2coffee.js

dist/js2coffee.min.js: dist/js2coffee.js
	# Because YUIcompressor seems to screw it up
	cd dist && ruby -e "require 'jsmin'; File.open('js2coffee.min.js','w') { |f| f.write JSMin.minify(File.read('js2coffee.js')) }"

demo: demo/ace.js demo/mode-javascript.js demo/js2coffee.min.js demo/mode-coffee.js

demo/js2coffee.js: dist/js2coffee.js
	cp dist/js2coffee.js demo/js2coffee.js

demo/js2coffee.min.js: dist/js2coffee.min.js
	cp dist/js2coffee.min.js demo/js2coffee.min.js

demo/ace.js:
	mkdir -p demo
	wget "http://ajaxorg.github.com/ace/build/src/ace.js" -O demo/ace.js

demo/theme-twilight.js:
	mkdir -p demo
	wget "http://ajaxorg.github.com/ace/build/src/theme-twilight.js" -O demo/theme-twilight.js

demo/mode-javascript.js:
	mkdir -p demo
	wget "http://ajaxorg.github.com/ace/build/src/mode-javascript.js" -O demo/mode-javascript.js

demo/mode-coffee.js:
	mkdir -p demo
	wget "http://ajaxorg.github.com/ace/build/src/mode-coffee.js" -O demo/mode-coffee.js
