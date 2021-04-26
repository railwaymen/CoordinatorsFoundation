# CoordinatorsFoundation

[![build status](https://git.railwaymen.org/open/coordinatorsfoundation/badges/develop/pipeline.svg)](https://git.railwaymen.org/open/coordinatorsfoundation/pipelines) [![Coverage report](https://git.railwaymen.org/open/coordinatorsfoundation/badges/develop/coverage.svg)](https://git.railwaymen.org/open/coordinatorsfoundation/commits/develop) [![Swift](https://img.shields.io/badge/Swift-5.1-green.svg?style=flat)](https://swift.org)

## Instalation

### SPM (Swift Package Manager)

Add the repo URL to the project in tab "Swift Packages" and import the CoordinatorsFoundation library.

### CocoaPods

1. Add pod to your Podfile:

  ```ruby
  pod 'CoordinatorsFoundation'
  ```

2. Install pods:

  ```bash
  bundle exec pod install
  ```

## Usage

3. Import framework in your project:

  ```swift
  import CoordinatorsFoundation
  ```

4. Add your implementation for protocols: `DeepLinkOptionable`, `CoordinatorTypeable`. We prefer to implement both as enumerators.

5. Use framework for creating your own app (look for the example app)

  ```swift
  class MyCoordinator: NavigationCoordinator<DeepLinkOption, CoordinatorType> {

  }
  ```

## Target

- iOS 11.4 + Xcode 10.3 (v0.1.2)
- iOS 13 + Xcode 11.2.1 (v0.2.0)
- iOS 13.5 + Xcode 11.5 (v0.3.0)

## Dependencies

### Gems

- [Cocoapods](https://cocoapods.org) 1.10.1
- [Fastlane](https://fastlane.tools) 2.181.0 ([README](fastlane/README.md))
- [Slather](https://github.com/SlatherOrg/slather) 2.7.0
- [xcode-install](https://github.com/xcpretty/xcode-install) 2.6.8

### CocoaPods

- [SwiftLint](https://cocoapods.org/pods/SwiftLint) 0.43.1 ([Rules](.swiftlint.yml))

## Contribution

### Requirements

- [Bundler](https://bundler.io) 2.2.16
- [Xcode](https://developer.apple.com/xcode/) 12.4

### Configuration

#### Framework

- Open the folder with Xcode and you're ready to go!

#### Example app

- Open the main project folder
- Run `bundle install`
- Enter `Example` directory
- Run `bundle exec pod install --repo-update`
- Open the `.xcworkspace` file with Xcode

### Before you push changes

- Run all checks in your console by typing:

 ```
 bundle exec fastlane all_checks
 ```

### Release

Merge changes to `master`. And tag with proper version marked previously in podspec e.g. `1.0.1` Then manually deploy on GitLab
