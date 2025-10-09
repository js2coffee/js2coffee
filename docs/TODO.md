# js2coffee Modernization TODO

This document tracks the implementation plan for extending js2coffee to support ES5 through ES.Next.

## Project Overview

**Goal:** Extend js2coffee to handle modern JavaScript syntax (ES5 through ES.Next) by adding a Babel preprocessing stage.

**Strategy:** Two-stage pipeline architecture
1. Stage 1: Babel transpiles ES.Next → ES5/partial ES6 (target for existing Esprima 2.5 parser)
2. Stage 2: Existing js2coffee transforms ES5/ES6 → CoffeeScript

**Rationale:** This approach preserves the battle-tested js2coffee transformation logic while enabling modern JavaScript support through Babel's robust transpilation capabilities.

## Architecture Decisions

### Why Babel Preprocessing?

- **Proven Reliability:** Babel is the industry standard for JavaScript transpilation
- **Comprehensive Support:** Handles all ES.Next features with well-maintained presets
- **Preserve Core Logic:** Keeps js2coffee's CoffeeScript generation intact
- **Incremental Adoption:** Can be added without rewriting existing transforms
- **Future-Proof:** Babel updates handle new JavaScript features automatically

### Target Language Version

**Question:** What should Babel target as output?

**Options:**
1. **ES5 (Full compatibility)** - Esprima 2.5 has full ES5 support
2. **ES5 + Partial ES6** - Esprima 2.5 supports specific ES6 features
3. **Detect supported features** - Map Esprima 2.5 capabilities precisely

**Recommendation:** Start with ES5 target for maximum compatibility, then incrementally enable ES6 features that Esprima 2.5 handles well.

### Esprima 2.5 ES6 Support Analysis

According to the Esprima 2.5.0 changelog, supported ES6 features include:
- Template literals
- Arrow functions
- Classes
- Destructuring
- for-of loops
- Generators
- Module syntax (import/export)
- let/const
- Default parameters
- Rest/spread operators
- Unicode escape sequences
- `new.target`

**Not fully supported or problematic:**
- Async/await (requires polyfills)
- Some advanced ES6+ features

## Implementation Phases

### Phase 0: Research & Planning ✓ COMPLETE

- [x] Analyze current js2coffee architecture
- [x] Research Babel transpilation options
- [x] Determine Esprima 2.5 capabilities
- [x] Document modernization strategy
- [x] Create implementation roadmap

### Phase 0.5: CoffeeScript 2.x Migration 🔥 HIGH PRIORITY

**Goal:** Migrate codebase from deprecated `coffee-script@1.x` to modern `coffeescript@2.x`

**Why This Matters:**
- The original project was likely abandoned due to this migration burden
- `coffee-script` package deprecated in 2017, no security updates
- CoffeeScript 2.x has better ES6+ support and modern features
- Blocking full modernization of the project

**Migration Blockers Identified:**
- ~180 test failures when attempting direct upgrade
- Breaking syntax changes in CoffeeScript 2.x:
  - Stricter `super` call requirements (must include explicit arguments)
  - Class inheritance pattern changes
  - More restrictive indentation/syntax rules

**Implementation Tasks:**

- [ ] Audit all class constructors for `super` calls
  - Create inventory of all classes using inheritance
  - Document current `super` usage patterns
  - Plan migration strategy for each case

- [ ] Create CoffeeScript 2.x compatibility transform script
  - Automated tool to update `super` → `super(args...)`
  - Handle class inheritance patterns systematically
  - Preserve formatting and comments

- [ ] Incremental migration strategy
  - Start with leaf classes (no subclasses)
  - Work up inheritance hierarchy
  - Test each migration step independently

- [ ] Update build tooling for CoffeeScript 2.x
  - Update `coffeeify` or switch to modern alternative
  - Test browserify build process
  - Verify dist bundle generation

- [ ] Fix all test failures systematically
  - Categorize failures by type
  - Fix common patterns first
  - Document edge cases and special handling

- [ ] Update documentation
  - Note CoffeeScript version requirement
  - Document any syntax changes affecting users
  - Update contribution guidelines

**Success Criteria:**
- All 321+ tests passing with `coffeescript@^2.7.0`
- No deprecated dependencies
- Build process working
- Documentation updated

