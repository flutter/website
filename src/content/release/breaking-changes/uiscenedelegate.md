---
title: UISceneDelegate adoption
description: >
  A guide for Flutter iOS developers to adopt Apple's UISceneDelegate protocol.
---

## Summary

Apple now requires iOS developers to adopt the UISceneDelegate protocol, which
changes the order of initialization when applications launch. Certain usages of
Flutter inside `application:didFinishLaunchingWithOptions:` on iOS will have to
be updated.

## Background

Most Flutter apps won't have custom logic inside of
`application:didFinishLaunchingWithOptions:`.
Those apps won't need to do any code migration.
In most cases, Flutter automatically migrates the Info.plist.

Apple now requires the adoption of `UISceneDelegate`, which reorders the
initialization of iOS apps. After a `UISceneDelegate` is specified,
initialization of the Storyboard is delayed until after calling
`application:didFinishLaunchingWithOptions:`. That means
`UIApplicationDelegate.window` and
`UIApplicationDelegate.window.rootViewController` cannot be accessed from
`application:didFinishLaunchingWithOptions:`.

Apple is driving the adoption of the `UISceneDelegate` API since it allows apps
to have multiple instances of their UIs, like multitasking on iPadOS.

Previously, Flutter’s documentation would suggest that
`application:didFinishLaunchingWithOptions:` was a good place to set up platform
channels for users that want easy interop between the host application and
Flutter. That is no longer a reliable place to register these platform channels
since the Flutter engine won’t have been created yet.

## Migration guide

### Info.plist migration

`UISceneDelegate`s must be specified in an app’s Info.plist or specified in
`application:configurationForConnectingSceneSession:options:`. The Flutter tool
will attempt to automatically edit the Info.plist if no `UISceneDelegate` is
specified, so nothing may be required beyond running `flutter run` or `flutter
build` again. Projects can be manually upgraded by adding the following to the
Info.plist. `FlutterSceneDelegate` is the new class in the Flutter framework
that users can use as the `UISceneDelegate`.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
 <key>UIApplicationSceneManifest</key>
 <dict>
  <key>UIApplicationSupportsMultipleScenes</key>
  <false/>
  <key>UISceneConfigurations</key>
  <dict>
  <key>UIWindowSceneSessionRoleApplication</key>
    <array>
      <dict>
        <key>UISceneClassName</key>
        <string>UIWindowScene</string>
        <key>UISceneDelegateClassName</key>
        <string>FlutterSceneDelegate</string>
        <key>UISceneConfigurationName</key>
        <string>flutter</string>
        <key>UISceneStoryboardFile</key>
        <string>Main</string>
      </dict>
    </array>
   </dict>
 </dict>
</dict>
```

As seen in Xcode's editor:

![Xcode plist editor for UISceneDelegate](assets/uiscenedelegate-plist.png)

### Creating platform channels in `application:didFinishLaunchingWithOptions:`

For users creating `FlutterViewController`s programmatically, they can continue
to operate as before. User’s relying on Storyboards (and XIBs) that are creating
platform channels in `application:didFinishLaunchingWithOptions:` should now use
the `FlutterPluginRegistrant` API to accomplish the same thing.

#### Before

{% tabs "darwin-language" %}
{% tab "Swift" %}

```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery",
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // This method is invoked on the UI thread.
      // Handle battery messages.
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

{% endtab %}
{% tab "Obj-C" %}

```objc
@implementation AppDelegate
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

  FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                          methodChannelWithName:@"samples.flutter.dev/battery"
                                          binaryMessenger:controller.binaryMessenger];

  [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
    // This method is invoked on the UI thread.
    // TODO
  }];

  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end
```

{% endtab %}
{% endtabs %}

#### After

{% tabs "darwin-language" %}
{% tab "Swift" %}

```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FlutterPluginRegistrant {
  override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    pluginRegistrant = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func registerPlugins(_ registry: FlutterPluginRegistry) {
    let registrar = registry.registrar(forPlugin: "battery")
    let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery",
                                              binaryMessenger: registrar.messenger)
    batteryChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // This method is invoked on the UI thread.
      // Handle battery messages.
    })

    GeneratedPluginRegistrant.register(with: registry)
  }
}
```

{% endtab %}
{% tab "Obj-C" %}

```objc
@interface AppDelegate () <FlutterPluginRegistrant>
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
  self.pluginRegistrant = self;
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  NSObject<FlutterPluginRegistrar>* registrar = [registry registrarForPlugin:@"battery"];
  FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                          methodChannelWithName:@"samples.flutter.dev/battery"
                                          binaryMessenger:registrar.messenger];

  [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
    // This method is invoked on the UI thread.
    // TODO
  }];

  [GeneratedPluginRegistrant registerWithRegistry:registry];
}
@end
```

{% endtab %}
{% endtabs %}

Set up the `FlutterPluginRegistrant` programmatically through the
`FlutterAppDelegate`.

### Bespoke FlutterViewController usage

For users that are using `FlutterViewController`s instantiated from Storyboards
in `application:didFinishLaunchingWithOptions:` for things other than creating
platform channels, it will be their responsibility to accommodate the new
initialization order.

Migration options:

- Subclass `FlutterViewController` and put the logic in the subclasses’
  `awakeFromNib`.
- Specify a `UISceneDelegate` in the Info.plist or in the
  `UIApplicationDelegate` and put the logic in
  `scene:willConnectToSession:options:`.  See [Apple’s
  documentation](https://developer.apple.com/documentation/uikit/specifying-the-scenes-your-app-supports)
  for more information.

#### Example

```swift
@objc class MyViewController: FlutterViewController {
  override func awakeFromNib() {
    self.awakeFromNib()
    doSomethingWithFlutterViewController(self)
  }
}
```

## Timeline

- Landed in main: TBD
- Landed in stable: TBD
- Unknown: Apple changes their warning to an assert and Flutter apps that
  haven’t adopted `UISceneDelegate` will start crashing on startup with the
  latest SDK.

## References

- https://github.com/flutter/flutter/issues/167267 - The initial reported issue.
- https://developer.apple.com/documentation/uikit/specifying-the-scenes-your-app-supports
  - Apple’s documentation on specifying `UISceneDelegate`s.
