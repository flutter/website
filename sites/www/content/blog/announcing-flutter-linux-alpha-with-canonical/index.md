---
title: "Announcing Flutter Linux Alpha with Canonical"
description: "The Ubuntu team has produced a new GTK+ based host for Flutter apps on all Linux distros"
publishDate: 2020-07-08
author: csells
image: images/0uMT4fCQFO8VQwB0Q.webp
category: announcement
layout: blog
---

## Canonical enables Linux desktop app support with Flutter

*By Chris Sells (Google) & Ken VanDine (Canonical)*

Google’s goal for Flutter has always been to provide a portable toolkit for building beautiful UIs that run at native speeds, no matter which platform you target. To validate this capability, we started by focusing on the mobile platforms Android and iOS, where we’ve seen more than 80,000 fast, beautiful Flutter apps published to Google Play.

To build on this success, for more than a year we’ve been expanding our focus to include desktop-class experiences, both for the web and for the desktop operating systems: macOS, Windows, and Linux. This work includes extensive refactoring of the engine to support desktop-style mouse and keyboard input, as well as resizable top-level windows. It also includes new UI capabilities that adapt well to desktop, like Material Density support and [the NavigationRail](https://api.flutter.dev/flutter/material/NavigationRail-class.html), and experiments with deep integration into the underlying desktop OS with experiments in [Dart:FFI](https://dart.dev/guides/libraries/c-interop) and access to the system menu bar and standard dialogs. All of this work was to ensure that in addition to being suitable for mobile-style experiences, Flutter is ready to handle full-featured, full-sized desktop apps.

It has long been our vision for Flutter to power platforms. We’ve seen this manifest already at Google with products like [the Assistant](https://developers.googleblog.com/2019/05/Flutter-io19.html), so now we’re thrilled to see others harnessing Flutter to power more platforms. Today we are happy to jointly announce the availability of the Linux alpha for Flutter alongside Canonical, the publisher of [Ubuntu](https://ubuntu.com/), the world’s most popular desktop Linux distribution.

## Why Flutter for Linux?

Last year, when Google announced desktop-class application support with Flutter, Canonical saw an exciting opportunity to make Linux distributions, including Ubuntu, an attractive target platform for Flutter app developers. Flutter’s native cross-platform story is growing rapidly and Canonical wanted to be at the vanguard. By enabling desktop Linux support in Flutter, Canonical is making it very easy for application developers to publish their apps for Linux users via the Snap Store, the app store for Linux. By making Linux a first-class Flutter platform, Canonical is inviting application developers to publish their apps to millions of Linux users and broaden the availability of high quality applications available to them.

A number of things about Flutter were exciting for Canonical:

* Fast growing ecosystem of application developers

* Multiple platform support

* Highly optimized native applications

* Modern UI framework supporting declarative, reactive, and composable widgets

* Rich development platform using Visual Studio Code, Android Studio, and IntelliJ

Google’s initial announcement announcement of Flutter desktop support started with an alpha release supporting macOS and plans for Linux and Windows. Canonical is making a significant investment in Flutter by dedicating a team of developers to work alongside Google’s developers to bring the best Flutter experience to the majority of Linux distributions. Canonical will continue to collaborate with Google to further improve Linux support and to maintain feature parity with the other supported platforms.

## Flokk: Proving Flutter’s readiness for the desktop

To demonstrate that Flutter was ready for the desktop, we worked with the designers and developers at [gskinner](https://gskinner.com) to create an innovative, beautiful Flutter desktop app. Flokk is a real-world app that works with real-world data, specifically your Google Contacts list.

<YoutubeEmbed id="cTFJcq7UTRY" title="YouTube" fullwidth="true"/>


In addition to being able to manage your contacts, including searching contacts, adding new contacts, and editing existing contacts, Flokk also lets you associate GitHub and Twitter handle information with your contacts.

<DashImage figure src="images/0uMT4fCQFO8VQwB0Q.webp" alt="The Flokk Contacts app was built with Flutter to target the desktop" caption="The Flokk Contacts app was built with Flutter to target the desktop" />


The display of GitHub and Twitter notifications turns your contacts into your own personal social network. And if you’re not seeing your favorite social networks in Flokk Contacts, then the good news is that Flokk is [completely open source](https://github.com/gskinnerTeam/Flokk/), so you can submit a PR to add your favorite.

In addition to innovating in the social space, Flokk uses Flutter features to look and feel great. As just one example, the dark theme not only switches the colors but animates the changes as it does so.

<DashImage figure src="images/0dKv6teOS8d4zjiWk.webp" alt="Flutter enables Flokk to take advantage of smooth animation, high-performance scrolling, and easy theming" caption="Flutter enables Flokk to take advantage of smooth animation, high-performance scrolling, and easy theming" />


The creative team behind the Flokk Contacts app was led by [Grant Skinner](https://gskinner.com), who’s well known for both excellence in design and implementation of innovative user experience. Grant had this to say about working with Flutter on Linux:
> *“Building the Flokk Contacts app was a breeze! We were able to apply all our previous expertise in Flutter to target Linux with virtually no adjustments, and the app runs fantastically. Working with the Canonical team was a wonderful experience; they were enthusiastic, engaged, and passionate about making Flutter better not just for Linux, but for every platform. It was an amazing project, and I’m thrilled to be able to target another major OS with Flutter.” — Grant Skinner*

If you’d like to use the Flokk app on your Linux machine, you can download the latest release on [GitHub](https://github.com/gskinnerTeam/Flokk/releases). Or, if you’re running snapd, you can download the Flokk App from the [Snap Store](https://snapcraft.io/flokk-contacts).

## Easy install of Flutter on Linux

Now that you’ve seen how well Flutter works for desktop-class applications, especially on Linux, you’re going to want to get it running on your own Linux machine. To make that as simple as possible, we’re pleased to provide the Flutter SDK for Linux as a snap in the [Snap Store.](https://snapcraft.io/flutter) The Flutter SDK snap provides everything needed to develop Flutter apps on your favorite Linux distribution. No need to install a bunch of development dependencies; simply install the Flutter SDK snap and your favorite IDE, and you have everything you need to create, build, and publish your applications for Linux.

For example, if you’d like to get started developing Flutter applications for Linux and your IDE of choice is Visual Studio Code, this is all you need to do at your Linux terminal:

```bash
$ snap install --classic flutter
$ snap install --classic code
$ code --install-extension dart-code.flutter
```


If you also want to use Linux to develop mobile apps, you can do so by [installing the Android SDK or Android Studio](https://developer.android.com/studio/install#linux) (which includes the Android SDK). For more information on the Flutter SDK as a snap, see [https://snapcraft.io/flutter](https://snapcraft.io/flutter)

## Flutter for Linux desktop

Once the Flutter SDK is installed on your Linux machine, to build a desktop app you need to upgrade to the Flutter dev or master channel. Then enable Linux desktop support:

```bash
$ flutter channel dev
$ flutter upgrade
$ flutter config --enable-linux-desktop
```


Now when you create a new Flutter project, you’ll get a `linux` subdirectory that lets you run the app on your Linux desktop:

```bash
$ flutter create counter
$ cd counter
$ flutter run -d linux
```


<DashImage figure src="images/0isPy4BXVD5J5hyQg.webp" alt="The famous Flutter Counter app runs great on Linux, too" caption="The famous Flutter Counter app runs great on Linux, too" />


What you’ll get is a shiny new Linux app built with Flutter running on the latest stable version of GTK+. If you have an existing Flutter project to which you’d like to add Linux support after you have Linux enabled, you can add the `linux` subdirectory like so:

```bash
$ cd my_flutter_app
$ flutter create .
```


This will create the `linux` subdirectory with the Runner project that you need to build and run your Flutter app on the Linux desktop.

## Accessing native code in Linux from Flutter

In addition to supporting the desktop by writing Dart to create Flutter widgets, your Linux desktop apps can also access all of native Linux using [platform channels](https://flutter.dev/docs/development/platform-integration/platform-channels) or [the Dart Foreign Function Interface for C/C++](https://dart.dev/guides/libraries/c-interop). Or, if you’d like to reuse pre-existing code, you can [find that code on pub.dev](https://pub.dev/flutter/packages?platform=linux), Dart and Flutter’s package manager site. Most of the packages you’ll find on pub.dev are pure Dart, most of which work just fine in Linux apps. Some packages, called plugins, have native code in them that are specific to one or more platforms. As part of this release, we’ve published three plugins on pub.dev that use native functionality of Linux:

* [url_launcher](https://pub.dev/packages/url_launcher): launch the default browser at a URL provided

* [shared_preferences](https://pub.dev/packages/shared_preferences): user preferences shared between app sessions

* [path_provider](https://pub.dev/packages/path_provider): path information about special-purpose directories, such as downloads, pictures, and so on

Each of these plugins is available for you to use in your apps, as well as serving as an example of how to access Linux natively from your Flutter code, like [the Linux implementation of url_launcher](https://github.com/flutter/plugins/tree/master/packages/url_launcher/url_launcher_linux/).

## Deploying to the Snap Store

To deploy your Flutter app to the Snap Store, you first need to install Snapcraft, the tool that you’ll use to build and publish your application as a snap:

```bash
$ sudo snap install snapcraft --classic
```


To drive the Snapcraft tool, you’ll need to create a `snapcraft.yaml` file in your app’s project directory. As one example, this is the `snapcraft.yaml` file for Flokk:

```yaml
name: flokk-contacts
version: 1.0.1
summary: Flokk Contacts
description: A fresh and modern Google Contacts manager that integrates with GitHub and Twitter.
confinement: strict
base: core18
grade: stable

apps:
  flokk-contacts:
    command: flokk-contacts
    extensions: [flutter-master]
    plugs:
    - network

parts:
  flokk-contacts:
    source: .
    plugin: flutter
    flutter-target: lib/main.dart # app's main entry-point file
```


In the directory with your `snapcraft.yaml` file, you can now run `snapcraft` to build a snap of your application.

```bash
$ snapcraft
```


If all goes well, this produces a file in your current working directory like `flokk-contacts_1.0.1_amd64.snap`.

Once you’ve [set up your account](https://snapcraft.io/docs/creating-your-developer-account) for publishing in the Snap Store, you can publish your snap:

```bash
$ snapcraft login
$ snapcraft register flokk-contacts
$ snapcraft upload flokk-contacts_1.0.1_amd64.snap --release edge
```


This command will upload the application to the Snap Store and attempt to publish it to the [edge channel](https://snapcraft.io/docs/channels#heading--risk-levels). Once your application is published in the edge channel, it can be installed either via the Snap Store Desktop client or using the command line:

```bash
$ snap install --edge flokk-contacts
```


For more details on building your first snap and publishing it in the Snap Store, see [https://snapcraft.io/first-snap#flutter](https://snapcraft.io/first-snap#flutter) for a guided tutorial.

## Flutter Linux desktop samples

The Flokk app is an excellent example of a real-world Flutter app targeting the Linux desktop. For a simpler sample, you can check out [the Photo Search app](https://github.com/flutter/samples/tree/master/experimental/desktop_photo_search), which was also built specifically to show off desktop features.

<DashImage figure src="images/0y2IpiLOI01i9BqiC.webp" alt="Try the Photo Search sample on Linux" caption="Try the Photo Search sample on Linux" />


Photo Search is a simple online photo search app that uses several plugins to access native platform functionality, supporting both macOS and Linux.

For an example Linux desktop app with step-by-step instructions, I recommend [the Write a Flutter desktop application codelab](https://codelabs.developers.google.com/codelabs/flutter-github-graphql-client/index.html#0), which walks you through using OAuth and GraphQL to build a GitHub client in Flutter.

<DashImage figure src="images/0vktUouQPnTpgk0Ko.webp" alt="The Flutter GitHub codelab client application in action" caption="The Flutter GitHub codelab client application in action" />


For a more comprehensive app that exercises much more of the surface area of Flutter as well as providing several little applets, I recommend [the Flutter Gallery](https://github.com/flutter/gallery), which was redesigned last year to support desktop as well as mobile. If you’d like to see that in action, you can check that out [on the Snap Store](https://snapcraft.io/flutter-gallery), too.

<DashImage figure src="images/0yW96xpHMveP4-kUm.webp" alt="The Flutter Gallery sample is available on the Snap Store" caption="The Flutter Gallery sample is available on the Snap Store" />


One more desktop app that shows off the fun side of Flutter is a multi-player game built by Thorsten Lorenz called [batufo](https://thlorenz.com/batufo/). Set against a beautiful backdrop, the game lets players from all over the world compete against each other in real time.

<DashImage figure src="images/1ghwj9i6N9nvBvNmKdP8oZw.gif" alt="Play in real time across multiple Flutter platforms" caption="Play in real time across multiple Flutter platforms" />


Thorsten has been building this game to support multiple Flutter platforms including Linux, macOS, Android, and iOS. If you’d like to see how he did it and follow along with future updates, he makes his coding sessions available as [videos](https://thlorenz.com/batufo/#watch) and [the code available on GitHub](https://github.com/thlorenz/batufo). To install the game from Linux, you can pull it down from the [Snap Store](https://snapcraft.io/batufo).

## Summary

With this alpha release and the close partnership between Google and Canonical, Linux developers get Flutter support for their operating system of choice. Install the [Flutter SDK via snap](https://snapcraft.io/flutter). Build and test your desktop app on Linux using Visual Studio Code or Android Studio. Deploy your app to the Snap Store. For the latest details, see [the desktop page on flutter.dev](https://flutter.dev/desktop). And above all else, [make sure to provide feedback](https://github.com/flutter/flutter/issues) so that we can continue making Flutter the best it can be on Linux, as we strive to do for every supported Flutter platform.

Flutter for Linux from the Canonical team is a giant step forward for our dream of making Flutter the best way to build an app, no matter which platform you’re targeting. Targeting the desktop has made the Flutter engine that much more adaptable to a long tail of devices that Google itself can’t support directly, but for which we plan to continue to build partnerships and to enable the ecosystem.

Wherever there are devices that need fast, beautiful apps, that’s where we want Flutter to be.