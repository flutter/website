---
title: "Updates on Flutter and Firebase"
description: >-
  Updated Firebase plugins for higher quality and a new site with
  Flutter-specific docs, snippets and videos
publishDate: 2020-08-19
author: csells
image: images/0v4wFYjvXB2iCem55.webp
category: announcement
layout: blog
---

### *Updated Firebase plugins for higher quality and a new site with Flutter-specific docs, snippets, and videos*

Flutter is more than just an engine, a set of widgets, and some tools; it also includes a large ecosystem of packages to add functionality to your apps beyond what comes out of the box. Some of the most popular packages are the set that supports Firebase (aka FlutterFire). As part of our continued focus on quality for all aspects of Flutter, [we recently announced](https://medium.com/flutter/flutter-package-ecosystem-update-d50645f2d7bc) that Invertase, a consulting firm with deep expertise in Dart, Flutter, and Firebase, would be taking over the bulk of the development and maintenance of the FlutterFire plugins. In just the short amount of time since that announcement, they’ve made a tremendous amount of progress, including a new set of Core, Authentication, and Firestore plugins that provide new functionality and align the APIs more closely with other Firebase SDKs. In addition, they’ve created a whole site of Flutter-specific documentation for each of the Firebase plugins that includes installation instructions and code snippets for common scenarios, as well as a migration guide to help you move your code to this new version. And finally, in addition to all of that great work, this release represents 300+ issues resolved and 80+ pull requests merged.

<DashImage figure src="images/0kZUvqusPkrzKt54k.webp" />

## Principles

Historically, the Firebase plugins for Flutter grew organically due to passionate team members contributing when they could. With the transfer of plugin engineering to Invertase, the Flutter team and Invertase together took the opportunity to reexamine the basics. This exercise led to a number of principles:

* **Features will be consistent with native Firebase SDKs**, like the ability to access the currently logged-in user synchronously instead of asynchronously.

* **Naming will be consistent with native Firebase SDKs**, like the use of *get()* instead of *getDocuments().*

* All plugins will **depend on firebase_core and consistently require initialization** using *Firebase.initializeApp().*

* All plugins will **depend on the same underlying native Firebase SDK version.**

* All plugins will be **updated to use [federation](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#federated-plugins)**, making it possible to support a wide range of platforms and not just mobile.

* All plugins will require **explicit adoption of the new *firebase_core*** version, so that running *flutter pub update* won’t break your code.

* **Old names will be deprecated** to ease adoption as plugins are updated to meet these principles.

* **Important issues will be fixed and a full set of tests** will be created for each set of plugins as they are updated.

The goal of these principles is to make for a better experience for new and existing Firebase users on Flutter. We’re also working hard to make sure that you’re able to adopt the changes to each set of 3-4 plugins as we release them instead of waiting for the whole set of 15 plugins to be updated.

## Migration

Migration to the new [Core](https://firebase.flutter.dev/docs/core/usage), [Authentication](https://firebase.flutter.dev/docs/auth/overview), and [Firestore](https://firebase.flutter.dev/docs/firestore/overview) plugins is largely a matter of updating the versions in your *pubspec.yaml* file, pulling down those versions with *flutter pub get*, and adding a call to [*Firebase.initializeApp()*](https://firebase.flutter.dev/docs/overview#initializing-flutterfire). Once you do that, you may also choose to deal with the set of names that have been deprecated, although the old methods and properties will continue to work for now.

Not all of the work associated with these principles has been completed yet (in fact, we’re just getting started), but if you do adopt the new Core, you can continue to use the rest of the plugins that haven’t had any major changes yet; even plugins, like Storage and Messaging, have been updated to depend on the new Core. This means that you’ll get a more consistent experience across the board now with more changes coming that will just make things better.

For the full list of changes for the new versions of Core, Authentication, and Firestore, as well as detailed instructions on how to bring your Firebase code forward, I recommend that you [read the Migration Guide](https://firebase.flutter.dev/docs/migration).

## Platform support

The work that Invertase is doing is currently focused on Android and iOS, with macOS thrown in since it shares 99% of the same code with iOS. You can see the support for the Firebase plugins at the new documentation site for FlutterFire: [https://firebase.flutter.dev/](https://firebase.flutter.dev/)

<DashImage figure src="images/0v4wFYjvXB2iCem55.webp" alt="Current status of the Firebase plugins for Flutter" caption="Current status of the Firebase plugins for Flutter" />

You’ll notice that while every Firebase plugin supports mobile, which includes Android and iOS, not all of them support macOS. We’ll bring that support along as we work our way through the list. You’ll also notice that several of the plugins already support Flutter on the web as well as mobile. The breadth of support will continue to grow as work continues.

## Documentation

In addition to providing a comprehensive migration guide and showing platform support for each plugin, we’ve also provided the first draft at a Flutter-centric set of documentation at [https://firebase.flutter.dev/docs](https://firebase.flutter.dev/docs).

<DashImage figure src="images/0UYxGBLGPhiFgOv2j.webp" />

No more reading the native Android or web Firebase docs and using that to guess the equivalent APIs to use in your Flutter apps! On this site, you’ll find docs for most of the Firebase plugins (many more than just Core, Authentication, and Firestore), Android, iOS, web-specific installation instructions, an overview of common scenarios with code snippets, and videos.

## What’s next?

Today we’ve announced the first round of updates for the Core, Authentication, and Firestore plugins. To make sure that we’re working on the highest impact plugins for Flutter developers, our next round will likely be Crashlytics, Functions, Messaging, and Storage. Once those are in shape, we’ll circle back and make sure that web support for those 7 plugins lives up to our principles as well. This is a first big step on a journey to ensure that Flutter developers have the full range of services that other Firebase SDKs have to offer. If we make any missteps along the way, [please let us know](https://github.com/firebaseextended/flutterfire/issues).
