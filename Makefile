all: dist/js2coffee.min.js

.PHONY: test

test:
	coffee test/test.coffee

dist/js2coffee.js: lib/*
	mkdir -p dist
	coffee -c lib/js2coffee.coffee
	( cat lib/narcissus_packed.js; cat lib/js2coffee.js ) > dist/js2coffee.js
	rm lib/js2coffee.js

dist/js2coffee.min.js: dist/js2coffee.js
	# Because YUIcompressor seems to screw it up
	cd dist && ruby -e "require 'jsmin'; File.open('js2coffee.min.js','w') { |f| f.write JSMin.minify(File.read('js2coffee.js')) }"
