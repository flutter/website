---
title: Adding iOS app extensions
description: Learn how to add app extensions to your Flutter apps
---

App extensions for Apple platforms allow you to expand functionality
outside your app. Your app could appear as a home screen widget,
or you can make buttons for your app available to other apps.

Apple categorizes the available app extensions.
To learn more about these app extensions, check out
[Apple's documentation][].

## How do you add an app extension to your Flutter app?
App extensions create miniature apps.

To add an app extension to your Flutter app,
add the extension point *target* to your Xcode project.

1. Open your Flutter app in Xcode.
   In your IDE, right-click on the `ios` directory in your project
   and select **Open in Xcode.**

1. In Xcode, select **File -> New -> Target** from the menu bar. 

   {% include docs/app-figure.md
    image="development/platform-integration/app-extensions/xcode-new-target.png" %}

1. Select the app extension you intend to add.
   This selection then generates extension-specific code.
   To learn more about the generated code and the SDKs for each
   extension point, check out the resources in
   [Apple's documentation][].

## How do Flutter apps interact with App Extensions? 
Flutter apps interact with app extensions using the same
techniques as UIKit or SwiftUI apps.
The containing app and the app extension don't communicate directly.
These components read and write to shared resources or
use higher-level APIs to communicate with each other.


### Using higher-level APIs
Some extension points have APIs to configure or update the app
extension.

For example, the [Core Spotlight][] framework indexes your app 
allowing users to search from Spotlight and Safari. The
[WidgetKit][] framework can trigger an update of your Home Screen
Widget.

For APIs that don't display a UI, use a plugin to make calls to and
from your Flutter app. To find plugins that wrap app extension APIs,
check out [Leveraging Apple's System APIs and Frameworks][] or
search [pub.dev][].

### Sharing resources
To share resources between your Flutter app and your app extension, put
the `Runner` app target and the extension target in the same
[App Group][].

To add a target to an App Group:

1. Open the target in Xcode.
1. Navigate to the **Signing & Capabilities** tab.
1. Select **+ Capability** then **App Groups**.
1. Select or create the App Group.

{{site.alert.note}}
  You must be signed in to your Apple Developer account.
{{site.alert.end}}

{% include docs/app-figure.md
image="development/platform-integration/app-extensions/xcode-app-groups.png" %}

When two targets belong to the same App Group, they can read and write
data to the same container using one of the following
options:

- **Key/value:** Use the [`shared_preference_app_group`][]
  plugin to grant access to `UserDefaults` within the same App Group.
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
You might want to direct users from an App Extension to a
specific page in your Flutter app.
To have a URL open a specified route in your app, you can use
[Deep Linking][].

## Creating app extension UIs with Flutter
Some app extensions display a user interface.
For example, iMessage extensions allow users to access your app's
content directly from the **Messages** app.

{% include docs/app-figure.md
image="development/platform-integration/app-extensions/imessage-extension.png" %}

Flutter tooling does **not** support targeting app extensions. 
To enable targeting in some cases, embed the `FlutterViewController`
widget as described in the following section.

{{site.alert.note}}
  This requires a custom build of the Flutter engine and
  is only for advanced users.
  To learn more, check out [Compiling the engine][].
{{site.alert.end}}

1. Create a custom build of the Flutter engine that removes uses of
   `sharedApplication` and corrects the path for the bundle.
   Check out an [example from the community on GitHub][].
2. Open the Flutter app project settings in Xcode to share build
   configurations. 

   In the **Info** tab,
   under the **Configurations** expandable group,
   expand the **Debug**, **Profile**, and **Release** entries.
   For each, select the same value from the drop-down menu for the
   extension target as the entry selected for the normal app target. 

   {% include docs/app-figure.md
    image="development/platform-integration/app-extensions/xcode-configurations.png" %}

3. Embed the `FlutterViewController` as described in
   [Adding a Flutter Screen][]. 
   If the extension UI code leverages storyboard, remove the storyboard
   file and change references to point to the `ViewController` class.

To see a complete tutorial of these steps, check out the
[Adding an iMessage Extension][] codelab.

{{site.alert.important}}
This hasn't been tested in App Store submissions
and might not work for some app extensions.
For example, Home Screen Widgets can't use some
lower-level APIs needed to draw Flutter UI.
{{site.alert.end}}

## Tutorials
For step-by-step instruction using app extensions with your
Flutter iOS app, check out the following codelabs:

- [Adding an iMessage Extension][] creates an iMessage extension using Flutter
- [Adding Home Screen Widgets to your Flutter app][] creates Android and iOS Widgets 
that communicate with your Flutter app

[Apple's documentation]: https://developer.apple.com/app-extensions/
[Core Spotlight]: https://developer.apple.com/documentation/corespotlight
[WidgetKit]: https://developer.apple.com/documentation/widgetkit
[Leveraging Apple's System APIs and Frameworks]: {{site.url}}/development/platform-integration/ios/apple-frameworks
[pub.dev]: {{site.pub-pkg}}
[App Group]: https://developer.apple.com/documentation/xcode/configuring-app-groups
[Adding a Flutter Screen]: {{site.url}}/development/add-to-app/ios/add-flutter-screen?tab=vc-uikit-swift-tab#alternatively---create-a-flutterviewcontroller-with-an-implicit-flutterengine
[`shared_preference_app_group`]: {{site.pub-pkg}}/shared_preference_app_group
[Compiling the Engine]: https://github.com/flutter/flutter/wiki/Compiling-the-engine
[`path_provider`]: {{site.pub-pkg}}/path_provider
[`sqflite`]: {{site.pub-pkg}}/sqflite
[`workmanager`]: {{site.pub-pkg}}/workmanager
[read and write files]: {{site.url}}/cookbook/persistence/reading-writing-files
[example from the community on GitHub]: {{site.github}}/tomduncalf/engine/pull/1/files
[Deep Linking]:{{site.url}}/development/ui/navigation/deep-linking

<!--  TO DO: add links when published -->
[Adding an iMessage Extension]: {{site.codelabs}}/flutter
[Adding Home Screen Widgets to your Flutter app]: {{site.codelabs}}/flutter