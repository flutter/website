---
title: "What’s New in Flutter 2.8"
description: >-
  Performance improvements, new Firebase features, desktop status,
  tooling updates, and more!
publishDate: 2021-12-09
author: csells
image: images/00frogkEKgpNOgCVF.webp
category: release
layout: blog
---

It’s that time of year in the northern hemisphere: the leaves are turning, the temperature is cooling and the final stable release of the year is here. Hello and welcome to Flutter 2.8! This release represents the hard work of 207 contributors and 178 reviewers, producing 2,424 PRs merged and 2976 issues closed. Special thanks to the top community contributor of this release, Bartosz Selwesiuk, a Flutter Engineer at Very Good Ventures, who provided 23 PRs, most of which were primarily “focused” (sic) around the camera plugin for web.

All of this collective work produced significant performance improvements in both the engine and in Flutter DevTools, a stable release of the Google Mobile Ads SDK for Flutter, a slew of new Firebase features and improvements, WebView 3.0, a new batch of Flutter Favorite packages, a raft of updates to desktop on our way to a stable release, and a new version of DartPad with support for more packages, including Firebase itself. This might be the last release of the year but it’s by no means the least. Let’s get to it!

## Performance

As always, job #1 with Flutter is quality. We spend much of our time ensuring that Flutter runs as smoothly and as robustly as it can across the range of supported devices.

### Startup

This release includes improvements to application startup latency. Testing these improvements against Google Pay, a large, popular app with more than 1 million lines of code to ensure that these changes result in perceivable impact in the real-world. All together these improvements have resulted in reduction in startup latency for Google Pay of 50% when running on a low-end Android device, and a 10% improvement on high-end devices.