**Estimated Effort:** High - This is a foundational modernization task

**Dependencies:** None - This can (and should) be done before or parallel to other phases

### Phase 1: Development Environment Setup ✓ COMPLETE

**Goal:** Prepare the development environment for Babel integration

- [ ] Add Babel dependencies to package.json
  - `@babel/core`
  - `@babel/preset-env`
  - `@babel/parser` (for comparison/testing)
- [ ] Configure Babel with appropriate presets
  - Create `.babelrc` or `babel.config.js`
  - Set target to ES5 initially
  - Document configuration rationale
- [ ] Update development dependencies
  - Ensure compatibility with existing test framework
  - Update any conflicting dependencies
- [ ] Run existing test suite to establish baseline
  - Document current pass/fail state
  - Identify any existing issues

### Phase 2: Babel Integration Architecture

**Goal:** Design and implement the preprocessing pipeline

- [ ] Design API integration points
  - Determine where Babel fits in the pipeline
  - Preserve existing API compatibility
  - Plan for optional Babel preprocessing (feature flag?)
- [ ] Implement Babel preprocessing module
  - Create `lib/preprocessor/babel.coffee` (or .js)
  - Handle Babel errors gracefully
  - Maintain source maps through the pipeline
- [ ] Modify main entry point (`js2coffee.coffee`)
  - Add preprocessing step before `parseJS()`
  - Ensure backwards compatibility
  - Add configuration option to enable/disable preprocessing
- [ ] Update error handling
  - Preserve line/column information through Babel
  - Merge Babel and js2coffee warnings
  - Test error messages for clarity

### Phase 3: Testing Infrastructure

**Goal:** Ensure the Babel integration works correctly with comprehensive tests

- [ ] Create test fixtures for modern JavaScript
  - ES2015 features (classes, arrow functions, destructuring)
  - ES2016+ features (async/await, optional chaining)
  - ES.Next features (class fields, private methods)
  - Edge cases and complex combinations
- [ ] Add integration tests
  - Test complete pipeline (modern JS → CoffeeScript)
  - Verify source map accuracy
  - Test error handling and reporting
- [ ] Update existing tests
  - Ensure legacy tests still pass
  - Add compatibility mode tests
  - Document any necessary changes
- [ ] Performance benchmarking
  - Measure preprocessing overhead
  - Compare output quality
  - Identify optimization opportunities

### Phase 4: Babel Configuration Tuning

**Goal:** Optimize Babel configuration for best CoffeeScript output

- [ ] Analyze Babel output vs js2coffee expectations
  - Identify problematic transformations
  - Document mapping between Babel output and CoffeeScript idioms
- [ ] Configure Babel plugins selectively
  - Enable only necessary transformations
  - Preserve idioms that translate well to CoffeeScript
  - Disable transformations that make CoffeeScript output worse
- [ ] Test with real-world codebases
  - React components
  - Node.js modules
  - Modern framework code (Vue, Angular, etc.)
- [ ] Optimize for CoffeeScript idioms
  - Preserve arrow functions where beneficial
  - Keep destructuring when CoffeeScript supports it
  - Maintain readability in output

### Phase 5: Documentation & Examples

**Goal:** Document the modernization and provide usage examples

- [ ] Update main README.md
  - Document ES.Next support
  - Explain Babel integration
  - Add modern JavaScript examples
- [ ] Create migration guide for modern JavaScript
  - Document supported features
  - Provide examples for common patterns
  - List known limitations
- [ ] Add modern JavaScript examples
  - Update `notes/Specs.md` with ES.Next examples
  - Create showcase of modern feature support
  - Document best practices
- [ ] Update API documentation
  - Document new configuration options
  - Explain Babel integration settings
  - Provide programmatic usage examples
- [ ] Create changelog entry
  - Document all changes from fork point
  - List new features and improvements
  - Note any breaking changes

### Phase 6: CLI Enhancements

**Goal:** Update command-line interface for modern JavaScript support

- [ ] Add CLI flags for Babel configuration
  - `--babel-target` to specify target version
  - `--no-babel` to disable preprocessing
  - `--babel-config` to specify custom Babel config
