---
title: UISceneDelegate adoption
description: >-
  Learn how to migrate your Flutter iOS app, add-to-app integration, or plugin
  to Apple's required UIScene lifecycle using FlutterSceneDelegate.
---

{% render "docs/breaking-changes.md" %}

:::important
As of the Flutter 3.41 release,
`UIScene` support is the default for iOS apps, and
eligible apps are migrated automatically.
:::

## Summary

Apple now requires iOS developers to adopt the `UIScene` lifecycle.
This migration has implications for the
[app launch sequence][] and [app lifecycle][].

[app launch sequence]: {{site.apple-dev}}/documentation/uikit/about-the-app-launch-sequence
[app lifecycle]: {{site.apple-dev}}/documentation/uikit/managing-your-app-s-life-cycle

## Background

During WWDC25, Apple [announced][uiscene-announcement] the following:

> In the release following iOS 26, any UIKit app built with the latest SDK will
> be required to use the UIScene life cycle, otherwise it will not launch.

To adopt the `UIScene` lifecycle,
follow the guide that corresponds to your use case:

* For all Flutter apps that support iOS,
  follow the [migration guide for Flutter apps][].
* For Flutter apps embedded in existing native iOS apps,
  follow the [migration guide for add-to-app][].
* For Flutter plugins that use iOS application lifecycle events,
  follow the [migration guide for Flutter plugins][].

Migrating to `UIScene` shifts the role of the `AppDelegate`:
the `UISceneDelegate` now handles the UI lifecycle,
while the `AppDelegate` remains responsible for
process events and the overall application lifecycle.

Move all UI-related logic from the `AppDelegate` to the
corresponding `UISceneDelegate` methods.
After you migrate to `UIScene`, UIKit no longer
calls `AppDelegate` methods related to UI state.

[uiscene-announcement]: {{site.apple-dev}}/videos/play/wwdc2025/243/?time=1317
[migration guide for Flutter apps]: #migrate-a-flutter-app
[migration guide for add-to-app]: #migrate-an-add-to-app-integration
[migration guide for Flutter plugins]: #migrate-a-flutter-plugin

<a id="migration-guide-for-flutter-apps" aria-hidden="true"></a>

## Migrate a Flutter app

### Auto-migrate

As of Flutter 3.41, `UIScene` is supported by default.
If your `AppDelegate` hasn't been customized,
the Flutter CLI automatically migrates your app.

To trigger the migration, build or run your app with
the `flutter run` or `flutter build ios` commands.
If the migration succeeds,
the CLI outputs `Finished migration to UIScene lifecycle` and
no further action is required.
Otherwise, the CLI warns you and
provides instructions to migrate manually.

### Migrate AppDelegate

