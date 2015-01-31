spec_files := $(shell find specs)
browserify := ./node_modules/.bin/browserify
uglify := ./node_modules/.bin/uglifyjs

all: \
	notes/Specs.md \
	notes/Special_cases.md \
	dist

notes/Specs.md: $(spec_files)
	./node_modules/.bin/coffee ./lib/support/report_specs.coffee > $@

notes/Special_cases.md: $(spec_files)
	./node_modules/.bin/coffee ./lib/support/report_notes.coffee > $@

dist: dist/js2coffee.js

dist/js2coffee.js: js2coffee.coffee $(shell find lib)
	$(browserify) -t coffeeify --extension=".coffee" -s js2coffee $< | $(uglify) -m > $@
