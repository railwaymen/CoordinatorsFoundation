# CoordinatorsFoundation

[![build status](https://git.railwaymen.org/ios/coordinatorsfoundation/badges/develop/build.svg)](https://git.railwaymen.org/ios/coordinatorsfoundation/pipelines) [![Coverage report](https://git.railwaymen.org/ios/coordinatorsfoundation/badges/develop/coverage.svg)](https://git.railwaymen.org/ios/coordinatorsfoundation/commits/develop)

## Instalation

1. Add pod to your Podfile:

  ```ruby
  pod 'CoordinatorsFoundation'
  ```

2. Install pods:

  ```bash
  bundle exec pod install
  ```

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

## Dependencies

### Gems

- [Cocoapods](https://cocoapods.org) 1.7.5
- [Fastlane](https://fastlane.tools) 2.130.0 ([README](fastlane/README.md))
- [Slather](https://github.com/SlatherOrg/slather) 2.4.7
- [xcode-install](https://github.com/xcpretty/xcode-install) 2.6.0
- [xcov](https://github.com/nakiostudio/xcov) 1.5.1

### CocoaPods

- [SwiftLint](https://cocoapods.org/pods/SwiftLint) 0.34.0 ([Rules](.swiftlint.yml))

## Contribution

### Requirements

- [Bundler](https://bundler.io) 1.16.5
- [Xcode](https://developer.apple.com/xcode/) 10.3 (10G8)

### Configuration

- `bundle install`
- `bundle exec pod install`
- Open `*.xcworkspace` in xcode

### Unit tests

- `bundle exec fastlane test`

### Release

Merge changes to brach named:

```
release/[VERSION_BUMP_TYPE]
```

You should replace `[VERSION_BUMP_TYPE]` with `patch`, `minor` or `major` depending on release type.

Example:

```
release/minor
```
