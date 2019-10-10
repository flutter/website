---
title: Adding a Flutter screen to an iOS app
short-title: Add a Flutter screen
description: Learn how to add a single Flutter screen to your existing iOS app.
---

This guide describes how to add a single Flutter screen to an existing iOS app.

## Integration Steps

 1. [Create Flutter Module](#create-a-flutter-module) - This creates the Flutter project which will be hosted in the existing app.
 1. [Add Module Dependency in Existing App](#make-the-host-app-depend-on-the-flutter-module) - This sets up XCode to include your Flutter project into the build of your existing app.
 1. [Add FlutterViewController to Existing App](#write-code-to-use-flutterviewcontroller-from-your-host-app) - This steps introduces the code that will conjure the instance of Flutter into your existing app.
 1. (optional) [Attach Flutter Tool](#building-and-running-your-app) - This step allows you to attach to Flutter's debugger and enables you do use hot reload / restart.

## Create a Flutter module

Flutter projects created using `flutter create xxx` include very simple host
apps for your Flutter/Dart code (a single-ViewController iOS host). You can
modify these host apps to suit your needs and build from there.

But if you're starting off with an *existing* host app for either platform,
you'll likely want to include your Flutter project in that app as some form of
library instead.

This is what the Flutter module template provides. Executing
`flutter create -t module xxx` produces a Flutter project containing a CocoaPods
pod designed for consumption by your existing host app.

Let's assume you have an existing iOS app at `some/path/MyApp`, and that you
want your Flutter project as a sibling:

```bash
cd some/path/
flutter create -t module my_flutter
```

This creates a `some/path/my_flutter/` Flutter module project with some Dart
code to get you started and a `.ios/` hidden subfolder that wraps up the
module project that contains some Cocoapods and a helper Ruby script.

## Make the host app depend on the Flutter module

The description below assumes that your existing iOS app has a structure similar
to what you get by asking Xcode version 10.0 to generate a new "Single View App"
project using Objective-C. If your existing app has a different folder structure
and/or existing `.xcconfig` files, you can reuse those, but probably need to adjust
some of the relative paths mentioned below accordingly.

The assumed folder structure is as follows:

```text
some/path/
  my_flutter/
    lib/main.dart
    .ios/
  MyApp/
    MyApp/
      AppDelegate.h
      AppDelegate.m (or swift)
      :
```

### Add your Flutter app to your Podfile

Integrating the Flutter framework requires use of the CocoaPods dependency manager.
This is because the Flutter framework needs to be available also to any Flutter plugins
that you might include in my_flutter.

Please refer to [cocoapods.org](https://cocoapods.org/) for how to install CocoaPods
on your development machine, if needed.

If your host application (`MyApp`) is already using CocoaPods, you only have to do the
following to integrate with your `my_flutter` app:

1. Add the following lines to your `Podfile`:

```ruby
  flutter_application_path = 'path/to/my_flutter/'
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
```

2. For each Xcode [target](https://guides.cocoapods.org/syntax/podfile.html#target) that needs to embed Flutter, call `install_all_flutter_pods(flutter_application_path)`.

```ruby
  target 'MyApp' do
    install_all_flutter_pods(flutter_application_path)
  end
  target 'MyAppTests' do
    install_all_flutter_pods(flutter_application_path)
  end
```

3. Run `pod install`.

Whenever you change the Flutter plugin dependencies in `some/path/my_flutter/pubspec.yaml`,
you need to run `flutter pub get` from `some/path/my_flutter` to refresh the list
of plugins read by the `podhelper.rb` script. Then run `pod install` again from
`some/path/MyApp`.

The `podhelper.rb` script will ensure that your plugins, the Flutter.framework, and the App.framework
are embedded in your project.

You should now be able to build the project using `⌘B`.

### Under the hood

If you have some reason to do this manually or debug why these steps aren't working, here's what's going on under the hood:

1. `Flutter.framework` (the Engine library) is getting embedded into your app for you.  This has to match up with the release type
(debug/profile/release) as well as the architecture for your app (arm*, x86_64, etc.).  CocoaPods pulls this in as a vendored
framework and makes sure it gets embedded into your native app.
2. `App.framework` (your Flutter application binary) is embedded into your app.  CocoaPods also pulls this in as a vendored framework and
makes sure it gets embedded into your native app.
3. Any plugins are added as CocoaPod pods.  In theory, it should be possible to manually merge those in as well, but those instructions
vary on the pod dependencies of each plugin.
4. A build script is added to the Podfile targets that call `install_all_flutter_pods` to ensure that the binaries you build stay up to date
with the Dart code that's actually in the folder.  It also uses your Xcode build configuration (Debug, Profile, Release) to embed the matching
release type of `Flutter.framework` and `App.framework`.

## Write code to use FlutterViewController from your host app

The proper place to do this will be specific to your host app. Here is an
example that makes sense for the blank screen of the host app generated
by Xcode.

First declare your app delegate to be a subclass of `FlutterAppDelegate`. Then define a FlutterEngine property, which help you to register a plugin without a FlutterViewController instance.

In `AppDelegate.h`:

```objective-c
@import UIKit;
@import Flutter;

@interface AppDelegate : FlutterAppDelegate
@property (nonatomic,strong) FlutterEngine *flutterEngine;
@end
```

This allows `AppDelegate.m` to be really simple, unless your host app
needs to override other methods here:

```objective-c
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h> // Only if you have Flutter Plugins

#import "AppDelegate.h"

@implementation AppDelegate

// This override can be omitted if you do not have any Flutter Plugins.
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
  [self.flutterEngine runWithEntrypoint:nil];
  [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
```

If you are writing in Swift, you can do the following in your `AppDelegate.swift`:

```swift
import UIKit
import Flutter
import FlutterPluginRegistrant // Only if you have Flutter Plugins.

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
  var flutterEngine : FlutterEngine?;
  // Only if you have Flutter plugins.
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.flutterEngine = FlutterEngine(name: "io.flutter", project: nil);
    self.flutterEngine?.run(withEntrypoint: nil);
    GeneratedPluginRegistrant.register(with: self.flutterEngine);
    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }

}
```

<details>
<summary>What to do if the app delegate already inherits from somewhere else.</summary>

Make your app delegate implement the `FlutterAppLifeCycleProvider` protocol, e.g.:

```objective-c
@import Flutter;
@import UIKit;
@import FlutterPluginRegistrant; // Only if you have Flutter Plugins

@interface AppDelegate : UIResponder <UIApplicationDelegate, FlutterAppLifeCycleProvider>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) FlutterEngine *flutterEngine;
@end
```

The implementation should mostly just delegate to a `FlutterPluginAppLifeCycleDelegate`:

```objective-c
@implementation AppDelegate
{
    FlutterPluginAppLifeCycleDelegate *_lifeCycleDelegate;
}

- (instancetype)init {
    if (self = [super init]) {
        _lifeCycleDelegate = [[FlutterPluginAppLifeCycleDelegate alloc] init];
    }
    return self;
}

- (BOOL)application:(UIApplication*)application
didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
    [self.flutterEngine runWithEntrypoint:nil];
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine]; // Only if you are using Flutter plugins.
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

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    [super touchesBegan:touches withEvent:event];

    // Pass status bar taps to key window Flutter rootViewController.
    if (self.rootFlutterViewController != nil) {
        [self.rootFlutterViewController handleStatusBarTouches:event];
    }
}

- (void)applicationDidEnterBackground:(UIApplication*)application {
    [_lifeCycleDelegate applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication*)application {
    [_lifeCycleDelegate applicationWillEnterForeground:application];
}

- (void)applicationWillResignActive:(UIApplication*)application {
    [_lifeCycleDelegate applicationWillResignActive:application];
}

- (void)applicationDidBecomeActive:(UIApplication*)application {
    [_lifeCycleDelegate applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication*)application {
    [_lifeCycleDelegate applicationWillTerminate:application];
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
  completionHandler:(void (^)(BOOL succeeded))completionHandler NS_AVAILABLE_IOS(9_0) {
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

</details>

`ViewController.m`:

```objective-c
@import Flutter;
#import "AppDelegate.h"
#import "ViewController.h"

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(handleButtonAction)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

- (void)handleButtonAction {
    FlutterEngine *flutterEngine = [(AppDelegate *)[[UIApplication sharedApplication] delegate] flutterEngine];
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [self presentViewController:flutterViewController animated:false completion:nil];
}
@end
```

Or, using Swift:

`ViewController.swift`:

```swift
import UIKit
import Flutter

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let button = UIButton(type:UIButton.ButtonType.custom)
    button.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
    button.setTitle("Press me", for: UIControl.State.normal)
    button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
    button.backgroundColor = UIColor.blue
    self.view.addSubview(button)
  }

  @objc func handleButtonAction() {
    let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine;
    let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)!;
    self.present(flutterViewController, animated: false, completion: nil)
  }
}
```

You should now be able to build and launch MyApp on the Simulator or on a device.
Pressing the button should bring up a full-screen Flutter view with the standard
Flutter Demo counting app. You can use routes to show different widgets at different
places in your app, as described in the Android section above. To set the route, call

- Objective-C:

```objective-c
[flutterViewController setInitialRoute:@"route1"];
```

- Swift:

```swift
flutterViewController.setInitialRoute("route1")
```

immediately after construction of the `FlutterViewController` (and before presenting
it).

You can have the Flutter app dismiss itself by calling `SystemNavigator.pop()`
in the Dart code.

## Building and running your app

You build and run MyApp using Xcode in exactly the same way that you did before you
added the Flutter module dependency. The same goes for editing, debugging, and
profiling your iOS code.

## Hot restart/reload and debugging Dart code

Connect a device or launch a Simulator. Then make Flutter CLI tooling listen
for your app to come up:

```bash
$ cd some/path/my_flutter
$ flutter attach
Waiting for a connection from Flutter on iPhone X...
```

Launch `MyApp` in debug mode from Xcode. Navigate to an area of the app that uses
Flutter. Then turn back to the terminal, and you should see output similar to the
following:

```text
Done.
Syncing files to device iPhone X...                          4.7s

🔥  To hot reload changes while running, press "r". To hot restart (and rebuild state), press "R".
An Observatory debugger and profiler on iPhone X is available at: http://127.0.0.1:54741/
For a more detailed help message, press "h". To quit, press "q".
```

You can now edit the Dart code in `my_flutter`, and the changes can be hot
reloaded by pressing `r` in the terminal. You can also paste the URL above into
your browser to use the Dart Observatory for setting breakpoints, analyzing
memory retention and other debugging tasks.

### Debugging specific instances of Flutter

It's possible to add multiple instances of Flutter (`root isolates`) to an app. `flutter attach` connects to all of the available isolates by default. Any commands sent from the attached CLI are then forwarded to each of the attached isolates.

List all attached isolates by typing `l` from an attached `flutter` CLI tool. If unspecified, isolate names are automatically generated from the dart entry point file and function name.

Example `l` output for an application that's displaying two Flutter isolates simultaneously:

```text
Connected views:
  main.dart$main-517591213 (isolates/517591213)
  main.dart$main-332962855 (isolates/332962855)
```

Attach to specific isolates instead in two steps:

1. Name the Flutter root isolate of interest in its Dart source.

```dart
// main.dart
import 'dart:ui' as ui;

void main() {
  ui.window.setIsolateDebugName("debug isolate");
  // ...
}
```

2. Run `flutter attach` with the `--isolate-filter` option.

```bash
$ flutter attach --isolate-filter='debug'
Waiting for a connection from Flutter...
Done.
Syncing files to device...      1.1s

🔥  To hot reload changes while running, press "r". To hot restart (and rebuild state), press "R".
An Observatory debugger and profiler is available at: http://127.0.0.1:43343/
For a more detailed help message, press "h". To detach, press "d"; to quit, press "q".

Connected view:
  debug isolate (isolates/642101161)
```

You can check out [`93573de`](https://github.com/flutter/flutter/commit/93573de2165c750fdeefcd2d620e2b8bd494fed6) for a more detailed example.
