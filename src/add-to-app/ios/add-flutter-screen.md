---
title: Adding a Flutter screen to an iOS app
short-title: Add a Flutter screen
description: Learn how to add a single Flutter screen to your existing iOS app.
---

This guide describes how to add a single Flutter screen to an existing iOS app.

## Start a FlutterEngine and FlutterViewController

To launch a Flutter screen from an existing iOS, you start a
[`FlutterEngine`][] and a [`FlutterViewController`][].

{{site.alert.secondary}}
  The `FlutterEngine` serves as a host to the Dart VM and your Flutter runtime,
  and the `FlutterViewController` attaches to a `FlutterEngine` to pass 
  input events into Flutter and to display frames rendered by the
  `FlutterEngine`.
{{site.alert.end}}

The `FlutterEngine` may have the same lifespan as your
`FlutterViewController` or outlive your `FlutterViewController`.

{{site.alert.tip}}
  It's generally recommended to pre-warm a long-lived
  `FlutterEngine` for your application because:

  * The first frame appears faster when showing the `FlutterViewController`.
  * Your Flutter and Dart state will outlive one `FlutterViewController`.
  * Your application and your plugins can interact with Flutter and your Dart
    logic before showing the UI.
{{site.alert.end}}

See [Loading sequence and performance][]
for more analysis on the latency and memory
trade-offs of pre-warming an engine.

### Create a FlutterEngine

Where you create a `FlutterEngine` depends on your host app.

{% samplecode engine %}

{% sample SwiftUI %}
In this example, we create a `FlutterEngine` object inside a SwiftUI `ObservableObject`. 
We then pass this `FlutterEngine` into a `ContentView` using the 
 `environmentObject()` property. 

 **In `MyApp.swift`:**
 <!--code-excerpt "MyApp.swift" title-->
 ```swift
import SwiftUI
import Flutter
// The following library connects plugins with iOS platform code to this app.
import FlutterPluginRegistrant

class FlutterDependencies: ObservableObject {
  let flutterEngine = FlutterEngine(name: "my flutter engine")
  init(){
    // Runs the default Dart entrypoint with a default Flutter route.
    flutterEngine.run()
    // Connects plugins with iOS platform code to this app.
    GeneratedPluginRegistrant.register(with: self.flutterEngine);
  }
}

@main
struct MyApp: App {
  // flutterDependencies will be injected using EnvironmentObject.
  @StateObject var flutterDependencies = FlutterDependencies()
    var body: some Scene {
      WindowGroup {
        ContentView().environmentObject(flutterDependencies)
      }
    }
}
```

{% sample UIKit-Swift %}
As an example, we demonstrate creating a
`FlutterEngine`, exposed as a property, on app startup in
the app delegate.

**In `AppDelegate.swift`:**

<!--code-excerpt "AppDelegate.swift" title-->
```swift
import UIKit
import Flutter
// The following library connects plugins with iOS platform code to this app.
import FlutterPluginRegistrant

@UIApplicationMain
class AppDelegate: FlutterAppDelegate { // More on the FlutterAppDelegate.
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine")

  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Runs the default Dart entrypoint with a default Flutter route.
    flutterEngine.run();
    // Connects plugins with iOS platform code to this app.
    GeneratedPluginRegistrant.register(with: self.flutterEngine);
    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }
}
```
{% sample UIKit-ObjC %}

In this example, we create a `FlutterEngine` 
object inside a SwiftUI `ObservableObject`. 
We then pass this `FlutterEngine` into a 
`ContentView` using the `environmentObject()` property. 

**In `AppDelegate.h`:**

<!--code-excerpt "AppDelegate.h" title-->
```objectivec
@import UIKit;
@import Flutter;

@interface AppDelegate : FlutterAppDelegate // More on the FlutterAppDelegate below.
@property (nonatomic,strong) FlutterEngine *flutterEngine;
@end
```

**In `AppDelegate.m`:**

<!--code-excerpt "AppDelegate.m" title-->
```objectivec
// The following library connects plugins with iOS platform code to this app.
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
  self.flutterEngine = [[FlutterEngine alloc] initWithName:@"my flutter engine"];
  // Runs the default Dart entrypoint with a default Flutter route.
  [self.flutterEngine run];
  // Connects plugins with iOS platform code to this app.
  [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
```
{% endsamplecode %}

### Show a FlutterViewController with your FlutterEngine

{% samplecode vc %}

{% sample SwiftUI %}
The following example shows a generic `ContentView` with a
`Button` hooked to present a [`FlutterViewController`][].
The `FlutterViewController` constructor takes the pre-warmed 
`FlutterEngine` as an argument. `FlutterEngine` is passed in 
as an `EnvironmentObject` via `flutterDependencies`.

