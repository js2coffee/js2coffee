# Coding Standards

## Core Principles

### Minimalism (Occam's Razor)
If two approaches work and meet our standards, choose the smaller one. Apply this to code length, dependency count, and conceptual complexity.

### Self-Documenting Code
Code must speak for itself. Comments are a code smell indicating something needs fixing later. Only comment when explaining truly confusing behavior that can't be immediately refactored.

Replace `comment_philosophy: "Explain why, not what"` with: eliminate comments by making code clearer.

### Honesty Everywhere
Never allow mock interfaces or test data without clear self-identification. No silent deception in codebases.
This goes for fallback mechanisms too: fallback and graceful degredation should never be silent.

### Vertical Alignment
Align related code vertically to show relationships. Use REPL to generate columnar content when manual alignment is difficult.

## Alignment Examples

From the CoffeeScript example:

```coffee
express    = require 'express'
cors       = require 'cors'

routing    = require './lib/routing'
middleware = require './lib/middleware'
config     = require './lib/config'


URL_PREFIX = "https://#{config.VAULT_SERVER}"


module.exports.app =
  app = express()

middleware.setup(app)
routing   .setup(app)
```

### Alignment Rules

- **Related imports**:       Line up assignment operators
- **Blank lines**:           Separate conceptual sections (imports vs config vs initialization)
- **Method calls**:          Line up dots when calling similar methods (`.setup(app)`)
- **Export pattern**:        `module.exports.foo = foo =` instead of single assignment at end
- **Indentation hierarchy**: Indent continuation lines to show relationship
- **Semantic grouping**:     Don't align unrelated operations even if they look similar
- **Language constraints**:  Respect syntax requirements (Python whitespace) over alignment

### Non-Alignment Indicators

- Different conceptual categories (imports vs assignments vs exports)
- Unrelated operations that happen to have similar structure
- Syntax conflicts in whitespace-sensitive languages

## Output Formatting

Columnar data in output strings should align:

```coffee
console.log """
  Port:            #{config.PORT}
  Environment:     #{config.NODE_ENV or 'development'}
  Repository Path: #{config.REPO_PATH}
  Vault Server:    #{config.VAULT_SERVER}
"""
```

Use variables to reduce redundancy:
```coffee
  URL_PREFIX = "https://#{config.VAULT_SERVER}"
  # Then use URL_PREFIX in output strings
```
## Utility

### Filename tagging

- At or near the top of every file, include a comment following the pattern
  "#{comment_prefix} FILENAME: { #{projectName}/#{directories}/#{filename} } #{comment_suffix_if_any}"
  indicating where you intend that file to go:

```html
  <!-- FILENAME: { ClodExample/static/index.html } -->
```

```coffee
  #!/usr/bin/env coffee
  # FILENAME: { ClodExample/scripts/build }
```

```markdown
  [//] : # ( FILENAME: { ClodExample/docs/README.md } )

  # First Markdown Header
```

If something about the file format in question makes the above difficult or
impossible, mention it in chat.

## Patterns

### Define functions after their first use

```coffee
main ->
  options   = getOptions ()
  ourWorld  =
    options :            options
    display : getDisplay options
    rules   : getRules   options
  
  runGame        ourWorld

  exitGracefully ourWorld

getOptions   = ->
  Object.assign {}, defaultOptions(), overridenOptions()

defaultOptions = ->
  user:
    name:       "player1"
  rules:
    module:     "basic"
    difficulty: "for babies"

overridenOptions = ->
  # look in the usual locations for config files and return their contents

getDisplay   = (options) ->
  # start SDL or WebGL or whatever

getRules     = (options) ->
  # require() some modules referenced in the options

runGame      = (ourWorld) ->
  # event loop

gracefulExit = (ourWorld) ->
  # return resources, close handles, etc
```

### Abstract out repetition into data structures

Express if/else if/else chains as arrays of functions to invoke.

```coffee

objectMap = (o, fn) ->
  Object.keys o
        .map fn

objectInvokeValues = (o) ->
  Object.fromEntries objectMap (k) -> [k, o[k]()]

# Define detectors as a data structure

CAPABILITY_DETECTORS =
  featureName : -> detection logic here
  anotherOne  : -> more detection logic
  
  # Group related detectors visually
  grouped1    : -> similar detection pattern
  grouped2    : -> similar detection pattern
  
  # Separate different patterns with blank lines
  different   : -> different kind of detection

detectCapabilities = -> objectInvokeValues CAPABILITY_DETECTORS

# Later...
capabilities = detectCapabilities()
```

Benefits:

* Extensible: Add/remove capabilities by editing data, not code
* Testable: Can mock detectors for testing
* Readable: Left column shows what, right column shows how
* Composable: Can merge detector sets, filter them, etc.

