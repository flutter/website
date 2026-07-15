---
title: "The future of iOS development with Flutter"
description: "Our recent accomplishments and future priorities for making Flutter a better tool for developing iOS apps"
publishDate: 2023-05-18
author: leighajarett
image: images/1OGs9_siPcMAYd1yDAp-AOA.webp
category: announcements
layout: blog
---

Since its launch in 2017, [Flutter](http://flutter.dev) has quickly become a top choice for iOS app development. Developers worldwide *love* Flutter. Using Flutter, they can code once and deploy their apps to iOS, Android, web and desktop. This has led to a massive following, with over [a million apps](https://medium.com/flutter/racing-forward-at-i-o-2023-with-flutter-and-dart-df2a8fa841ab) built using Flutter.

For iOS developers who value innovative design, Flutter has become a go-to platform. By providing a blank canvas, Flutter gives designers endless possibilities. They can create original experiences that break free from pre-set design systems.

<YoutubeEmbed id="6IKhXXFFOuw" title="Build Wonders with Flutter" fullwidth="true"/>


Today, I want to tell you about some recent improvements to Flutter and our future focus areas for iOS developers. If you’re a pro or new to Flutter, read on to learn about the future of Flutter for iOS.

## Notable Flutter iOS apps

Flutter has seen success across various industries and categories for iOS development. Large enterprises like [BMW](https://apps.apple.com/us/app/my-bmw/id1519457734), [Sonos](https://apps.apple.com/us/app/sonos/id1488977981), and [Nubank](https://apps.apple.com/us/app/nubank-conta-e-cart%C3%A3o/id814456780) build their digital experiences with Flutter.

<DashImage figure src="images/1OGs9_siPcMAYd1yDAp-AOA.webp" />


Tech giants like [WeChat](https://apps.apple.com/us/app/wechat/id414478124) and [PUBG MOBILE](https://www.youtube.com/watch?v=03ETVuWZiBc) use Flutter to support over one billion active users. Smaller companies have also capitalized on Flutter’s quick development cycle. One example would be [BrickIt](https://apps.apple.com/us/app/brickit-app/id1477221636) which uses machine learning to suggest new LEGO brick creations.

Apple and other tech leaders have even recognized Flutter iOS apps. [Wonderous](http://wonderous.app), Flutter’s reference app, was [nominated for a Webby in design](https://winners.webbyawards.com/2023/apps-dapps-and-software/app-features/best-user-interface/239934/wonderous). Apple accepted [Reflection.app](https://flutter.dev/showcase/reflectionapp) to its prestigious accelerator program. [So Vegan](https://flutter.dev/showcase/so-vegan) was awarded Apple’s App of the Day *several* times.

<DashImage figure src="images/14QurT4QkFUMSNCSFtfOzxg.webp" />


## Recent enhancements

Flutter’s iOS support has been a top priority. We’ve made significant improvements in recent releases. Let’s review some highlights:

### Improved Performance

Impeller, our purpose-built rendering engine, now serves as the default for Flutter on iOS. Impeller has been a multi-year journey for our team. It addresses the top concerns for iOS developers leveraging Flutter: smooth graphics and top tier performance. Since its release, we’ve seen great improvements in app quality. More recently, enhancements to Flutter’s engine continue to improve startup latency and reduce app size.

<YoutubeEmbed id="vd5NqS01rlA" title="Introducing Impeller - Flutter's new rendering engine" fullwidth="true"/>


Impeller also simplifies adding new features. These features range from wide gamut image support to custom rendering solutions. We demonstrated one such custom rendering solution, a proof of concept for 3D support, at [Flutter Forward.](https://www.youtube.com/watch?v=goL7tvLQ7Dw)

<DashImage figure src="images/0MUGkFV9MRrcT7-68.webp" />


<DashImage figure src="images/0YnEEnzt7QIuuxofn.webp" />


<DashImage figure src="images/04Mb0dUry2lkuUvXI.webp" alt="Impeller enables Flutter to render 3D graphics, as shown in this fun demo of Dash (our mascot)." caption="Impeller enables Flutter to render 3D graphics, as shown in this fun demo of Dash (our mascot)." />


### Developer Experience Enhancements

We understand the challenges of building and releasing an iOS app. To save help save developer’s time, we’ve added new tools and resources to simplify the entire process. You can now [connect to iOS devices](https://docs.flutter.dev/get-started/install/macos#ios-setup) over Wi-Fi to test and debug your app. We’ve also [added validation](https://github.com/flutter/flutter/issues/97730) to the release process. This step ensures that you took all necessary steps before releasing your app to the App Store.

<iframe src="https://twitter.com/EnzoConty/status/1656379609796038670" width="500" height="281" frameborder="0" allowfullscreen></iframe>


In addition, we’ve created iOS-focused documentation and tutorials to help developers learn Flutter and build iOS apps. We’ve incorporated Swift and SwiftUI examples into our documentation. We added guides on moving from [Swift to Dart](https://dart.dev/guides/language/coming-from/swift-to-dart), [SwiftUI to Flutter](https://docs.flutter.dev/get-started/flutter-for/swiftui-devs) and adding [ Flutter to an existing iOS app](https://docs.flutter.dev/add-to-app/ios/project-setup). We’ve also added resources for supporting [flavors on iOS](https://docs.flutter.dev/deployment/flavors) and using [ iOS app extensions](https://docs.flutter.dev/platform-integration/ios/app-extensions) like home and lock screen widgets.

### iOS-style UI ComponentUpdates

The [Cupertino library](https://docs.flutter.dev/ui/widgets/cupertino) provides widgets (UI components) resembling SwiftUI and UIKit views. This should make your app feel right at home on Apple devices. To better align with the latest iOS design guidelines, we’ve made significant updates to our Cupertino library.

We’ve addressed top-voted issues and added new widgets like [CupertinoCheckbox](https://api.flutter.dev/flutter/cupertino/CupertinoCheckbox-class.html), [CupertinoRadio](https://api.flutter.dev/flutter/cupertino/CupertinoRadio-class.html), [CupertinoListTile](https://api.flutter.dev/flutter/cupertino/CupertinoListTile-class.html) and spell check support on text input fields.

<DashImage figure src="images/1qYEQdMvlHvAFS1biiH6phg.webp" alt="Automatic iOS style spell check on TextField and CupertinoTextField" caption="Automatic iOS style spell check on TextField and CupertinoTextField" />


In addition, we recognize the importance of cross-platform design. We’ve added [adaptive constructors](https://docs.flutter.dev/resources/platform-adaptations#ui-components) to several Material widgets. This allows your Flutter app to adapt between Android and iOS design conventions. For common widgets *without* adaptive constructors, we’ve created [preliminary guides](https://docs.flutter.dev/resources/platform-adaptations#top-app-bar-and-navigation-bar) to give you code snippets to adapt entire widgets or widget properties.

<DashImage figure src="images/1rBWjG-4wCqJlY98oPeADrw.webp" />


## *Roadmap*

As we continue to make Flutter a better tool for iOS developers, we’re focusing on a few key areas:

### Integrations with the Apple ecosystem

Flutter developers should be able to easily use Apple’s APIs in their apps. This allows them to create immersive experiences that integrate all of Apple’s great offerings.

A few months ago, we launched [FFIgen](https://pub.dev/packages/ffigen). This tool generates bindings to [call Objective-C and Swift APIs directly from Dart code.](https://dart.dev/guides/libraries/objective-c-interop) Some apps are using FFIgen to call Apple’s APIs now. But, there are still limitations. We’re actively working on making the tool more robust with support for async callbacks and better Swift interop.

Furthermore, we know the importance of [app extensions](https://developer.apple.com/app-extensions/) within the iOS ecosystem. That’s why we’re developing a way to create the user interface (UI) for some extensions using Flutter. This will enable developers to reuse components from their Flutter app to design their extension’s interface. It’s worth noting that this approach won’t work for all types of extensions. WidgetKit widgets, for instance, have strict API restrictions. However, it will work for other common extensions such as [Share](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Share.html#//apple_ref/doc/uid/TP40014214-CH12-SW1) or [iMessage](https://developer.apple.com/documentation/messages). To keep up with our progress, you can follow [this work in this Flutter Github issue](https://github.com/flutter/flutter/issues/124287).

<DashImage figure src="images/1K2e5QrjXtv0bCU35H_uRkw.webp" alt="A proof of concept for a Flutter app running as an iOS share extension" caption="A proof of concept for a Flutter app running as an iOS share extension" />


### Cross-platform design

Deploying your app across multiple platforms requires some design considerations. There’s a balance between customizing the design of UI components to match your brand, while adhering to platform conventions.

As such, we’re investigating ways to improve the experience for designing and building Flutter apps. First, we want to make Flutter’s out-of-the-box UI components more flexible. This way, developers can quickly customize widgets to match their own design systems. Second, we want to leverage more automated adaptations that make Flutter apps feel natural on both iOS and Android.

### Developer experience

We’re committed to improving the iOS developer experience with Flutter. One key focus is decreasing build times to improve developer productivity. Additionally, we’re addressing long-standing requests such as the ability to [rename the Runner app](https://github.com/flutter/flutter/issues/9767). Finally, we’ll continue to prioritize performance enhancements and general iOS fidelity.

## Send us your feedback

As an open source project, you can track our progress on [GitHub](https://github.com/flutter/flutter). We may add, prolong, or defer features based on what we learn and what you tell us.

As always, we value your feedback and appreciate your support! The best way to send us your input is by filing issues in [GitHub](http://github.com/flutter/flutter/issues) and filling out our quarterly user survey. You can stay up to date on future Flutter iOS work by following me on [Twitter](https://twitter.com/LeighaJarett).

## Resources

* [Flutter website](http://flutter.dev)

* [Wonderous app GitHub](https://github.com/gskinnerTeam/flutter-wonderous-app)

* [Flutter GitHub](https://github.com/flutter)
