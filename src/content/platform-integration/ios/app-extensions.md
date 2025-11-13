---
title: Adding iOS app extensions
description: Learn how to add app extensions to your Flutter apps
---

This guide shows you how to use iOS app extensions with a
Flutter app.

## Overview {: #overview }

[iOS app extensions][] allow you to expand functionality
outside of your iOS app. Your app could appear as a home screen widget,
or you can make portions of your app available within other apps.

In the following example, when a user selects a
photo to share in the iOS Photo app, a Flutter app called
`Example App With Extension` is displayed in the
Photo apps share sheet:

<figure>
  <div class="site-figure-container">
    <img src='/assets/images/docs/development/platform-integration/app-extensions/share-extension.png' alt='Share sheet with a Flutter app in it.' height='400'>
  </div>
</figure>

[iOS app extensions]: {{site.apple-dev}}/app-extensions/

## Add an iOS app extension to your Flutter app {: #add-extension }

If you want to integrate your Flutter app with
the iOS operating system, you can add iOS app extensions
to your Flutter project. For a seamless workflow, the
following steps show how to add a [Share][]
app extension to a new Flutter app called
`example_app_with_extension`, but you can always start with
an existing project.

1.  In the console, create a new Flutter project called
    `example_app_with_extension`.

    ```console
    $ flutter create example_app_with_extension
    ```

1.  In the console, open the Xcode workspace for the
    `example_app_with_extension` project.

    ```console
    $ cd example_app_with_extension && open ios/Runner.xcworkspace
    ```

1.  In Xcode, add an app extension called `Share`
    and call it `ShareExtension`.

    *   In the Xcode menu bar, select
        **File** > **New** > **Target**.

    *   Add **Share Extension**.

    *   In the **Name field**, enter **ShareExtension**.

    *   Click **Finish**.

    *   In the **Activate … Scheme** dialog box that
        appears, select **Activate**.

1.  In Xcode, change the order of the build process.

    *   Open the **project navigator**
        (**View** > **Navigators** > **Project**).

    *   In the **project navigator**, at the top, select
        **Runner**.

    *   In the main window under **TARGETS**, select
        **Runner**.

    *   Open the **Build Phases** tab.

    *   Drag **Embed Foundation Extensions** above
        **Run Script**.


1.  Make sure your **Minimum Deployments** iOS value is properly
    set and matches in both **Runner** and **ShareExtension**

    *   Open the **project navigator**
        (**View** > **Navigators** > **Project**).

    *   In the **project navigator**, at the top, select
        **Runner**.

    *   In the main window under **TARGETS**, select
        **Runner**.

    *   On the **General** tab check your **Minimum Deployments**
        dropdown value to match the one you have on
        **ShareExtension** > **General** tab.

1.  In the console, run the following command to rebuild your
    iOS app:

    ```console
    $ flutter build ios --config-only
    ```

1.  [Test your app with the simulator][].

