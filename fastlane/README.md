fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios set_podspec_version
```
fastlane ios set_podspec_version
```
Sets podspec version to the current tag version.
### ios all_checks
```
fastlane ios all_checks
```
Runs all checks needed for CI to succeed
### ios lint_podspec
```
fastlane ios lint_podspec
```
Lints .podspec file
### ios lint_package
```
fastlane ios lint_package
```
Lint package
### ios test_framework
```
fastlane ios test_framework
```
Run unit tests
### ios test_example_app
```
fastlane ios test_example_app
```
Builds example app

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