<!--code-excerpt "ContentView.swift" title-->
```swift
import SwiftUI
import Flutter

struct ContentView: View {
  // Flutter dependencies are passed in an EnvironmentObject.
  @EnvironmentObject var flutterDependencies: FlutterDependencies

  // Button is created to call the showFlutter function when pressed.
  var body: some View {
    Button("Show Flutter!") {
      showFlutter()
    }
  }

func showFlutter() {
    // Get the RootViewController.
    guard
      let windowScene = UIApplication.shared.connectedScenes
        .first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene }) as? UIWindowScene,
      let window = windowScene.windows.first(where: \.isKeyWindow),
      let rootViewController = window.rootViewController
    else { return }

    // Create the FlutterViewController.
    let flutterViewController = FlutterViewController(
      engine: flutterDependencies.flutterEngine,
      nibName: nil,
      bundle: nil)
    flutterViewController.modalPresentationStyle = .overCurrentContext
    flutterViewController.isViewOpaque = false

    rootViewController.present(flutterViewController, animated: true)
  }
}
```

{% sample UIKit-Swift %}
The following example shows a generic `ViewController` with a
`UIButton` hooked to present a [`FlutterViewController`][].
The `FlutterViewController` uses the `FlutterEngine` instance
created in the `AppDelegate`.
<!--code-excerpt "ViewController.swift" title-->
```swift
import UIKit
import Flutter

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    // Make a button to call the showFlutter function when pressed.
    let button = UIButton(type:UIButton.ButtonType.custom)
    button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
    button.setTitle("Show Flutter!", for: UIControl.State.normal)
    button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
    button.backgroundColor = UIColor.blue
    self.view.addSubview(button)
  }

  @objc func showFlutter() {
    let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
    let flutterViewController =
        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    present(flutterViewController, animated: true, completion: nil)
  }
}
```

{% sample UIKit-ObjC %}
The following example shows a generic `ViewController` with a
`UIButton` hooked to present a [`FlutterViewController`][].
The `FlutterViewController` uses the `FlutterEngine` instance
created in the `AppDelegate`.
<!--code-excerpt "ViewController.m" title-->
```objectivec
@import Flutter;
#import "AppDelegate.h"
#import "ViewController.h"

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    // Make a button to call the showFlutter function when pressed.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(showFlutter)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show Flutter!" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.blueColor;
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

- (void)showFlutter {
    FlutterEngine *flutterEngine =
        ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    FlutterViewController *flutterViewController =
        [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [self presentViewController:flutterViewController animated:YES completion:nil];
}
@end
```
{% endsamplecode %}

Now, you have a Flutter screen embedded in your iOS app.

{{site.alert.note}}
  Using the previous example, the default `main()`
  entrypoint function of your default Dart library
  would run when calling `run` on the
  `FlutterEngine` created in the `AppDelegate`.
{{site.alert.end}}

### _Alternatively_ - Create a FlutterViewController with an implicit FlutterEngine

As an alternative to the previous example, you can let the
`FlutterViewController` implicitly create its own `FlutterEngine` without
pre-warming one ahead of time.

This is not usually recommended because creating a
`FlutterEngine` on-demand could introduce a noticeable
latency between when the `FlutterViewController` is
presented and when it renders its first frame. This could, however, be
useful if the Flutter screen is rarely shown, when there are no good
heuristics to determine when the Dart VM should be started, and when Flutter
doesn't need to persist state between view controllers.

To let the `FlutterViewController` present without an existing
`FlutterEngine`, omit the `FlutterEngine` construction, and create the
`FlutterViewController` without an engine reference.

{% samplecode no-engine-vc %}
{% sample SwiftUI %}
```swift
import SwiftUI
import Flutter

struct ContentView: View {
  var body: some View {
    Button("Show Flutter!") {
      openFlutterApp()
    }
  }

func openFlutterApp() {
    // Get the RootViewController.
    guard
      let windowScene = UIApplication.shared.connectedScenes
        .first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene }) as? UIWindowScene,
      let window = windowScene.windows.first(where: \.isKeyWindow),
      let rootViewController = window.rootViewController
    else { return }

    // Create the FlutterViewController without an existing FlutterEngine.
    let flutterViewController = FlutterViewController(
      project: nil,
      nibName: nil,
      bundle: nil)
    flutterViewController.modalPresentationStyle = .overCurrentContext
    flutterViewController.isViewOpaque = false

    rootViewController.present(flutterViewController, animated: true)
  }
}
```
{% sample UIKit-Swift %}
<!--code-excerpt "ViewController.swift" title-->
```swift
// Existing code omitted.
func showFlutter() {
  let flutterViewController = FlutterViewController(project: nil, nibName: nil, bundle: nil)
  present(flutterViewController, animated: true, completion: nil)
}
```
{% sample UIKit-ObjC %}
<!--code-excerpt "ViewController.m" title-->
```objectivec
// Existing code omitted.
- (void)showFlutter {
  FlutterViewController *flutterViewController =
      [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
  [self presentViewController:flutterViewController animated:YES completion:nil];
}
@end
```
{% endsamplecode %}

