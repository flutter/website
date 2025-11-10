---
title: UISceneDelegate adoption
description: >
  A guide for Flutter iOS developers to adopt Apple's UISceneDelegate protocol.
---

{% render "docs/breaking-changes.md" %}

:::note
This is an upcoming breaking change that has not yet been finalized or
implemented. The current details are provisional and might be altered. Further
announcements will be made as the change approaches implementation.
:::

## Summary

Apple now requires iOS developers to adopt the UIScene life cycle.
This migration has implications on the [app launch
sequence]({{site.apple-dev}}/documentation/uikit/about-the-app-launch-sequence)
and [app life
cycle]({{site.apple-dev}}/documentation/uikit/managing-your-app-s-life-cycle).

## Background

During WWDC25, Apple
[announced]({{site.apple-dev}}/videos/play/wwdc2025/243/?time=1317)
the following:
> In the release following iOS 26, any UIKit app built with the latest SDK will
> be required to use the UIScene life cycle, otherwise it will not launch.

To use the UIScene lifecycle with Flutter, migrate the following support:
* All Flutter apps that support iOS - See the [migration guide for Flutter
  apps](/release/breaking-changes/uiscenedelegate/#migration-guide-for-flutter-apps)
* Flutter embedded in iOS native apps - See the [migration guide for adding
  Flutter to an existing
  app](/release/breaking-changes/uiscenedelegate/#migration-guide-for-adding-flutter-to-existing-app-add-to-app)
* Flutter plugins that use iOS application lifecycle events - See the [migration
  guide for
  plugins](/release/breaking-changes/uiscenedelegate/#migration-guide-for-flutter-plugins)

Migrating to UIScene shifts the AppDelegate's role—the UI lifecycle is
now handled by the UISceneDelegate. The AppDelegate
remains responsible for process events and the overall application
lifecycle. All UI-related logic should be moved from the AppDelegate to the
corresponding UISceneDelegate methods. After migrating to UIScene,
UIKit won't call AppDelegate methods related to UI state.

## Migration guide for Flutter apps

### Auto-Migrate (Experimental)

The Flutter CLI can automatically migrate your app if your AppDelegate has not
been customized.

1. Enable UIScene Migration Feature

```console
flutter config --enable-uiscene-migration
```

2. Build or run your app

```console
flutter run
or
flutter build ios
```

If the migration succeeds, you will see a log that says "Finished migration to
UIScene lifecycle". Otherwise, it warns you to migrate manually using the
included instructions. If the migration succeeds, no further action is required!

### Migrate AppDelegate

Previously, Flutter plugins were registered in
`application:didFinishLaunchingWithOptions:`. To accomodate the new app launch
sequence, plugin registration must now be handled in a new callback called
`didInitializeImplicitFlutterEngine`.

1. Add `FlutterImplicitEngineDelegate` and move `GeneratedPluginRegistrant`.

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

+ - (void)didInitializeImplicitFlutterEngine:(NSObject<FlutterImplicitEngineBridge>*)engineBridge {
+   [GeneratedPluginRegistrant registerWithRegistry:engineBridge.pluginRegistry];
+ }
```

2. Create method channels and platform views in
`didInitializeImplicitFlutterEngine`, if applicable.

If you previously created [method channels][platform-views-docs] or
[platform views][platform-views-docs] in
`application:didFinishLaunchingWithOptions:`,
move that logic to `didInitializeImplicitFlutterEngine`.

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
  func didInitializeImplicitFlutterEngine:(NSObject<FlutterImplicitEngineBridge>*)engineBridge {
    // Register plugins with `engineBridge.pluginRegistry`
    [GeneratedPluginRegistrant registerWithRegistry:engineBridge.pluginRegistry];

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
`application:didFinishLaunchingWithOptions:`, it might result in a crash.
Use the `FlutterImplicitEngineDelegate` protocol instead.

```swift
// BAD
let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
```

To access the `FlutterViewController` directly, visit
[Bespoke FlutterViewController
usage](/release/breaking-changes/uiscenedelegate/#bespoke-flutterviewcontroller-usage).
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

If you implement your own SceneDelegate, you must subclass it with
`FlutterSceneDelegate` or conform to the `FlutterSceneLifeCycleProvider`
protocol. See the [following
examples](/release/breaking-changes/uiscenedelegate/#createupdate-a-scenedelegate-uikit).

### Migrate Info.plist

To complete the migration to the UIScene lifecycle, add an `Application Scene
Manifest` to your Info.plist.

As seen in Xcode's editor:

![Xcode plist editor for
UIApplicationSceneManifest](/assets/images/docs/breaking-changes/uiscenedelegate-plist.png)

As XML:

```xml title="Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "https://www.apple.com/DTDs/PropertyList-1.0.dtd">
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

### Create a SceneDelegate (Optional)

If you need access to the `SceneDelegate`, you can create one by
subclassing `FlutterSceneDelegate`.

1. Open your app in Xcode
2. Right click the **Runner** folder and select **New Empty File**

![New Empty File option in Xcode](/assets/images/docs/breaking-changes/uiscene-new-file.png)

For Swift projects, create a `SceneDelegate.swift`:

```swift title=my_app/ios/Runner/SceneDelegate.swift
import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {

}
```

For Objective-C projects, create a `SceneDelegate.h` and `SceneDelegate.m`:

```objc title=my_app/ios/Runner/SceneDelegate.h
#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>

@interface SceneDelegate : FlutterSceneDelegate

@end
```

```objc title=my_app/ios/Runner/SceneDelegate.m
#import "SceneDelegate.h"

@implementation SceneDelegate

@end
```

3. Change the "Delegate Class Name" (`UISceneDelegateClassName`) in the
Info.plist from `FlutterSceneDelegate` to
`$(PRODUCT_MODULE_NAME).SceneDelegate`.

## Migration guide for adding Flutter to existing app (Add to App)

Similar to the `FlutterAppDelegate`, the `FlutterSceneDelgate` is recommended
but not required. The `FlutterSceneDelgate` forwards scene callbacks, such as
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


### Create/Update a SceneDelegate (SwiftUI)

When using Flutter in a SwifUI app, you can [optionally use a
FlutterAppDelegate](/add-to-app/ios/add-flutter-screen#using-the-flutterappdelegate)
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

2. If your app does not support multiple scenes, set `Enable Multiple Scenes`
to `NO` under `Application Scene Manifest` in your target's Info properties.
This is enabled by default for SwiftUI apps.

![Xcode plist editor for
UIApplicationSceneManifest](/assets/images/docs/breaking-changes/uiscenedelegate-swiftui-info-plist.png)

Otherwise, see [If your app supports multiple
scenes](/release/breaking-changes/uiscenedelegate/#if-your-app-supports-multiple-scenes)
for further instructions.
### If you can't directly make FlutterSceneDelegate a subclass

If you can't directly make `FlutterSceneDelegate` a subclass, you can use the
`FlutterSceneLifeCycleProvider` protocol and
`FlutterPluginSceneLifeCycleDelegate` object to forward scene life cycle events
to Flutter.

```swift title="SceneDelegate.swift" diff
  import Flutter
  import UIKit

- class SceneDelegate: UIResponder, UIWindowSceneDelegate
+ class SceneDelegate: UIResponder, UIWindowSceneDelegate, FlutterSceneLifeCycleProvider
  {
+   var sceneLifeCycleDelegate: FlutterPluginSceneLifeCycleDelegate =
+     FlutterPluginSceneLifeCycleDelegate()

    var window: UIWindow?

    func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions
    ) {
+     sceneLifeCycleDelegate.scene(
+       scene,
+       willConnectTo: session,
+       options: connectionOptions
+     )
    }

    func sceneDidDisconnect(_ scene: UIScene) {
+     sceneLifeCycleDelegate.sceneDidDisconnect(scene)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
+     sceneLifeCycleDelegate.sceneWillEnterForeground(scene)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
+     sceneLifeCycleDelegate.sceneDidBecomeActive(scene)
    }

    func sceneWillResignActive(_ scene: UIScene) {
+     sceneLifeCycleDelegate.sceneWillResignActive(scene)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
+     sceneLifeCycleDelegate.sceneDidEnterBackground(scene)
    }

    func scene(
      _ scene: UIScene,
      openURLContexts URLContexts: Set<UIOpenURLContext>
    ) {
+     sceneLifeCycleDelegate.scene(scene, openURLContexts: URLContexts)
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
+     sceneLifeCycleDelegate.scene(scene, continue: userActivity)
    }

    func windowScene(
      _ windowScene: UIWindowScene,
      performActionFor shortcutItem: UIApplicationShortcutItem,
      completionHandler: @escaping (Bool) -> Void
    ) {
+     sceneLifeCycleDelegate.windowScene(
+       windowScene,
+       performActionFor: shortcutItem,
+       completionHandler: completionHandler
+     )
    }
  }
```
```objc title="SceneDelegate.h" diff
- @interface SceneDelegate : UIResponder <UIWindowSceneDelegate>
+ @interface SceneDelegate : UIResponder <UIWindowSceneDelegate, FlutterSceneLifeCycleProvider>

  @property(strong, nonatomic) UIWindow* window;

+ @property (nonatomic,strong) FlutterPluginSceneLifeCycleDelegate *sceneLifeCycleDelegate;

  @end
```
```objc title="SceneDelegate.m" diff
  @implementation SceneDelegate

  - (instancetype)init {
      if (self = [super init]) {
+         _sceneLifeCycleDelegate = [[FlutterPluginSceneLifeCycleDelegate alloc] init];
      }
      return self;
  }

  - (void)scene:(UIScene*)scene
      willConnectToSession:(UISceneSession*)session
                  options:(UISceneConnectionOptions*)connectionOptions {
+   [self.sceneLifeCycleDelegate scene:scene willConnectToSession:session options:connectionOptions];
  }

  - (void)sceneDidDisconnect:(UIScene*)scene {
+   [self.sceneLifeCycleDelegate sceneDidDisconnect:scene];
  }

  - (void)sceneDidBecomeActive:(UIScene*)scene {
+   [self.sceneLifeCycleDelegate sceneDidBecomeActive:scene];
  }

  - (void)sceneWillResignActive:(UIScene*)scene {
+   [self.sceneLifeCycleDelegate sceneWillResignActive:scene];
  }

  - (void)sceneWillEnterForeground:(UIScene*)scene {
+   [self.sceneLifeCycleDelegate sceneWillEnterForeground:scene];
  }

  - (void)sceneDidEnterBackground:(UIScene*)scene {
+   [self.sceneLifeCycleDelegate sceneDidEnterBackground:scene];
  }

  - (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
+   [self.sceneLifeCycleDelegate scene:scene openURLContexts:URLContexts];
  }

  - (void)scene:(UIScene *)scene continueUserActivity:(NSUserActivity *)userActivity {
+   [self.sceneLifeCycleDelegate scene:scene continueUserActivity:userActivity];
  }

  - (void)windowScene:(UIWindowScene *)windowScene performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
+   [self.sceneLifeCycleDelegate windowScene:windowScene performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
  }
```

### If your app supports multiple scenes

When multiple scenes is enabled (UIApplicationSupportsMultipleScenes), Flutter cannot automatically associate a
`FlutterEngine` with a scene during the scene connection phase. In order for
plugins to receive launch connection information, the `FlutterEngine` must be
manually registered with either the `FlutterSceneDelegate` or
`FlutterPluginSceneLifeCycleDelegate` during
`scene:willConnectToSession:options:`. Otherwise, once the view, created by the
`FlutterViewController` and `FlutterEngine`, is added to the view heirarchy,
the `FlutterEngine` will automatically register for scene events.

```swift title="SceneDelegate.swift"
import Flutter
import FlutterPluginRegistrant
import UIKit

class SceneDelegate: FlutterSceneDelegate {
  let flutterEngine = FlutterEngine(name: "my flutter engine")

  override func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }
    window = UIWindow(windowScene: windowScene)

    flutterEngine.run()
    GeneratedPluginRegistrant.register(with: flutterEngine)

    // If using FlutterSceneDelegate:
    self.registerSceneLifeCycle(with: flutterEngine)

    // If using FlutterSceneLifeCycleProvider:
    // sceneLifeCycleDelegate.registerSceneLifeCycle(with: flutterEngine)

    let viewController = ViewController(engine: flutterEngine)
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
    super.scene(scene, willConnectTo: session, options: connectionOptions)
  }
}
```
```objc title="SceneDelegate.h"
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

@interface SceneDelegate : FlutterSceneDelegate
@property (nonatomic, strong) FlutterEngine *flutterEngine;
@end
```
```objc title="SceneDelegate.m"
#import "SceneDelegate.h"
#import "ViewController.h"

@implementation SceneDelegate

  - (instancetype)init {
      if (self = [super init]) {
         _flutterEngine = [[FlutterEngine alloc] initWithName:@"my flutter engine"];
      }
      return self;
  }

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session
                                            options:(UISceneConnectionOptions *)connectionOptions {
    if (![scene isKindOfClass:[UIWindowScene class]]) {
        return;
    }
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];

    [self.flutterEngine run];
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];

    // If using FlutterSceneDelegate:
    [self registerSceneLifeCycleWithFlutterEngine:self.flutterEngine];

    // If using FlutterSceneLifeCycleProvider:
    // [self.sceneLifeCycleDelegate registerSceneLifeCycleWithFlutterEngine:self.flutterEngine];

    ViewController *viewController = [[ViewController alloc] initWithEngine:self.flutterEngine];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    [super scene:scene willConnectToSession:session options:connectionOptions];
}
@end
```

If you manually register a `FlutterEngine` with a scene, you must also
unregister it if the view created by the `FlutterEngine` changes scenes.

```swift
// If using FlutterSceneDelegate:
self.unregisterSceneLifeCycle(with: flutterEngine)

// If using FlutterSceneLifeCycleProvider:
sceneLifeCycleDelegate.unregisterSceneLifeCycle(with: flutterEngine)
```

```objc
// If using FlutterSceneDelegate:
[self unregisterSceneLifeCycleWithFlutterEngine:self.flutterEngine];

// If using FlutterSceneLifeCycleProvider:
[self.sceneLifeCycleDelegate unregisterSceneLifeCycleWithFlutterEngine:self.flutterEngine];
```

## Migration guide for Flutter plugins

Not all plugins use lifecycle events. If your plugin does, though, you will
need to migrate to UIKit's scene-based lifecycle.

1. Update the Dart and Flutter SDK versions in your pubspec.yaml

```yaml
environment:
  sdk: ^3.10.0-290.1.beta
  flutter: ">=3.38.0-0.1.pre"
```

:::warning
The below Flutter APIs are available in the 3.38.0-0.1.pre beta, but are not
yet available on stable. You might consider publishing a
[prerelease](https://dart.dev/tools/pub/publishing#publishing-prereleases) or
[preview](https://dart.dev/tools/pub/publishing#publish-preview-versions)
version of your plugin to migrate early.
:::

2. Adopt the `FlutterSceneLifeCycleDelegate` protocol

```swift diff
- public final class MyPlugin: NSObject, FlutterPlugin {
+ public final class MyPlugin: NSObject, FlutterPlugin, FlutterSceneLifeCycleDelegate {
```

```objc diff
- @interface MyPlugin : NSObject<FlutterPlugin>
+ @interface MyPlugin : NSObject<FlutterPlugin, FlutterSceneLifeCycleDelegate>
```

3. Registers the plugin as a receiver of `UISceneDelegate` calls.

To continue supporting apps that have not migrated to the UIScene lifecycle yet,
you might consider remaining registered to the App Delegate and keeping the App
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

4. Add one or more of the following scene events that are needed for your
plugin.

Most App Delegate UI events have a 1-to-1 replacement. To see details for each
event, visit Apple's documentation on
[`UISceneDelegate`][] and [`UIWindowSceneDelegate`][].

[`UISceneDelegate`]: {{site.apple-dev}}/documentation/uikit/uiscenedelegate
[`UIWindowSceneDelegate`]: {{site.apple-dev}}/documentation/uikit/uiwindowscenedelegate


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
                 options:(nullable UISceneConnectionOptions*)connectionOptions { }

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

5. Move launch logic from `application:willFinishLaunchingWithOptions:` and
`application:didFinishLaunchingWithOptions:` to
`scene:willConnectToSession:options:`.

Despite `application:willFinishLaunchingWithOptions:` and
`application:didFinishLaunchingWithOptions:` not being deprecated, after
migrating to the `UIScene` lifecycle, the launch options will be `nil`. Any logic
performed here related to the launch options should be moved to the
`scene:willConnectToSession:options:` event.

## Bespoke FlutterViewController usage

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

## Hide Migration Warning
To hide the Flutter CLI warning about migrating to UIScene, add the following
to your pubspec.yaml:

```yaml file="pubspec.yaml" diff
  flutter:
    config:
+     enable-uiscene-migration: false
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
[method-channels-docs]: /platform-integration/platform-channels
[platform-views-docs]: /platform-integration/ios/platform-views
[`openURL`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1623112-application
[local_auth]: {{site.pub}}/packages/local_auth
