---
title: Adding iOS app extensions
description: Learn how to add app extensions to your Flutter apps
---

iOS App extensions allow you to expand functionality
outside your app. Your app could appear as a home screen widget,
or you can make portions of your app available within other apps.

To learn more about app extensions, check out
[Apple's documentation][].

## How do you add an app extension to your Flutter app?
To add an app extension to your Flutter app,
add the extension point *target* to your Xcode project.

1. Open the default Xcode workspace in your project by running
   `open ios/Runner.xcworkspace` in a terminal window from your
   Flutter project directory.
1. In Xcode, select **File -> New -> Target** from the menu bar. 

    <figure class="site-figure {{include.class}}">
    <div class="site-figure-container">
        <img src={{ '/assets/images/docs/development/platform-integration/app-extensions/xcode-new-target.png' | relative_url }}
        height='300'>
    </div>
    </figure>
1. Select the app extension you intend to add.
   This selection generates extension-specific code 
   within a new folder in your project.
   To learn more about the generated code and the SDKs for each
   extension point, check out the resources in
   [Apple's documentation][].

## How do Flutter apps interact with App Extensions? 
Flutter apps interact with app extensions using the same
techniques as UIKit or SwiftUI apps.
The containing app and the app extension don't communicate directly.
The containing app might not be running while the device user interacts with the extension.
The app and your extension can read and write to shared resources or
use higher-level APIs to communicate with each other.

### Using higher-level APIs
Some extensions have APIs. For example, 
the [Core Spotlight][] framework indexes your app 
allowing users to search from Spotlight and Safari. The
[WidgetKit][] framework can trigger an update of your home screen
widget.

To simplify how your app communicates with extensions,
Flutter plugins wrap these APIs.
To find plugins that wrap extension APIs,
check out [Leveraging Apple's System APIs and Frameworks][] or
search [pub.dev][].

### Sharing resources
To share resources between your Flutter app and your app extension, put
the `Runner` app target and the extension target in the same
[App Group][].

{{site.alert.note}}
  You must be signed in to your Apple Developer account.
{{site.alert.end}}

To add a target to an App Group:

1. Open the target settings in Xcode.
1. Navigate to the **Signing & Capabilities** tab.
1. Select **+ Capability** then **App Groups**.
1. Choose which App Group you want to add the target from one of two options:
    1. Select an App Group from the list.
    1. Click **+** to add a new App Group.

{% include docs/app-figure.md
image="development/platform-integration/app-extensions/xcode-app-groups.png" %}

When two targets belong to the same App Group, they can read and write
data to the same source. Choose one of the following sources for your data.

- **Key/value:** Use the [`shared_preference_app_group`][]
  plugin to read or write to `UserDefaults` within the same App Group.
- **File:** Use the App Group container path from the
  [`path_provider`][] plugin to [read and write files][].
- **Database:** Use the App Group container path from
  the [`path_provider`][] plugin to create a database with the
  [`sqflite`][] plugin.

### Background updates
Background tasks provide a means to update your extension through code
regardless of the status of your app.

To schedule background work from your Flutter app, use the
[`workmanager`][] plugin.

### Deep linking
You might want to direct users from an app extension to a
specific page in your Flutter app.
To have a URL open a specified route in your app, you can use
[Deep Linking][].

## Creating app extension UIs with Flutter
Some app extensions display a user interface.
For example, iMessage extensions allow users to access your app's
content directly from the **Messages** app.

<figure class="site-figure {{include.class}}">
    <div class="site-figure-container">
        <img src={{ '/assets/images/docs/development/platform-integration/app-extensions/imessage-extension.png' | relative_url }}
        height='300'>
    </div>
</figure>

Flutter does **not** support 
building Flutter UI for app extensions. 
To create the UI for 
an app extension using Flutter, you must compile 
a custom engine and embed the `FlutterViewController`
as described in the following section.

{{site.alert.note}}
  Creating an app extension user interface with Flutter
  requires you to compile a custom build of the Flutter engine.
  The Flutter team cautions that only advanced users
  should try to create a custom build.
  To learn more, check out [Compiling the engine][].
{{site.alert.end}}

1. Create a custom build of the Flutter engine that removes uses of
   `sharedApplication` and corrects the path for the bundle.
   Check out an [example from the community on GitHub][].

1. Open the Flutter app project settings in Xcode to share build
   configurations. 

   1. Navigate to the **Info** tab.
   1. Expand the **Configurations** group. 
   1. Expand the **Debug**, **Profile**, and **Release** entries.
   1. For each of these configurations, make sure the value in the
       **Based on configuration file** drop-down menu for your
       extension matches the one selected for the normal app target.

    <figure class="site-figure {{include.class}}">
        <div class="site-figure-container">
            <img src={{ '/assets/images/docs/development/platform-integration/app-extensions/xcode-configurations.png' | relative_url }}
            height='300'>
        </div>
    </figure>

1. (Optional) Replace any storyboard files with an extension class if needed.
    1. In the **Info.plist** file, delete the **NSExtensionMainStoryboard** property.
    1. Add the **NSExtensionPrincipalClass** property.
    1. Set this value for this property to the name of your `ViewController`.
        For example, in an iMessage extension you would use `MessageViewController`. 
    
    <figure class="site-figure {{include.class}}">
        <div class="site-figure-container">
            <img src={{ '/assets/images/docs/development/platform-integration/app-extensions/extension-info.png' | relative_url }}
            height='300'>
        </div>
    </figure>


1. Embed the `FlutterViewController` as described in
   [Adding a Flutter Screen][]. For example, you can display a 
   specific route in your Flutter app within an iMessage extension.

    ```swift
    //This attribute tells the compiler that this piece of Swift code can be accessed from Objective-C.
    @objc(MessagesViewController)

    class MessagesViewController: MSMessagesAppViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            showFlutter()
        }
    
        @objc func showFlutter() {
            // Create a FlutterViewController with an implicit FlutterEngine
            let flutterViewController = FlutterViewController(project: nil, initialRoute: "/ext", nibName: nil, bundle: nil)
            present(flutterViewController, animated: true, completion: nil)
        }
    ```

{{site.alert.important}}
  Commenting out `sharedApplication` disables
  many features in the Flutter framework.
  This hasn't been tested in App Store submissions
  and might not work for some app extensions.

  For example, home screen Widgets and Live Activities can't use some
  lower-level APIs needed to draw Flutter UI.
{{site.alert.end}}

{% comment %}
## Tutorials
For step-by-step instruction for using app extensions with your
Flutter iOS app, check out the 
[Adding Home Screen Widgets and Live Activities to your Flutter app][] codelab.
{% endcomment %}

[Apple's documentation]: https://developer.apple.com/app-extensions/
[Core Spotlight]: https://developer.apple.com/documentation/corespotlight
[WidgetKit]: https://developer.apple.com/documentation/widgetkit
[Leveraging Apple's System APIs and Frameworks]: {{site.url}}/platform-integration/ios/apple-frameworks
[pub.dev]: {{site.pub-pkg}}
[App Group]: https://developer.apple.com/documentation/xcode/configuring-app-groups
[Adding a Flutter Screen]: {{site.url}}/add-to-app/ios/add-flutter-screen?tab=vc-uikit-swift-tab#alternatively---create-a-flutterviewcontroller-with-an-implicit-flutterengine
[`shared_preference_app_group`]: {{site.pub-pkg}}/shared_preference_app_group
[Compiling the Engine]: https://github.com/flutter/flutter/wiki/Compiling-the-engine
[`path_provider`]: {{site.pub-pkg}}/path_provider
[`sqflite`]: {{site.pub-pkg}}/sqflite
[`workmanager`]: {{site.pub-pkg}}/workmanager
[read and write files]: {{site.url}}/cookbook/persistence/reading-writing-files
[example from the community on GitHub]: {{site.github}}/flutter/engine/pull/39941
[Deep Linking]:{{site.url}}/ui/navigation/deep-linking

<!--  TO DO: add links when published -->
[Adding Home Screen Widgets to your Flutter app]: {{site.codelabs}}/?product=flutter