- [ ] Update help documentation
  - Document new flags
  - Provide usage examples
  - Explain when to use Babel preprocessing
- [ ] Add version detection
  - Auto-detect when Babel preprocessing is needed
  - Provide helpful messages for unsupported syntax
- [ ] Improve error messages
  - Make Babel errors user-friendly
  - Suggest fixes for common issues
  - Link to documentation

### Phase 7: Optimization & Polish

**Goal:** Refine implementation for production use

- [ ] Performance optimization
  - Cache Babel transformations when possible
  - Optimize for large codebases
  - Profile and eliminate bottlenecks
- [ ] Code quality improvements
  - Add type annotations if using TypeScript/Flow
  - Improve code organization
  - Follow CoffeeScript idioms in implementation
- [ ] Edge case handling
  - Test with unusual input
  - Handle malformed JavaScript gracefully
  - Test with very large files
- [ ] Browser bundle considerations
  - Minimize bundle size impact
  - Consider optional Babel inclusion
  - Test browser API with modern JavaScript

### Phase 8: Release Preparation

**Goal:** Prepare for public release

- [ ] Version numbering strategy
  - Decide on version number (3.0.0?)
  - Document versioning strategy
  - Create release notes
- [ ] Update package metadata
  - Update package.json with new description
  - Add keywords for modern JavaScript
  - Update repository URLs for fork
- [ ] Create release checklist
  - All tests passing
  - Documentation complete
  - Examples working
  - Performance acceptable
- [ ] Plan announcement
  - Document benefits of modernization
  - Provide migration guide
  - Solicit feedback from community

## Technical Decisions to Make

### 1. Babel Target Configuration

**Decision needed:** What should be the default Babel target?

**Options:**
- **Option A:** Target ES5 strictly for maximum compatibility
  - Pros: Guaranteed to work with Esprima 2.5
  - Cons: May produce more verbose output

- **Option B:** Target ES5 + safe ES6 features
  - Pros: Better CoffeeScript output, leverages ES6 → CoffeeScript mappings
  - Cons: Requires careful testing of ES6 feature support

- **Option C:** Configurable target with smart defaults
  - Pros: Flexibility for users, optimal output
  - Cons: More complexity, requires documentation

**Recommendation:** Start with Option A (ES5), then add Option C (configurable) once stable.

### 2. API Design

**Decision needed:** How should users enable Babel preprocessing?

**Options:**
- **Option A:** Always enabled (breaking change)
  - Pros: Simplicity, modern by default
  - Cons: Breaking change, may affect performance

- **Option B:** Opt-in flag (backwards compatible)
  - Pros: Backwards compatible, safe
  - Cons: Users must know to enable it

- **Option C:** Auto-detect (smart default)
  - Pros: Best of both worlds
  - Cons: Complex detection logic

**Recommendation:** Option C (auto-detect) with Option B (flag to force on/off).

### 3. Dependency Management

**Decision needed:** How should Babel be included?

**Options:**
- **Option A:** Required dependency
  - Pros: Always available, simpler code
  - Cons: Increases bundle size

- **Option B:** Peer dependency
  - Pros: Smaller bundle, user control
  - Cons: Users must install manually

- **Option C:** Optional dependency with graceful fallback
  - Pros: Flexible, best for both use cases
  - Cons: More complex code

**Recommendation:** Option A (required dependency) for simplicity, with documentation for users who want minimal bundles.

### 4. Upgrade Path

**Decision needed:** How to handle Esprima upgrade?

**Future consideration:** Should we eventually upgrade Esprima to v4 (full ES6) or beyond?

**Options:**
- **Option A:** Stick with Esprima 2.5 + Babel preprocessing
  - Pros: Proven stability, minimal changes to core
  - Cons: Maintaining old dependency

- **Option B:** Upgrade Esprima to v4+ and update transforms
  - Pros: Native modern JavaScript support, remove Babel dependency
  - Cons: Significant rewrite, risky

- **Option C:** Add Babel now, consider Esprima upgrade later
  - Pros: Incremental approach, lower risk
  - Cons: May result in some churn

**Recommendation:** Option C (Babel now, evaluate Esprima later) - get modern JavaScript working quickly, then optimize.

## Testing Strategy

### Test Coverage Goals

