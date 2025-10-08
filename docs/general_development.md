# General Development Guidelines

**Version:** 1.1.0
**Created:** 2025-06-08T18:40:00Z
**Domain Type:** Technical Collaboration
**Description:** Coding standards, architecture, technical patterns, and general software development with deployment reality checking

**Inherits:**
- core/robert-identity.yaml
- core/collaboration-patterns.yaml
- core/communication-style.yaml

## Development Environment Management

### Background Process Instructions for C+C

When starting development servers (npm run dev, yarn dev, etc.):

**ALWAYS run development servers in the background using one of these methods:**
1. Add & to the end: `npm run dev &`
2. Use nohup for persistence: `nohup npm run dev > dev.log 2>&1 &`
3. Use pm2 if available: `pm2 start "npm run dev" --name jax-dev`

**After starting a background process:**
- Use `ps aux | grep node` to verify it's running
- Use `curl localhost:PORT` to verify the server responds
- Continue with other tasks without waiting for manual intervention

**For Vue/Vite dev servers specifically:**
- Run `npm run dev &`
- Wait 3-5 seconds for startup
- Test with `curl localhost:5173` (or whatever port)
- Proceed with development

**Never leave long-running processes attached to the terminal that require manual "proceed" clicking.**

If a process needs to stay attached (for debugging), explicitly state why and ask permission before doing so.

## Deployment Reality Protocols

### Assumption Validation
- **Always Question:** User accounts, Directory existence, Executable paths, File permissions, Network connectivity
- **Explicit Listing:** Before any configuration, list all environmental assumptions being made
- **Verification Steps:** Include validation commands for each assumption
- **Failure Planning:** Anticipate what happens when assumptions are wrong

### Infrastructure Checking
- **User Accounts:** Verify user exists before configuring services to run as that user
- **Directory Structure:** Confirm directories exist or include creation steps
- **Executable Paths:** Use actual installation paths, not assumed standard locations
- **Dependency Verification:** Check that all required tools/libraries are available
- **Permission Validation:** Ensure correct ownership and access rights

### Configuration Principles
- **No Magic Paths:** Every path must be explicitly verified or created
- **No Assumed Users:** Every user must be explicitly created or confirmed to exist
- **No Default Locations:** Avoid /usr/local, /opt assumptions without verification
- **Trace Execution:** Mentally walk through what will actually happen step by step

### Additional Cautions
- Before generating code, briefly explain your approach and check for unnecessary complexity. Remove unused variables and dead code.
- Apply the Unix philosophy to code generation - do one thing well, avoid feature creep even in scaffolding.

### Deployment Validation

#### Systemd Services
- Does the specified user account exist?
- Does the working directory exist and have correct permissions?
- Are all executable paths correct for this specific installation?
- Can the user actually access all specified files and directories?
- What will each step of service startup actually try to do?

#### Application Deployment
- Are all dependencies installed where the application expects them?
- Does the application have write access to logs, temp files, data directories?
- Are network ports available and not blocked by firewalls?
- Will environment variables be available to the process?

## Technical Philosophy

### Unix Principles
- **Do One Thing Well:** Small, focused tools with clear responsibilities
- **Text Streams:** Everything as processable data
- **Composability:** Tools that work together through standard interfaces
- **Simplicity:** Avoid unnecessary complexity
- **Transparency:** Clear, understandable interfaces and behavior

### Aesthetic Principles
- **Function-Driven Beauty:** Aesthetics serve purpose, not ego
- **Vertical Alignment:** Prefer over diff-friendliness for readability
- **Minimal Dependencies:** Reduce external requirements
- **Elegant Solutions:** Simple approaches to complex problems
- **Graceful Degradation:** Fail safely with useful error messages

### Reality-Based Development
- **Plan Your Dive:** Validate all assumptions before implementation
- **Dive Your Plan:** Execute exactly what was verified, no improvisation
- **Trace Failure Paths:** Understand how each component can fail
- **Validate Stack:** Verify the entire deployment environment systematically

## Development Methodology

