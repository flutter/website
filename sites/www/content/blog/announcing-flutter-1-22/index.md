---
title: "Announcing Flutter 1.22"
description: >-
  Supporting iOS 14 and Android 11, new i18n and l10n support,
  Google Maps and WebView plugins ready for production, and much more!
publishDate: 2020-10-01
author: csells
image: images/0luz0EiazQQqsAEC4.webp
category: release
layout: blog
---

## Supporting iOS 14 and Android 11, new i18n and l10n support, Google Maps and WebView plugins ready for production, a new App Size tool and much more!

We’re delighted to introduce our latest release of Flutter, with extensive support for iOS 14 and Android 11. Flutter 1.22 builds on the foundation set by previous releases by enabling developers to build fast, beautiful user experiences for multiple platforms from a single codebase. Our quarterly stable releases package the latest features, performance improvements, and bug fixes, and are suitable for broad production use.

Since this is the season for new mobile OS versions, this release focuses on ensuring that Android 11 and iOS 14 work great with Flutter. Updates for both of these OSes include a lot of under-the-hood work to conform to the latest SDKs and to make sure everything passes our extensive test suite. For iOS 14, this release includes support for the new Xcode 12, new icons, and preview support for the new iOS 14 App Clips feature. For Android 11, the update supports the new types of display cutouts as well as smoother animation when bringing up the soft keyboard.