Improvements to the way that Flutter influences Dart VM garbage collection policy now helps avoid ill-timed GC cycles during the application startup sequence. For example, before the first frame is rendered on Android, Flutter now [only notifies the Dart VM of memory pressure for `TRIM_LEVEL_RUNNING_CRITICAL` and above](https://github.com/flutter/flutter/issues/90551) signals. In local testing, this change reduced the time to first frame by up to 300ms on a low-end device.

Due to an [abundance of caution](https://github.com/flutter/engine/pull/29145#pullrequestreview-778935616), in previous releases, Flutter blocked the platform thread while creating platform views. [Careful reasoning and testing](https://github.com/flutter/flutter/issues/91711) determined that some of the serialization could be removed, which removed >100ms of blockage during startup of Google Pay on a low-end device.

Previously, setting up the default font manager introduced an artificial delay when setting up the first Dart isolate. [Delaying the default font manager setup](https://github.com/flutter/engine/pull/29291) to run concurrently with Dart `Isolate` setup both improved startup latency, and made the effects of the above optimizations much more visible, as this was the primary bottleneck.

### Memory

Flutter developers targeting memory constrained devices [were having problems](https://github.com/flutter/flutter/issues/91382) taking performance traces due to Flutter eagerly loading the Dart VM’s “service isolate”, whose AOT code was bundled with the app such that Flutter was reading both into memory simultaneously. For Android in the 2.8 release, the Dart VM’s service isolate [was split into its own bundle](https://github.com/flutter/engine/pull/29245) that can be loaded separately, which results in a memory savings of up to 40 MB until the service isolate is needed. The memory footprint has been further reduced by up to 10% by the [Dart VM informing the OS](https://github.com/flutter/flutter/issues/92120) that the pages in memory used by the AOT program are backed by a file that likely won’t need to be read again. Therefore, the pages that had been holding a copy of the file-backed data can then be reclaimed and put to other uses.

### Profiling

Sometimes developers want to view performance trace data from Flutter alongside Android native tracing events. Furthermore, they’d often like to see trace events even in release mode builds to get a better understanding of performance issues in their deployed applications. To that end, [the 2.8 stable release](https://github.com/flutter/engine/pull/28903) now sends tracing events to the Android systrace recorder if it is enabled at application startup, and these events are sent even when the Flutter application is built in release mode.

<DashImage figure src="images/1eAFKwrcfLHlqKk6ng677pw.webp" alt="Flutter tracing events are now shown (bottom) in the Android systrace recording tooling" caption="Flutter tracing events are now shown (bottom) in the Android systrace recording tooling" />

Additionally, to help create animations with less jank, some of you wanted [more information](https://github.com/flutter/flutter/issues/92286) in performance traces about the behavior of the raster cache, which allows Flutter to blit expensive, reused pictures instead of re-drawing them on each frame. [New flow events](https://github.com/flutter/flutter/issues/92286) in performance traces now allow you to track the lifetimes of raster cached pictures.

### Flutter DevTools

For debugging performance issues, this release of DevTools adds a [new “Enhance Tracing” feature](https://github.com/flutter/devtools/pull/3451) to help you diagnose UI jank stemming from expensive build, layout, and paint operations.

<DashImage figure src="images/0QXiOV7Bm7wlP9gI-.webp" />

When any of these tracing features are enabled, the Timeline includes new events for widgets built, render objects laid out, and render objects painted, as appropriate.

<DashImage figure src="images/0ltUPM1ji3asrgDOw.webp" />

In addition, this release of DevTools adds new [support for profiling the performance of your app’s startup](https://github.com/flutter/devtools/pull/3357). This profile contains CPU samples from the initialization of the Dart VM up until the first Flutter frame has been rendered. After you press the “Profile app start up” button and the app startup profile has been loaded, you will see that the “AppStartUp” user tag is selected for the profile. You can also load the app startup profile by selecting this user tag filter, when present, in the list of available user tags. Selecting this tag shows your profile data for your app’s startup.

<DashImage figure src="images/0xpb0al6JT1AdKUjO.webp" />

### Web platform views

Android and iOS aren’t the only platforms getting performance improvements. This release also improves the performance of platform views for Flutter web. If you’re unfamiliar with platform views, they’re the way that Flutter allows you to host native UI components from the underlying platform in your app. Flutter web implements this with the [`HtmlElementView`](https://api.flutter.dev/flutter/widgets/HtmlElementView-class.html) widget, which allows you to host HTML elements inside your Flutter web app. If you’re using the web versions of the google_maps_flutter plugin or the video_player plugin, or you’re following the Flutter team’s advice about how to optimize the [display images on the web](https://docs.flutter.dev/development/platform-integration/web-images#use-img-in-a-platform-view), then you’re using platform views.

In previous versions of Flutter, embedding a platform view immediately created a new canvas and each extra platform view added another canvas. The extra canvases are expensive to create, as each is the size of the entire window. This release [reuses canvases created for earlier platform views](https://github.com/flutter/engine/pull/28087) so, rather than incurring the cost 60x per second, you incur the cost once in the entire lifetime of the app. This means that you can have multiple `HtmlElementView` instances in your web apps without degrading performance, while also reducing scrolling jank when platform views are used.

## Ecosystem

Flutter isn’t just the framework, the engine, and the tools — there are more than 20,000 Flutter-compatible packages and plugins on pub.dev with more added every day. A significant amount of what Flutter developers interact with day-to-day is part of the larger ecosystem, so let’s take a look at what’s been going on in the Flutter ecosystem since the previous release.

### GA of Flutter Ads

First and foremost is the [release of the Google Mobile SDK for Flutter into general availability](https://medium.com/flutter/announcing-general-availability-for-the-google-mobile-ads-sdk-for-flutter-574e51ea6783) in November.

<DashImage figure src="images/0hRLh9gi5n3E82lXG.webp" />

This release supports 5 ad formats, integrates both AdMob and Ad Manager support and includes a beta of a new mediation feature to help you optimize ad performance. For more information about integrating Google Ads into your Flutter app as well as other monetization options, [check out the new monetization page on flutter.dev](https://flutter.dev/monetization).

### WebView 3.0

Another new release that comes with Flutter this time around is the 3.0 release of [the webview_flutter plugin](https://pub.dev/packages/webview_flutter). We’ve bumped the version number because of the number of new features but also because of a potentially breaking change in the way web views work on Android. In previous versions of `webview_flutter`, the hybrid composition mode has been available but not the default. Hybrid composition fixes a number of issues that the previous default virtual displays mode has. Based on user feedback and issue tracking, we think it’s time for hybrid composition to become the default. In addition, `webview_flutter` also adds a number of highly requested features:

* Support for POST as well as GET for populating content ([4450](https://github.com/flutter/plugins/pull/4450), [4479](https://github.com/flutter/plugins/pull/4479), [4480](https://github.com/flutter/plugins/pull/4480), [4573](https://github.com/flutter/plugins/pull/4573))

* Loading HTML from files and strings ([4446](https://github.com/flutter/plugins/pull/4446), [4486](https://github.com/flutter/plugins/pull/4486), [4544](https://github.com/flutter/plugins/pull/4544), [4558](https://github.com/flutter/plugins/pull/4558))

* Transparent background support ([3431](https://github.com/flutter/plugins/pull/3431), [4569](https://github.com/flutter/plugins/pull/4569), [4570](https://github.com/flutter/plugins/pull/4570))

* Writing cookies prior to loading content ([4555](https://github.com/flutter/plugins/pull/4555), [4556](https://github.com/flutter/plugins/pull/4556), [4557](https://github.com/flutter/plugins/pull/4557))

Furthermore, in the 3.0 release, `webview_flutter` provides preliminary support for a new platform: the web. We’ve had many of you ask for the ability to host a webview in a Flutter web app, which allows you to build an app for mobile *or* web from a single code base. What does hosting a webview look like in a Flutter web app? Well, from a coding perspective, it looks just the same:

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

void main() {
  runApp(const MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // required while web support is in preview
    if (kIsWeb) WebView.platform = WebWebViewPlatform();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Flutter WebView example')),
        body: const WebView(initialUrl: 'https://flutter.dev'),
      );
}
```

When running on the web, it works as you’d expect:

<DashImage figure src="images/04T03yBAog-6unwc8.webp" />

Note that the current implementation of `webview_flutter` for web has a number of limitations based around the fact that it’s built using an `iframe`, which only supports simple URL loading and has no ability to control or interact with the loaded content (for more info, check out [the webview_flutter_web README](https://pub.dev/packages/webview_flutter_web)). However, we’re making `webview_flutter_web` available due to popular demand as [an unendorsed plugin](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#endorsed-federated-plugin). If you want to give it a try, add the following line to your pubspec.yaml:

```yaml
dependencies:
  webview_flutter: ^3.0.0
  webview_flutter_web: ^0.1.0 # add unendorsed plugin explicitly
```

If you have feedback on webview_flutter v3.0, either on the web or off, please [log them on the Flutter repo as a webview issue](https://github.com/flutter/flutter/issues). Also, if you haven’t used webview before or you’d like a refresher, check out [the new webview codelab](https://codelabs.developers.google.com/codelabs/flutter-webview), which takes you step-by-step through the process of hosting web content in your Flutter app.

### Flutter Favorites

The [Flutter Ecosystem Committee](https://docs.flutter.dev/development/packages-and-plugins/favorites#flutter-ecosystem--committee) has met again to designate the following as Flutter Favorite packages:

* Three custom router packages for the new Router API: [`beamer`](https://pub.dev/packages/beamer), [`routemaster`](https://pub.dev/packages/routemaster), and [`go_router`](https://pub.dev/packages/go_router)

* [`drift`](https://pub.dev/packages/drift), a rename of an already capable and popular reactive persistence library for Flutter and Dart, built on top of [`sqlite`](https://pub.dev/packages/sqlite3)

* [`freezed`](https://pub.dev/packages/freezed), a Dart “language patch” to provide a simple syntax for defining models, cloning objects, pattern matching, and more

* [`dart_code_metrics`](https://pub.dev/packages/dart_code_metrics)

* And several great looking GUI packages: [`flex_color_scheme`](https://pub.dev/packages/flex_color_scheme), [`flutter_svg`](https://pub.dev/packages/flutter_svg), [`feedback`](https://pub.dev/packages/feedback), [`toggle_switch`](https://pub.dev/packages/toggle_switch), and [`auto_size_text`](https://pub.dev/packages/auto_size_text)

<DashImage figure src="images/0raIVwhHpVh0ON5ha.webp" alt="The Flexfold app is built with flex_color_scheme" caption="The Flexfold app is built with flex_color_scheme" />

Congratulations to those package authors and thank you for supporting the Flutter community with your hard work. If you’re interested in nominating your favorite Flutter package for a Flutter Favorite award, follow the guidelines and instructions on [the Flutter Favorite program page](https://docs.flutter.dev/development/packages-and-plugins/favorites).

### Platform-specific Packages

If you are a package author, one decision you must make is which platforms you’re going to support. If you’re building a plugin with platform-specific native code, you can do that [using the `pluginClass` property in your project’s `pubspec.yaml`](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#plugin-platforms), which indicates the native class that’s providing the functionality:

```yaml
flutter:
  plugin:
    platforms:
      android:
        package: com.example.hello
        pluginClass: HelloPlugin
      ios:
        pluginClass: HelloPlugin
```

However, as [Dart FFI](https://dart.dev/guides/libraries/c-interop) becomes more mature, it’s possible to implement platform-specific functionality in 100% Dart, like the [`path_provider_windows` package](https://pub.dev/packages/path_provider_windows) does. When you don’t have any native class to use but you still want to designate your package as supporting only certain platforms, use the `dartPluginClass` property instead:

```yaml
flutter:
  plugin:
    implements: hello
    platforms:
      windows:
        dartPluginClass: HelloPluginWindows
```

This setting in place, you have designates your package as only supporting certain platforms even if you don’t have any native code. You also must provide the Dart plugin class; learn more in [the Dart-only platform implementations docs on flutter.dev](https://docs.flutter.dev/development/packages-and-plugins/developing-packages#dart-only-platform-implementations).

### Firebase

Another big part of the Flutter ecosystem is FlutterFire, which is used by two-thirds of Flutter apps. This release adds a set of new features that make it easier to build applications using Flutter and Firebase:

* All FlutterFire plugins are graduating from beta to stable

* New support in DartPad for several Firebase services

* New libraries to more easily build UI for authentication and live Firestore queries

* New Firestore Object/Document Mapping for Flutter, available in Alpha

#### Production Quality

[The FlutterFire plugins](https://firebase.flutter.dev) have (almost) all moved from beta to stable quality.

<DashImage figure src="images/00BHU6qlHwKUxPrXb.webp" />

Plugins moving to stable for Android, iOS, and web include [Analytics](https://firebase.flutter.dev/docs/analytics/overview), [Dynamic Links](https://firebase.flutter.dev/docs/dynamic-links/overview), [In-App Messaging](https://firebase.flutter.dev/docs/in-app-messaging/overview/), [Performance Monitoring](https://firebase.flutter.dev/docs/performance/overview), [Realtime Database](https://firebase.flutter.dev/docs/database/overview), [Remote Config](https://firebase.flutter.dev/docs/remote-config/overview) and, the new kid on the block, [Installations](https://firebase.flutter.dev/docs/installations/overview). The App Check plugin and macOS platform support are still in beta because of the phase of the Firebase libraries themselves, which are also in beta. If you’ve worried about whether to choose Realtime Database, Analytics, or Remote Config because the FlutterFire libraries weren’t ready for prime-time, worry no more. These are now fully supported plugins ready for production use.

#### Dart-only Firebase Initialization

As packages have moved to production quality, we’ve added the ability to [initialize Firebase on any supported platform from Dart](https://github.com/FirebaseExtended/flutterfire/pull/6549):

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // generated via `flutterfire` CLI

Future<void> main() async {
  // initialize firebase across all supported platforms
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}
```

This code initializes a Firebase app using the options appropriate for each supported platform as defined in the `firebase_options.dart` file, which contains per-platform data structures that look like this:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIzaSyCZFKryCEiKhD0JMPeq_weJguspf09h7Cg',
  appId: '1:111079797892:web:b9195888086158195ffed1',
  messagingSenderId: '111079797892',
  projectId: 'flutterfire-fun',
  authDomain: 'flutterfire-fun.firebaseapp.com',
  storageBucket: 'flutterfire-fun.appspot.com',
  measurementId: 'G-K029Y6KJDX',
);
```

To gather the data for each platform’s initialization option data structure, check out [the new `flutterfire` CLI tool](https://pub.dev/packages/flutterfire_cli).

<DashImage figure src="images/069rsgRC_hcraKOAK.webp" />

This tool digs into the data in your platform-specific sub-folders to find the unique bundle ID and then uses that to look up the Firebase-project specific details for your matching platform-specific apps, even creating a new Firebase project and/or new platform-specific apps if there aren’t any. What this means for you is no more downloading and adding a `json` file to your Android project, downloading and adding a `plist` file to your iOS and macOS projects, or [pasting code into your web project’s index.html](https://github.com/FirebaseExtended/flutterfire/pull/7359) — no matter which supported Firebase platform you’re targeting, this single snippet of Dart code initializes Firebase for your app. Note that this may not be the only initialization you have to do to get your FlutterFire app working; for example, you might want to integrate the creation of your Crashlytics symbols into your [Android build](https://firebase.google.com/docs/crashlytics/get-started?platform=android#add-plugin) or your [iOS build](https://firebase.google.com/docs/crashlytics/get-started?platform=ios#set-up-dsym-uploading), but it should get it up and running in minutes with any new Firebase project.

#### Use Firebase with DartPad

With this Dart-only initialization of FlutterFire, you can now use Firebase from within DartPad.

<DashImage figure src="images/0y2N78Oatw9te8kPh.webp" />

[This example](https://dartpad.dev/?id=d57c6c898dabb8c6fb41018588b8cf73) demonstrates [a little chat app](https://twitter.com/puf/status/1458516522133909506) using Flutter, Firebase, and DartPad, all of which you can use right now with no installation. Today DartPad’s Firebase support already includes the core APIs, Authentication, and Firestore. Expect more Firebase services to appear in DartPad over time.

The other thing that FlutterFire support in DartPad enables is the ability to use [an embedded instance of DartPad right in the docs](https://firebase.flutter.dev/docs/firestore/example/).

<DashImage figure src="images/0_l1bJAoLwWB5DBdq.webp" />

In this example, you’re seeing the docs for Cloud Firestore with the code for the [example application](https://github.com/FirebaseExtended/flutterfire/tree/master/packages/cloud_firestore/cloud_firestore/example) that you can run and edit directly in your browser without having to install a thing, create a test project, or even copy/paste the code. It’s all right there for your immediate use.

#### Firebase UI

When integrating Firebase into an app, most apps have some kind of authentication flow. This includes allowing users to log in with email and password, or with a social auth provider like the one that Google provides. Firebase Authentication also allows for creating new accounts on the fly, validating email addresses, resetting passwords, and might even involve 2-step verification with SMS, logging in with a phone number, or even merging multiple user accounts into a single account. Firebase Authentication supports all of this functionality, but as a Flutter developer, you’re responsible for implementing the UI for all of it. Until today.

Today, we’re pleased to announce that the [flutterfire_ui](https://pub.dev/packages/flutterfire_ui) package can create a basic authentication experience with a small amount of code. As an example, assume that you’ve got Email and Google authentication setup in your Firebase project:

<DashImage figure src="images/09zL2daapFy48CypY.webp" />

With this configuration, you can trigger an authentication experience as follows:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: AuthenticationGate(),
      );
}

class AuthenticationGate extends StatelessWidget {
  const AuthenticationGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is not signed in - show a sign-in screen
          if (!snapshot.hasData) {
            return SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(
                  clientId: 'xxxx-xxxx.apps.googleusercontent.com',
                ),
              ],
            );
          }

          return HomePage(); // show your app's home page after login
        },
      );
}
```

This initializes Firebase and, noticing that the user is not already logged in, shows the sign-in screen. The `SigninScreen` widget is configured with the Email and Google authentication providers. The code also listen to the user’s authentication state using the `firebase_auth` package, so once the user signs in you can display the rest of the application. With this code, you get a working login for all of the Firebase-supported platforms: Android, iOS, web, and macOS.

With a little more configuration, you can easily add an image and some custom text (details are available in [the docs](https://firebase.flutter.dev/docs/ui/overview)), which gives you a full-featured login experience:

<DashImage figure src="images/0u_epPOxdzkf_z2W1.webp" />

This screenshot shows the mobile version, but because the `flutterfire_ui` screens are responsive, here’s what you get on a desktop device:

<DashImage figure src="images/00frogkEKgpNOgCVF.webp" />

If the user has an email/password already, they can log in and be done. If they use Google auth, they’ll be shown the normal Google auth flow, whether they’re on mobile, web, or desktop. If they don’t have an account already, they can press the button on the login screen and get to the registration screen. Once they’ve logged in or registered, there are flows for validating their email address, resetting their password, logging out, and linking social authentication accounts. Logging in by email works on all platforms along with social auth support for Google, Facebook, and Twitter, with partial support for Apple (it doesn’t work on Android). Authentication support in `flutterfire_ui` supports a number of scenarios and navigation schemes, along with customization and localization options. [Check out the detailed docs and samples in the firebase.flutter.dev docs](https://firebase.flutter.dev/docs/ui/overview).

Furthermore, authentication is not the only Firebase UI-related feature that flutterfire_ui supports. For showing users a live, infinite scroll list of data from a Firebase query, this release includes the `FirestoreListView`, which you can drop into your app with a live query as follows:

```dart
class UserListView extends StatelessWidget {
  UserListView({Key? key}) : super(key: key);

  // live Firestore query
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Contacts')),
        body: FirestoreListView<Map>(
          query: usersCollection,
          pageSize: 15,
          primary: true,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, snapshot) {
            final user = snapshot.data();

            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Text((user['firstName'] ?? 'Unknown')[0]),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${user['firstName'] ?? 'unknown'} '
                          '${user['lastName'] ?? 'unknown'}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          user['number'] ?? 'unknown',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
              ],
            );
          },
        ),
      );
}
```

And this is what it looks like in action:

<DashImage figure src="images/0jpo2j3C5Yo7HwuKW.webp" />

Or, if you’d like to provide your users with the ability to create, read, update, and delete entries in a table, you’ve got the beginnings of that in `FirestoreDataTable`:

```dart
class FirestoreTableStory extends StatelessWidget {
  FirestoreTableStory({Key? key}) : super(key: key);

  // live Firestore query
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FirestoreDataTable(
      query: usersCollection,
      columnLabels: const {
        'firstName': Text('First name'),
        'lastName': Text('Last name'),
        'prefix': Text('Prefix'),
        'userName': Text('User name'),
        'email': Text('Email'),
        'number': Text('Phone number'),
        'streetName': Text('Street name'),
        'city': Text('City'),
        'zipCode': Text('Zip code'),
        'country': Text('Country'),
      },
    );
  }
}
```

Which works like this:

<DashImage figure src="images/05K_qZZ3Sb4n8tXiW.gif" />

For details about authentication, list views, and data tables, [check out the `flutterfire_ui` docs](https://firebase.flutter.dev/docs/ui/overview/). As this is a preview release, additional features are planned. If you have a question or a feature request, please [head over to the repo on GitHub to log issues or ask questions in the discussion section](https://github.com/FirebaseExtended/flutterfire/discussions/6978).

#### Firestore Object/Document Mapping

And last but not least, one new feature to the integration between Firebase and Flutter that you should be aware of: the alpha release of [the Firestore Object/Document Mapper](https://firebase.flutter.dev/docs/firestore-odm/overview/). The Firestore ODM is aimed at helping Flutter developers be more productive by simplifying use of Firestore through familiar type-safe, structured objects and methods. Using code generation, the Firestore ODM improves the syntax for interacting with documents and collections by allowing you to model your data in a type-safe way:

```dart
@JsonSerializable()
class Person {
  Person({required this.name, required this.age});

  final String name;
  final int age;
}

@Collection<Person>('/persons')
final personsRef = PersonCollectionReference();
```

With these types in place, you can now execute type-safe queries:

```dart
personsRef.whereName(isEqualTo: 'Bob');
personsRef.whereAge(isGreaterThan: 42);
```

The ODM also supports defining strongly typed sub-collections and provides built-in options for optimizing widget rebuilds with its `select` feature. You can read about all of this and more in [the Firestore ODM docs](https://firebase.flutter.dev/docs/firestore-odm/overview/). Since this is an alpha release, please provide feedback. To give feedback and ask questions, [join the Firestore ODM thread](https://github.com/FirebaseExtended/flutterfire/discussions/7475) of the FlutterFire discussion.

## Desktop

The Flutter 2.8 release includes another big step along the road to the stable release of Windows, macOS, and Linux. The quality bar is high, including internationalization and localization support like the recently landed [Chinese IME support](https://github.com/flutter/engine/pull/29620), [Korean IME support](https://github.com/flutter/engine/pull/24713), and [Kanji IME support](https://github.com/flutter/engine/pull/29761). Or, like the tight integration being built into [Windows accessibility support](https://github.com/flutter/flutter/issues/77838). It’s not enough for Flutter to run on desktop on the stable channel (which it already does [in beta behind a flag](https://docs.flutter.dev/desktop#beta-snapshot-in-stable-channel)), it has to run well for languages and cultures around the world and for people of varying kinds of abilities. It’s not quite where we want to be yet, but it’s getting there!

One example of the ongoing work to prepare desktop for a stable release is [the complete re-architecture of how Flutter handles keyboard events to allow for synchronous response](https://flutter.dev/go/handling-synchronous-keyboard-events). This enables a widget to handle a keystroke and cancel its propagation through the rest of the tree. [The initial work landed](https://github.com/flutter/flutter/issues/33521) in Flutter 2.5 and Flutter 2.8 adds fixes for issues and regressions as it approaches stable quality. This is in addition to the ongoing work to re-engineer [how we handle device-specific keyboard input](https://github.com/flutter/flutter/issues/44918) and [a refactor of the way that Flutter handles text editing](https://github.com/flutter/flutter/pull/86736), all of which are necessary for keyboard input-intensive desktop apps.

In addition, [we continue to expand Flutter’s support for visual density](https://github.com/flutter/flutter/pull/89353) and [expose alignment for dialogs](https://github.com/flutter/flutter/pull/88984), both to enable more desktop-friendly UI.

<DashImage figure src="images/0SBoQZBrfuLVhEkdW.webp" />

And finally, the Flutter team is not the only one working on Flutter desktop. As just one example, the desktop team at Canonical is working with Invertase on a Linux and Windows implementation of the most popular Firebase plugins for Flutter.

<DashImage figure src="images/0xt35ZmY8r4BlFvfx.webp" />

You can [read more about the preview release on the Invertase blog](https://invertase.io/blog/announcing-flutterfire-desktop).

## DartPad

A Flutter release is not complete without a look at the tooling improvements. This post focuses on the improvements in DartPad, the biggest of which is the support for a larger number of packages. In fact, 23 packages are available for import. In addition to several Firebase services, the list includes such popular packages as `bloc`, `characters`, `collection`, `google_fonts`, and `flutter_riverpod`. The DartPad team continues to add new packages, so if you’d like to see which packages are currently supported, click on the information icon in the lower right hand corner.

<DashImage figure src="images/0gE84QAGGECM-tFAH.webp" />

To learn the plan for adding new packages to DartPad over time, check out [this article on the Dart wiki](https://github.com/dart-lang/dart-pad/wiki/Adding-support-for-a-new-package).

There’s another new DartPad feature that’s pretty handy, too. Previously, DartPad always ran the latest stable version. With this release, you can select the latest beta channel releases as well as the previous stable release (called the “old channel”), by using the new **Channel** menu in the status bar.

<DashImage figure src="images/0ax1aVB0JnPAllO4a.webp" />

This can be very useful if, for example, you’re writing a blog post where the latest stable isn’t quite new enough…

## Removing the dev channel

A Flutter “channel” governs how quickly the underlying Flutter framework and engine changes on your development machine, with stable representing the least churn and master representing the most. Due to resource constraints, we recently stopped updating the `dev` channel. While we did get some questions about this, we found that fewer than 3% of Flutter developers use the `dev` channel. We have therefore decided to start the process to formally decommission the `dev` channel. While few developers use the dev channel, it takes Flutter engineers considerable time and effort to maintain it. If you spend all of your time on the stable channel (as more than 90% of Flutter developers do), you won’t miss it. By dropping it, you have one fewer decision to make, and the Flutter team can spend its time and energy on other things.

You can decide which channel you’d like using the `flutter channel` command. Here’s how the Flutter team thinks about each channel:

* The `stable` channel represents the highest-quality builds we have. They’re released quarterly (roughly), and are hotfixed for critical issues in between. This is the “slow” channel: safe, mature, long-term servicing.

* The `beta` channel provides a fast-moving alternative to stable for those who are comfortable with a faster cadence. Currently released monthly, stabilized prior to release. This is the “fast” channel. If we find that the `dev` channel was serving needs that the beta channel cannot currently serve, we may change how we think of the `beta` channel to address those needs as well (for example, accelerating the release cadence for `beta` or reducing the level of testing and hot fixing that we perform on `beta`).

* The `master` channel is our active development channel. We provide no support on this channel, but we run a comprehensive suite of unit tests against it. This is the right channel for contributors or advanced users who are comfortable with unstable builds. On this channel, we run fast and break things (and then fix them pretty fast, too).

As we decommission the `dev` channel in the coming months, consider the `beta` or `master` channels, depending on your tolerance for churn and your need for the latest and greatest.

## Breaking Changes

As always, we strive to reduce the number of breaking changes in each release. In this release, Flutter 2.8 is free of breaking changes aside from deprecated APIs that have expired and been removed according to [our breaking change policy](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes).

* [90292](https://github.com/flutter/flutter/pull/90292) Remove `autovalidate` deprecations

* [90293](https://github.com/flutter/flutter/pull/90293) Remove `FloatingHeaderSnapConfiguration.vsync` deprecation

* [90294](https://github.com/flutter/flutter/pull/90294) Remove [`AndroidViewController.id`](https://androidviewcontroller.id/) deprecation

* [90295](https://github.com/flutter/flutter/pull/90295) Remove `BottomNavigationBarItem.title` deprecation

* [90296](https://github.com/flutter/flutter/pull/90296) Remove deprecated text input formatting classes

If you’re still using these APIs and would like details on how to update your code, you can [read the migration guidance on flutter.dev](https://docs.flutter.dev/release/breaking-changes/2-5-deprecations). As always, many thanks to the community for [contributing tests](https://github.com/flutter/tests/blob/master/README.md) that help us identify these breaking changes.

## Summary

As we close out 2021 and look forward to 2022, the Flutter team would like to express our gratitude for the work and support of the entire Flutter community. While it’s true that we’re building Flutter for the growing number of developers in the world, it’s also literally true that we couldn’t build it without you. The Flutter community is like no other and we’re grateful for all that you do. Have a happy holiday season and we’ll see you in the new year!
