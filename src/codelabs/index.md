---
title: Codelabs & workshops
description: "Codelabs and workshops help you quickly get started programming Flutter."
---

The Flutter codelabs provide a guided,
hands-on coding experience. Some codelabs
run in DartPad&mdash;no downloads required!

Flutter workshops are similar to the codelabs,
but are instructor led and always use DartPad.
The provided workshop link takes you to the relevant YouTube video,
which tells you where to find the associated DartPad link.

{{site.alert.secondary}}
  You might want to check out the workshops
  created by our Google Developer Experts (GDEs).
  You can find them on the [Flutter community blog][].
{{site.alert.end}}

[Flutter community blog]: {{site.medium}}/flutter-community/dartpad-workshops-from-flutter-gdes-622b52f70173

## Good for beginners

If you're new to Flutter, we recommend starting with
one of the following codelabs:

{% comment %}
TODO(filiph): add the video for the new codelab when ready

* [Building your first Flutter app][] (workshop)<br>
  An instructor-led version of our very popular
  "Write your first Flutter app, part 1" codelab
  (listed below).
{% endcomment %}

* [Your first Flutter app][]<br>
  Create a simple app that automatically generates cool-sounding names,
  such as "newstay", "lightstream", "mainbrake", or "graypine".
  This app is responsive and runs on mobile, desktop, and web.
  (This also replaces the previous "write your first Flutter app"
  for mobile, part 1 and part 2 codelabs.)

* [Write your first Flutter app on the web][]<br>
  Implement a simple web app in DartPad (no downloads
  required!) that displays a sign-in screen
  containing three text fields. As the user fills out the
  fields, a progress bar animates along the top of the
  sign-in area. This codelab is written specifically for
  the web, but if you have downloaded and configured
  Android and iOS tooling, the completed app
  works on Android and iOS devices, as well.

[Building your first Flutter app]: {{site.youtube-site}}/watch?v=Z6KZ3cTGBWw
[Your first Flutter app]: {{site.codelabs}}/codelabs/flutter-codelab-first
[Write your first Flutter app on the web]: {{site.url}}/get-started/codelab-web

## Next steps

* [Building scrolling experiences in Flutter][] (workshop)<br>
  Start with an app that performs simple, straightforward scrolling
  and enhance it to create fancy and custom scrolling effects
  by using slivers.

* [Dart null safety in Action][] (workshop)<br>
  An instructor-led workshop based on the [Null safety codelab][]
  on the dart.dev site.

* [How to manage application states using inherited widgets][inherited-widget-ws] (workshop)<br>
  Learn how to manage the state of your app's data by
  using the `InheritedWidget` class, one of the
  [low-level state management][] classes provided
  by Flutter.

[Dart null safety in Action]: {{site.youtube-site}}/watch?v=HdKwuHQvArY
[inherited-widget-ws]: {{site.youtube-site}}/watch?v=LFcGPS6cGrY
[low-level state management]: {{site.url}}/data-and-backend/state-mgmt/options#inheritedwidget--inheritedmodel
[Null safety codelab]: {{site.dart-site}}/codelabs/null-safety

## Designing a Flutter UI

Learn about Material Design and basic Flutter concepts,
like layout and animations:

* [Basic Flutter layout concepts][]<br>
  Use DartPad in a browser (no downloads required!)
  to learn the basics of creating a Flutter layout.

* [How to debug layout issues with the Flutter Inspector][]<br>
  Not an official codelab, but step-by-step instructions on
  how to debug common layout problems using the Flutter 
  Inspector and Layout Explorer.

* [Implicit animations][]<br>
  Use DartPad (no downloads required!) to learn how to use
  implicit animations to add motion and create
  visual effects for the widgets in your UI.

* [Building Beautiful Transitions with Material Motion for Flutter][]<br>
  Learn how to use the Material [animations][] package to
  add pre-built transitions to a Material app called Reply.

* [Take your Flutter app from boring to beautiful][]<br>
  Learn how to use some of the features in Material 3
  to make your app more beautiful _and_ more responsive.

* [MDC-101 Flutter: Material Components (MDC) Basics][]<br>
  Learn the basics of using Material Components by building
  a simple app with core components.  The four MDC codelabs
  guide you through building an e-commerce app called Shrine.
  You'll start by building a login page using several of MDC
  Flutter's components.

* [MDC-102 Flutter: Material Structure and Layout][]<br>
  Learn how to use Material for structure and layout in Flutter.
  Continue building the e-commerce app, introduced in MDC-101,
  by adding navigation, structure, and data.

* [MDC-103 Flutter: Material Theming with Color, Shape, Elevation, and Type][]<br>
  Discover how Material Components for Flutter make it
  easy to differentiate your product, and express your
  brand through design. Continue building your e-commerce
  app by adding a home screen that displays products.