See [Loading sequence and performance][]
for more explorations on latency and memory usage.

## Using the FlutterAppDelegate

Letting your application's `UIApplicationDelegate` subclass
`FlutterAppDelegate` is recommended but not required.

The `FlutterAppDelegate` performs functions such as:

* Forwarding application callbacks such as [`openURL`][]
  to plugins such as [local_auth][].
* Keeping the Flutter connection open 
  in debug mode when the phone screen locks.

### Creating a FlutterAppDelegate subclass
Creating a subclass of the the `FlutterAppDelegate` in UIKit apps was shown 
in the [Start a FlutterEngine and FlutterViewController section][]. 
In a SwiftUI app, you can create a subclass of the 
`FlutterAppDelegate` that conforms to the `ObservableObject` protocol as follows:

```swift
import SwiftUI
import Flutter
import FlutterPluginRegistrant

class AppDelegate: FlutterAppDelegate, ObservableObject {
  let flutterEngine = FlutterEngine(name: "my flutter engine")

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Runs the default Dart entrypoint with a default Flutter route.
      flutterEngine.run();
      // Used to connect plugins (only if you have plugins with iOS platform code).
      GeneratedPluginRegistrant.register(with: self.flutterEngine);
      return true;
    }
}

@main
struct MyApp: App {
//  Use this property wrapper to tell SwiftUI
//  it should use the AppDelegate class for the application delegate
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
      WindowGroup {
        ContentView()
      }
  }
}
```

Then, in your view, the `AppDelegate`is accessible as an `EnvironmentObject`.

```swift
import SwiftUI
import Flutter

struct ContentView: View {
  // Access the AppDelegate using an EnvironmentObject.
  @EnvironmentObject var appDelegate: AppDelegate

  var body: some View {
    Button("Show Flutter!") {
      openFlutterApp()
    }
  }

func openFlutterApp() {
    // Get the RootViewController.
    guard
      let windowScene = UIApplication.shared.connectedScenes
        .first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene }) as? UIWindowScene,
      let window = windowScene.windows.first(where: \.isKeyWindow),
      let rootViewController = window.rootViewController
    else { return }

    // Create the FlutterViewController.
    let flutterViewController = FlutterViewController(
      // Access the Flutter Engine via AppDelegate.
      engine: appDelegate.flutterEngine,
      nibName: nil,
      bundle: nil)
    flutterViewController.modalPresentationStyle = .overCurrentContext
    flutterViewController.isViewOpaque = false

    rootViewController.present(flutterViewController, animated: true)
  }
}

```

### If you can't directly make FlutterAppDelegate a subclass
If your app delegate can't directly make `FlutterAppDelegate` a subclass,
make your app delegate implement the `FlutterAppLifeCycleProvider`
protocol in order to make sure your plugins receive the necessary callbacks.
Otherwise, plugins that depend on these events may have undefined behavior.

For instance:

{% samplecode app-delegate %}
{% sample Swift %}
```swift
import Foundation
import Flutter

class AppDelegate: UIResponder, UIApplicationDelegate, FlutterAppLifeCycleProvider, ObservableObject {

  private let lifecycleDelegate = FlutterPluginAppLifeCycleDelegate()

  let flutterEngine = FlutterEngine(name: "flutter_nps_engine")

  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    flutterEngine.run()
    return lifecycleDelegate.application(application, didFinishLaunchingWithOptions: launchOptions ?? [:])
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    lifecycleDelegate.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }

  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    lifecycleDelegate.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
  }

  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    lifecycleDelegate.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return lifecycleDelegate.application(app, open: url, options: options)
  }

  func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
    return lifecycleDelegate.application(application, handleOpen: url)
  }

  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    return lifecycleDelegate.application(application, open: url, sourceApplication: sourceApplication ?? "", annotation: annotation)
  }

  func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    lifecycleDelegate.application(application, performActionFor: shortcutItem, completionHandler: completionHandler)
  }

  func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
    lifecycleDelegate.application(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler)
  }

  func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    lifecycleDelegate.application(application, performFetchWithCompletionHandler: completionHandler)
  }

  func add(_ delegate: FlutterApplicationLifeCycleDelegate) {
    lifecycleDelegate.add(delegate)
  }
}
```

