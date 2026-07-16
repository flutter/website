---
title: "What’s new in Flutter 2.2"
description: "The Flutter 2.2 release focuses on polish and optimization, including iOS performance improvements, Android deferred components, updated…"
publishDate: 2021-05-19
author: csells
image: images/0fS4WbRPwmo_FQgDo.webp
category: release
layout: blog
---

*The Flutter 2.2 release focuses on polish and optimization, including iOS performance improvements, Android deferred components, updated service worker for Flutter web and more!*

Today is the day we make Flutter 2.2 available. You get to it by switching to the stable channel and upgrading your current Flutter installation, or going to [flutter.dev/docs/get-started](https://flutter.dev/docs/get-started) to start a new installation.

Even though it’s only been a couple of months since the Flutter 2 release, we have a lot of improvements to share in 2.2. This release merges 2,456 PRs and closes 3,105 issues across the framework, engine, and plugins repositories. Special shoutout to the Flutter community at large who provided a significant number of PRs and PR reviews, including [Abhishek01039](https://github.com/Abhishek01039) who contributed the most PRs (17) and [xu-baolin](https://github.com/xu-baolin), who reviewed the most PRs (9) towards Flutter 2.2. Thanks to all contributors for your help in bringing Flutter 2.2 to the stable channel. We couldn’t do it without you.

With each new Flutter release to stable comes a new set of updates, whether those are performance enhancements, new features or bug fixes. In addition, a release includes a number of features that haven’t yet ready for production use but that we want you to be able to verify that they’re working the way you want them to. And finally, each new release comes with a set of associated tooling updates and updates from the larger Flutter community. To be honest, there is so much going on with each new release of Flutter these days that we can’t reasonably capture it all in a single blog post, but we’ll try to hit the highlights.

## Flutter 2.2 updates in stable

This release covers a wide range of improvements on top of Flutter 2, including updates across Android, iOS, and web, new Material icons, updates to text handling, scrollbar behavior, and mouse cursor support for the `TextSpan` widget and new guidance on how to best support multiple kinds of platforms from a single source code base. All of these features are available in stable now and available for your use in production apps. And all of them are built on a new release of Dart.

### Dart 2.13

Flutter 2.2 comes with the Dart 2.13 release. Among other things, this Dart update contains a new type aliases feature, which enables you to create aliases for types as well as for functions:

```dart
// Type alias for functions (existing)
typedef ValueChanged<T> = void Function(T value);

// Type alias for classes (new!)
typedef StringList = List<String>;

// Rename classes in a non-breaking way (new!)
@Deprecated("Use NewClassName instead")
typedef OldClassName<T> = NewClassName<T>;
```

Type aliases make it possible to give nice short names to long, complicated types, and it also lets you rename your classes in a non-breaking way. There’s more that’s new in Dart 2.13 as well; check out the details in [the Dart 2.13 release announcement](https://medium.com/dartlang/announcing-dart-2-13-c6d547b57067).

### Flutter web updates

Flutter’s newest stable platform, web, has been improved in this release.

To start, we’ve optimized caching behavior with a new service worker-loading mechanism, and fixed double-downloading of `main.dart.js`. In previous versions of Flutter web, the service worker downloaded updates to your app in the background while giving your user access to the stale version of your app. Once that update was downloaded, the user wouldn’t see those changes until they refreshed the browser page a couple times. As of Flutter 2.2, when the new service worker detects a change, the user will wait until the updates are downloaded to use the app, but then they’ll see the updates without requiring a second manual refresh of the page.

Enabling this change requires you to regenerate the `index.html` of your Flutter app. To do that, save your modifications, delete the `index.html` file, and then run `flutter create .` in your project directory to recreate it.

We also made improvements to both web renderers. For HTML, we added support for [font features](https://developer.mozilla.org/en-US/docs/Web/CSS/font-feature-settings) to enable setting [`FontFeature`](https://api.flutter.dev/flutter/dart-ui/FontFeature-class.html) as well as using canvas APIs to render text so that it appears in the correct place when hovering. For both HTML and CanvasKit, we added support for shader masks and [`computeLineMetrics`](https://api.flutter.dev/flutter/painting/TextPainter/computeLineMetrics.html), addressing the parity gaps between Flutter web and mobile apps. For example, developers can now use [opacity masks](https://api.flutter.dev/flutter/widgets/Opacity-class.html) to perform fade-out transitions with shader masks, and use `computeLineMetrics` as they would for mobile apps.

For Flutter web, as well as Flutter in general, accessibility is one of our top priorities. As designed, Flutter implements accessibility by building a `SemanticsNode` tree. Once a Flutter web app user enables accessibility, the framework generates a DOM tree parallel to the `RenderObject` DOM tree, and translates the semantic properties to Aira. In this release, we improved semantic node position to close the gap between mobile and desktop web apps when using transforms, which means that the focus box should appear properly over elements when widgets are styled with transforms. To see this in action, check out this video by Victor Tsaran, who leads the Accessibility program for Material Design, using VoiceOver with Flutter Gallery App:

<YoutubeEmbed id="A6Sx0lBP8PI" title="Flutter's web support - Accessibility Demo" fullwidth="true"/>

We also exposed the semantics node debug tree with a command line flag in profile and release modes to help developers debug accessibility by visualizing the semantic nodes created for their web app.

To enable this for your own Flutter web app, run the following:

```bash
$ flutter run -d chrome --profile \
  --dart-define=FLUTTER_WEB_DEBUG_SHOW_SEMANTICS=true
```

With that flag activated, you’ll be able to see your semantic nodes on top of the widgets, which allows you to debug and see if semantic elements are placed where they shouldn’t be. If you find examples like that, please don’t hesitate to [file a bug report](https://goo.gle/flutter_web_issue).

While we’ve made significant progress with support for a set of core accessibility features, we will continue to improve accessibility support. In builds available on the master and dev channels beyond the 2.2 stable release, we’ve added an API to let developers programmatically [auto-enable accessibility](https://github.com/flutter/engine/pull/25830) for their apps and are fixing issues with [using Tab with screen readers](https://github.com/flutter/engine/pull/25797).

And last but certainly not least, the latest version of Flutter DevTools now supports the layout explorer for your Flutter web apps.

<DashImage figure src="images/0fS4WbRPwmo_FQgDo.webp" />

This update gives you the same layout debugging tool on the web that you’re used to with your mobile and desktop apps.

### iOS page transitions and incremental installs

For iOS, in this release [we’ve made the page transition smoother in Cupertino by reducing the time it takes to render the frames of the animation by 75%](https://github.com/flutter/flutter/pull/75670), and potentially more on low-end phones. We don’t just look for end-user performance improvements; we’re always looking for ways to improve the development performance as well.

In this release, we’ve [implemented incremental iOS installs](https://github.com/flutter/flutter/pull/77756) during the development process. In our benchmarks, we’ve seen a 40% decrease in the amount of time to install an updated version of your iOS app, which decreases your turn-around time when testing app changes.

### Use Flutter to build platform adaptive apps

As Flutter expands to support more platforms in stable, it becomes useful to consider apps that support not just different form factors, such as mobile, tablet, and desktop, but also different input types (touch vs. mouse+keyboard) and platforms with different idioms, such as navigation drawers vs. system menus for navigation. We call apps that can adjust to the details of different target platforms to be “platform adaptive” apps.

For an introduction to the considerations you’ll want to keep in mind when building platform adaptive apps, we’ll point you at the [Building platform adaptive apps](https://events.google.com/io/session/868dfd56-7f8c-49ee-84ad-ac69a23ba19d?lng=en) session from Kevin Moore. For a more detailed look, check out [the platform adaptive apps guidance on flutter.dev](https://flutter.dev/docs/development/ui/layout/building-adaptive-apps).

And, finally, for sample apps that have been written for multiple platforms according to these principles, we recommend the [Flokk](https://flutter.gskinner.com/flokk) and [Flutter Folio](https://flutter.gskinner.com/folio) apps from gSkinner. You can download the code for [Flokk](https://github.com/gskinnerTeam/flokk) and [Folio](https://github.com/gskinnerTeam/flutter-folio) as well as download [Flokk](https://flutter.gskinner.com/flokk/#g-download) and [Folio](https://flutter.gskinner.com/folio/#g-download) from the various app stores or run them directly from your browser. Another great sample is the app used to create the guidance itself:

<YoutubeEmbed id="8YUIrIGGc3Y" title="Flutter Adaptive Demo App" fullwidth="true"/>

The UX portions of the Flutter platform adaptive apps guidance is based on the new [Material Guidance for Large Screens](https://material.io/blog/material-design-for-large-screens). This new guidance from the Material team includes reworks of several of the main layout articles as well as updates to several components and an updated Design Kit, all with large screens in mind.

<DashImage figure src="images/0ROXD5MqgkYuZgDZQ.webp" />

Flutter’s goal has always been to enable apps that do more than just run on multiple platforms; we’re not done until your apps run *great* on all of the platforms you’re targeting. Flutter has the support you need to not only target your app at multiple platforms but also intends to *tailor* your apps for screen size, input modes, and idioms of each of these platforms.

### More Material icons

And on the subject of Material guidance, in this release we’ve landed not one but [two](https://github.com/flutter/flutter/pull/76607) [separate](https://github.com/flutter/flutter/pull/78311) PRs adding new Material icons to Flutter, including an icon for Dash herself!

<DashImage figure src="images/0hlsSKR8Uco4AurMH.webp" />

<DashImage figure src="images/0K7L6ppH1A1gBmVY-.webp" />

These updates bring the total number of Material icons for your apps up to more than 7,000. If you have trouble finding the icon you’re looking for in that embarrassment of riches (who wouldn’t?) you can search by category and name at [fonts.google.com/icons](https://fonts.google.com/icons).

<DashImage figure src="images/0NofBGAEBtDHtwclP.webp" alt="Searching for Flutter Material icons by name" caption="Searching for Flutter Material icons by name" />

Once you find the perfect icon, the new ‘Flutter’ tab shows you how to use it, or you can download just that icon for use as a stand-alone asset in your app. Adding Dash to your Flutter app has never been easier.

### Improved text handling

As we continue to improve Flutter to support the specifics on each platform, we continue to push into new areas that weren’t as important on mobile form-factors as they are on desktop form-factors. One of those areas is text handling. In this release, we’ve started refactoring how we handle text input that enables features like canceling a keystroke as it bubbles through the widget hierarchy, and by introducing the ability to fully customize the keystrokes associated with text actions.

Being able to cancel a keystroke allows Flutter to implement things like using the spacebar and the arrow keys without triggering scroll events, giving your end users a more intuitive experience. You can use this same capability to handle a keystroke before it gets to the parent widgets in your own apps. Another example, is that in this release you can Tab between the `TextField` and a button in your Flutter app and it just works:

```dart
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter Text Editing Fun',
    home: HomePage(),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        TextField(),
        OutlinedButton(onPressed: () {}, child: const Text('Press Me')),
      ],
    ),
  );
}

```

<DashImage figure src="images/0krVx4ycTN2nTl7wO.webp" alt="Flutter 2.2 can cancel a keystroke from bubbling up the widget hierarchy, for example allowing TAB to change focus from a TextField" caption="Flutter 2.2 can cancel a keystroke from bubbling up the widget hierarchy, for example allowing TAB to change focus from a TextField" />

Custom text actions allow you to do things like special handling of the Enter key in a TextField; for example, you can trigger sending a message in a chat client while still allowing a newline to be inserted via Ctrl+Enter. These same text actions [allow Flutter itself to provide different keystrokes](https://github.com/flutter/flutter/pull/75032) to match the behavior of text editing to the host OS itself, for example, Ctrl+C on Windows and Linux, but Cmd+C on macOS.

As an example of this, the following sample overrides the default left arrow action and provides a new action for the backspace and delete keys:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter TextField Key Binding Demo',
    home: Scaffold(body: UnforgivingTextField()),
  );
}

/// A text field that clears itself if the user tries to back up or correct
/// something.
class UnforgivingTextField extends StatefulWidget {
  @override
  State<UnforgivingTextField> createState() => _UnforgivingTextFieldState();
}

class _UnforgivingTextFieldState extends State<UnforgivingTextField> {
  // The text editing controller used to clear the text field.
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Shortcuts(
       shortcuts: <LogicalKeySet, Intent>{
         // This overrides the left arrow key binding that the text field normally
         // has in order to move the cursor back by a character. The default is
         // created by the MaterialApp, which has a DefaultTextEditingShortcuts
         // widget in it.
         LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ClearIntent(),

         // This binds the delete and backspace keys to also clear the text field.
         // You can bind any key, not just those already bound in
         // DefaultTextEditingShortcuts.
         LogicalKeySet(LogicalKeyboardKey.delete): const ClearIntent(),
         LogicalKeySet(LogicalKeyboardKey.backspace): const ClearIntent(),
       },
       child: Actions(
         actions: <Type, Action<Intent>>{
           // This binds the intent that indicates clearing a text field to the
           // action that does the clearing.
           ClearIntent: ClearAction(controller: controller),
         },
         child: Center(child: TextField(controller: controller)),
       ),
     );
}

/// An intent that is bound to ClearAction.
class ClearIntent extends Intent {
  const ClearIntent();
}

/// An action that is bound to ClearIntent that clears the TextEditingController
/// passed to it.
class ClearAction extends Action<ClearIntent> {
  ClearAction({required this.controller});

  final TextEditingController controller;

  @override
  Object? invoke(covariant ClearIntent intent) {
    controller.clear();
  }
}
```

<DashImage figure src="images/0RFbQWBEWCoP4PF1j.webp" alt="Unforgiving TextField example where pressing left arrow or ESC clears the text" caption="Unforgiving TextField example where pressing left arrow or ESC clears the text" />

We’ve still got more work to do, but we’re working to give you complete text editing actions. Our goal is that, by the time Flutter desktop gets to stable, your users won’t be able to tell the difference between editing text in their Flutter apps vs any other app on the host OS.

### Automatic scrolling behavior

As part of our continuing quest to make Flutter apps behave like the best apps on each platform, we took another look at scrollbars in this release. When it comes to actually showing a scrollbar, both Android and iOS are the same; they don’t show one by default. On the other hand, for a desktop app a scrollbar is usually shown automatically when the content is larger than the container, which requires you to add a `Scrollbar` parent widget. To get the correct behavior on mobile or desktop, this release automatically adds a `Scrollbar` when necessary.

Consider the following Scrollbar-less code:

```dart
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Automatic Scrollbars',
    home: HomePage(),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) => Text('Item $index'),
    ),
  );
}

```

When running it on the desktop, a scrollbar appears:

<DashImage figure src="images/0ymJePefMMrQBezVi.webp" />

If you don’t like the way the scrollbar looks or that it’s always shown, you can set a [`ScrollBarTheme`](https://api.flutter.dev/flutter/material/ThemeData/scrollbarTheme.html). If you don’t like this default behavior, you can change it app-wide or on a particular instance by setting a [`ScrollBehavior`](https://api.flutter.dev/flutter/widgets/ScrollBehavior-class.html). For more details about the new default scrollbar behavior and how to migrate your code to the new set of best practices, check out [the docs on flutter.dev](https://flutter.dev/docs/release/breaking-changes/default-desktop-scrollbars).

### Mouse cursors over text spans

In previous versions of Flutter, you could add a mouse cursor (like a hand indicating something clickable) over any widget. In fact, Flutter itself adds those mouse cursors for you in most cases, like adding a hand mouse cursor over all of the buttons. However, if you wanted a run of rich text with different text spans with their own styles and potentially long enough to wrap, you were out of luck — a `TextSpan` is not a `Widget` and therefore could not be used as a visual scope for a mouse cursor… until now! As of this release, when you have a `TextSpan` with a gesture recognizer, you will automatically get the corresponding mouse cursor:

```dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

void main() => runApp(App());

class App extends StatelessWidget {
  static const title = 'Flutter App';
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: title,
    home: HomePage(),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(App.title)),
    body: Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 48),
          children: [
            TextSpan(
              text: 'This is not a link, ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'but this is',
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                urlLauncher.launch('https://flutter.dev');
                },
            ),
          ],
        ),
      ),
    ),
  );
}

```

Now you can have all of the wrapping text spans you want and any of them with recognizers will get the appropriate mouse cursors.

<DashImage figure src="images/0u6tJI44Ucu9fDvAb.webp" />

In this release, `TextSpan` also supports `onEnter` and `onExit` along with the `mouseCursor`. Things like this may seem small but they go a long way towards making a Flutter app feel just like a user expects it to feel.

## Flutter 2.2 updates in preview

In addition to the new features available for production use, Flutter 2.2 comes with a number of features in preview, including iOS shader compiler performance improvements, Android deferred component support, Flutter desktop updates, and ARM64 Linux host support from Sony. Please give these a try and [let us know if you have any issues](https://github.com/flutter/flutter/issues).

### Preview: iOS shader compilation improvements

In graphics rendering terms, a “shader” is a program to be compiled and run on the GPU available on the end-user’s device. Flutter has used shaders in the underlying Skia graphics library since its inception to provide native performance in its own high quality graphics effects with colors, shadows, animation, and so on. Due to the flexibility of Flutter’s APIs, shaders are generated and compiled just-in-time, synchronous with the frame workloads that need them. When the time to compile shaders goes beyond the frame budget, the result is noticeable to users as “jank.”

To avoid jank, Flutter has provided the ability to cache shaders during a training run, which are then packaged and bundled with an app, and compiled before the first frame while the Flutter Engine is starting up. This means that the precompiled shaders don’t have to be compiled during a frame workload, and won’t cause jank. However, Skia initially only implemented this feature for OpenGL.

So, when we enabled the Metal backend by default on iOS in response to Apple deprecating OpenGL, there was an increase in worst frame times as measured by our benchmarks, and an increase in user reports of jank. Our own measurements indicated that these reports were often due to increased shader compilation times, an increase in the number of shaders that Skia generated for the Metal backend, and the failure of compiled shaders to be cached across runs such that jank persisted beyond the first run of an app.

Therefore, until now, the only way to avoid this jank on iOS was to simplify scenes and animations, which was not ideal.

However, right now on the dev channel is a preview of [the new support in Skia for shader warm-up for Metal](https://github.com/flutter/flutter/issues/79298). Through Skia, Flutter now compiles the bundled shaders before the first frame workload begins.

<DashImage figure src="images/00_8hDcyhjXasCJX3.webp" alt="Traces showing precompilation occurring during application launch" caption="Traces showing precompilation occurring during application launch" />

This solution comes with some caveats, however:

* Skia still generates more shaders for the Metal backend than for the OpenGL backend.

* The final shader compilation to machine code still happens synchronously with the frame workload, but that’s faster than doing the entire shader generation and compilation as part of the frame render time.

* The resulting machine code is cached after the first run of an app until the device is rebooted.

If you’d like to take advantage of this new support in your apps, you can [follow along with the instructions on flutter.dev](https://flutter.dev/docs/perf/rendering/shader#how-to-use-sksl-warmup).

We’re not done with this work, however. On both Android and iOS, this implementation has a few drawbacks:

* The size of the deployed app is larger because it contains the bundled shaders.

* App startup latency is longer because the bundled shaders need to be precompiled.

* We aren’t happy with the developer experience that this implementation implies.

We consider that last issue the most important one to fix. In particular, we view the process of performing training runs, and reasoning about the trade-offs imposed by app size and app startup latency to be too onerous. Therefore, we continue to investigate approaches to eliminate shader compilation jank, and all jank in general, that do not rely on this implementation. In particular, we’re working with the Skia team to reduce the number of shaders it generates in response to Flutter’s requests, as well as investigating how much Flutter might be implemented with a small set of statically defined shaders bundled with the Flutter Engine.

You can follow along with [this project in the Flutter repo](https://github.com/flutter/flutter/projects/188) to see our progress.

### Android deferred components

For Android, this release uses Dart’s split AOT compilation feature to [allow Flutter apps to download modules containing ahead-of-time compiled code and assets at runtime](https://github.com/flutter/flutter/pull/76192). We call each of these installable splits a *deferred component*. By deferring the download of code and assets to only when needed, initial install size can be significantly reduced. For example, we implemented a version of Flutter Gallery with all studies and demos deferred and saw a 46% decrease in initial install size.

<DashImage figure src="images/0uLg1AGohi6Xzud9H.webp" alt="Downloading the Crane study in the Flutter Gallery" caption="Downloading the Crane study in the Flutter Gallery" />

When building with deferred components enabled, Dart compiles code imported exclusively with the `deferred` keyword into separate shared libraries that are packed into deferred components together with assets.

Deferred components are currently available only on Android, and this feature is offered as an early preview. Learn how to implement deferred components in the new [Deferred components](https://flutter.dev/docs/perf/deferred-components) page on flutter.dev. This page also links to a page on the Flutter wiki that contains a deep dive on how this feature works. Please log issues on [the Flutter issue tracker](https://github.com/flutter/flutter/issues).

### Flutter Windows UWP alpha

Another update for Flutter in this release is for desktop lovers; support for Windows UWP has moved to alpha in the dev channel (beyond the stable 2.2 version). UWP allows you to take your Flutter apps to devices where standard Windows apps don’t run, including Xbox. To try it out, you first need to [set up the UWP prerequisites](https://flutter.dev/desktop#windows-uwp). Then, switch to the dev channel and enable UWP support:

```bash
$ flutter channel dev
$ flutter upgrade
$ flutter config --enable-windows-uwp-desktop
```

Once enabled, creating a Flutter app includes a new a `winuwp` folder, which allows you to build and run your app in a UWP container:

```bash
*$ flutter create uwp_fun
$ cd uwp_fun
$ flutter pub get
$ flutter run -d winuwp*
```

Because you’re building a Windows UWP app, which runs in a sandbox environment on Windows, you’ll need to punch a hole in the app’s firewall on localhost during development to enable things like hot reload and debugger breakpoints. You can do that with a `checknetisolation` command by following the instructions on [the Flutter desktop docs page](https://flutter.dev/desktop/#windows-uwp). Once you’ve done that, you can see your favorite Flutter app running as a UWP app on Windows.

<DashImage figure src="images/0d2HU5GSLz88DZ7pv.webp" alt="Your favorite Flutter app running in a Windows UWP container" caption="Your favorite Flutter app running in a Windows UWP container" />

Of course, you can run much more interesting UWP apps, like these Flutter apps running on an Xbox.

<YoutubeEmbed id="s_zIzr60vMA" title="Flutter UWP on XBOX" fullwidth="true"/>

Special shout out to [clarkezone](https://github.com/clarkezone) who’s been working on this support for about as long as I’ve been on the Flutter team. For more details about the Windows UWP alpha, check out [flutter.dev/desktop/#windows-uwp](https://flutter.dev/desktop/#windows-uwp).

### ARM64 Linux host support from Sony

Another excellent effort by a Flutter community member-at-large is from [HidenoriMatsubayashi](https://github.com/HidenoriMatsubayashi), a software engineer at Sony, who has contributed [support for targeting ARM64 Linux](https://github.com/flutter/flutter/pull/61221). This PR enables you to build and run Flutter apps on ARM64 Linux machines.

<DashImage figure src="images/0hZswrrQ3ANrj6spe.webp" alt="Your favorite Flutter app running on an ARM64 Linux machine" caption="Your favorite Flutter app running on an ARM64 Linux machine" />

It’s exciting to see the Flutter community bringing Flutter to places that the team at Google could never have imagined. Keep up the good work, HidenoriMatsubayashi!

## Flutter ecosystem and tooling updates

The Flutter engine and framework are just a part of the overall experience. Updates to the packages ecosystem and tooling are equally important to the Flutter developer experience. And we’ve got some great updates in those areas to share.

On the ecosystem side, we have a number of new Flutter Favorite packages to announce as well as several updates to FlutterFire, Flutter’s support for Firebase. Even better, FlutterFire has support for the new Firebase App Check preview so Flutter developers can take advantage of it on day one.

On the tooling side, there are new updates to Flutter DevTools for optimizing your app’s memory footprint and a new tab for the provider package. There are notable updates to the IDE plugins for both VS Code and Android Studio/IntelliJ and, if you’re a content author targeting Flutter, there’s a whole new way to integrate DartPad into your writing.

Last but not least, there’s a new low-code app design and building tool called FlutterFlow that targets Flutter and runs on the web, since it was itself built with Flutter.

### Flutter Favorite updates

As part of this release, the Flutter Ecosystem Committee has been working hard to certify 24 new Flutter Favorite packages, our largest expansion yet. The newly tagged Flutter Favorites include:

* **[FlutterFire packages](https://firebase.flutter.dev) in production:** `cloud_firestore`, `cloud_functions`, `firebase_auth`, `firebase_core`, `firebase_crashlytics`, `firebase_messaging,` and `firebase_storage`

* **[Flutter Community “plus” packages](https://plus.fluttercommunity.dev):** `android_alarm_manager_plus`, `android_intent_plus`, `battery_plus`, `connectivity_plus`, `device_info_plus`, `network_info_plus`, `package_info_plus`, `sensors_plus,` and `share_plus`

* **[`googleapis`](https://pub.dev/packages/googleapis) package**

* **[`win32`](https://pub.dev/packages/win32) package**

* **[`intl`](https://pub.dev/packages/intl) and [`characters`](https://pub.dev/packages/characters) packages**

* **[Sentry](https://pub.dev/packages/sentry_flutter) packages:** `sentry` and `sentry_flutter`

* **[`infinite_scroll_pagination`](https://pub.dev/packages/infinite_scroll_pagination) and [`flutter_native_splash`](https://pub.dev/packages/flutter_native_splash) packages**

All of these packages have been migrated to null safety and support Android, iOS, and web as appropriate. For example, `firebase_crashlytics` has no underlying SDK on the web, and `android_alarm_manager_plus` is specifically designed for Android.

The [Flutter Community](https://github.com/fluttercommunity) “plus” packages provide a superset of the corresponding packages from the Flutter team. For example, [the battery package](https://pub.dev/packages/battery) has been provided by the Flutter team at Google since before the initial Flutter release and has been migrated to null safety, but is only supported on Android and iOS. The [Flutter Community `battery_plus` package](https://pub.dev/packages/battery_plus), on the other hand, supports all six Flutter platforms, including web, Windows, macOS, and Linux. The award of the Flutter Favorite awards for all 9 of the “plus” packages represents a big step forward in maturity for the Flutter community as a whole. Flutter is much, much larger than just what the team of engineers at Google are doing. You should migrate your code to the “plus” packages soon and, in the coming weeks, the corresponding packages from Google will be updated to recommend that you do so.

The `googleapis` plugin provides auto-generated Dart wrappers around 185 Google APIs for use in your client or server-side Dart applications (including your Flutter apps). If you want to learn more about this package, the author has an [I/O talk on powering up your Flutter apps using Google APIs](https://events.google.com/io/session/7f706716-0de0-4a9e-bad3-581afe8ef360).

The win32 package is a marvel of engineering, wrapping most of the commonly used Win32 API calls using [Dart FFI](https://dart.dev/guides/libraries/c-interop) to make them accessible to Dart code without requiring a C compiler or the Windows SDK. As Flutter gains popularity on the Windows platform, the `win32` package has become a key dependency for many popular plugins, including [`path_provider`](https://pub.dev/packages/path_provider), one of the most popular. And as a test of completeness, the author [timsneath](https://github.com/timsneath) has done crazy things like implementing [notepad](https://github.com/timsneath/win32/tree/main/example/notepad), [snake](https://github.com/timsneath/win32/blob/main/example/snake.dart) and [tetris](https://github.com/timsneath/win32/tree/main/example/tetris), all in raw Win32 using raw Dart.

<DashImage figure src="images/0rMkCGirgD14ME-Na.webp" alt="Tetris running on Windows built using Dart FFI and Win32 calls only" caption="Tetris running on Windows built using Dart FFI and Win32 calls only" />

The `win32` package is definitely worth checking out if you do anything with Dart or Flutter on Windows.

### FlutterFire updates and Firebase App Check

FlutterFire, Flutter’s support for Firebase, is one of the most popular collections of plugins to use with Flutter. Invertase has done a tremendous job getting it to production for the Flutter 2 release and continuing to improve it since then. In fact, since that initial production release of FlutterFire, Invertase has reduced the number of open issues by 79% and reduced the number of outstanding PRs by 88%. Furthermore, not only have they done an excellent job with the production quality plugins, they’ve also migrated the beta quality plugins to null safety and kept them building and running on the same core so that you can mix and match.

In addition, Invertase continues to add new features to the FlutterFire plugins, including a number of updates to Flutter’s integration with Cloud Firebase with this release of Flutter:

* [`Typesafe` API](https://firebase.flutter.dev/docs/firestore/usage/#typing-collectionreference-and-documentreference) for reading and writing data

* Support for the [Firebase Local Emulator Suite](https://firebase.flutter.dev/docs/storage/usage/#emulator-usage)

* Optimizing your data queries with [data bundles](https://firebase.flutter.dev/docs/firestore/usage#data-bundles)

And last, but not least, FlutterFire provides support for the beta release of a new Firebase product: [Firebase App Check](https://firebase.google.com/docs/app-check). Firebase App Check protects your backend resources like Cloud Storage from abuse like billing fraud or phishing. With App Check, devices running your Flutter app use an app identity attestation provider to certify that it is indeed your authentic app, and may also check that it’s running on an authentic, untampered device. This certification is attached to every request your app makes to your Firebase backend resources once you activate App Check. To learn more, see the [FlutterFire App Check documentation](https://firebase.flutter.dev/docs/app-check/overview).

### Flutter DevTools updates

Flutter DevTools comes with a number of notable updates with this release, including two memory tracking improvements and a whole new tab just for the `provider` plugin.

The first memory tracking improvement in this release of DevTools provides the ability to track down where an object was allocated. This is handy to find the location in your code of a memory leak.

<DashImage figure src="images/0mMd1Bs_OZWT7UB0l.webp" alt="Flutter DevTools memory tab allocation stack trace" caption="Flutter DevTools memory tab allocation stack trace" />

The second is the ability to inject custom messages into the memory timeline. This allows you to provide markers specific to your app, like before and after you’ve done some memory intensive work so that you can check that you’re cleaning things up properly.

<DashImage figure src="images/0FcPA9ntTT4JPVo5U.webp" alt="Flutter DevTools timeline tab custom memory events" caption="Flutter DevTools timeline tab custom memory events" />

As Flutter apps in the wild get larger and larger, we will continue to ensure that Flutter developers have the tools they need to track down and fix memory leaks and runtime issues of all kinds.

It isn’t just runtime issues in your use of the Flutter framework you want to track down; sometimes you want to track down issues related to packages as well. With over 15,000 Flutter-compatible packages and plugins on pub.dev, this becomes increasingly likely as your apps use more packages over time. So, with that in mind, we’ve been experimenting with adding a new **Provider** tab to Flutter DevTools. In fact, this tab was built by [Remi Roussel](https://github.com/rrousselGit), the author of [the `provider` package](https://pub.dev/packages/provider) itself (among many other wonderful things). If you’re running the latest version of Flutter DevTools and you are debugging a Flutter app that uses the `provider` plugin, you’ll automatically get the new **Provider** tab.

<DashImage figure src="images/0UgjcNnlHqFgKCH-t.webp" alt="Flutter DevTools Provider tab in action" caption="Flutter DevTools Provider tab in action" />

The Provider tab shows you the data associated with each of your providers, including real-time changes as you run your app. And as if that weren’t amazing enough, it allows you to change the data directly as a way to test the corner cases of your app!

Working with Remi on this tab has taught us a few things about how to better support other package authors who would like to do the same thing; you can [read about how Remi built the Provider tab](https://invertase.io/blog/how-to-flutter-devtool-plugin) and our current thinking about how to enable more tabs in the [Flutter DevTools Plugins](https://docs.google.com/document/d/1BWX8YQ962Vsx-EUDuDHRG7RX94fJlZSDRu299YRwasE/) proposal. Please give us your feedback and feel free to reach out to tell us about your plans for a new tab in Flutter DevTools.

This is only a few of the cool new things in Flutter DevTools in this release. For the complete list, check out the individual announcements here:

* [Flutter DevTools 2.1 Release Notes](https://groups.google.com/g/flutter-announce/c/tCreMfJaJFU/m/38p1BBeiCAAJ)

* [Flutter DevTools 2.2.1 Release Notes](https://groups.google.com/g/flutter-announce/c/t8opLnUyiFQ/m/dJth-jKxAAAJ)

* [Flutter DevTools 2.2.3 Release Notes](https://groups.google.com/g/flutter-announce/c/t8opLnUyiFQ/m/YX5Ds_q0AgAJ)

### IDE plugins updates

Both the Visual Studio Code and the IntelliJ/Android Studio IDE extensions for Flutter were updated in this release as well. For example, the Visual Studio Code extension now supports two additional Dart code refactors: Inline Method and Inline Local Variable.

<DashImage figure src="images/0C2RP0oCtMM9fvpgp.webp" alt="The new Dart refactor Inline Method in action" caption="The new Dart refactor Inline Method in action" />

In the Android Studio/IntelliJ extension, we’ve added the ability to print all stack traces to the console with an option.

<DashImage figure src="images/00pqAAk_u0mKtRZx9.webp" alt="You can now get all of the stack traces and not just the first one" caption="You can now get all of the stack traces and not just the first one" />

This is helpful in projects where the root cause might be in a different package, which previously wasn’t being printed. We already have ideas on how to make this less obviously verbose, so look for more changes in the future.

For the full list of changes to the IDE extensions for this release, check out these announcements:

* [VS Code extension v3.21](https://groups.google.com/g/flutter-announce/c/gNtKp9c1glU/m/SZYTuwcQBwAJ)

* [VS Code extension v3.22](https://groups.google.com/g/flutter-announce/c/1XR7baYZOVI/m/y6MGYrGhAAAJ)

* [Flutter IntelliJ Plugin M55 Release](https://groups.google.com/g/flutter-announce/c/tYwFDPAtLu0/m/FrsntcNNBwAJ)

* [Flutter IntelliJ Plugin M56 Release](https://groups.google.com/g/flutter-announce/c/EkgiAO4p3UM/m/P32ZXXKfAAAJ)

### DartPad workshops

To ensure that we have documentation ready across a rapidly growing Flutter developer community, the Dart and Flutter teams are always looking at ways to improve and expand the ways to create educational content. With this release, we’re adding a new, step-by-step UI for DartPad that devs can use to follow along with instructor-led workshops.

<DashImage figure src="images/058dlCP5YlIl5BdvR.webp" alt="A DartPad workshop in action" caption="A DartPad workshop in action" />

By adding instructions directly to DartPad, we’re enabling [a guided workshop experience for I/O](https://events.google.com/io/program/content?4=topic_flutter&5=type_workshop). However, we didn’t just build it for our own workshops; if you’d like to use it in your Dart or Flutter workshops, you can do so by following [the DartPad Workshop Authoring Guide](https://github.com/dart-lang/dart-pad/wiki/Workshop-Authoring-Guide). This is in addition to being able to [share code using DartPad in a Gist](https://github.com/dart-lang/dart-pad/wiki/Sharing-Guide) and [embedding DartPad in your own site](https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide), which have been available for awhile now.

We want everyone producing Dart and Flutter content to be able to provide rich, interactive experiences for their users. Please give this new feature a try and [let us know what you think](https://github.com/dart-lang/dart-pad/issues)!

### Community Spotlight: FlutterFlow

FlutterFlow is a “low code” app design and development tool for building apps all within your browser. It provides a WYSIWYG environment for laying out your app across multiple pages using real data from Firebase. The goal of a low code tool is to do most of the common things easily, allowing you to write as few lines of custom code as possible. In fact, as a demo, they built an entire multi-page mobile app for browsing the Metropolitan Museum of Art with zero code in less than an hour. You can see the entire process on YouTube.

<YoutubeEmbed id="TXsjnd_4SBo" title="Building FlutterMet" fullwidth="true"/>

FlutterFlow outputs Flutter code, so if you need to add code to further customize your app, you can. You can read about [the FlutterFlow product launch on flutterflow.io](https://flutterflow.io/blog/launch).

## Breaking Changes

As always, we strive to reduce the number of breaking changes and in this release we’ve been able to limit it to removing these deprecations:

* [73750](https://github.com/flutter/flutter/pull/73750) Remove deprecated BinaryMessages

* [73751](https://github.com/flutter/flutter/pull/73751) Remove deprecated TypeMatcher class

You can [find mitigations for these breaking changes on flutter.dev](https://flutter.dev/docs/release/breaking-changes/1-22-deprecations).

## Summary

As always, from all of us here on the Flutter Team at Google, we want to say — thank you. Thank you for being part of the community that makes all of this possible. With more than one in eight of new apps in the Play Store being built with Flutter and over 200,000 Flutter apps in the Play Store alone, our continued growth is mind blowing. Apps of all sizes around the world are entrusting their UI to Flutter to craft beautiful multi platform experiences to meet users wherever they may be.

<DashImage figure src="images/0rn6BZioI2VeCqSQY.webp" />

Finally, in case you missed it, before you leave I/O this year, don’t forget to check out the [I/O Photo Booth](https://photobooth.flutter.dev/#/) web app built in Flutter & Firebase to grab a selfie with Dash. We [open sourced the code](https://github.com/flutter/photobooth) so you can dig into best practices for Flutter web, camera plugin web support, and learn how we used cloud functions to generate custom social posts.