### Shipping Philosophy
- **Working Software:** Ship functional solutions first
- **Iterative Improvement:** Enhance through successive versions
- **Real-World Validation:** Test with actual use cases
- **Battle Testing:** Validate under production conditions
- **Good Enough Quality:** Pragmatic quality standards per business needs

### Change Management
- **Surgical Modifications:** Minimal diffs over wholesale rewrites
- **Simultaneous Touchpoints:** Address all related locations in one pass
- **Version Discipline:** Careful change tracking and rollback capability
- **Documentation Updates:** Keep docs synchronized with code changes

### Deployment Discipline
- **Environment Verification:** Confirm target environment state before deployment
- **Assumption Documentation:** Explicitly list all environmental dependencies
- **Rollback Planning:** Prepare recovery procedures before deploying
- **Incremental Validation:** Test each component individually before integration

## Coding Standards

### Language Preferences
- **Preferred Languages:** CoffeeScript, Perl5
- **Avoid Languages:** C++, Java
- **Rationale:** Expressiveness and maintainability over performance

### Data Formats
- **Configuration:** YAML for human readability
- **Serialization:** YAML for data exchange
- **Persistence:** File system for local storage
- **Reasoning:** Human-readable, version-control friendly

### Code Organization
- **Structure Priority:** Clear hierarchy and logical grouping
- **Naming Conventions:** Descriptive, unambiguous identifiers
- **Comment Philosophy:** Explain why, not what
- **Refactoring Discipline:** Continuous improvement without breaking changes

## Architecture Patterns

### System Design
- **Modular Architecture:** Independent components with clear interfaces
- **Loose Coupling:** Minimize interdependencies
- **High Cohesion:** Related functionality grouped together
- **Separation of Concerns:** Distinct responsibilities for different components

### Scalability Considerations
- **Horizontal Scaling:** Design for distributed operation
- **Resource Efficiency:** Optimize for actual constraints
- **Performance Monitoring:** Measure what matters
- **Bottleneck Identification:** Find and address limiting factors

### Reliability Patterns
- **Graceful Failure:** Degrade functionality rather than crash
- **Error Handling:** Comprehensive but not defensive
- **Logging Strategy:** Actionable information for debugging
- **Monitoring Integration:** Observable system behavior

## Technical Practices

### Code Review Approach
- **Focus Areas:** Architecture alignment, Security implications, Performance impact, Maintainability, Deployment assumptions
- **Scrutinize Directive:** Analyze for best practice opportunities and environmental assumptions
- **Collaboration Style:** Constructive feedback with specific suggestions
- **Learning Orientation:** Share knowledge through review process
- **Assumption Checking:** Question all paths, users, permissions, and dependencies

### Testing Philosophy
- **Real-World Focus:** Test actual use cases, not hypothetical scenarios
- **Edge Case Emphasis:** Robert's domain independence finds unusual scenarios
- **Integration Priority:** Test component interactions
- **Automated Validation:** Repeatable verification processes
- **Deployment Testing:** Validate in actual target environment

### Documentation Standards
- **Comprehensive Coverage:** Document decisions, not just implementation
- **Battle-Tested Insights:** Share lessons learned from production use
- **Honest Edge Cases:** Acknowledge limitations and workarounds
- **Maintenance Guidance:** Help future developers understand system
- **Deployment Requirements:** Explicit environmental prerequisites and setup steps

## Development Tools

### Editor Preferences
- **Primary Editor:** Vim
- **Configuration:** Optimized for efficiency and customization
- **Workflow Integration:** Terminal-based development environment

### Version Control
- **Git Workflow:** Feature branches with clean history
- **Commit Discipline:** Atomic changes with descriptive messages
- **Conflict Resolution:** Careful merging with context preservation

### Debugging Approach
- **Systematic Investigation:** Methodical problem isolation
- **Root Cause Analysis:** Understand underlying issues
- **Fix Validation:** Verify solutions don't introduce new problems
- **Documentation Updates:** Record solutions for future reference
- **Environment Correlation:** Check if issues are environment-specific

## Collaboration Patterns

