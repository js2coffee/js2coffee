all: dist/js2coffee.min.js

dist/js2coffee.js: lib/*
	mkdir -p dist
	coffee -c lib/js2coffee.coffee
	( cat lib/narcissus_packed.js; cat lib/js2coffee.js ) > dist/js2coffee.js
	rm lib/js2coffee.js

dist/js2coffee.min.js: dist/js2coffee.js
	yuicompressor dist/js2coffee.js > dist/js2coffee.min.js