This release comes two months after our 1.20 release, so it was shorter than most. Even in that short time, we closed 3,024 issues and merged 1,944 PRs from 197 contributors. Of those contributors, 114 (58%) of them were from the community-at-large and they contributed 271 PRs. The largest single contributor was [a14n](https://github.com/a14n), who makes our top contributor list again with 20 PRs, most of which were done as part of the work to support null safety in Flutter (more on that coming soon).

In addition to the support for the new mobile OS versions, there’s quite a bit more news to share, including a preview of one of the top-requested features for Android: state restoration, a new “universe” of Material buttons, new international and localization support that works with hot reload, a new Navigator, a stable release for Platform Views (the foundation for the Google Maps and WebView plugins), and a switch you can throw in your code to improve scrolling on devices with high frequency displays. We’ve also got a new tool for dissecting app size and for ensuring that the plugins that you’re building support only the platforms that you want to support.

## Targeting iOS 14

Whenever a new version of a mobile OS is announced, we test it thoroughly, looking for incompatibilities or changes that affect Flutter and its tools.

In the case of iOS 14, we made quite a few changes to Flutter to ensure that it works the way developers want:

* Xcode 12 requires iOS 9.0 or up, so our default template increases its default from 8.0 to 9.0

* iOS 14 specific crashes and font rendering issues were fixed in Flutter 1.22

* Problems deploying to physical devices were fixed as of Flutter 1.20.4

* A new policy that shows uses notifications when apps access their clipboard caused spurious notifications in Flutter apps, and was fixed as of Flutter 1.20.4

* A restriction disables running debug apps on iOS 14 devices except as part of the debugging process

* A new policy around network security for locally debugged Flutter apps causes iOS 14 to show a one-time confirmation dialog (only during development, not for released Flutter apps)

Bottom line: if you’re targeting iOS 14 with your Flutter app, we strongly encourage you to rebuild it with Flutter 1.22 and deploy it to the App Store now to ensure that your iOS 14 users have the best experience.

For more details about targeting iOS 14 with Flutter, including some Add-to-App, deep linking, and notification considerations, refer to [the iOS 14 documentation on flutter.dev](https://flutter.dev/docs/development/ios-14).

Hopefully, all of this work on the tooling and SDK support allows you to focus on the coding that you care about — taking advantage of new iOS 14 features.

One such feature is updated support for iOS’s new SF Symbols font, which inspired us to spend some time giving [the `cupertino_icon` package](https://pub.dev/packages/cupertino_icons) a refresh. Existing uses of `CupertinoIcons` will automatically map to the new style once you update your `cupertino_icons` dependency to the new 1.0 major version. If you use `cupertino_icons` 1.0 in conjunction with Flutter 1.22, you’ll also have access to ~900 new icons through the [`CupertinoIcons`](https://api.flutter.dev/flutter/cupertino/CupertinoIcons-class.html) API.

<DashImage figure src="images/0ZGKu3IhnPNp6fS_e.webp" />

You can see the complete list of icons on the [`cupertino_icons`](https://flutter.github.io/cupertino_icons/) preview page and [a migration detail page on flutter.dev](https://flutter.dev/docs/release/breaking-changes/cupertino-icons-1.0.0).

Another feature for you to try with Flutter on iOS 14 is [App Clips](https://developer.apple.com/app-clips/), a new iOS 14 feature that supports quick, no-install app executions of lightweight versions of apps under 10MB. In Flutter version 1.22, we have a preview of App Clip targets built with Flutter.

<DashImage figure src="images/08MER4IM-IEt2ye2a.webp" alt="A Flutter-powered App Clip experience" caption="A Flutter-powered App Clip experience" />

For more details on how to build App Clips with Flutter, check out [the docs on flutter.dev](https://flutter.dev/docs/development/platform-integration/ios-app-clip). You could also consult this [simple sample project](https://github.com/flutter/samples/tree/master/ios_app_clip).

## Android 11

This release of Flutter also coincides with the launch of Android 11 this month. The Flutter framework and engine have been updated to support two new features introduced in the latest version of Android.

Firstly, Flutter now supports exposing the safe insets of Android notches, cutouts and edges of waterfall displays.

<DashImage figure src="images/0lPO4ueKwxvV0QP_I.webp" />

By using the [`MediaQuery`](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html) and [`SafeArea`](https://api.flutter.dev/flutter/widgets/SafeArea-class.html) APIs, you can ensure that you’re placing active UI and interactive elements in the non-obstructed regions of the device’s display. Also, you’ll want to avoid gesture detectors in the waterfall edge area that may be prone to accidental touches.

Secondly, the animation is synchronized with Android 11 as it displays the software keyboard.

<DashImage figure src="images/0DFRjYzbqIc5kOoDm.webp" alt="See the position animation of the FAB" caption="See the position animation of the FAB" />

Issue [#19279](https://github.com/flutter/flutter/issues/19279) has been a long-standing problem where the system keyboard show/hide animation isn’t synchronized with Flutter’s inset. This is fixed for Android 11.

One note about the Android embedding API. With Flutter version 1.12 last year, we rolled out a new set of Flutter engine and Flutter plugin APIs for Android. We created these v2 APIs to better support our add-to-app users on Android. A year later, over 80% of our Android plugins use the new Android APIs. Starting in 1.22, we’re deprecating the older v1 APIs.

If you’re still using the Android v1 API, here’s what this means for you:

* Newly created plugins will no longer target the v1 APIs

* The Flutter tool’s `--no-enable-android-embedding-v2` config flag has been removed and is now the default behavior

* Older applications still using the v1 APIs will show a deprecation warning during build that points to the [Supporting the new Android plugins APIs](https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration) docs

Meanwhile, if you still have a Flutter application based on v1 Android APIs, it will continue to work. However, you may start to encounter new plugins that only target the v2 API and that can’t be consumed by v1 Android APIs. For more details, see [the breaking change documentation](https://flutter.dev/docs/release/breaking-changes/android-v1-embedding-create-deprecation).

## Expanding the Button “universe”

<DashImage figure src="images/1crNLxg7CCtlQkB4mLI_ErA.webp" alt="A new universe of Material Design buttons" caption="A new universe of Material Design buttons" />

Existing Flutter buttons look good but can be [hard to use](https://flutter.dev/go/material-button-system-updates), especially when you need custom theming. Furthermore, the Material specification has expanded to include new buttons with new styles.

To keep Flutter up to date with Material guidelines, we’re happy to announce a whole new “universe” of buttons in Flutter 1.22.

Rather than try and evolve the existing button classes and their theme in-place, [this PR](https://github.com/flutter/flutter/pull/59702) introduces new, replacement button widgets and themes. In addition to freeing us from the backwards compatibility labyrinth that evolving the existing classes would entail, the new names sync Flutter with the [Material Design spec](https://material.io/components/buttons/), which uses the new names for the button components.

<DashImage figure src="images/1di6uPEKEsRHoFtRryHeWPg.webp" />

The new themes follow the “normalized” pattern that Flutter has recently adopted for new Material widgets. If you’d like to play with a demo, there’s [a great one here on DartPad](https://dartpad.dev/e560e1c2e4455ad53aac245079ccdcf2). This is not a breaking change as the semantics of `FlatButton`, `OutlineButton`, `RaisedButton`, `ButtonBar`, `ButtonBarTheme`, and `ButtonTheme` won’t change. You can mix and match the old buttons with the new. as you prefer.

## New internationalization and localization support

Flutter has provided the core functionality you need for the internationalization (i18n) and localization (l10n) of your apps since Flutter’s inception. However, with this release, we’ve baked our opinions of best practices into our tools, even enabling hot reload support to update your app as you add new l10n information.

<DashImage figure src="images/0UBVlGmhw5NUWbg5I.webp" />

If you’d like more details about Flutter’s support for l10n, including localized messages, messages with parameters, dates, numbers, and currencies, [read the Flutter Internationalization User Guide](https://flutter.dev/go/i18n-user-guide).

Furthermore, if you’re interested in i18n and l10n, then you’re probably also interested in strings with characters that don’t fit into plain old ASCII, like Unicode and emoji. Recently, the Dart team released [the `characters` package](https://pub.dev/packages/characters), which helps developers deal with Unicode (extended) grapheme clusters. This package helps solve problems like how to properly abbreviate a string like “A 🇬🇧 text in English” to the first 15 characters. Using the `String` class, that abbreviation would be “A 🇬🇧 text in”, which is only 12 user-perceived characters. On the other hand, using the `characters` package yields the correct abbreviation of “A 🇬🇧 text in Eng”.

With [this PR](https://github.com/flutter/flutter/pull/59267), Flutter uses the characters package to properly handle these complex characters. For example, when using a `TextField` with a `maxLength` limit, characters like 👨‍👩‍👦 are now properly counted as a single character. Also, with [this PR](https://github.com/flutter/flutter/pull/59620), the characters package is automatically available in projects wherever Flutter is, without needing to manually add it. Hopefully this makes it even easier to handle strings of all kinds from all locales. For more details about the characters package, check out the excellent article, [Dart string manipulation done right 👉](https://medium.com/dartlang/dart-string-manipulation-done-right-5abd0668ba3e).

## Google Maps and WebView plugins ready for production

Here on the Flutter team, we are often cautious about labeling something as “production ready” until we’ve tested it thoroughly ourselves. In the case of the [`google_maps_flutter`](https://pub.dev/packages/google_maps_flutter) and [`webview_flutter`](https://pub.dev/packages/webview_flutter) plugins, the gating factor has been the underlying [Platform Views](https://flutter.dev/docs/development/platform-integration/platform-views) implementation, which allows native UI components from both Android and iOS to be hosted in a Flutter app. With this release of Flutter, we’re happy to announce that we have hardened the framework plumbing enough to declare both of these plugins as production ready.

<DashImage figure src="images/0luz0EiazQQqsAEC4.webp" alt="webview_flutter plugin hosting flutter.dev" caption="webview_flutter plugin hosting flutter.dev" />

In Flutter 1.22, we’ve added an alternative Platform Views implementation that fixes [all known keyboard, and accessibility issues for Android views](https://github.com/flutter/flutter/issues/61133). Also, it works with Android API level 19 and above (it used to require level 20). We have also made threading improvements on iOS that make platform views more efficient and more robust (and no longer requires you to add the `io.flutter.embedded_views_preview` flag to your iOS `Info.plist`).

The `webview_flutter` plugin supports the new Android Platform Views mode but currently it needs to be [enabled manually](https://github.com/flutter/plugins/blob/master/packages/webview_flutter/README.md#android). We’ll enable it by default in future versions once it’s gotten more use in the wider community.

The Google Maps and WebView plugins already benefit from the improvements in Platform Views. If you’d like to use Platform Views to host your own native UI components on iOS or Android, you can learn how to do so on [Hosting native Android and iOS views in your Flutter app with Platform Views](https://flutter.dev/docs/development/platform-integration/platform-views).

## Navigator 2.0

If you’ve used [navigation](https://flutter.dev/docs/development/ui/navigation) in your Flutter apps before, you may have noticed that the core data structure, the stack of pages that your user is navigating through, is hidden from you. Instead, to manage it, you call `Navigator.pop()` or `Navigator.push()`. For example, let’s say that you wanted to show a list of widgets on your home page and allow the user to tap on one to get to a detail page dedicated to just that color.

<DashImage figure src="images/0OVbaUaMkAXrpLQCy.webp" />

The two screens could be implemented like so:

```dart
class ColorListScreen extends StatelessWidget {
 final List<Color> colors;
 final void Function(Color color) onTapped;
 ColorListScreen({this.colors, this.onTapped});

 @override
 Widget build(BuildContext context) => Scaffold(
       appBar: AppBar(title: Text('Colors')),
       body: Column(
         children: [
           // you can see and decide on every color in this list
           for (final color in colors)
             Expanded(
               child: GestureDetector(
                 child: Container(color: color),
                 onTap: () => onTapped(color),
               ),
             )
         ],
       ),
     );
}

class ColorScreen extends StatelessWidget {
 final Color color;
 const ColorScreen({this.color});

 @override
 Widget build(BuildContext context) => Scaffold(
       appBar: AppBar(title: Text('Color')),
       body: Container(color: color),
     );
}
```

Using the simplest Navigator 1.0 style allows you to navigate between these two screens in a way that looks pretty easy:

```dart
class _ColorAppState extends State<ColorApp> {
 List<Color> _colors = [Colors.red, Colors.green, Colors.blue];

 @override
 Widget build(BuildContext context) => MaterialApp(
       title: 'Color App',
       home: Builder(
         builder: (context) => ColorListScreen(
           colors: _colors,
           // the Navigator manages the list of pages itself; you can only push and pop
           onTapped: (color) => Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => ColorScreen(color: color)),
           ),
         ),
       ),
     );
}
```

The call to `Navigator.push()` is all that’s needed to push another page on top of the first one, creating a stack of two pages. However, unlike the list of `Containers` created in the build method of the `ColorListScreen`, that stack is hidden from you. And because it’s hidden, it’s hard to manage for other scenarios, like handling deep linking with an initial route provided by a native embedding, for example, or a URL from the web or intent from Android. It’s also exceedingly difficult to manage nested routing between different arrangements of the same page.

Navigator 2.0 solves these problems and more by making the stack of pages visible. Here’s an updated example of navigating between the same `ColorListScreen` and `ColorScreen`:

```dart
class _ColorAppState extends State<ColorApp> {
  Color _selectedColor;
  List<Color> _colors = [Colors.red, Colors.green, Colors.blue];

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Color App',
    home: Navigator(
      // You can see and decide on every page in this list:
      pages: [
        MaterialPage(
          child: ColorListScreen(
            colors: _colors,
            onTapped: (color) => setState(() => _selectedColor = color),
          ),
        ),
        if (_selectedColor != null) MaterialPage(child: ColorScreen(color: _selectedColor)),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        setState(() => _selectedColor = null);
        return true;
      },
    ),
  );
}
```

The app explicitly creates a `Navigator` and gives it a list of pages that represents the complete stack. We create an empty `_selectedColor` to indicate that no color has yet been selected, so we don’t show the `ColorScreen` initially. When the user selects a color, we call `setState()` as normal to indicate to Flutter that you’d like the `build()` method called again, which now creates a stack with the `ColorScreen` on top.

You update your state in the `OnPopPage` call back, for example, if the user popped, then they’ve “unselected” the current color and we no longer want to show that page.

If Navigator 2.0 looks like the rest of Flutter, that’s the intent — it’s declarative, unlike Navigator 1.0 which is imperative. The idea was to unify the models between navigation and the rest of Flutter while simultaneously fixing a bunch of issues and adding features. In fact, this little example barely scratches the surface of what’s in Navigator 2.0. For the details, I highly recommend the article on [Declarative navigation and routing in Flutter](https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade).

Also, your existing use of Navigator 1.0 will continue to work just as it does today and won’t be removed anytime soon. If you prefer that model, you can certainly continue to use it. However, if you try Navigator 2.0, we think you’ll like it.

## Preview: State Restoration for Android

A new feature that is available for you to experiment with in this release is support for [State Restoration on Android](https://developer.android.com/topic/libraries/architecture/saving-states). This is one of our [most-requested features](https://github.com/flutter/flutter/issues/6827) with 217 thumbs up!

For those not familiar with the need for state restoration, mobile OSes might kill apps that are in the background to reclaim resources for foreground apps. When this happens, the OS notifies the app to be killed to save any UI state quickly so that it can be restored when the user cycles back to that app. When implemented correctly, this provides a seamless experience for the user while making better use of the device’s resources. Until now, Flutter didn’t support state restoration and it was very difficult to do it correctly without framework support. That’s why we’re very happy to be able to deliver the foundational implementation of this feature for Android.

Here’s [a very simple sample](https://api.flutter.dev/flutter/widgets/RestorationMixin-mixin.html#widgets.RestorationMixin.1) for restoring the state of the default Flutter Counter app:

```dart
class CounterState extends State<RestorableCounter> with RestorationMixin {
  @override
  String get restorationId => widget.restorationId;

  RestorableInt _counter = RestorableInt(0);

  @override
  void restoreState(RestorationBucket oldBucket) => registerForRestoration(_counter, 'count');

  void _incrementCounter() => setState(() => _counter.value++);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Text('${_counter.value}')),
    floatingActionButton: FloatingActionButton(onPressed: _incrementCounter),
  );
}

```

Briefly, each widget gets a storage bucket, which is registered with the [`RestorationMixin`](https://api.flutter.dev/flutter/widgets/RestorationMixin-mixin.html) using a unique ID. By using a [`RestorableProperty`](https://master-api.flutter.dev/flutter/widgets/RestorableProperty-class.html) type (like `RestorableInt` used here) to store the UI-specific data, and by registering that data with the State Restoration feature, the data is automatically stored before Android kills the app, and restored when it’s brought back to life. And that’s it. Any data that’s stored in a `Restoration*` type, like `RestorableInt`, `RestorableString` and `RestorableTextEditingController` (we’ve got a bunch of them) will be restored. And if we don’t cover all of the types you’d like to have restored, you can create your own by extending [`RestorableProperty<T>`](https://api.flutter.dev/flutter/widgets/RestorableProperty-class.html).

<DashImage figure src="images/01298qhTKz_FjPuRN.webp" />

For automated testing of state restoration, we’ve added [a new `restartAndRestore` API to WidgetTester](https://api.flutter.dev/flutter/flutter_test/WidgetTester/restartAndRestore.html). And to test manually, the easiest thing to do is to start your state restoration-enabled Flutter app on an Android device, enable “Don’t keep activities” in Android’s developer settings, run your Flutter app, put it into the background, and then return to it. At this point, Android will have killed and restored your app, so you can see if everything is working as you expect.

While we’re happy to put this preview version of State Restoration in your hands, there’s more work to do. For example, state restoration isn’t just for Android, iOS apps could benefit as well. Furthermore, we’re busy updating our own widgets to keep their state during restoration. We’ve already provided support in the `Scrollable` classes like `ListView` and `SingleChildScrollView` (to remember the user’s scroll position) and `TextFields` (to restore the text they’ve entered), and we plan to extend that to other widgets.

However, the key restoration support we have not yet added, and what makes this a preview release, is navigation (either 1.0 or 2.0). This means that where your user is in the app won’t be restored. That feature will be coming to a beta soon and to the next stable release of Flutter.

## Preview: Smooth scrolling for unmatched input and display frequencies

Working with our internal Google partners, the Flutter team has greatly improved the performance of scrolling when the input and the display frequencies are not the same. For example, the Pixel 4 input runs at 120hz whereas the display runs at 90hz. This mismatch can cause a performance penalty when scrolling. With a new `resamplingEnabled` flag, you can take advantage of the performance work we’ve done in Flutter to address this issue:

```dart
void main() {
  GestureBinding.instance.resamplingEnabled = true;
  run(MyApp());
}
```

Depending on the frequency discrepancies involved, you may see up to 97% less jank in scrolling by enabling this flag. When we’re sure this is the best experience, we plan to enable this flag by default in a future build.

## A new unified Dart developer tool

As always, an update to Flutter doesn’t just mean the engine and the framework but the tooling as well. Flutter 1.22 includes a new version of Dart (2.10), and there’s a new `dart` CLI tool that you might find useful as well.

Dart historically has had many smaller developer tools (such as `dartfmt` for formatting, and `dartanalyzer` for code analysis). New in Dart 2.10 is a unified `dart` developer tool very similar to the `flutter` tool.

<DashImage figure src="images/19pvyafhpaMEMhJfLVsz1JQ.webp" />

Starting with today’s Flutter 1.22 SDK, you will find that the `<flutter-sdk>/bin` folder (which you likely have in your `PATH`) contains both `flutter` and `dart` commands. For more details, see the [Dart 2.10 blog post](https://medium.com/@mit.mit/announcing-dart-2-10-350823952bd5).

## App size analysis tool

The tooling released as part of Flutter 1.22 includes a new output size analysis utility. This tool helps diagnose Flutter whether the breakdown of your app’s size changes over time.

You can use the tool to gather the data necessary for analysis by passing an `--analyze-size` flag to any of the following commands:

* `flutter build apk`

* `flutter build appbundle`

* `flutter build ios`

* `flutter build linux`

* `flutter build macos`

* `flutter build windows`

Using this flag while building a Flutter output artifact prints a summary of the artifact’s size and composition. This includes native code, assets, and even a package-level breakdown of compiled Dart code.

<DashImage figure src="images/0vfMD0AQZUOUwzfZ4.webp" alt="Example breakdown of the Flutter Gallery’s release APK" caption="Example breakdown of the Flutter Gallery’s release APK" />

This summary is helpful in quickly identifying hotspots in the application’s package size usage. In addition, the gathered data is also available as a JSON file for use in Dart DevTools, which allows you to further explore your app’s contents, pinpoint size issues and see changes between two different JSON files by following [the instructions on flutter.dev](https://flutter.dev/docs/development/tools/devtools/app-size). Once you load the JSON file, you’ll have an interface that gives you a tree map view of your app’s size.

<DashImage figure src="images/0gA2waLDAyITCzD7K.webp" alt="An example APK breakdown in Dart DevTools" caption="An example APK breakdown in Dart DevTools" />

For more details of the things you can do with the App Size tool, read [the Using the app size tool docs](https://flutter.dev/docs/development/tools/devtools/app-size) on flutter.dev.

## Preview: Updated Network Page in DevTools

Another DevTools preview feature in this release is the ability to see HTTP and HTTPs response bodies as part of the **Network** tab.

<DashImage figure src="images/0-FukCwELl9DLlefP.webp" />

To enable this feature, make sure you’re on the Flutter dev channel via `flutter channel dev` and `flutter channel upgrade`.

In addition, for apps with lots of network traffic, we’ve provided the ability to search and filter.

<DashImage figure src="images/0k-fEpOpbV_MiX9Fn.webp" />

For the **Network** tab docs, see [Using the Network View](https://flutter.dev/docs/development/tools/devtools/network) on flutter.dev.

## Hosted DevTools Inspector tab in IntelliJ

For a while now, we’ve been maintaining two copies of some of our Flutter tools, like the **Inspector** pane in IntelliJ and the **Inspector** tab in Dart DevTools. Not only does this slow us down because we’ve got to maintain two codebases, but some features haven’t yet made it into the IntelliJ plugin, like the Layout Explorer. So, to solve both of those problems, we’ve enabled the ability to host the **Inspector** tab from Dart DevTools directly inside of IntelliJ.

<DashImage figure src="images/0RQZ-EVyFP1-BqBIX.webp" />

Notice the addition of the Layout Explorer, which you can use right next to your code. To toggle this option on, go to **Preferences > Languages & Frameworks > Flutter > Enable embedded DevTools inspector**.

## Improved output linking in Visual Studio Code

A regular activity that all Flutter developers face is going from the error output in the terminal or in their stack traces. In the most recent release of the Flutter extension for Visual Studio Code, these links are now properly parsed for you to enable links directly from the output.

<DashImage figure src="images/0prigrwpp7gE6ChCE.webp" />

It seems like a small thing, but initial feedback is already very positive on this feature.

As always, there are too many tooling changes list here, but I recommend the following announcements for details:

* [Dart DevTools — 0.9.0](https://groups.google.com/g/flutter-announce/c/UxMv8MzE_uo/m/ED539pi2AAAJ)

* [Dart DevTools — 0.9.1](https://groups.google.com/g/flutter-announce/c/y27h86ATFJM)

* [Dart DevTools — 0.9.3](https://groups.google.com/g/flutter-announce/c/24LppkXdMtM)

* [Flutter IntelliJ Plugin M48.1 Release](https://groups.google.com/g/flutter-announce/c/nvgDi3RLAUE/m/Fx4Ze0vrBAAJ)

* [Flutter IntelliJ Plugin M49 Release](https://groups.google.com/g/flutter-announce/c/-ZMKRIBRtGU)

* [Flutter IntelliJ Plugin M50 Release](https://groups.google.com/g/flutter-announce/c/u0zU6zv3o44/m/2y0JsX1_AwAJ)

* [VS Code extensions v3.14.0](https://groups.google.com/g/flutter-announce/c/8e8e-ZrgySY)

* [VS Code extensions v3.15.0](https://dartcode.org/releases/v3-15/)

## Customer Spotlight: EasyA

EasyA is a subscription app designed to give school-age students access to brilliant tutors via instant messaging, and is written in Flutter. Recently it was featured by Apple as [their App of the Day](https://apps.apple.com/gb/story/id1527472788).

<DashImage figure src="images/0yLWTxV_YTJ2HKhuz.webp" />

> *“When schools began to go online earlier this year, we knew we needed to launch our tutoring app quickly to help students. The sheer speed of development with Flutter meant we were able to implement award-winning designs for both iOS and Android, and also publish to the web — just in time for lockdown! Normally, this would have been practically impossible. But since Flutter allows us to target all three platforms at once, we were able to share code efficiently and leverage our small team of developers to the fullest.”*
> *— Phil Kwok, Co-founder, [EasyA](https://easya.io/)*

## Breaking Changes

As always, we attempt to keep the number of breaking changes to a minimum. Here’s the list from the Flutter 1.22 release.

* [56413](https://github.com/flutter/flutter/pull/56413) [Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible](https://docs.google.com/document/d/1BZhxy176uUnqOCnXdnHM1XetS9mw9WIyUAOE-dgVdUM/edit?usp=sharing).

* [62395](https://github.com/flutter/flutter/pull/62395) [gen_l10n] Synthetic package generation by default

* [62588](https://github.com/flutter/flutter/pull/62588) Build routes even less.

## Summary

The Flutter 1.22 stable release may have come quickly on the heels of the previous release, but there’s so much good stuff in it that this post couldn’t mention it all. We hope this release helps you build amazing apps for iOS and Android, and we can’t wait to see what you have in store! Thank you for your support — we build Flutter for you.