When you add a new app extension, Xcode generates
sample code based on the template you selected. For more
information about the generated code and WidgetKit, see
[Apple's app extension documentation][].

[Apple's app extension documentation]: {{site.apple-dev}}/app-extensions/
[Test your app with the simulator]: #test-extensions
[Share]: https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Share.html

## Test an iOS app extension {: #test-extensions }

After you've added an app extension to your Flutter project,
you can test it, using a simulator or physical device.
If you are testing you extension in debug mode, you must
use the iOS simulator.

The following steps assume you're using the sample
application and Share extension from
[Adding iOS app extensions][].

<Tabs key="register-plugins-tabs" wrapped="true">

<Tab name="Simulator">

1.  In Xcode, [add an app extension to your project][].

1.  In the console, use the following command to run your
    iOS app:

    ```console
    $ flutter run
    ```

1.  In the simulator, test your app extension.

    *   Launch an app that supports the Share extension,
        such as the Photos app.

    *   Select a photo, tap the share button, then tap
        on the share extension icon of your app.

</Tab>

<Tab name="Physical device">

1.  Add an app extension to your project.

1.  In the console, run your Flutter app in release mode:

    ```console
    $ flutter run --release
    ```

1.  On your device, test your app extension.

    *   Launch an app that supports the Share extension,
        such as the Photos app.

    *   Select a photo, tap the share button, then tap on
        the share extension icon of your app.

</Tab>

</Tabs>

[Adding iOS app extensions]: #add-extension
[add an app extension to your project]: #add-extension

## Additional ways to interact with iOS app extensions {: #interact-app-extensions }

Flutter apps interact with iOS app extensions using the same
techniques as UIKit or SwiftUI apps.
The containing app and the app extension don't communicate directly.
The containing app might not be running while the device user
interacts with the extension.
The app and your extension can read and write to
shared resources or use higher-level APIs
to communicate with each other.

### Use higher-level APIs {: #using-higher-level-apis }

Some extensions have APIs. For example,
the [Core Spotlight][] framework indexes your app,
allowing users to search from Spotlight and Safari.
The [WidgetKit][] framework can trigger an update
of your home screen widget.

To simplify how your app communicates with extensions,
Flutter plugins wrap these APIs.
To find plugins that wrap extension APIs,
check out [Leveraging Apple's System APIs and Frameworks][leverage]
or search [pub.dev][].

[Core Spotlight]: {{site.apple-dev}}/documentation/corespotlight
[leverage]: /platform-integration/ios/apple-frameworks
[pub.dev]: {{site.pub-pkg}}
[WidgetKit]: {{site.apple-dev}}/documentation/widgetkit

### Share resources {: #sharing-resources }

To share resources between your Flutter app
and your app extension, put the `Runner` app target
and the extension target in the same [App Group][].

:::note
You must be signed in to your Apple Developer account.
:::

To add a target to an App Group:

1. Open the target settings in Xcode.
1. Navigate to the **Signing & Capabilities** tab.
1. Select **+ Capability** then **App Groups**.
1. Choose which App Group you want to add the target from
   one of two options:

    {: type="a"}
    1. Select an App Group from the list.
    1. Click **+** to add a new App Group.

<DashImage figure image="development/platform-integration/app-extensions/xcode-app-groups.png" alt="Selecting an App Group within an Xcode Runner target configuration." />

When two targets belong to the same App Group,
they can read from and write to the same source.
Choose one of the following sources for your data.

* **Key/value:** Use the [`shared_preference_app_group`][]
  plugin to read or write to `UserDefaults` within the same App Group.
* **File:** Use the App Group container path from the
  [`path_provider`][] plugin to [read and write files][].
* **Database:** Use the App Group container path from
  the [`path_provider`][] plugin to create a database with the
  [`sqflite`][] plugin.

[App Group]: {{site.apple-dev}}/documentation/xcode/configuring-app-groups
[`path_provider`]: {{site.pub-pkg}}/path_provider
[read and write files]: /cookbook/persistence/reading-writing-files
[`shared_preference_app_group`]: {{site.pub-pkg}}/shared_preference_app_group
[`sqflite`]: {{site.pub-pkg}}/sqflite

### Schedule background updates {: #background-updates }

Background tasks provide a means to update your extension
through code regardless of the status of your app.

To schedule background work from your Flutter app,
use the [`workmanager`][] plugin.

[`workmanager`]: {{site.pub-pkg}}/workmanager

### Add deep linking {: #deep-linking }

You might want to direct users from an
app extension to a specific page in your Flutter app.
To open a specific route in your app,
you can use [Deep Linking][].

[Deep Linking]:/ui/navigation/deep-linking

### Add a scrollable list {: #advanced-scrolling-behavior }

By default, flutter view does not handle scroll gestures
in a [Share][] extension. To support a scrollable list in
the Share extension, follow [these instructions][].

[Share]: https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Share.html
[these instructions]: {{site.github}}/flutter/flutter/issues/164670#issuecomment-2740702986

### Open a Flutter app in an iOS app extension {: #creating-app-extension-uis-with-flutter }

You can open your Flutter app directly
in some iOS app extensions, such as the
[Share][] extension, with a `FlutterViewController`.

In the following example, a Flutter app called
`Example App With Extension` is opened in the
Share extension, which lets users share content
between apps:

<figure>
  <div class="site-figure-container">
    <img src='/assets/images/docs/development/platform-integration/app-extensions/share-extension-open-app.gif' alt='An example of an entry added to the share menu by a Flutter app' height='400'>
  </div>
</figure>

Use the following steps to display a Flutter app inside of
a [Share][] app extension. In this example the app extension
scheme is called `ShareExtension`, the Flutter app scheme is
called `Runner`, and the Flutter app is called
`Example App With Extension`:

1.  [Add an extension to your Flutter app][] if you haven't
    already done so.

1.  In the console, navigate to your Flutter project
    directory and then open your project in Xcode
    with the following command:

    ```console
    open ios/Runner.xcworkspace
    ```

1.  In Xcode, disable user script sandboxing.

    *   Open the **project navigator**
        (**View** > **Navigators** > **Project**).

    *   In the main window under **TARGETS**, select
        **ShareExtension**.

    *   Open the **Build Settings** tab.

    *   Navigate to **Build Options**.

    *   Set **User Script Sandboxing** as **No**.

1.  In Xcode, add the pre-action to the
    `ShareExtension` scheme.

    *   Open the **Manage Schemes** window
        (**Product** > **Scheme** > **Manage Schemes**).

    *   Select the **ShareExtension** scheme and edit it.

    *   Expand the **Build** tab.

    *   Select **Pre-actions**.

    *   Click **+** and select **New Run Script Action**.

    *   In the **Provide build settings from**
        drop-down list, select **ShareExtension**.

    *   In the **Shell** text field, enter:

        ```console
        /bin/sh "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" prepare
        ```

    *   Click **Close**.

1.  In Xcode, share the build configurations.

    *   Open the **project navigator**
        (**View** > **Navigators** > **Project**).

    *   In the main window under **PROJECT**, select
        **Runner**.

    *   Open the **Info** tab.

    *   Expand **Configuration**.

    *   Expand **Debug** and update the value for
        **ShareExtension** to match the value for
        **Runner**.

    *   Repeat the previous step for **Profile**, and
        **Release**.

    *   When you are finished, make sure that the
        configurations look similar to the following:

        ![Xcode configurations](/assets/images/docs/development/platform-integration/app-extensions/xcode-configurations.png)


1.  (Optional) In Xcode, replace any storyboard files with
    an extension class, if needed.

    *   Open the **project navigator**
        (**View** > **Navigators** > **Project**).

    *   Select **Runner** > **ShareExtension** > **Info**.

    *   Expand **Information Property List**.

    *   Delete the **NSExtensionMainStoryboard** key.

    *   Add the **NSExtensionPrincipalClass** key.

    *   Add one of these values for the
        `NSExtensionPrincipalClass` key:

        *   (Swift) **ShareExtension.ShareViewController**
        *   (Objective-C)  **ShareViewController**

1.  In Xcode, update the `ShareViewController` to use the
    `FlutterViewController`.

    *   Open the **project navigator**
        (**View** > **Navigators** > **Project**).

    *   Select **Runner** > **ShareExtension** > **ShareViewController**.

    *   Update `ShareViewController` to use the
        `FlutterViewController` class:

<Tabs key="controller-code-tabs" wrapped="true">
<Tab name="UIKit-Swift">

```swift title="ShareViewController.swift"
import UIKit
import Flutter

class ShareViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        showFlutter()
    }

    func showFlutter() {
        let flutterEngine = FlutterEngine(name: "my flutter engine")
        flutterEngine.run()
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        addChild(flutterViewController)
        view.addSubview(flutterViewController.view)
        flutterViewController.view.frame = view.bounds
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.extensionContext?.cancelRequest(
            withError: NSError(domain: Bundle.main.bundleIdentifier!, code: 0))
    }
}
```

</Tab>

<Tab name="UIKit-ObjC">

```objc title="ShareViewController.h"
@import Flutter;
@import UIKit;

@interface ShareViewController : UIViewController

@end
```

```objc title="ShareViewController.m"
#import "ShareViewController.h"
@import Flutter;

@implementation ShareViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showFlutter];
}

- (void)showFlutter {
    FlutterEngine *flutterEngine = [[FlutterEngine alloc] initWithName:@"my flutter engine"];
    [flutterEngine run];
    FlutterViewController *flutterViewController =
            [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [self addChildViewController:flutterViewController];
    [self.view addSubview:flutterViewController.view];
    flutterViewController.view.frame = self.view.bounds;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.extensionContext cancelRequestWithError:[NSError errorWithDomain:NSBundle.mainBundle.bundleIdentifier code:0 userInfo:nil]];
}
@end
```

</Tab>

</Tabs>

8.  [Test your app with the simulator][].

[Add an extension to your Flutter app]: #add-extension
[Share]: https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Share.html
[Test your app with the simulator]: #test-extensions

### Register plugins

Use the following steps to register plugins for
an app extension. In this example, the app extension
scheme is called `ShareExtension`, the Flutter app scheme is
called `Runner`, and the Flutter app is called
`Example App With Extension`:

1.  [Add an extension to your Flutter app][] if you haven't
    already done so.

1.  In Xcode, add `GeneratedPluginRegistrant.m` to the
    app extension target.

    *   Open the **project navigator**
        (**View** > **Navigators** > **Project**).

    *   In the main window under **TARGETS**, select
        **ShareExtension**.

    *   Open the **Build Phases** tab.

    *   Expand **Compile Sources**.

    *   Click **+**.

    *   From the list in the
        _Choose item to add_ dialog box, select
        **GeneratedPluginRegistrant.m**.

    *   Click **Add**.

1.  (Swift only) In Xcode, update the
    `SWIFT_OBJC_BRIDGING_HEADER` build setting.

    *   Open the **project navigator**
        (**View** > **Navigators** > **Project**).

    *   In the main window under **TARGETS**, select
        **ShareExtension**.

    *   Open the **Build Settings** tab.

    *   Select the **All** filter.

    *   Navigate to **Swift Compiler - General** and change
        the value for the **Objective-C Bridging Header**
        key to **Runner/Runner-Bridging-Header.h**.

1.  In Xcode, update the code for `ShareViewController`
    to register `GeneratedPluginRegistrant.h`.

    *   Open the **project navigator**
        (**View** > **Navigators** > **Project**).

    *   Select **Runner** > **ShareExtension** > **ShareViewController**.

    *   Update the `ShareViewController` file to use the
        `GeneratedPluginRegistrant.h`:

<Tabs key="register-plugins-tabs" wrapped="true">

<Tab name="UIKit-Swift">

```swift title="ShareViewController.swift"
// Add this inside `showFlutter()` at the top
GeneratedPluginRegistrant.register(with: flutterEngine)
```

</Tab>

<Tab name="UIKit-ObjC">

```objc title="ShareViewController.m"
// Add this import at the top
#import "GeneratedPluginRegistrant.h"
```

```objc title="ShareViewController.m"
// Add this after [flutterEngine run]
[GeneratedPluginRegistrant registerWithRegistry:flutterEngine];
```

</Tab>

</Tabs>

5.  (Xcode) [Test your app with the simulator][].

[Add an extension to your Flutter app]: #add-extension
[Share]: https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Share.html
[Test your app with the simulator]: #test-extensions

## Constraints {: #constraints }

*   You must use an iOS simulator to test your extension in
    debug mode.

*   Flutter doesn't fully support running app extensions in
    debug mode on physical devices when used to build
    extension UIs because a physical device might run out of
    memory.

*   iOS app extensions have limited memory.
    It is advisable to only modify an app extension's UI
    if the app extension supports at least 100MB of memory.

## Call Dart code / render Flutter content in iOS app extensions

The [home_widget][] package provides a large amount of functionality,
which includes allowing the following:

* [Respond to user input][] in app extensions
  using Dart Code.

* [Render Flutter widgets][] in an app extension as an image.

* [Save and retrieve data][] from `UserDefaults` on iOS.

## Other resources {: #other-resources }

For step-by-step instruction for using app
extensions with your Flutter iOS app, check out the
[Adding a Home Screen Widget to your Flutter app][lab]
codelab.

To learn more about the various ways you can add a
Flutter Screen to an iOS app, see
[Adding a Flutter Screen to an iOS app][].

[Adding a Flutter Screen to an iOS app]: /add-to-app/ios/add-flutter-screen
[lab]: {{site.codelabs}}/flutter-home-screen-widgets
[home_widget]: https://pub.dev/packages/home_widget
[Save and retrieve data]: https://docs.page/abausg/home_widget/usage/sync-data
[Render Flutter widgets]: https://docs.page/abausg/home_widget/features/render-flutter-widgets
[Respond to user input]: https://docs.page/abausg/home_widget/features/interactive-widgets