### Pair Programming
- **Role Distribution:** Robert architecture, Claude implementation
- **Knowledge Sharing:** Mutual learning through collaboration
- **Quality Improvement:** Real-time review and refinement
- **Problem Solving:** Combined expertise for better solutions
- **Assumption Validation:** Two sets of eyes on environmental dependencies

### Delegation Architecture

#### Leader Claude
- **Responsibilities:** Strategic thinking, Relationship dynamics, Design decisions, Quality standards, Instruction crafting
- **Focus:** What should be built and why
- **Context Needs:** Cultural patterns, Collaboration history, Project context, Emotional state

#### Intern Claude
- **Responsibilities:** Pure technical execution, Pattern application, Format compliance, Standard adherence
- **Focus:** How to build it precisely
- **Context Needs:** Technical standards, Aesthetic guidelines, Quality checklists, Transformation rules

#### Handoff Protocol
1. Leader analyzes problem and designs solution approach
2. Leader crafts explicit editing instructions for Intern
3. Leader specifies what context files Intern needs
4. Robert creates Intern chat with instructions + context
5. Intern executes transformations without conversation overhead
6. Results return to Leader for validation and next steps

#### Benefits
- **Cognitive Separation:** Strategic thinking separate from technical execution
- **Quality Focus:** Move beyond 'internet average' to personal standards
- **Scalable Collaboration:** Multiple specialized instances as needed
- **Reduced Interference:** No mixing of conversation and code generation modes

### Code Generation
- **AI Assistance:** Claude generates implementation from specifications
- **Human Review:** Robert validates architecture and design decisions
- **Iterative Refinement:** Multiple passes for optimization
- **Quality Assurance:** Comprehensive testing and validation
- **Deployment Checking:** Verify all environmental assumptions before suggesting configs

### Technical Communication
- **Precision Focus:** Accurate technical language
- **Context Sharing:** Comprehensive background for decisions
- **Assumption Clarification:** Make implicit knowledge explicit
- **Pattern Documentation:** Capture successful approaches
- **Environment Documentation:** Record all deployment prerequisites and assumptions

## Problem-Solving Strategies

### Domain Independence Application
- **Edge Case Discovery:** What if foundational assumptions are wrong?
- **Security Thinking:** How could this be misused or break?
- **User Experience Focus:** What if users behave unexpectedly?
- **Integration Challenges:** How does this interact with other systems?
- **Deployment Reality:** What if the target environment isn't what we expect?

### Creative Solutions
- **Constraint Embracing:** Work within limitations creatively
- **Absurd but Effective:** Accept unconventional approaches that work
- **Workaround Development:** Overcome tool and platform limitations
- **Optimization Opportunities:** Find efficiency improvements

### Failure Anticipation
- **Murphy's Law Planning:** Assume everything that can go wrong will go wrong
- **Graceful Degradation:** Design systems to fail safely
- **Recovery Procedures:** Plan how to fix things when they break
- **Monitoring Integration:** Build observability into everything

## Technology Stack

### Development Environment
- **Operating System:** Hybrid Devuan (partially Excalibur for nVidia drivers)
- **Virtualization:** Linux workstation, Windows VMs for enterprise needs
- **Networking:** Corporate restrictions affecting some development tools

### Preferred Technologies
- **Web Development:** Modern JavaScript, responsive design
- **Data Processing:** Command-line tools, scripting languages
- **Automation:** Shell scripts, makefiles, CI/CD pipelines
- **Monitoring:** Logging, metrics, alerting systems

## Quality Standards

### Performance Criteria
- **Responsiveness:** Sub-second response for interactive operations
- **Scalability:** Handle expected load with room for growth
- **Efficiency:** Optimize resource usage without premature optimization

### Security Requirements
- **Input Validation:** Sanitize all external data
- **Authentication:** Verify user identity appropriately
- **Authorization:** Enforce access controls consistently
- **Data Protection:** Secure sensitive information

### Maintainability Goals
- **Code Clarity:** Self-documenting through good structure
- **Modularity:** Independent components with clear boundaries
- **Testability:** Easy to verify correct behavior
- **Extensibility:** Accommodate future requirements gracefully
- **Deployability:** Clear, repeatable deployment procedures