{% sample Objective-C %}
<!--code-excerpt "AppDelegate.h" title-->
```objectivec
@import Flutter;
@import UIKit;
@import FlutterPluginRegistrant;

@interface AppDelegate : UIResponder <UIApplicationDelegate, FlutterAppLifeCycleProvider>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) FlutterEngine *flutterEngine;
@end
```

The implementation should delegate mostly to a
`FlutterPluginAppLifeCycleDelegate`:

<!--code-excerpt "AppDelegate.m" title-->
```objectivec
@interface AppDelegate ()
@property (nonatomic, strong) FlutterPluginAppLifeCycleDelegate* lifeCycleDelegate;
@end

@implementation AppDelegate

- (instancetype)init {
    if (self = [super init]) {
        _lifeCycleDelegate = [[FlutterPluginAppLifeCycleDelegate alloc] init];
    }
    return self;
}

- (BOOL)application:(UIApplication*)application
didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id>*))launchOptions {
    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
    [self.flutterEngine runWithEntrypoint:nil];
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
    return [_lifeCycleDelegate application:application didFinishLaunchingWithOptions:launchOptions];
}

// Returns the key window's rootViewController, if it's a FlutterViewController.
// Otherwise, returns nil.
- (FlutterViewController*)rootFlutterViewController {
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([viewController isKindOfClass:[FlutterViewController class]]) {
        return (FlutterViewController*)viewController;
    }
    return nil;
}

- (void)application:(UIApplication*)application
didRegisterUserNotificationSettings:(UIUserNotificationSettings*)notificationSettings {
    [_lifeCycleDelegate application:application
didRegisterUserNotificationSettings:notificationSettings];
}

- (void)application:(UIApplication*)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    [_lifeCycleDelegate application:application
didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication*)application
didReceiveRemoteNotification:(NSDictionary*)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    [_lifeCycleDelegate application:application
       didReceiveRemoteNotification:userInfo
             fetchCompletionHandler:completionHandler];
}

- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options {
    return [_lifeCycleDelegate application:application openURL:url options:options];
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url {
    return [_lifeCycleDelegate application:application handleOpenURL:url];
}

- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
  sourceApplication:(NSString*)sourceApplication
         annotation:(id)annotation {
    return [_lifeCycleDelegate application:application
                                   openURL:url
                         sourceApplication:sourceApplication
                                annotation:annotation];
}

- (void)application:(UIApplication*)application
performActionForShortcutItem:(UIApplicationShortcutItem*)shortcutItem
  completionHandler:(void (^)(BOOL succeeded))completionHandler {
    [_lifeCycleDelegate application:application
       performActionForShortcutItem:shortcutItem
                  completionHandler:completionHandler];
}

- (void)application:(UIApplication*)application
handleEventsForBackgroundURLSession:(nonnull NSString*)identifier
  completionHandler:(nonnull void (^)(void))completionHandler {
    [_lifeCycleDelegate application:application
handleEventsForBackgroundURLSession:identifier
                  completionHandler:completionHandler];
}

- (void)application:(UIApplication*)application
performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    [_lifeCycleDelegate application:application performFetchWithCompletionHandler:completionHandler];
}

- (void)addApplicationLifeCycleDelegate:(NSObject<FlutterPlugin>*)delegate {
    [_lifeCycleDelegate addDelegate:delegate];
}
@end
```

{% endsamplecode %}
## Launch options

The examples demonstrate running Flutter using the default launch settings.

In order to customize your Flutter runtime,
you can also specify the Dart entrypoint, library, and route.

### Dart entrypoint

Calling `run` on a `FlutterEngine`, by default,
runs the `main()` Dart function
of your `lib/main.dart` file.

You can also run a different entrypoint function by using
[`runWithEntrypoint`][] with an `NSString` specifying
a different Dart function.

{{site.alert.note}}
  Dart entrypoint functions other than `main()`
  must be annotated with the following in order to
  not be [tree-shaken][] away when compiling:

  ```dart
  @pragma('vm:entry-point')
  void myOtherEntrypoint() { ... };
  ```
{{site.alert.end}}

### Dart library

In addition to specifying a Dart function, you can specify an entrypoint
function in a specific file.

For instance the following runs `myOtherEntrypoint()`
in `lib/other_file.dart` instead of `main()` in `lib/main.dart`:

