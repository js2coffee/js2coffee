## Thank you!
Before anything else, thank you. Thank you for taking some of your precious time helping this project move forward.

**Table of contents**

- [Contributing to Js2coffee](#reporting)
  - [Creating a Bug Report](#bugreport)
    - [js2coffee.org isn't up to date!](#website)
    - [Behaviour of CoffeeScript](#coffeeScript)
  - [Creating a Pull Request](#pullRequest)
  - [Setting Up a Development Environment](#dev)

<a name="reporting" />
## Contributing to Js2coffee
If you've found a bug in Js2coffee, this is the place to start. You'll need to create a (free) GitHub account in order to submit an issue, to comment on them or to create pull requests.

<a name="bugreport" />
## Creating a Bug Report
If you've found a problem in Js2coffee use the [Issue Tracker](https://github.com/rstacruz/js2coffee/issues). If you find no issue addressing it you can add a new one.

With your bug report, specify:

- **what you did**
- **what happened**
- **what you expected**
- your Js2coffee version `js2coffee -v` or look it up in the package.json
- your node version `node -v`
- your npm version `npm -v`
- your OS, architecture and version


If you've found multiple bugs, which are not reported already, you should create **one issue per bug**.

<a name="website" />
### js2coffee.org isn't up to date!
The website [js2coffee.org](http://js2coffee.org) contains an **old version** of Js2coffee.
When you reporting a bug, ensure that you use the latest version.  
This will be fixed soon.

<a name="coffeeScript" />
### Behaviour of CoffeeScript
Remind that CoffeeScript itself has some special restrictions [[1]](http://https://github.com/michaelficarra/CoffeeScriptRedux/wiki/Intentional-Deviation-From-jashkenas-coffee-script)[[2]](http://ceronman.com/2012-09-17/coffeescript-less-typing-bad-readability) and also bugs.
So if your want to report a bug, ensure that it's neither a feature nor a bug of CoffeeScript.

<a name="pullRequest" />
## Creating a Pull Request
As a next step beyond reporting issues, you can help the project resolve existing issues. If you check the Everyone's Issues list in GitHub Issues, you'll find lots of issues already requiring attention. What can you do for these? Quite a bit, actually:

For starters, it helps just to **verify bug reports**. Can you reproduce the reported issue on your own computer? If so, you can add a comment to the issue saying that you're seeing the same thing.

If something is very vague, can you help squash it down into something specific? Maybe you can **provide additional information** to help reproduce a bug, or help by eliminating needless steps that aren't required to demonstrate the problem.

Anything you can do to make bug reports more succinct or easier to reproduce is a help to folks trying to **write code** to fix those bugs - whether you end up writing the code yourself or not.

If you need help to create a pull request, read this github help guide: [Creating a pull request](https://help.github.com/articles/creating-a-pull-request)

<a name="dev" />
## Setting Up a Development Environment

1. Fork this repository by clicking on the fork button
2. Clone the forked repository to your machine:  
  `git clone https://github.com/<USERNAME>/js2coffee.git`
3. Jump into the new directory `cd js2coffee` and do a `npm install`

Since Js2coffee is written in CoffeeScript, you need to compile it into JavaScript. This project uses DocPad for the build process.
You can use these commands for development:

- `npm run-script compile` - compile and test
- `npm test` - only run the test
- `npm run-script watch` - compile and test changes as they happen

These commands are defined in the `package.json` and those commands in turn are defined in the Cakefile. You can also use `cake` which comes with CoffeeScript.