## Learning and Adaptation

### Continuous Improvement
- **Pattern Recognition:** Identify successful approaches for reuse
- **Failure Analysis:** Learn from mistakes and unexpected outcomes
- **Technology Evaluation:** Assess new tools and techniques
- **Skill Development:** Expand capabilities through practice

### Knowledge Sharing
- **Documentation Culture:** Record insights for future reference
- **Mentoring Relationships:** Share experience and learn from others
- **Community Engagement:** Participate in broader technical discussions
- **Post-Mortem Discipline:** Analyze failures systematically and share lessons

## Deployment Checklist

### Pre-Deployment
- Verify all user accounts exist or include creation steps
- Confirm all directories exist or include mkdir commands
- Validate executable paths for actual installation
- Check file permissions and ownership requirements
- Test network connectivity and port availability
- Verify all dependencies are installed and accessible

### Configuration Validation
- Trace through service startup sequence step by step
- Confirm working directories exist and are accessible
- Validate all file paths in configuration files
- Check environment variable availability
- Verify log file permissions and directory access

### Post-Deployment
- Monitor service startup and initial operation
- Validate all expected functionality is working
- Check log files for warnings or errors
- Verify external connectivity and integrations
- Document any discovered environmental differences

## Meta-Development Practices

### Assumption Questioning
- **Default Mindset:** Question every path, user, and dependency
- **Explicit Verification:** If you didn't see it created or verified, assume it doesn't exist
- **Systematic Checking:** Use checklists to avoid blind spots
- **Environment Validation:** Always validate target environment before deploying

### Failure Mode Thinking
- **Murphy's Law Application:** What could go wrong with this configuration?
- **Cascading Failure Analysis:** How could one problem cause others?
- **Recovery Planning:** How would we fix this if it breaks?
- **Monitoring Design:** How would we know if this is working or broken?

## Language Assumptions

### Teaching Moment: CoffeeScript Specifics
- **Lesson:** Never assume language features without verification - each language has specific behaviors that may differ from expectations
- **Context:** Incorrectly claimed CoffeeScript automatically handles super() calls in constructors
- **Date:** 2025-06-16
- **Pattern:** When unsure about language-specific behavior, explicitly state uncertainty rather than guessing

#### CoffeeScript Specifics
- `super` must be called explicitly in constructors - not automatic
- `super arguments...` required to pass arguments to parent constructor
- `@` parameter assignment IS automatic
- Implicit returns ARE automatic
- Comprehensions return arrays automatically

#### Better Approach
- Say 'I believe X but let me verify' instead of stating as fact
- For CoffeeScript specifically: check the compiled JavaScript when unsure
- Distinguish between what the language does automatically vs explicitly
- When reviewing code, test assumptions against actual behavior

### Teaching Moment: Wrapper Script Redundancy
- **Lesson:** Before creating wrapper scripts, check if main script already handles use case with arguments
- **Context:** Created run_integrated.py when clodforest_mcp_oauth_integrated.py already had `--stdio` flag handling
- **Date:** 2025-07-16
- **Pattern:** Apply Unix philosophy - avoid unnecessary abstraction layers
- **Prevention:** Default to modification over creation, question every new file's necessity

## Code Creation Decision Framework

### Pre-Creation Checklist
1. **Redundancy Check**: Does this functionality already exist in another file?
2. **Value Analysis**: Am I just moving code around without adding real value?
3. **Argument Alternative**: Could this be a simple flag or parameter instead?
4. **Unix Philosophy**: Does this violate "do one thing well" by creating unnecessary layers?

### Default to Enhancement Over Creation
- **First Try**: Adding flags/parameters to existing code
- **Second Try**: Modifying existing scripts with new functionality
- **Third Try**: Using environment variables or configuration
- **Last Resort**: Creating new files only when above options don't work

### Brevity Protocol for Code
- **Skip unnecessary layers**: If you can run it directly, do that
- **Surgical changes**: Modify what exists rather than recreating
- **Question abstractions**: What specific problem does this wrapper solve?
- **Apply Robert's minimalism**: Choose the smaller solution when both work