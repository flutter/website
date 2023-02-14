---
title: Adding iOS App Extensions
description: Learn how to add app extensions to your Flutter apps
---

Application extensions allow you to extend functionality beyond your app. 
With an app extension, you make content available for users 
in other parts of the system. 

There are many different types of app extension available. 
You can learn more at [Apple's documentation][].

## How do you add an app extension to your Flutter app?
App extensions are essentially miniature apps. 
To add an app extension to your Flutter app, 
you must add the extension point *target* to your Xcode project.

First, open your Flutter app in Xcode. To do so, right click on the `ios` 
directory in your IDE and select **Open in Xcode.**

Next, select **File -> New -> Target** from the menu bar. 

{% include docs/app-figure.md
image="development/platform-integration/app-extensions/xcode-new-target.png" %}

Next, you select the app extension you intend to add. 
This will generate extension-specific 
code. To learn more about the generated code and the SDKs for each extension point, 
see the resources in [Apple's documentation][].

## How do Flutter apps interact with App Extensions? 
Flutter apps can interact with app extensions in the same ways that UIKit or SwiftUI apps do. 
There is no direct communication between the containing app and the app extension. 
Instead, they communicate indirectly by reading and writing to shared resources or 
using higher level APIs.


### Using higher level APIs
Some extension points have APIs to configure or update the app extension. 
For example, the [Core Spotlight][] framework allows you to index your app 
so users can search from Spotlight and Safari. The [WidgetKit][] framework allows you 
to trigger an update of your Home Screen Widget.

For APIs that do not display UI, you can use a plugin to make calls 
to and from your Flutter app. You can find plugins that wrap around 
app extension APIs at [Leveraging Apple's System APIs and Frameworks][] 
or by searching on [pub.dev][].

### Sharing resources
To share resources between your Flutter app and your app extension, the `Runner` app target 
and the extension target must be in the same [App Group][]. 
To add a target to an App Group, open the target in Xcode and navigate 
to the **Signing & Capabilities** tab. 

Add an App Group by selecting **+ Capability**, and selecting **App Groups**. Next, 
select or create the App Group. 

{{site.alert.note}}
You must be signed in to your Apple Developer account.
{{site.alert.end}}


{% include docs/app-figure.md
image="development/platform-integration/app-extensions/xcode-app-groups.png" %}

When two targets are in the same App Group, they can read and write data to the same 
container. There are a few different data storage options:

- **Key/value:** The [`shared_preference_app_group`][] plugin gives access to 
`UserDefaults` within App Groups
- **File:** Use the App Group container path from the [`path_provider`][] 
plugin to [read and write files][]
- **Database:** Use the App Group container path from the [`path_provider`][] 
plugin to create a database with the [`sqflite`][] plugin. 

### Background updates
Background tasks allow you to programmatically update 
your extension, even while your app is not running. To schedule 
background work from your Flutter app, use the [`workmanager`][] plugin.

### Deep linking
You may want to direct users from an App Extension to a 
specific page in your Flutter app. You can use deep linking 
so that a URL opens a specified route in your app. For more 
information, see [Deep Linking][].


## Creating app extension UIs with Flutter
Some app extensions display UI. For example, iMessage extensions allow users 
to access your app's content directly from the Messages app. 

{% include docs/app-figure.md
image="development/platform-integration/app-extensions/imessage-extension.png" %}

Flutter tooling does **not** officially support targeting app extensions. 
However, in some cases it may be possible by embedding the `FlutterViewController` 
as described below. 

{{site.alert.note}}
This requires a custom build of the Flutter engine. You can learn more at [Compiling the engine][]
{{site.alert.end}}

1. Create a custom build of the Flutter engine that removes uses of `sharedApplication` 
and corrects the path for the bundle. See an [example from the community on Github][].
2. Share build configurations by opening the Flutter app project settings in Xcode. 
In the **Info** tab, under the **Configurations** expandable group, expand the
 **Debug**, **Profile**, and **Release** entries. For each, select the same value from 
 the drop-down menu for the extension target as the entry selected for the normal app target. 
    {% include docs/app-figure.md
    image="development/platform-integration/app-extensions/xcode-configurations.png" %}
3. Embed the `FlutterViewController` as described in [Adding a Flutter Screen][]. 
If the extension UI code leverages storyboard, 
remove the storyboard file and change references to point to the `ViewController` class. 


You can see a complete tutorial of these steps at [Adding an iMessage Extension][].


{{site.alert.important}}
This has not been tested in App Store submissions.
Also, this may not work for some app extensions. 
For example, Home Screen Widgets are not able to use some 
lower level APIs that are needed to draw Flutter UI.
{{site.alert.end}} 

## Tutorials
For a step-by-step tutorial of leveraging app extensions with your Flutter iOS app, see the 
codelabs linked below:

- [Adding an iMessage Extension][]: creating an iMessage extension using Flutter
- [Adding Home Screen Widgets to your Flutter app][]: creating Android and iOS Widgets 
that communicate with your Flutter app




[Apple's documentation]: https://developer.apple.com/app-extensions/
[Core Spotlight]: https://developer.apple.com/documentation/corespotlight
[WidgetKit]: https://developer.apple.com/documentation/widgetkit
[Leveraging Apple's System APIs and Frameworks]: {{site.url}}/development/platform-integration/ios/apple-frameworks
[pub.dev]: {{site.pub-pkg}}
[App Group]: https://developer.apple.com/documentation/xcode/configuring-app-groups
[Adding a Flutter Screen]: https://docs.flutter.dev/development/add-to-app/ios/add-flutter-screen?tab=vc-uikit-swift-tab#alternatively---create-a-flutterviewcontroller-with-an-implicit-flutterengine
[`shared_preference_app_group`]: {{site.pub-pkg}}/shared_preference_app_group
[Compiling the Engine]: https://github.com/flutter/flutter/wiki/Compiling-the-engine
[`path_provider`]: {{site.pub-pkg}}/path_provider
[`sqflite`]: {{site.pub-pkg}}/sqflite
[`workmanager`]: {{site.pub-pkg}}/workmanager
[read and write files]: {{site.url}}/cookbook/persistence/reading-writing-files
[example from the community on Github]: https://github.com/tomduncalf/engine/pull/1/files
[Deep Linking]:{{site.url}}/development/ui/navigation/deep-linking

<!--  TO DO: add links when published -->
[Adding an iMessage Extension]: https://codelabs.developers.google.com/
[Adding Home Screen Widgets to your Flutter app]:https://codelabs.developers.google.com/