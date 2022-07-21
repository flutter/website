---
title: iOS FlutterViewController splashScreenView make nullable
description: FlutterViewController splashScreenView changed from nonnull to nullable.
---

## Summary

We changed property `splashScreenView` of `FlutterViewController` from `nonnull` to `nullable`.

Old declaration of `splashScreenView`:

```objective-c
@property(strong, nonatomic) UIView* splashScreenView;
```

New declaration of `splashScreenView`:

```objective-c
@property(strong, nonatomic, nullable) UIView* splashScreenView;
```

## Context

This allows iOS add-to-app users writen in `Swift` to remove the splash screen view.

However, the previous declaration would build error when set `nil` value using `Swift`, only supported if using `Objective-C`.

## Description of change

Before migrated, it would be a compilation error if the calling code is in Swift and gets the splash screen and stores in a nonnull UIView variable.

```
error build: Value of optional type 'UIView?' must be unwrapped to a value of type 'UIView'
```

After [PR #34743][], you need to update code to instead store in a UIView?. Instead of declare variable `splashScreenView` as type `UIView`:

```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  var splashScreenView = UIView()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    var flutterEngine = FlutterEngine(name: "my flutter engine")
    let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    splashScreenView = flutterViewController.splashScreenView // compilation error: Value of optional type 'UIView?' must be unwrapped to a value of type 'UIView'
```

instead use `UIView?`:

```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  var splashScreenView : UIView? = UIView()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    var flutterEngine = FlutterEngine(name: "my flutter engine")
    let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    let splashScreenView = flutterViewController.splashScreenView // compiles successfully
    if let splashScreenView = splashScreenView {
      
    }
```


## Migration guide

Code before migration:

```swift
  var splashScreenView = UIView()
  var flutterEngine = FlutterEngine(name: "my flutter engine")
  let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
  splashScreenView = flutterViewController.splashScreenView // compilation error: Value of optional type 'UIView?' must be unwrapped to a value of type 'UIView'
```

Code after migration:

```swift
  var splashScreenView : UIView? = UIView()
  var flutterEngine = FlutterEngine(name: "my flutter engine")
  let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
  let splashScreenView = flutterViewController.splashScreenView // compiles successfully
  if let splashScreenView = splashScreenView {
  }
```

## Timeline

In stable release: not yet

## References

Related PR [][PR #34743] Make splashScreenView of FlutterViewController nullable

[PR #34743]: {{site.github}}/flutter/engine/pull/34743