- [ ] Unit tests for Babel preprocessing module
- [ ] Integration tests for full pipeline
- [ ] Regression tests for existing functionality
- [ ] Feature tests for each ES.Next feature category:
  - [ ] ES2015 (ES6): classes, arrows, destructuring, modules
  - [ ] ES2016: exponentiation operator, Array.includes
  - [ ] ES2017: async/await, Object.entries/values
  - [ ] ES2018: rest/spread properties, async iteration
  - [ ] ES2019: optional catch binding, Array.flat
  - [ ] ES2020: optional chaining, nullish coalescing, BigInt
  - [ ] ES2021: logical assignment, numeric separators
  - [ ] ES2022: class fields, top-level await, private methods
  - [ ] ES2023+: latest features

### Test Methodology

1. **Baseline Testing:** Run existing test suite to establish baseline
2. **Feature Testing:** Add tests for each new feature category
3. **Real-World Testing:** Test with actual modern JavaScript projects
4. **Regression Testing:** Ensure old functionality still works
5. **Performance Testing:** Measure overhead of Babel preprocessing

## Success Criteria

### Minimum Viable Product (MVP)

- [ ] Babel preprocessing integrated and working
- [ ] ES2015 (ES6) features fully supported
- [ ] All existing tests passing
- [ ] Basic documentation updated
- [ ] CLI working with modern JavaScript input

### Full Release Goals

- [ ] ES2015-ES2023 features supported
- [ ] Comprehensive test coverage (>90%)
- [ ] Complete documentation
- [ ] Performance overhead <20% vs baseline
- [ ] Real-world codebase testing successful
- [ ] User feedback incorporated

## Known Challenges

### 1. Line Number Preservation (Not Full Source Maps)

**Note:** Full source maps are unnecessary for js2coffee's use case. Users convert `.js` → `.coffee` once and then maintain the CoffeeScript going forward. They never need to map back to the original JavaScript.

