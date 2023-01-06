---
title: iOS FlutterViewController splashScreenView made nullable
description: FlutterViewController splashScreenView changed from nonnull to nullable.
---

## Summary

The `FlutterViewController` property `splashScreenView` has been changed from `nonnull` to `nullable`.

Old declaration of `splashScreenView`:

```objective-c
@property(strong, nonatomic) UIView* splashScreenView;
```

New declaration of `splashScreenView`:

```objective-c
@property(strong, nonatomic, nullable) UIView* splashScreenView;
```

## Context

Prior to this change, on iOS the `splashScreenView` property returned `nil` when no splash screen view
was set, and setting the property to `nil` removed the splash screen view. However, the 
`splashScreenView` API was incorrectly marked `nonnull`. This property is most often used
when transitioning to Flutter views in iOS add-to-app scenarios.

## Description of change

While it was possible in Objective-C to work around the incorrect `nonnull` annotation by setting
`splashScreenView` to a `nil` `UIView`, in Swift this caused a compilation error:
```
error build: Value of optional type 'UIView?' must be unwrapped to a value of type 'UIView'
```
[PR #34743][] updates the property attribute to `nullable`. It can return `nil` and can be set to `nil` to remove the view in both Objective-C and Swift.

## Migration guide

If `splashScreenView` is stored in a `UIView` variable in Swift, update to an optional type `UIView?`.
 
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

Landed in version: TBD  
In stable release: TBD

## References

Relavant PR:
* [Make splashScreenView of FlutterViewController nullable][]

[Make splashScreenView of FlutterViewController nullable]: {{site.github}}/flutter/engine/pull/34743
[PR #34743]: {{site.github}}/flutter/engine/pull/34743