---
title: "Announcing Flutter Windows Alpha"
description: >-
  Native Windows app compilation, some early plugins,
  and a desktop-ready Flutter Gallery app
publishDate: 2020-09-23
author: csells
image: images/039MKtw4ICepbL_8d.webp
category: announcement
layout: blog
---

Our mission is to provide developers with an open source, high-productivity framework for building beautiful, native apps on any platform. So far, we’ve shipped production-quality support for Android and iOS, with eight stable releases and over 100,000 apps shipped to the Google Play Store alone. We continue to broaden our focus to include other platforms including web, macOS, and Linux. Today, we’re pleased to announce an additional target for Flutter with the alpha release of Flutter support for Windows.

Windows remains a popular choice for desktop and laptop devices, with Microsoft reporting over [one billion active devices running Windows 10](https://blogs.windows.com/windowsexperience/2020/03/16/windows-10-powering-the-world-with-1-billion-monthly-active-devices/). Our own statistics show that over half of all Flutter developers use Windows, so it’s a natural target for Flutter. Native desktop support opens up a variety of exciting possibilities for Flutter, including improved developer tooling, reduced friction for new users, and of course apps that can reach any device a user might have from a single codebase.

## Adding Windows to Flutter

As described in our [architectural overview](https://flutter.dev/docs/resources/architectural-overview), Flutter is a cross-platform UI toolkit that is designed to allow code reuse across operating systems such as iOS and Android, while also allowing applications to interface directly with underlying platform services. The goal is to enable developers to deliver high-performance apps that feel natural on different platforms, embracing differences where they exist while sharing as much code as possible. At the core of Flutter is the engine, which supports the primitives necessary to support all Flutter applications. The engine is responsible for rasterizing composited scenes whenever a new frame needs to be painted. It provides the low-level implementation of Flutter’s core API, including graphics, text layout, file and network I/O, accessibility support, plugin architecture, and a Dart runtime and compile toolchain.

Each new platform we add to Flutter expands the core framework with new services to enable it to shine on that platform. We started on Android and iOS with Material Design as well as a touch-based, mobile-centric user interface that is designed to be pixel-perfect on both mobile platforms. Adding support for desktop form factors with web, Windows, macOS, and Linux brings a whole new set of services, including robust support for keyboards, mice, mouse wheels and controllers on the input side as well as widgets that adapt or even work best at the larger screen sizes that come with web and desktop apps.

Furthermore, each new platform doesn’t just influence the Flutter framework and engine, but a lot of other things as well:

* **Toolchain updates:** adding a new target to the CLI and IDE tools (in this case Windows)

* **Shell:** support for handling input from Windows via `WM_*` messages and output via [ANGLE](https://opensource.google/projects/angle), which uses [Skia](https://skia.org/) to render at native speed to an underlying DirectX surface

* **Runner:** every project gets a shell application for the supported targets. For Windows, it’s a Win32/C++ program that loads your Flutter code and executes it at runtime. It’s a good place to add native code to your app if you need it.

* **Plugins:** A plugin is a mixture of Dart code and native code for each of the platforms that the plugin supports. That native code needs to be added for each plugin that is compiled into your Flutter app on Windows.

This alpha release offers a solid foundation that we’ll stabilize over the coming months. With support for Windows 7 and above, we hope this gives adventurous developers something to get started with.

## Exploring some sample apps

To see Flutter support for Windows in action, you might want to try out some of the sample apps that we’ve created that run well on Windows with our newly-added support. The first, the Flokk app, was created in concert with the designers and developers at [gskinner.com](https://gskinner.com). The goal was to demonstrate that Flutter was ready for the desktop by creating an innovative, beautiful Flutter desktop app. Flokk is an app that works with your real Google Contacts data as well as showing your contacts’ activity on GitHub and Twitter.

<DashImage figure src="images/039MKtw4ICepbL_8d.webp" />

If you’d like to use the Flokk app on your Windows machine, you can [download the latest release on GitHub](https://github.com/gskinnerTeam/Flokk/releases). And if you’d like to read about how gskinner built this app, see their excellent blog post: [Flokk — How we built a Desktop App Using Flutter](https://blog.gskinner.com/archives/2020/09/flokk---how-we-built-a-desktop-app-using-flutter.html).

In addition, the Flutter Gallery app, our showcase app for all things Flutter, was completely rewritten recently to add support for desktop form factors. This allowed us to check that it works well on [the web](https://gallery.flutter.dev) as well as Windows, macOS, and Linux.

<DashImage figure src="images/0N_tKeqs435R4yICO.webp" />

Many studies in the Gallery demonstrate ideas for different app styles that we recommend when designing your own Windows app with Flutter. When you find something you like, [the code is available on GitHub](https://github.com/flutter/gallery).

## Getting started with Flutter for Windows

Get started by installing the Flutter SDK according to the [Windows install instructions](https://flutter.dev/docs/get-started/install/windows). To target Windows desktop, you first need to [install the tooling described in the desktop docs](https://flutter.dev/desktop#additional-windows-requirements). By default, Flutter assumes that you’re building production software and isn’t configured to develop Windows apps. However, that’s easily fixed from the command line:

```bash
$ flutter channel dev
$ flutter upgrade
$ flutter config --enable-windows-desktop
```

The first command sets Flutter to use the experimental-quality “dev” channel (instead of the “stable” channel, which is the default). This allows you to use platform support that’s still in alpha, like Windows. The second command pulls down the latest bits on that channel. The third command enables Windows app development on your PC.

Once you’ve set it up, every time you create a new Flutter app, using the extension support for either [Android Studio](https://flutter.dev/docs/get-started/editor?tab=androidstudio) or [Visual Studio Code](https://flutter.dev/docs/get-started/editor?tab=vscode), or from the command line, it creates a windows subfolder.

<DashImage figure src="images/0O-akivVSsv0tL0wI.webp" />

If you’re curious, running the default app on Windows looks like the following:

<DashImage figure src="images/1fsnlPFkpQWZjYIv-NCE6Vg.webp" />

And finally, once you’ve created your app, building it creates a release-mode, native EXE file as well as the necessary supporting DLLs. At that point, if you want to experiment with running your new Windows app on any Windows 10 machine, even those that don’t have Flutter installed, you can follow [the steps to zip up the necessary files](https://flutter.dev/desktop#distribution) and go.

## Plugins for Windows

Even though we’ve just reached the alpha release, the Flutter community has already been working on plugins for Windows. Here are a few:

* [url_launcher](https://pub.dev/packages/url_launcher): launch URLs in the browser from your app

* [path_provider](https://pub.dev/packages/path_provider): find the path to special directions on the user’s machine like Documents or temp

* [shared_preferences](https://pub.dev/packages/shared_preferences): keep user preferences serialized on disk between sessions of your app

* [biometric_storage](https://pub.dev/packages/biometric_storage): storage encrypted by biometrics

* [flutter_audio_desktop](https://pub.dev/packages/flutter_audio_desktop): play audio from your desktop apps

The benefit of using these plugins is that most of them also support other Flutter platforms, which enables you to target your apps at Android, iOS, web, etc. as well as Windows. Furthermore, while about one-third of the available packages on [pub.dev](https://pub.dev) (the package manager for Dart and Flutter) are plugins with platform-specific code, most are not. For instance, [many of the highest quality and most used packages](https://pub.dev/flutter/favorites) are part of the Flutter Favorite program and most of them work on Windows. If you’d like to see the full list of packages that run on Windows, you can [run this query on pub.dev](https://pub.dev/flutter/packages?platform=windows).

## Interop with Windows

If you’d like to build your own plugins for Windows, you can. Once you’re on the dev channel and you have Windows enabled for your machine, you can get started with the following command:

```bash
$ flutter create --template plugin --platforms windows hello_plugin
```

At that point, you’ll be able to add your Flutter code to the `lib` subfolder and your Windows code to the `windows` subfolder in your plugin project. You’ll communicate between the two stacks using [Platform Channels](https://flutter.dev/docs/development/platform-integration/platform-channels), which is essentially message passing between your Dart and C++ code. For a well crafted example of this, [see the url_launcher implementation](https://github.com/flutter/plugins/tree/master/packages/url_launcher/url_launcher_windows).

However, Platform Channels are not your only option for interop with Windows. If you like, you can use the [Dart FFI (Foreign Function Interface)](https://flutter.dev/docs/development/platform-integration/c-interop) to load libraries and call into C-style APIs, such as the Win32 API. Unlike url_launcher, which uses Platform Channels, the path_provider plugin was implemented using FFI, as you can see in [the GitHub repo](https://github.com/flutter/plugins/tree/master/packages/path_provider/path_provider_windows). Instead of going back and forth between Dart and C++, FFI allows you to write code to import the API that you want directly. For example, here’s the code for calling the MessageBox API:

```dart
typedef MessageBoxNative = Int32 Function(
  IntPtr hWnd,
  Pointer<Utf16> lpText,
  Pointer<Utf16> lpCaption,
  Int32 uType
);

typedef MessageBoxDart = int Function(
  int hWnd,
  Pointer<Utf16> lpText,
  Pointer<Utf16> lpCaption,
  int uType
);

final user32 = DynamicLibrary.open('user32.dll');

final win32MessageBox =
  user32.lookupFunction<MessageBoxNative, MessageBoxDart>('MessageBoxW');

void showMessageBox(String message, String caption) =>
  win32MessageBox(
    0, // No owner window
    Utf16.toUtf16(message), // Message
    Utf16.toUtf16(caption), // Window title
    0 // OK button only
  );

...

// call just like any other Dart function
showMessageBox('Test Message', 'Window Caption');
```

This code doesn’t incur the overhead of transitioning between two threads like Platform Channels. FFI includes support for many different kinds of APIs, including Win32, WinRT, and COM. But before you run off and wrap the entire C-based Windows API, please check out [the win32 plugin](https://pub.dev/packages/win32), which is already well on its way to doing just that. In fact, the [path_provider](https://pub.dev/packages/path_provider) plugin was itself implemented using the win32 plugin. For the details of how the win32 plugin was developed and how it works, check out the blog post, [Windows fun with Dart FFI](https://medium.com/@timsneath/windows-fun-with-dart-ffi-687c4619e78d).

## Flutter for Windows resources

Wherever you are in your Flutter for Windows journey, you should be sure to [read the desktop documentation on flutter.dev](https://flutter.dev/desktop), which includes the latest details. Also, you’ll want to take a spin through the Flutter [codelab for writing a Windows, macOS, and Windows desktop-targeted application](https://codelabs.developers.google.com/codelabs/flutter-github-graphql-client), which includes code for real-world scenarios like authentication using OAuth, accessing the GitHub API, and using GraphQL. Or, for another good example of Flutter desktop code that works on Windows, [check out the Photo Search sample](https://github.com/flutter/samples/tree/master/experimental/desktop_photo_search).

<DashImage figure src="images/03OlPPAMAvO84mJ6M.webp" />

It uses the standard Windows File Open dialog, a tree view widget, a splitter widget, and integrates the results with a real-world REST API.

For other helpful desktop-oriented widgets, we recommend [the menubar plugin](https://github.com/google/flutter-desktop-embedding/tree/master/plugins/menubar), [the NavigationRail widget](https://api.flutter.dev/flutter/material/NavigationRail-class.html), and [the DataTable widget](https://api.flutter.dev/flutter/material/DataTable-class.html). You might also be interested in [the InteractiveViewer widget](https://api.flutter.dev/flutter/widgets/InteractiveViewer-class.html), which has full desktop support for mouse gestures to pan and zoom child widgets.

Another useful set of widgets to explore are [those from SyncFusion](https://pub.dev/publishers/syncfusion.com/packages), who are already well-known in the Windows development community. They provide a wide range of enterprise-quality widgets for creating charts, gauges, data grids, and more.

<DashImage figure src="images/0dY1TC_i0KyjKNrvh.webp" />

These widgets have a community and enterprise license, so you can find the right fit for your project.

## Flutter for Windows in the wild

In addition to packages and plugins for Windows (and Flutter desktop in general), Flutter developers have also been building great apps to target Windows, like this experimental build from [Invoice Ninja](https://www.invoiceninja.com/):

<DashImage figure src="images/0ZuwlwG4e6fwCeQ_1.webp" />

Invoice Ninja is an invoicing company that depends on Flutter to bring in its revenue. They target Android and iOS in production today and have [a web-based demo](https://demo.invoiceninja.com) for you to try, but are also looking ahead to providing a desktop version.
> “At Invoice Ninja we’ve struggled in the past to support just web and mobile, at one point maintaining three separate codebases. With Flutter, and more recently Flutter Desktop, we’ve been able to build apps for every major platform with a single codebase. Not only do we basically get a free desktop version of our app but it has the best performance of them all!”
> — Hillel Coren, Co-Founder, Invoice Ninja

If you’re interested in the implementation of a real-world, revenue-generating Flutter app that works on mobile and desktop form factors, [the source code is available on GitHub](https://github.com/invoiceninja/flutter-client).

[Aartos](https://drone-detection-system.com/) is another company building great things, including a real-time drone detection system with [a multi-platform client written in Flutter](https://drone-detection-system.com/aartos-dds/product-overview/). Here’s an early version of the Windows client running right next to the mobile client:

<YoutubeEmbed id="mGvPCT7Vc2Y" title="Flutter Client App for Aartos, Desktop + Mobile" fullwidth="true"/>

Both of these versions, targeting iOS and Windows, share the exact same codebase.

If you’re an experienced Flutter developer and you find yourself switching between different versions of Flutter; for example, one version to ship your production mobile apps and another to experiment with the Windows alpha, then you might appreciate the Flutter Version Manager, which now comes with [a Windows GUI that you can download](https://github.com/leoafarias/fvm/releases).

<YoutubeEmbed id="_WA71wSt2ww" title="FVM App for Windows" fullwidth="true"/>

This tool is open source, so can [see for yourself](https://github.com/leoafarias/fvm) how Leo makes it look so great.

## What’s next

Now that we’ve released the alpha, our attention shifts to completing the feature set and stabilizing the product for release. As an open source project, you can follow our [progress to beta on our GitHub site](https://github.com/flutter/flutter/projects/55), with remaining work to complete including accessibility, globalization and localization, enhanced keyboard and text handling, support for command line arguments, and more.

In addition to supporting the classic Win32 API, we’re also experimenting with [a UWP-based version of the Flutter shell](https://docs.microsoft.com/en-us/windows/uwp/get-started/universal-application-platform-guide), which allows Flutter to reach an even broader variety of Windows-based devices, including Xbox. As part of that experiment, this week we released a UWP-based version of the [Flutter Gallery to the Windows Store](https://www.microsoft.com/en-us/p/flutter-gallery/9pdwctdfc7qq).

The following screenshot shows the UWP-based Flutter Gallery running on an Xbox:

<DashImage figure src="images/0cNcLDSm8fwlwux15.webp" />

And here’s the same app running on a dual-screen Windows device running on the [Windows 10X emulator](https://docs.microsoft.com/en-us/dual-screen/windows/get-dev-tools):

<DashImage figure src="images/1ZIxhg4Lx_KI5v4bc1zi5zg.webp" />

[You can read more about the progress on Flutter for UWP on GitHub](https://github.com/flutter/flutter/issues/14967#issuecomment-697108439).

## Summary

With this release, we bring the power of Flutter to Windows, with its declarative, composable, reactive framework for developer productivity, its adaptable implementation of the Material spec so you can make your apps look and feel the way you want them to, as well as the full set of Flutter development and debugging tools. When complete, your app is compiled to native 64-bit code that you can package and bring to other Windows machines just like any other native app. And finally, you can use that same codebase to create an app targeting Android, iOS, web, macOS, and Linux.

If you’d like to start building Windows apps with Flutter, we’d love [your feedback](https://github.com/flutter/flutter/issues)! If you prefer to use your Windows expertise to [build out the Windows implementation of popular plugins](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin), or build some Windows-centric tooling for Flutter (perhaps a CLI that creates MSIXs from the output of a `flutter build windows` command…), that’s also welcome!

With the new support for Windows in Flutter, what are you going to build?
