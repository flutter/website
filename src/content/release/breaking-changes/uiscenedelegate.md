---
title: UISceneDelegate adoption
description: >
  A guide for Flutter iOS developers to adopt Apple's UISceneDelegate protocol.
---

:::note
This is an upcoming breaking change that has not yet been finalized or
implementated. The current details are provisional and may be altered. Further
announcements will be made as the change approaches implementation.
:::

## Summary

Apple now requires iOS developers to adopt UIScene life cycle.
This migration has many implications on [app launch
sequence]({{site.apple-dev}}/documentation/uikit/about-the-app-launch-sequence)
and [app life
cycle]({{site.apple-dev}}/documentation/uikit/managing-your-app-s-life-cycle).

## Background

During WWDC25, Apple
[announced]({{site.apple-dev}}/videos/play/wwdc2025/243/?time=1317)
the following:
> In the release following iOS 26, any UIKit app built with the latest SDK will
> be required to use the UIScene life cycle, otherwise it will not launch.

To use the UIScene lifecycle with Flutter, the following will need to be
migrated:
* All Flutter apps that support iOS - See [Migration guide for Flutter
  apps](http://flutter.dev/release/breaking-changes/uiscenedelegate/#migration-guide-for-flutter-apps)
* Flutter plugins that use iOS application lifecycle events - See [Migration
  guide for
  plugins](http://flutter.dev/release/breaking-changes/uiscenedelegate/#migration-guide-for-flutter-plugins)
* Flutter embedded in iOS native apps - See [Migration guide for adding Flutter
  to existing
  app](http://flutter.dev/release/breaking-changes/uiscenedelegate/#migration-guide-for-adding-flutter-to-existing-app-add-to-app)

Migrating to UIScene shifts the AppDelegate's role. It is no longer in charge
of the UI lifecycle, which is now handled by the UISceneDelegate. The
AppDelegate remains responsible for process events and the overall application
lifecycle. All UI-related logic should be moved from the AppDelegate to the
corresponding UISceneDelegate methods. After migrating to UIScene, UIKit will
stop calling AppDelegate methods that related to UI state.

## Migration guide for Flutter apps

### Migrate AppDelegate

Previously, Flutter plugins were registered in
`application:didFinishLaunchingWithOptions:`. To accomodate the new UIScene
lifecycle, plugin registration must now be done in a new callback called
`didInitializeImplicitFlutterEngine`.

1. Add `FlutterImplicitEngineDelegate` and move `GeneratedPluginRegistrant`

```swift  title="my_app/ios/Runner/AppDelegate.swift" diff
- @objc class AppDelegate: FlutterAppDelegate {
+ @objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
-     GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
  }

+ func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
+   GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
+ }
}
```
```objc title="my_app/ios/Runner/AppDelegate.h" diff
- @interface AppDelegate : FlutterAppDelegate
+ @interface AppDelegate : FlutterAppDelegate <FlutterImplicitEngineDelegate>
```
```objc title="my_app/ios/Runner/AppDelegate.m" diff
  - (BOOL)application:(UIApplication *)application
      didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
-    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
  }

+ - (void)didInitializeImplicitFlutterEngine:(FlutterImplicitEngineBridge*)engineBridge {
+   [GeneratedPluginRegistrant registerWithRegistry:engineBridge.pluginRegistry];
+ }
```

2. Create method channels and platform views in
`didInitializeImplicitFlutterEngine` if applicable

If you were previously creating [method channels][platform-views-docs] or
[platform views][platform-views-docs] in
`application:didFinishLaunchingWithOptions:`, move that logic to
`didInitializeImplicitFlutterEngine`.

```swift
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    // Register plugins with `engineBridge.pluginRegistry`
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    // Create method channels with `engineBridge.applicationRegistrar.messenger()`
    let batteryChannel = FlutterMethodChannel(
      name: "samples.flutter.dev/battery",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )

    // Create platform views with `engineBridge.applicationRegistrar.messenger()`
    let factory = FLNativeViewFactory(messenger: engineBridge.applicationRegistrar.messenger())
  }
```

```objc
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    // Register plugins with `engineBridge.pluginRegistry`
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    // Create method channels with `engineBridge.applicationRegistrar.messenger`
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                          methodChannelWithName:@"samples.flutter.dev/battery"
                                          binaryMessenger:engineBridge.applicationRegistrar.messenger];

    // Create platform views with `engineBridge.applicationRegistrar.messenger`
    FLNativeViewFactory* factory =
      [[FLNativeViewFactory alloc] initWithMessenger:engineBridge.applicationRegistrar.messenger];
  }
```

:::warning
If you try to access the `FlutterViewController` in
`application:didFinishLaunchingWithOptions:`, it may result in a crash. Use the
`FlutterImplicitEngineDelegate` protocol instead.

```swift
// BAD
let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
```

If you need access to the `FlutterViewController` specifically, see [Bespoke
FlutterViewController
usage](http://flutter.dev/release/breaking-changes/uiscenedelegate/#bespoke-flutterviewcontroller-usage)
below.
:::

3. Migrate any custom logic within application life cycle events.

Apple has deprecated application life cycle events related to UI state. After
migrating to UIScene lifecycle, UIKit will no longer call these events.

If you were using one of these depreacted APIs, such as
[`applicationDidBecomeActive`]({{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/applicationdidbecomeactive(_:)),
you will likely need to create a SceneDelegate and migrate to scene life cycle
events. See [Apple's
documenation]({{site.apple-dev}}/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle)
on migrating.

If you implement your own SceneDelegate, you can must subclass it with
`FlutterSceneDelegate` or conform to the `FlutterSceneLifeCycleProvider`
protocol. See examples
[below](https://docs.flutter.dev/release/breaking-changes/uiscenedelegate/#createupdate-a-scenedelegate-uikit).

### Migrate Info.plist

To complete the migration to UIScene lifecycle, add a `Application Scene
Manifest` to your Info.plist with the following:

As seen in Xcode's editor:

![Xcode plist editor for
UIApplicationSceneManifest](/assets/images/docs/breaking-changes/uiscenedelegate-plist.png)

As XML:

```xml title="Info.plist"
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

## Migration guide for Flutter plugins

Not all plugins use lifecycle events. If your plugin does, though, you will
need to migrate to adopt UIKit scene-based lifecycle.

1. Adopt the `FlutterSceneLifeCycleDelegate` protocol

```swift diff
- public final class MyPlugin: NSObject, FlutterPlugin {
+ public final class MyPlugin: NSObject, FlutterPlugin, FlutterSceneLifeCycleDelegate {
```

```objc diff
- @interface MyPlugin : NSObject<FlutterPlugin>
+ @interface MyPlugin : NSObject<FlutterPlugin, FlutterSceneLifeCycleDelegate>
```

2. Registers the plugin as a receiver of `UISceneDelegate` calls.

To continue supporting apps that have not migrated to UIScene lifecycle yet,
you may consider remaining registered to the App Delegate and keeping the App
Delegate events as well.

```swift diff
  public static func register(with registrar: FlutterPluginRegistrar) {
    ...
    registrar.addApplicationDelegate(instance)
+   registrar.addSceneDelegate(instance)
  }
```

```objc diff
  + (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    ...
    [registrar addApplicationDelegate:instance];
+   [registrar addSceneDelegate:instance];
  }
```

3. Add one or more of the following scene events that are needed for your
plugin.

Most App Delegate UI events have a 1-to-1 replacement. To see details on each
event, please see Apple's documentation on
[UISceneDelegate]({{site.apple-dev}}/documentation/uikit/uiscenedelegate)
and
[UIWindowSceneDelegate]({{site.apple-dev}}/documentation/uikit/uiwindowscenedelegate).


```swift
public func scene(
  _ scene: UIScene,
  willConnectTo session: UISceneSession,
  options connectionOptions: UIScene.ConnectionOptions?
) -> Bool { }

public func sceneDidDisconnect(_ scene: UIScene) { }

public func sceneWillEnterForeground(_ scene: UIScene) { }

public func sceneDidBecomeActive(_ scene: UIScene) { }

public func sceneWillResignActive(_ scene: UIScene) { }

public func sceneDidEnterBackground(_ scene: UIScene) { }

public func scene(
    _ scene: UIScene,
    openURLContexts URLContexts: Set<UIOpenURLContext>
  ) -> Bool { }

public func scene(_ scene: UIScene, continue userActivity: NSUserActivity)
    -> Bool { }

public func windowScene(
    _ windowScene: UIWindowScene,
    performActionFor shortcutItem: UIApplicationShortcutItem,
    completionHandler: @escaping (Bool) -> Void
  ) -> Bool { }
```

```objc
- (BOOL)scene:(UIScene*)scene
    willConnectToSession:(UISceneSession*)session
                 options:(nullable UISceneConnectionOptions*)connectionOptions;

- (void)sceneDidDisconnect:(UIScene*)scene { }

- (void)sceneWillEnterForeground:(UIScene*)scene { }

- (void)sceneDidBecomeActive:(UIScene*)scene { }

- (void)sceneWillResignActive:(UIScene*)scene { }

- (void)sceneDidEnterBackground:(UIScene*)scene { }

- (BOOL)scene:(UIScene*)scene openURLContexts:(NSSet<UIOpenURLContext*>*)URLContexts { }

- (BOOL)scene:(UIScene*)scene continueUserActivity:(NSUserActivity*)userActivity { }

- (BOOL)windowScene:(UIWindowScene*)windowScene
    performActionForShortcutItem:(UIApplicationShortcutItem*)shortcutItem
               completionHandler:(void (^)(BOOL succeeded))completionHandler { }
```

4. Due to changes in app launch sequence, plugins will no longer receive the
`application:didFinishLaunchingWithOptions:` event, despite it not being
deprecated. Any logic done here should be moved to the
`scene:willConnectToSession:options:` event.

## Migration guide for adding Flutter to existing app (Add to App)

Similar to the `FlutterAppDelegate`, the `FlutterSceneDelgate` is recommended
but not required. The `FlutterSceneDelgate` fowards scene callbacks such as
[`openURL`][] to plugins such as [local_auth][].

### Create/Update a SceneDelegate (UIKit)

```swift diff
  import UIKit
+ import Flutter

- class SceneDelegate: UIResponder, UIWindowSceneDelegate {
+ class SceneDelegate: FlutterSceneDelegate {
```

```objc diff
- @interface SceneDelegate : UIResponder <UIWindowSceneDelegate>
+ @interface SceneDelegate : FlutterSceneDelegate
```

#### If you can't directly make FlutterSceneDelegate a subclass

If you can't directly make `FlutterSceneDelegate` a subclass, you can use the
`FlutterSceneLifeCycleProvider` protocol and
`FlutterPluginSceneLifeCycleDelegate` object to forward scene life cycle events
to Flutter.

```swift
import Flutter
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate,
  FlutterSceneLifeCycleProvider
{
  var sceneLifeCycleDelegate: FlutterPluginSceneLifeCycleDelegate =
    FlutterPluginSceneLifeCycleDelegate()

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    sceneLifeCycleDelegate.scene(
      scene,
      willConnectTo: session,
      options: connectionOptions
    )
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    sceneLifeCycleDelegate.sceneDidDisconnect(scene)
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    sceneLifeCycleDelegate.sceneWillEnterForeground(scene)
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    sceneLifeCycleDelegate.sceneDidBecomeActive(scene)
  }

  func sceneWillResignActive(_ scene: UIScene) {
    sceneLifeCycleDelegate.sceneWillResignActive(scene)
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    sceneLifeCycleDelegate.sceneDidEnterBackground(scene)
  }

  func scene(
    _ scene: UIScene,
    openURLContexts URLContexts: Set<UIOpenURLContext>
  ) {
    sceneLifeCycleDelegate.scene(scene, openURLContexts: URLContexts)
  }

  func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
    sceneLifeCycleDelegate.scene(scene, continue: userActivity)
  }

  func windowScene(
    _ windowScene: UIWindowScene,
    performActionFor shortcutItem: UIApplicationShortcutItem,
    completionHandler: @escaping (Bool) -> Void
  ) {
    sceneLifeCycleDelegate.windowScene(
      windowScene,
      performActionFor: shortcutItem,
      completionHandler: completionHandler
    )
  }
}
```

### Create/Update a SceneDelegate (SwiftUI)

When using Flutter in a SwifUI app, you can [optionally use a
FlutterAppDelegate](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#using-the-flutterappdelegate)
to receive application events. To migrate that to use UIScene events, you can
make the following changes:

1. Set the Scene Delegate to `FlutterSceneDelegate` in
`application:configurationForConnecting:options:`.
```swift diff
  @Observable
  class AppDelegate: FlutterAppDelegate {
    ...
+   override func application(
+     _ application: UIApplication,
+     configurationForConnecting connectingSceneSession: UISceneSession,
+     options: UIScene.ConnectionOptions
+   ) -> UISceneConfiguration {
+     let configuration = UISceneConfiguration(
+       name: nil,
+       sessionRole: connectingSceneSession.role
+     )
+     configuration.delegateClass = FlutterSceneDelegate.self
+     return configuration
+   }
  }
```

2. Set `Enable Multiple Scenes` to `NO` under `Application Scene Manifest` in your target's
Info properties.

Some event may be lost and may now work properly with multi-scene.

![Xcode plist editor for
UIApplicationSceneManifest](/assets/images/docs/breaking-changes/uiscenedelegate-swiftui-info-plist.png)

### Bespoke FlutterViewController usage

For apps that use a `FlutterViewController` instantiated from Storyboards in
`application:didFinishLaunchingWithOptions:` for reasons other than
creating platform channels, it is their responsibility to
accommodate the new initialization order.

Migration options:

- Subclass `FlutterViewController` and put the logic in
  the subclasses' `awakeFromNib`.
- Specify a `UISceneDelegate` in the `Info.plist` or
  in the `UIApplicationDelegate` and
  put the logic in `scene:willConnectToSession:options:`.
  For more information, check out [Apple's documentation][apple-delegate-docs].

[apple-delegate-docs]: {{site.apple-dev}}/documentation/uikit/specifying-the-scenes-your-app-supports

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
  haven't adopted `UISceneDelegate` will start crashing on startup with the
  latest SDK.

## References

- [Issue 167267][] - The initial reported issue.

[Issue 167267]: {{site.github}}/flutter/flutter/issues/167267
[apple-delegate-docs]: {{site.apple-dev}}/documentation/uikit/specifying-the-scenes-your-app-supports
[method-channels-docs]: https://docs.flutter.dev/platform-integration/platform-channels
[platform-views-docs]: https://docs.flutter.dev/platform-integration/ios/platform-views
[`openURL`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1623112-application
[local_auth]: {{site.pub}}/packages/local_auth