Previously, Flutter plugins were registered in
`application:didFinishLaunchingWithOptions:`.
To accommodate the new app launch sequence,
you must now register plugins in a
new `didInitializeImplicitFlutterEngine` callback.

 1. Conform your `AppDelegate` to the `FlutterImplicitEngineDelegate`
    protocol and move the `GeneratedPluginRegistrant` registration to
    `didInitializeImplicitFlutterEngine`.

    <Tabs key="ios-language-switcher">
    <Tab name="Swift">

    ```swift title="my_app/ios/Runner/AppDelegate.swift" diff
    - @objc class AppDelegate: FlutterAppDelegate {
    + @objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
        override func application(
          _ application: UIApplication,
          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
    -     GeneratedPluginRegistrant.register(with: self)
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }

    +   func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    +     GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    +   }
      }
    ```

    </Tab>
    <Tab name="Objective-C">

    ```objc title="my_app/ios/Runner/AppDelegate.h" diff
    - @interface AppDelegate : FlutterAppDelegate
    + @interface AppDelegate : FlutterAppDelegate <FlutterImplicitEngineDelegate>
    ```

    ```objc title="my_app/ios/Runner/AppDelegate.m" diff
      - (BOOL)application:(UIApplication *)application
          didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    -   [GeneratedPluginRegistrant registerWithRegistry:self];
        return [super application:application didFinishLaunchingWithOptions:launchOptions];
      }

    + - (void)didInitializeImplicitFlutterEngine:(NSObject<FlutterImplicitEngineBridge>*)engineBridge {
    +   [GeneratedPluginRegistrant registerWithRegistry:engineBridge.pluginRegistry];
    + }
    ```

    </Tab>
    </Tabs>

 1. If applicable, create method channels and platform views in
    `didInitializeImplicitFlutterEngine`.

    If you previously created [method channels][] or [platform views][]
    in `application:didFinishLaunchingWithOptions:`,
    move that logic to `didInitializeImplicitFlutterEngine`.

    <Tabs key="ios-language-switcher">
    <Tab name="Swift">

    ```swift
    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
      // Register plugins with `engineBridge.pluginRegistry`:
      GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

      // Create method channels with `engineBridge.applicationRegistrar.messenger()`:
      let batteryChannel = FlutterMethodChannel(
        name: "samples.flutter.dev/battery",
        binaryMessenger: engineBridge.applicationRegistrar.messenger()
      )

      // Create platform views with `engineBridge.applicationRegistrar.messenger()`:
      let factory = FLNativeViewFactory(messenger: engineBridge.applicationRegistrar.messenger())
    }
    ```

    </Tab>
    <Tab name="Objective-C">

    ```objc
    - (void)didInitializeImplicitFlutterEngine:(NSObject<FlutterImplicitEngineBridge>*)engineBridge {
      // Register plugins with `engineBridge.pluginRegistry`:
      [GeneratedPluginRegistrant registerWithRegistry:engineBridge.pluginRegistry];

      // Create method channels with `engineBridge.applicationRegistrar.messenger`:
      FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
          methodChannelWithName:@"samples.flutter.dev/battery"
                binaryMessenger:engineBridge.applicationRegistrar.messenger];

      // Create platform views with `engineBridge.applicationRegistrar.messenger`:
      FLNativeViewFactory* factory =
          [[FLNativeViewFactory alloc] initWithMessenger:engineBridge.applicationRegistrar.messenger];
    }
    ```

    </Tab>
    </Tabs>

    :::warning
    If you try to access the `FlutterViewController` in
    `application:didFinishLaunchingWithOptions:`, your app might crash.
    Use the `FlutterImplicitEngineDelegate` protocol instead.

    ```swift
    // BAD
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    ```

    To access the `FlutterViewController` directly,
    check out [Bespoke FlutterViewController usage][].
    :::

 1. Migrate any custom logic within application lifecycle events.

    Apple has deprecated application lifecycle events related to UI state.
    After you migrate to the `UIScene` lifecycle,
    UIKit no longer calls these events.

    If you used one of these deprecated APIs,
    such as [`applicationDidBecomeActive`][],
    you likely need to create a `SceneDelegate` and
    migrate to scene lifecycle events.
    To learn more, see [Apple's documentation][] on migrating.

    If you implement your own `SceneDelegate`,
    you must subclass `FlutterSceneDelegate` or
    conform to the `FlutterSceneLifeCycleProvider` protocol.
    For examples, see [Create or update a SceneDelegate][].

[method channels]: /platform-integration/platform-channels
[platform views]: /platform-integration/ios/platform-views
[Bespoke FlutterViewController usage]: #bespoke-flutterviewcontroller-usage
[`applicationDidBecomeActive`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/applicationdidbecomeactive
[Apple's documentation]: {{site.apple-dev}}/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle
[Create or update a SceneDelegate]: #create-or-update-a-scenedelegate

### Migrate Info.plist

To complete the migration to the `UIScene` lifecycle,
add an **Application Scene Manifest** entry to your `Info.plist`.

As shown in Xcode's editor:

![Xcode plist editor for UIApplicationSceneManifest](/assets/images/docs/breaking-changes/uiscenedelegate-plist.png)

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
</plist>
```

### Create a SceneDelegate (optional)

If you need access to the `SceneDelegate`,
you can create one by subclassing `FlutterSceneDelegate`:

 1. Open your app in Xcode.

 1. Right-click the **Runner** folder, then select **New Empty File**.

    ![New Empty File option in Xcode](/assets/images/docs/breaking-changes/uiscene-new-file.png)

 1. Create your `SceneDelegate` class.

    <Tabs key="ios-language-switcher">
    <Tab name="Swift">

    For Swift projects,
    create a `SceneDelegate.swift` file:

    ```swift title="my_app/ios/Runner/SceneDelegate.swift"
    import Flutter
    import UIKit

    class SceneDelegate: FlutterSceneDelegate {}
    ```

    </Tab>
    <Tab name="Objective-C">

    For Objective-C projects,
    create a `SceneDelegate.h` and a `SceneDelegate.m` file:

    ```objc title="my_app/ios/Runner/SceneDelegate.h"
    #import <Flutter/Flutter.h>
    #import <UIKit/UIKit.h>

    @interface SceneDelegate : FlutterSceneDelegate

    @end
    ```

    ```objc title="my_app/ios/Runner/SceneDelegate.m"
    #import "SceneDelegate.h"

    @implementation SceneDelegate

    @end
    ```

    </Tab>
    </Tabs>

 1. In your `Info.plist` file,
    change the **Delegate Class Name** (`UISceneDelegateClassName`) value
    from `FlutterSceneDelegate` to your new class.

    <Tabs key="ios-language-switcher">
    <Tab name="Swift">

    For Swift projects, use `$(PRODUCT_MODULE_NAME).SceneDelegate`:

    ```xml title="Info.plist" highlightLines=10-11
    <key>UIApplicationSceneManifest</key>
    <dict>
      <!-- ... -->
      <key>UISceneConfigurations</key>
      <dict>
        <key>UIWindowSceneSessionRoleApplication</key>
        <array>
          <dict>
            <!-- ... -->
            <key>UISceneDelegateClassName</key>
            <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
            <!-- ... -->
          </dict>
        </array>
      </dict>
    </dict>
    ```

    </Tab>
    <Tab name="Objective-C">

    For Objective-C projects, use `SceneDelegate`:

    ```xml title="Info.plist" highlightLines=10-11
    <key>UIApplicationSceneManifest</key>
    <dict>
      <!-- ... -->
      <key>UISceneConfigurations</key>
      <dict>
        <key>UIWindowSceneSessionRoleApplication</key>
        <array>
          <dict>
            <!-- ... -->
            <key>UISceneDelegateClassName</key>
            <string>SceneDelegate</string>
            <!-- ... -->
          </dict>
        </array>
      </dict>
    </dict>
    ```

    </Tab>
    </Tabs>

<a id="migration-guide-for-adding-flutter-to-existing-app-add-to-app" aria-hidden="true"></a>

## Migrate an add-to-app integration

Similar to the `FlutterAppDelegate`,
the `FlutterSceneDelegate` is recommended but not required.
The `FlutterSceneDelegate` forwards scene callbacks,
such as [`openURL`][], to plugins such as [`local_auth`][].

[`openURL`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1623112-application
[`local_auth`]: {{site.pub}}/packages/local_auth

<a id="createupdate-a-scenedelegate" aria-hidden="true"></a>

### Create or update a SceneDelegate

<Tabs key="ios-framework-switcher">
<Tab name="UIKit-Swift">

```swift diff
  import UIKit
+ import Flutter

- class SceneDelegate: UIResponder, UIWindowSceneDelegate {
+ class SceneDelegate: FlutterSceneDelegate {
```

</Tab>
<Tab name="UIKit-ObjC">

```objc diff
- @interface SceneDelegate : UIResponder <UIWindowSceneDelegate>
+ @interface SceneDelegate : FlutterSceneDelegate
```

</Tab>
<Tab name="SwiftUI">

When using Flutter in a SwiftUI app,
you can [optionally use a `FlutterAppDelegate`][flutter-app-delegate]
to receive application events.
To migrate it to receive `UIScene` events, 
make the following changes:

 1. Set the scene delegate to `FlutterSceneDelegate` in
    `application:configurationForConnecting:options:`:

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

 1. If your app doesn't support multiple scenes,
    set **Enable Multiple Scenes** to **NO** under
    **Application Scene Manifest** in your target's Info properties.
    Multiple-scene support is enabled by default for SwiftUI apps.

    ![Xcode plist editor for UIApplicationSceneManifest](/assets/images/docs/breaking-changes/uiscenedelegate-swiftui-info-plist.png)

    If your app does support multiple scenes,
    see [If your app supports multiple scenes][] for further instructions.

</Tab>
</Tabs>

[flutter-app-delegate]: /add-to-app/ios/add-flutter-screen#using-the-flutterappdelegate
[If your app supports multiple scenes]: #if-your-app-supports-multiple-scenes

<a id="if-you-cant-directly-make-flutterscenedelegate-a-subclass" aria-hidden="true"></a>

### If you can't subclass FlutterSceneDelegate

If you can't subclass `FlutterSceneDelegate`,
use the `FlutterSceneLifeCycleProvider` protocol and a
`FlutterPluginSceneLifeCycleDelegate` object to
forward scene lifecycle events to Flutter.

<Tabs key="ios-language-switcher">
<Tab name="Swift">

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

</Tab>
<Tab name="Objective-C">

```objc title="SceneDelegate.h" diff
- @interface SceneDelegate : UIResponder <UIWindowSceneDelegate>
+ @interface SceneDelegate : UIResponder <UIWindowSceneDelegate, FlutterSceneLifeCycleProvider>

  @property(strong, nonatomic) UIWindow* window;

+ @property(nonatomic, strong) FlutterPluginSceneLifeCycleDelegate* sceneLifeCycleDelegate;

  @end
```

```objc title="SceneDelegate.m" diff
  @implementation SceneDelegate

  - (instancetype)init {
    if (self = [super init]) {
+     _sceneLifeCycleDelegate = [[FlutterPluginSceneLifeCycleDelegate alloc] init];
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

  - (void)scene:(UIScene*)scene openURLContexts:(NSSet<UIOpenURLContext*>*)URLContexts {
+   [self.sceneLifeCycleDelegate scene:scene openURLContexts:URLContexts];
  }

  - (void)scene:(UIScene*)scene continueUserActivity:(NSUserActivity*)userActivity {
+   [self.sceneLifeCycleDelegate scene:scene continueUserActivity:userActivity];
  }

  - (void)windowScene:(UIWindowScene*)windowScene
      performActionForShortcutItem:(UIApplicationShortcutItem*)shortcutItem
                 completionHandler:(void (^)(BOOL))completionHandler {
+   [self.sceneLifeCycleDelegate windowScene:windowScene
+             performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
  }
```

</Tab>
</Tabs>

### If your app supports multiple scenes

When multiple scenes are enabled (`UIApplicationSupportsMultipleScenes`),
Flutter can't automatically connect a `FlutterEngine` to its
corresponding `UIScene` during the initial scene connection phase.

To ensure that Flutter plugins can receive the initial scene setup options
(such as deep link URLs or shortcut items passed inside the
`UIScene.ConnectionOptions` payload), you must manually register the
`FlutterEngine` with either your `FlutterSceneDelegate` or your
`FlutterPluginSceneLifeCycleDelegate` inside the
`scene:willConnectToSession:options:` method.

If you don't perform this manual registration,
the `FlutterEngine` still registers itself automatically once the view
created by the `FlutterViewController` is added to the active view hierarchy.
However, by that point, the engine and its plugins have already missed
any launch connection events passed during `willConnectToSession:`.

<Tabs key="ios-language-switcher">
<Tab name="Swift">

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

</Tab>
<Tab name="Objective-C">

```objc title="SceneDelegate.h"
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

@interface SceneDelegate : FlutterSceneDelegate
@property(nonatomic, strong) FlutterEngine *flutterEngine;
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

- (void)scene:(UIScene *)scene
    willConnectToSession:(UISceneSession *)session
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

</Tab>
</Tabs>

If you manually register a `FlutterEngine` with a scene,
you must also unregister it if the view
created by the `FlutterEngine` changes scenes.

<Tabs key="ios-language-switcher">
<Tab name="Swift">

```swift
// If using FlutterSceneDelegate:
self.unregisterSceneLifeCycle(with: flutterEngine)

// If using FlutterSceneLifeCycleProvider:
sceneLifeCycleDelegate.unregisterSceneLifeCycle(with: flutterEngine)
```

</Tab>
<Tab name="Objective-C">

```objc
// If using FlutterSceneDelegate:
[self unregisterSceneLifeCycleWithFlutterEngine:self.flutterEngine];

// If using FlutterSceneLifeCycleProvider:
[self.sceneLifeCycleDelegate unregisterSceneLifeCycleWithFlutterEngine:self.flutterEngine];
```

</Tab>
</Tabs>

<a id="migration-guide-for-flutter-plugins" aria-hidden="true"></a>

## Migrate a Flutter plugin

Not all plugins use lifecycle events.
However, if your plugin does,
migrate it to UIKit's scene-based lifecycle as follows:

 1. Update the Dart and Flutter SDK versions in your `pubspec.yaml`.

    The APIs required for this migration are available
    starting in Flutter 3.38:

    ```yaml title="pubspec.yaml"
    environment:
      sdk: ^3.10.0
      flutter: ">=3.38.0"
    ```

 1. Adopt the `FlutterSceneLifeCycleDelegate` protocol.

    <Tabs key="ios-language-switcher">
    <Tab name="Swift">

    ```swift diff
    - public final class MyPlugin: NSObject, FlutterPlugin {
    + public final class MyPlugin: NSObject, FlutterPlugin, FlutterSceneLifeCycleDelegate {
    ```

    </Tab>
    <Tab name="Objective-C">

    ```objc diff
    - @interface MyPlugin : NSObject<FlutterPlugin>
    + @interface MyPlugin : NSObject<FlutterPlugin, FlutterSceneLifeCycleDelegate>
    ```

    </Tab>
    </Tabs>

 1. Register the plugin as a receiver of `UISceneDelegate` calls.

    To continue supporting apps that haven't yet
    migrated to the `UIScene` lifecycle,
    consider remaining registered to the application delegate and
    keeping the `AppDelegate` events as well.

    <Tabs key="ios-language-switcher">
    <Tab name="Swift">

    ```swift diff
      public static func register(with registrar: FlutterPluginRegistrar) {
        ...
        registrar.addApplicationDelegate(instance)
    +   registrar.addSceneDelegate(instance)
      }
    ```

    </Tab>
    <Tab name="Objective-C">

    ```objc diff
      + (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
        ...
        [registrar addApplicationDelegate:instance];
    +   [registrar addSceneDelegate:instance];
      }
    ```

    </Tab>
    </Tabs>

 1. Add the scene events that your plugin needs.

    Most `AppDelegate` UI events have a one-to-one replacement,
    as shown in the following table.
    For details about each event, visit Apple's documentation for
    [`UISceneDelegate`][] and [`UIWindowSceneDelegate`][].

    | App delegate method                                               | Scene delegate equivalent                                         |
    |:------------------------------------------------------------------|:------------------------------------------------------------------|
    | [`applicationDidBecomeActive`][]                                  | [`sceneDidBecomeActive`][]                                        |
    | [`applicationWillResignActive`][]                                 | [`sceneWillResignActive`][]                                       |
    | [`applicationWillEnterForeground`][]                              | [`sceneWillEnterForeground`][]                                    |
    | [`applicationDidEnterBackground`][]                               | [`sceneDidEnterBackground`][]                                     |
    | [`application:continueUserActivity:restorationHandler:`][]        | [`scene:continueUserActivity:`][]                                 |
    | [`application:performActionForShortcutItem:completionHandler:`][] | [`windowScene:performActionForShortcutItem:completionHandler:`][] |
    | [`application:openURL:options:`][]                                | [`scene:openURLContexts:`][]                                      |
    | [`application:performFetchWithCompletionHandler:`][]              | [`BGAppRefreshTask`][]                                            |
    | [`application:willFinishLaunchingWithOptions:`][]                 | [`scene:willConnectToSession:options:`][]                         |
    | [`application:didFinishLaunchingWithOptions:`][]                  | [`scene:willConnectToSession:options:`][]                         |

    {:.table}

    Once you identify the scene events that replace the
    application events your plugin relied on,
    implement the corresponding `FlutterSceneLifeCycleDelegate` methods.
    The following snippets show the signature of each
    scene event that `FlutterSceneLifeCycleDelegate` supports;
    implement only the ones your plugin needs.

    <Tabs key="ios-language-switcher">
    <Tab name="Swift">

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

    public func scene(
      _ scene: UIScene,
      continue userActivity: NSUserActivity
    ) -> Bool { }

    public func windowScene(
      _ windowScene: UIWindowScene,
      performActionFor shortcutItem: UIApplicationShortcutItem,
      completionHandler: @escaping (Bool) -> Void
    ) -> Bool { }
    ```

    </Tab>
    <Tab name="Objective-C">

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

    </Tab>
    </Tabs>

 1. Move launch logic from `application:willFinishLaunchingWithOptions:`
    and `application:didFinishLaunchingWithOptions:` to
    `scene:willConnectToSession:options:`.

    Although `application:willFinishLaunchingWithOptions:` and
    `application:didFinishLaunchingWithOptions:` aren't deprecated,
    their launch options are `nil` after you migrate to the `UIScene` lifecycle.
    Move any logic that relies on the launch options to the
    `scene:willConnectToSession:options:` event.

 1. Optional: Migrate other deprecated APIs to support
    multiple scenes in the future.

    | Deprecated API                     | UIScene replacement           |
    |:-----------------------------------|:------------------------------|
    | [`UIScreen mainScreen`][]          | [`UIWindowScene screen`][]    |
    | [`UIApplication keyWindow`][]      | [`UIWindowScene keyWindow`][] |
    | [`UIApplication windows`][]        | [`UIWindowScene windows`][]   |
    | [`UIApplicationDelegate window`][] | [`UIView window`][]           |

    {:.table}

    Instead of accessing these APIs,
    access the `windowScene` through the `viewController`,
    as shown in the following examples.

    <Tabs key="ios-language-switcher">
    <Tab name="Swift">

    ```swift diff
      public class MyPlugin: NSObject, FlutterPlugin {
    +   var registrar: FlutterPluginRegistrar

    +   init(registrar: FlutterPluginRegistrar) {
    +     self.registrar = registrar
    +   }

        public static func register(with registrar: FlutterPluginRegistrar) {
    -     let instance = MyPlugin()
    +     let instance = MyPlugin(registrar: registrar)
        }

        func someMethod() {
    -     let screen = UIScreen.main
    +     let screen = self.registrar.viewController?.view.window?.windowScene?.screen

    -     let window = UIApplication.shared.delegate?.window
    +     let window = self.registrar.viewController?.view.window

    -     let keyWindow = UIApplication.shared.keyWindow
    +     if #available(iOS 15.0, *) {
    +       let keyWindow = self.registrar.viewController?.view.window?.windowScene?.keyWindow
    +     } else {
    +       let keyWindow = self.registrar.viewController?.view.window?.windowScene?.windows
    +         .filter({ $0.isKeyWindow }).first
    +     }

    -     let windows = UIApplication.shared.windows
    +     let windows = self.registrar.viewController?.view.window?.windowScene?.windows
        }
      }
    ```

    </Tab>
    <Tab name="Objective-C">

    ```objc diff
      @interface MyPlugin ()
    + @property(nonatomic, weak) NSObject<FlutterPluginRegistrar> *registrar;
    + - (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
      @end

      @implementation MyPlugin

    + - (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    +   self = [super init];
    +   if (self) {
    +     _registrar = registrar;
    +   }
    +   return self;
    + }

      + (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    -   MyPlugin *instance = [[MyPlugin alloc] init];
    +   MyPlugin *instance = [[MyPlugin alloc] initWithRegistrar:registrar];
      }

      - (void)someMethod {
    -   UIScreen *screen = [UIScreen mainScreen];
    +   UIScreen *screen = self.registrar.viewController.view.window.windowScene.screen;

    -   UIWindow *window = [UIApplication sharedApplication].delegate.window;
    +   UIWindow *window = self.registrar.viewController.view.window;

    -   UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    +   if (@available(iOS 15.0, *)) {
    +     UIWindow *keyWindow = self.registrar.viewController.view.window.windowScene.keyWindow;
    +   } else {
    +     for (UIWindow *window in self.registrar.viewController.view.window.windowScene.windows) {
    +       if (window.isKeyWindow) {
    +         UIWindow *keyWindow = window;
    +       }
    +     }
    +   }

    -   NSArray<UIWindow *> *windows = [UIApplication sharedApplication].windows;
    +   NSArray<UIWindow *> *windows = self.registrar.viewController.view.window.windowScene.windows;
      }
    ```

    </Tab>
    </Tabs>

[`UISceneDelegate`]: {{site.apple-dev}}/documentation/uikit/uiscenedelegate
[`UIWindowSceneDelegate`]: {{site.apple-dev}}/documentation/uikit/uiwindowscenedelegate
[`applicationWillResignActive`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1622950-applicationwillresignactive
[`applicationWillEnterForeground`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1623076-applicationwillenterforeground
[`applicationDidEnterBackground`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground
[`application:continueUserActivity:restorationHandler:`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1623072-application
[`application:performActionForShortcutItem:completionHandler:`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/application(_:performactionfor:completionhandler:)
[`application:openURL:options:`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1623112-application
[`application:performFetchWithCompletionHandler:`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1623125-application
[`application:willFinishLaunchingWithOptions:`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1623032-application
[`application:didFinishLaunchingWithOptions:`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1622921-application
[`sceneDidBecomeActive`]: {{site.apple-dev}}/documentation/uikit/uiscenedelegate/3197915-scenedidbecomeactive
[`sceneWillResignActive`]: {{site.apple-dev}}/documentation/uikit/uiscenedelegate/3197919-scenewillresignactive
[`sceneWillEnterForeground`]: {{site.apple-dev}}/documentation/uikit/uiscenedelegate/3197918-scenewillenterforeground
[`sceneDidEnterBackground`]: {{site.apple-dev}}/documentation/uikit/uiscenedelegate/3197917-scenedidenterbackground
[`scene:continueUserActivity:`]: {{site.apple-dev}}/documentation/uikit/uiscenedelegate/scene(_:continue:)
[`windowScene:performActionForShortcutItem:completionHandler:`]: {{site.apple-dev}}/documentation/uikit/uiwindowscenedelegate/3238088-windowscene
[`scene:openURLContexts:`]: {{site.apple-dev}}/documentation/uikit/uiscenedelegate/3238059-scene
[`BGAppRefreshTask`]: {{site.apple-dev}}/documentation/backgroundtasks/bgapprefreshtask
[`scene:willConnectToSession:options:`]: {{site.apple-dev}}/documentation/uikit/uiscenedelegate/3197914-scene
[`UIScreen mainScreen`]: {{site.apple-dev}}/documentation/uikit/uiscreen/1617815-mainscreen
[`UIWindowScene screen`]: {{site.apple-dev}}/documentation/uikit/uiwindowscene/screen?language=objc
[`UIApplication keyWindow`]: {{site.apple-dev}}/documentation/uikit/uiapplication/1622924-keywindow
[`UIWindowScene keyWindow`]: {{site.apple-dev}}/documentation/uikit/uiwindowscene/keywindow?language=objc
[`UIApplication windows`]: {{site.apple-dev}}/documentation/uikit/uiapplication/windows
[`UIWindowScene windows`]: {{site.apple-dev}}/documentation/uikit/uiwindowscene/windows?language=objc
[`UIApplicationDelegate window`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/window
[`UIView window`]: {{site.apple-dev}}/documentation/uikit/uiview/window?language=objc

## Bespoke FlutterViewController usage

If your app instantiates a `FlutterViewController` from
storyboards in `application:didFinishLaunchingWithOptions:` for
reasons other than creating platform channels,
you must accommodate the new initialization order.
To do so, use one of the following migration options:

- Subclass `FlutterViewController` and put the logic in
  the subclass's `awakeFromNib` method.
- Specify a `UISceneDelegate` in the `Info.plist` or
  in the `UIApplicationDelegate`, and
  put the logic in `scene:willConnectToSession:options:`.
  To learn more, check out [Apple's documentation][apple-delegate-docs].

[apple-delegate-docs]: {{site.apple-dev}}/documentation/uikit/specifying-the-scenes-your-app-supports

### Example

```swift
@objc class MyViewController: FlutterViewController {
  override func awakeFromNib() {
    super.awakeFromNib()
    doSomethingWithFlutterViewController(self)
  }
}
```

## Hide migration warning

To hide the Flutter CLI warning about migrating to `UIScene`,
add the following to your `pubspec.yaml`:

```yaml title="pubspec.yaml" diff
  flutter:
    config:
+     enable-uiscene-migration: false
```

## Temporarily disable UIScene

To _temporarily_ disable `UIScene` support, add an underscore (`_`)
in front of **Application Scene Manifest** in your `Info.plist`:

![Xcode plist editor with an underscore in front of Application Scene Manifest](/assets/images/docs/breaking-changes/disable-ui-scene.png)

When you're ready to re-enable `UIScene` support, remove the underscore.

## Timeline

Landed in version: 3.38.0-0.1.pre<br>
In stable release: 3.38

Apple hasn't yet announced when it will enforce the `UIScene` requirement.
Once Apple changes its warning to an assertion,
Flutter apps that haven't adopted the `UIScene` lifecycle will
crash on startup when built with the latest SDK.

## References

- [Issue 167267][]: The initial reported issue.

[Issue 167267]: {{site.github}}/flutter/flutter/issues/167267
