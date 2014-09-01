all: Specs.md Special_cases.md

Specs.md: dummy
	../node_modules/.bin/coffee ../lib/report_specs.coffee > $@

Special_cases.md: dummy
	../node_modules/.bin/coffee ../lib/report_notes.coffee > $@

dummy:

.PHONY: dummy