{% samplecode entrypoint-library %}
{% sample Swift %}
<!--code-excerpt "Swift" title-->
```swift
flutterEngine.run(withEntrypoint: "myOtherEntrypoint", libraryURI: "other_file.dart")
```
{% sample Objective-C %}
<!--code-excerpt "Objective-C" title-->
```objectivec
[flutterEngine runWithEntrypoint:@"myOtherEntrypoint" libraryURI:@"other_file.dart"];
```
{% endsamplecode %}


### Route

Starting in Flutter version 1.22, an initial route can be set for your Flutter
[`WidgetsApp`][] when constructing the FlutterEngine or the
FlutterViewController.

{% samplecode initial-route %}
{% sample Swift %}
<!--code-excerpt "Creating engine" title-->
```swift
let flutterEngine = FlutterEngine()
// FlutterDefaultDartEntrypoint is the same as nil, which will run main().
engine.run(
  withEntrypoint: FlutterDefaultDartEntrypoint, initialRoute: "/onboarding")
```
{% sample Objective-C %}
<!--code-excerpt "Creating engine" title-->
```objectivec
FlutterEngine *flutterEngine = [[FlutterEngine alloc] init];
// FlutterDefaultDartEntrypoint is the same as nil, which will run main().
[flutterEngine runWithEntrypoint:FlutterDefaultDartEntrypoint
                    initialRoute:@"/onboarding"];
```
{% endsamplecode %}

This code sets your `dart:ui`'s [`window.defaultRouteName`][]
to `"/onboarding"` instead of `"/"`.

Alternatively, to construct a FlutterViewController directly without pre-warming
a FlutterEngine:

{% samplecode initial-route-without-pre-warming %}
{% sample Swift %}
<!--code-excerpt "Creating view controller" title-->
```swift
let flutterViewController = FlutterViewController(
      project: nil, initialRoute: "/onboarding", nibName: nil, bundle: nil)
```
{% sample Objective-C %}
<!--code-excerpt "Creating view controller" title-->
```objectivec
FlutterViewController* flutterViewController =
      [[FlutterViewController alloc] initWithProject:nil
                                        initialRoute:@"/onboarding"
                                             nibName:nil
                                              bundle:nil];
```
{% endsamplecode %}

{{site.alert.tip}}
  In order to imperatively change your current Flutter
  route from the platform side after the `FlutterEngine`
  is already running, use [`pushRoute()`][]
  or [`popRoute()`] on the `FlutterViewController`.

  To pop the iOS route from the Flutter side,
  call [`SystemNavigator.pop()`][].
{{site.alert.end}}

See [Navigation and routing][] for more about Flutter's routes.

### Other

The previous example only illustrates a few ways to customize
how a Flutter instance is initiated. Using [platform channels][],
you're free to push data or prepare your Flutter environment
in any way you'd like, before presenting the Flutter UI using a
`FlutterViewController`.


[`FlutterEngine`]: {{site.api}}/objcdoc/Classes/FlutterEngine.html
[`FlutterViewController`]: {{site.api}}/objcdoc/Classes/FlutterViewController.html
[Loading sequence and performance]: {{site.url}}/add-to-app/performance
[local_auth]: {{site.pub}}/packages/local_auth
[Navigation and routing]: {{site.url}}/ui/navigation
[Navigator]: {{site.api}}/flutter/widgets/Navigator-class.html
[`NavigatorState`]: {{site.api}}/flutter/widgets/NavigatorState-class.html
[`openURL`]: {{site.apple-dev}}/documentation/uikit/uiapplicationdelegate/1623112-application
[platform channels]: {{site.url}}/platform-integration/platform-channels
[`popRoute()`]: {{site.api}}/objcdoc/Classes/FlutterViewController.html#/c:objc(cs)FlutterViewController(im)popRoute
[`pushRoute()`]: {{site.api}}/objcdoc/Classes/FlutterViewController.html#/c:objc(cs)FlutterViewController(im)pushRoute:
[`runApp`]: {{site.api}}/flutter/widgets/runApp.html
[`runWithEntrypoint`]: {{site.api}}/objcdoc/Classes/FlutterEngine.html#/c:objc(cs)FlutterEngine(im)runWithEntrypoint:
[`SystemNavigator.pop()`]: {{site.api}}/flutter/services/SystemNavigator/pop.html
[tree-shaken]: https://en.wikipedia.org/wiki/Tree_shaking
[`WidgetsApp`]: {{site.api}}/flutter/widgets/WidgetsApp-class.html
[`window.defaultRouteName`]: {{site.api}}/flutter/dart-ui/SingletonFlutterWindow/defaultRouteName.html
[Start a FlutterEngine and FlutterViewController section]:{{site.url}}/add-to-app/ios/add-flutter-screen/#start-a-flutterengine-and-flutterviewcontroller