* [MDC-104 Flutter: Material Advanced Components][]<br>
  Improve your design and learn to use our advanced
  component backdrop menu. Finish your e-commerce app
  by adding a backdrop with a menu that filters
  products by the selected category.

* [Adaptive Apps in Flutter][]<br>
  Learn how to build a Flutter app that adapts to the 
  platform that it's running on, be that Android, iOS, 
  the web, Windows, macOS, or Linux.

[Adaptive Apps in Flutter]: {{site.codelabs}}/codelabs/flutter-adaptive-app
[animations]: {{site.pub}}/packages/animations
[Basic Flutter layout concepts]: {{site.url}}/codelabs/layout-basics
[Building Beautiful Transitions with Material Motion for Flutter]: {{site.codelabs}}/codelabs/material-motion-flutter
[Building scrolling experiences in Flutter]: {{site.youtube-site}}/watch?v=YY-_yrZdjGc
[How to debug layout issues with the Flutter Inspector]: {{site.flutter-medium}}/how-to-debug-layout-issues-with-the-flutter-inspector-87460a7b9db
[Implicit animations]: {{site.url}}/codelabs/implicit-animations
[MDC-101 Flutter: Material Components (MDC) Basics]: {{site.codelabs}}/codelabs/mdc-101-flutter
[MDC-102 Flutter: Material Structure and Layout]: {{site.codelabs}}/codelabs/mdc-102-flutter
[MDC-103 Flutter: Material Theming with Color, Shape, Elevation, and Type]: {{site.codelabs}}/codelabs/mdc-103-flutter
[MDC-104 Flutter: Material Advanced Components]: {{site.codelabs}}/codelabs/mdc-104-flutter
[Take your Flutter app from boring to beautiful]: {{site.codelabs}}/codelabs/flutter-boring-to-beautiful

## Using Flutter with...

Learn how to use Flutter with other technologies.

{% comment %}
  Once we get at least 3 codelabs on a specific topic,
  add a subheader for that topic.
{% endcomment %}

### Monetizing Flutter

* [Adding AdMob Ads to a Flutter app][]<br>
  Learn how to add an AdMob banner, an interstitial ad,
  and a rewarded ad to an app called Awesome Drawing Quiz,
  a game that lets players guess the name of the drawing.

* [Adding an AdMob banner and native inline ads to a Flutter app][]<br>
  Learn how to implement inline banner and native ads
  to a travel booking app that lists possible
  flight destinations.

* [Adding in-app purchases to your Flutter app][]<br>
  Extend a simple gaming app that uses the Dash mascot as
  currency to offer three types of in-app purchases:
  consumable, non-consumable, and subscription.

[Adding AdMob Ads to a Flutter app]: {{site.codelabs}}/codelabs/admob-ads-in-flutter
[Adding an AdMob banner and native inline ads to a Flutter app]: {{site.codelabs}}/codelabs/admob-inline-ads-in-flutter
[Adding in-app purchases to your Flutter app]: {{site.codelabs}}/codelabs/flutter-in-app-purchases

### Flutter and Firebase

* [Add a user authentication flow to a Flutter app using FirebaseUI][]<br>
  Learn how to add Firebase authentication to a Flutter app
  with only a few lines of code.

* [Get to know Firebase for Flutter][firebase-ws] (workshop)<br>
  An instructor-led version of our popular
  "Get to know Firebase for Flutter" codelab
  (listed below).

* [Get to know Firebase for Flutter][]<br>
  Build an event RSVP and guestbook chat app on both Android
  and iOS using Flutter, authenticating users with Firebase
  Authentication, and sync data using Cloud Firestore.

* [Local development for your Flutter apps using the Firebase Emulator Suite][]<br>
  Learn how to use the Firebase Emulator Suite when
  developing with Flutter. You will also learn to use
  the Auth and Firestore emulators.

[Add a user authentication flow to a Flutter app using FirebaseUI]: {{site.firebase}}/codelabs/firebase-auth-in-flutter-apps
[firebase-ws]: {{site.youtube-site}}/watch?v=wUSkeTaBonA
[Get to know Firebase for Flutter]: {{site.firebase}}/codelabs/firebase-get-to-know-flutter
[Local development for your Flutter apps using the Firebase Emulator Suite]: {{site.firebase}}/codelabs/get-started-firebase-emulators-and-flutter

### Flutter and TensorFlow

* [Create a custom text-classification model with TensorFlow Lite Model Maker][]<br>

* [Create a Flutter app to classify texts with TensorFlow][]<br>
  Learn how to run a text-classification inference from a Flutter
  app with TensorFlow Serving through REST and gRPC.

* [Train a comment-spam detection model with TensorFlow Lite Model Maker][]<br>
  Learn how to install the TensorFlow Lite Model Maker with Colab,
  How to use a data loader, and how to build a model.

