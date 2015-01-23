spec_files := $(shell find specs)

all: \
	notes/Specs.md \
	notes/Special_cases.md

notes/Specs.md: $(spec_files)
	./node_modules/.bin/coffee ./lib/support/report_specs.coffee > $@

notes/Special_cases.md: $(spec_files)
	./node_modules/.bin/coffee ./lib/support/report_notes.coffee > $@