**What we need instead:**
- Approximate line number preservation during conversion (via Babel's `retainLines: true`)
- Helpful for debugging conversion issues by comparing input/output side-by-side
- Good enough for one-time conversion process

**Current status:** ✅ Already implemented via Babel config

### 2. Error Message Quality

**Challenge:** Providing helpful errors when Babel preprocessing fails

**Approach:**
- Wrap Babel errors with context
- Maintain line/column accuracy
- Provide actionable error messages

### 3. Performance Impact

**Challenge:** Babel preprocessing adds overhead

**Mitigation:**
- Profile and optimize hot paths
- Consider caching strategies
- Make preprocessing optional for simple inputs

### 4. CoffeeScript Output Quality

**Challenge:** Babel output may not translate elegantly to CoffeeScript

**Approach:**
- Tune Babel configuration for best output
- Selectively enable/disable transformations
- Post-process Babel output if needed

### 5. Dependency Version Management

**Challenge:** Keeping Babel and related dependencies updated

**Approach:**
- Pin Babel versions initially for stability
- Document upgrade procedures
- Test thoroughly before upgrading

## Future Enhancements

### Post-Release Improvements

- [ ] **Browser Bundle Support** (DEFERRED)
  - Current status: Babel too large to bundle with browserify
  - Options to explore: Lighter Babel build, pre-compilation, alternative bundlers
  - Tests created but marked as `describe.skip` for future work
  - Use case: js2coffee.github.io online converter
  - Priority: LOW (Node.js CLI is primary use case)

- [ ] **TypeScript → CoffeeScript pipeline** (HIGH VALUE)
  - Document TypeScript → JavaScript → CoffeeScript conversion workflow
  - Test with real TypeScript codebases
  - Position as "escape hatch" from TypeScript complexity
  - Enable TypeScript users to migrate to CoffeeScript's simplicity

- [ ] Optional Esprima v4+ upgrade path
- [ ] Direct Babel AST to CoffeeScript translation (skip Esprima)
- [ ] JSX/React support
- [ ] Flow type annotation support (strip types)
- [ ] Advanced optimization passes
- [ ] Plugin system for custom transformations
- [ ] Web service API for online conversions
- [ ] Editor integrations (VSCode, Sublime, etc.)
- [ ] Watch mode for continuous conversion

### Research Topics

- [ ] Compare Babel AST vs Esprima AST
- [ ] Investigate direct AST transformation (Babel → CoffeeScript)
- [ ] Explore CoffeeScript v2+ feature mapping
- [ ] Consider alternative parsers (SWC, Acorn, etc.)
- [ ] Research streaming/incremental parsing

## Resources & References

### Documentation

- [Babel Documentation](https://babeljs.io/docs/)
- [Esprima Documentation](https://esprima.org/)
- [CoffeeScript Documentation](https://coffeescript.org/)
- [ESTree Spec](https://github.com/estree/estree)

### Related Projects

- [decaffeinate](https://decaffeinate-project.org/) - CoffeeScript → JavaScript (opposite direction)
- [js2coffee original](https://github.com/js2coffee/js2coffee) - Original project
- [Babel plugins](https://babeljs.io/docs/plugins/) - Available transformations

### Community

- [CoffeeScript Discourse](https://discuss.coffeescript.org/)
- [Babel Slack](https://babeljs.slack.com/)
- [js2coffee Issues](https://github.com/js2coffee/js2coffee/issues) - Learn from original issues

## Notes

### Babel Configuration Example

Initial `.babelrc` to target ES5:

```json
{
  "presets": [
    ["@babel/preset-env", {
      "targets": {
        "ie": "10"
      },
      "modules": false,
      "useBuiltIns": false
    }]
  ],
  "comments": true,
  "sourceMaps": true
}
```

### Integration Point Example

Proposed modification to `js2coffee.build()`:

```coffeescript
js2coffee.build = (source, options = {}) ->
  options.filename ?= 'input.js'
  options.indent ?= 2
  options.source = source
  options.babel ?= true  # Enable Babel by default, or auto-detect

  # NEW: Preprocess with Babel if enabled
  if options.babel
    source = js2coffee.preprocess(source, options)

  ast = js2coffee.parseJS(source, options)
  {ast, warnings} = js2coffee.transform(ast, options)
  {code, map} = js2coffee.generate(ast, options)
  {code, ast, map, warnings}
```

### Testing Checklist Template

For each ES feature:
- [ ] Feature parses correctly
- [ ] Output CoffeeScript is valid
- [ ] Output CoffeeScript is idiomatic
- [ ] Source maps are accurate
- [ ] Error messages are clear
- [ ] Edge cases handled
- [ ] Performance acceptable

---

## Status Tracking

**Current Phase:** Phase 0.5 (CoffeeScript 2.x Migration) - HIGH PRIORITY

**Completed Phases:**
- ✅ Phase 0: Research & Planning
- ✅ Phase 1: Development Environment Setup
- ✅ Phase 2: Babel Integration Architecture
- ✅ Phase 3: Testing Infrastructure

**Phase 1-3 Summary:**
- Added Babel preprocessing with auto-detection
- Created `lib/preprocessor.coffee` module
- Integrated into `js2coffee.build()` pipeline
- Added 18 new tests (14 ES.Next, 4 CLI) - all passing
- Total: 325 tests passing (up from 307 baseline), 49 pending
- No breaking changes to existing API

**CLI & Distribution Issues (Resolved):**
- Fixed CLI to use source files instead of dist bundle (Babel too large for browserify)
- Fixed environmental sensitivity - CLI now works from any directory:
  - `bin/js2coffee` used `__dirname` for absolute path resolution
  - `lib/preprocessor.coffee` uses `require.resolve` with `paths` option for Babel/preset
- Browser bundle deferred as future work (marked as `describe.skip` in tests)
- CLI fully functional with ES.Next support via Node.js

**Critical Blocker Identified:**
- CoffeeScript 1.x → 2.x migration required for full modernization
- Deprecated `coffee-script` package (no updates since 2017)
- ~180 test failures when attempting direct upgrade
- Likely reason original project was abandoned

**Last Updated:** 2025-10-08 (CLI environmental sensitivity fix complete)

**Next Steps (HIGH PRIORITY):**
1. **Begin Phase 0.5: CoffeeScript 2.x Migration**
2. Audit all `super` calls in class constructors
3. Create automated migration tool
4. Fix test failures incrementally
5. Once CoffeeScript 2.x migration complete, continue with Phase 4+