[Create a custom text-classification model with TensorFlow Lite Model Maker]: {{site.developers}}/codelabs/classify-text-update-tensorflow-serving
[Create a Flutter app to classify texts with TensorFlow]: {{site.developers}}/codelabs/classify-texts-flutter-tensorflow-serving
[Train a comment-spam detection model with TensorFlow Lite Model Maker]: {{site.developers}}/codelabs/classify-text-tensorflow-serving

### Flutter and other technologies

* [Adding Google Maps to a Flutter app][]<br>
  Display a Google map in an app, retrieve data from a
  web service, and display the data as markers on the map.

* [Adding WebView to your Flutter app][]<br>
  With the WebView Flutter plugin you can add a WebView 
  widget to your Android or iOS Flutter app.

* [Build voice bots for mobile with Dialogflow and Flutter][] (workshop)<br>
  An instructor-led version of the Dialogflow
  and Flutter codelab (listed below).

* [Build voice bots for Android with Dialogflow and Flutter][]<br>
  Learn how to build a mobile FAQ bot that can answer most
  common questions about the tool Dialogflow. End users
  can interact with the text interface or stream a voice
  interaction via the built-in microphone of a mobile device.

* [Building a game with Flutter and Flame][]<br> **NEW**
  Learn how to create a platform game (featuring
  Dash or Sparky), using the Flame package.

* [Using FFI in a Flutter plugin][]<br> **NEW**
  Learn how to use Dart's FFI (foreign function interface)
  library, ffigen, allowing you to leverage
  existing native libraries that provide a
  C interface.

[Adding Google Maps to a Flutter app]: {{site.codelabs}}/codelabs/google-maps-in-flutter
[Adding WebView to your Flutter app]: {{site.codelabs}}/codelabs/flutter-webview
[Build voice bots for Android with Dialogflow and Flutter]: {{site.codelabs}}/codelabs/dialogflow-flutter
[Build voice bots for mobile with Dialogflow and Flutter]: {{site.youtube-site}}/watch?v=O7JfSF3CJ84
[Building a game with Flutter and Flame]: {{site.codelabs}}/codelabs/flutter-flame-game
[Using FFI in a Flutter plugin]: {{site.codelabs}}/codelabs/flutter-ffigen

## Testing

Learn how to test your Flutter application.

* [How to test a Flutter app][]<br>
  Start with a simple app that manages state with the Provider package.
  Unit test the provider package. Write widget tests for two of the
  widgets. Use Flutter Driver to create an integration test.

[How to test a Flutter app]: {{site.codelabs}}/codelabs/flutter-app-testing/#0

## Writing platform-specific code

Learn how to write code that's targeted for specific platforms,
like iOS, Android, desktop, or the web.

* [Building a Cupertino app with Flutter][]<br>
  Build a version of the Shrine shopping app
  (used in the Material Design codelabs) using the
  Cupertino package to create an iOS style look and feel.
  Create multiple tabs and navigate between them.
  Use the [provider][] package to manage state between screens.

* [How to write a Flutter plugin][]<br>
  Learn how to write a plugin by creating a music plugin
  for iOS and Android that processes audio on the host platform.
  Then make an example app that uses your plugin to make a music keyboard.

* [Using a plugin with a Flutter web app][]<br>
  Finish an app that reports the number of stars on a GitHub repository.
  use Dart DevTools to do some simple debugging, and
  Host your app on Firebase and, finally, use a Flutter plugin to
  launch the app and open the hosted privacy policy.

* [Write a Flutter desktop application][]<br>
  Build a Flutter desktop app (Windows, Linux, or macOS)
  that accesses GitHub APIs to retrieve your repositories,
  assigned issues, and pull requests. As part of this task,
  create and use plugins to interact with native APIs and desktop applications,
  and use code generation to build type-safe client libraries for GitHub's APIs.

[Building a Cupertino app with Flutter]: {{site.codelabs}}/codelabs/flutter-cupertino
[How to write a Flutter plugin]: {{site.codelabs}}/codelabs/write-flutter-plugin
[provider]: {{site.pub}}/packages/provider
[Using a plugin with a Flutter web app]: {{site.codelabs}}/codelabs/web-url-launcher
[Write a Flutter desktop application]: {{site.codelabs}}/codelabs/flutter-github-client

## Other resources

For Dart-specific codelabs, see the
[codelabs][] page on the [Dart site][].

We also recommend the following online class:

* [The Complete Flutter Development Bootcamp Using Dart][]

{{site.alert.note}}
  If you have trouble viewing any of the codelabs
  on [`codelabs.developers.google.com`]({{site.codelabs}}), try 
  [this mirror of the Flutter codelabs][].
{{site.alert.end}}

[codelabs]: {{site.dart-site}}/codelabs
[Dart site]: {{site.dart-site}}
[The Complete Flutter Development Bootcamp Using Dart]: https://www.appbrewery.co/p/flutter-development-bootcamp-with-dart
[this mirror of the Flutter codelabs]: https://codelabs.flutter-io.cn/
