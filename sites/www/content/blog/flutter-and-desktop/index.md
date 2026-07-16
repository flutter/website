---
title: "Flutter and Desktop"
description: "Ongoing progress towards an ambient computing vision"
publishDate: 2020-06-17
author: timsneath
image: images/0OLMhLy7-b-4BisTc.webp
category: announcement
layout: blog
---

## Flutter and Desktop Apps

It’s no secret that our mission for Flutter is to target a broad variety of devices— including iOS, Android, Windows, Linux, macOS, and web — from a single codebase, with native compilation and game-quality visuals. Within Google Flutter is used by projects from [Assistant](https://store.google.com/product/google_nest_hub) to [Stadia](https://stadia.google.com/), from [Cloud Search](https://play.google.com/store/apps/details?id=com.google.enterprise.topaz.mobile.android) to [Blogger](https://play.google.com/store/apps/details?id=com.google.android.apps.blogger). And outside of Google, Flutter has been adopted by companies from [ByteDance](https://apps.apple.com/cn/app/%E4%BB%8A%E6%97%A5%E5%A4%B4%E6%9D%A1/id529092160?l=en) to [Grab](https://play.google.com/store/apps/details?id=com.grabtaxi.passenger), from [Nubank](https://medium.com/building-nubank/https-medium-com-freire-why-nubank-chose-flutter-61b80b568772) to [MGM Resorts](https://superformula.com/flutter/), all of whom benefit from the productivity and flexibility of Flutter.

Many of you are interested in progress on desktop operating systems including Windows, macOS, and Linux: in surveys and on GitHub, desktop is repeatedly one of the most popular new features. Over the coming weeks, we’re going to show off more of our work here, and we thought we’d start by surveying some of the work from various feature teams that contribute towards the overall project. While desktop support is currently a technical preview, there’s been plenty of work going on.

<DashImage figure src="images/0OLMhLy7-b-4BisTc.webp" />

## Release Mode

Recently we checked in profile and [release mode for Windows](https://github.com/flutter/flutter/issues/38477) and [Linux](https://github.com/flutter/flutter/issues/38478), in addition to the existing support for macOS. For example, if you’re running the latest builds of Flutter, you can now compile a Flutter application to a Windows executable with `flutter build windows`. This uses our production [AOT compiler](https://en.wikipedia.org/wiki/Ahead-of-time_compilation) to create native x64 machine code that can be distributed to a machine without Flutter installed.

## Desktop-class experiences

Whether you’re building standalone executables or web apps, there are unique attributes to building desktop-class experiences. Desktop windows are usually in landscape mode and resizable; input usually comes from a physical keyboard and mouse rather than an on-screen keyboard and touch; and controls are optimized for a different screen density.

At the framework level, we’ve made various changes to Flutter to support desktop-class experiences.

* When you create a new project in recent builds, you’ll see that the default template now includes a reference to a [`visualDensity`](https://api.flutter.dev/flutter/material/ThemeData/visualDensity.html) property, which [allows controls to adapt their density](https://github.com/flutter/flutter/issues/43350) based on the platform they are targeting, with more compact spacing on desktop platforms. An example of how this is used is [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html), which now offers [compact, comfortable, and standard spacing](https://github.com/flutter/flutter/pull/51438) depending on the specified density.

* We’ve added much better support for mouse and keyboard input; this includes [raw key codes on Windows](https://github.com/flutter/flutter/issues/52264), right-click mouse button, [cursor changes](https://github.com/google/flutter-desktop-embedding/issues/376) and scroll wheel support.

* You can now query for the specific platform (through the `Platform` class) and Windows, macOS, and Linux all provide the appropriate results.

* In the most recent release, we’ve added [a `NavigationRail` widget](https://api.flutter.dev/flutter/material/NavigationRail-class.html) that is specifically designed for desktop-class experiences on desktop and tablet.

## FFI

The Dart team has been hard at work polishing [Foreign Function Interface (FFI)](https://dart.dev/guides/libraries/c-interop), which is a great velocity booster for platform integration. For C-based APIs, the `dart:ffi` library provides a direct mechanism for binding to native code; the Dart runtime provides the ability to allocate memory on the heap that is backed by a Dart object and make calls to dynamically linked libraries.

For a simple example from Windows, here’s a fragment of code to call the traditional Win32 `MessageBox()` API entirely with Dart code:

```dart
typedef MessageBoxNative = Int32 Function(
    IntPtr hWnd, Pointer<Utf16> lpText, Pointer<Utf16> lpCaption, Int32 uType);
typedef MessageBoxDart = int Function(
    int hWnd, Pointer<Utf16> lpText, Pointer<Utf16> lpCaption, int uType);

final user32 = DynamicLibrary.open('user32.dll');
final win32MessageBox =
    user32.lookupFunction<MessageBoxNative, MessageBoxDart>('MessageBoxW');

void showMessageBox(String message, String caption) => win32MessageBox(
    0,                      // No owner window
    Utf16.toUtf16(message), // Message
    Utf16.toUtf16(caption), // Window title
    0                       // OK button only
    );

…

showMessageBox('Test Message', 'Window Caption'); // call just like any other Dart function
```

In this code, we provide `typedef`s that represent the method signature both in its native and Dart-based representations. With these defined, we can load the Windows dynamic link library (DLL) that provides the implementation of the function via the `lookupFunction()` method, which maps the Dart function signature onto the underlying native entrypoint. Lastly, we optionally add a simple idiomatic wrapper to make it easily accessible from other Dart code, resulting in something like this:

<DashImage figure src="images/0rCBxqUkuMqFvPvq4.webp" alt="A simple Windows example app that uses the Win32 `MessageBox` API" caption="A simple Windows example app that uses the Win32 `MessageBox` API" />

You don’t have to do this work yourself, of course: chances are that [someone has already paved the way for the API that you want to use](https://pub.dev/packages/win32). You can [read more about using FFI from Flutter in our docs](https://flutter.dev/docs/development/platform-integration/c-interop).

## Updating the plugin model

By design, Flutter itself has a small core. Rather than adding heft to the base framework, plugins and packages (whether directly from the Flutter team or the broader ecosystem of contributors), provide integration with the underlying operating systems.

However, with Flutter increasingly supporting mobile, web, and desktop, developing a plugin for every supported platform becomes ever more challenging. It’s more likely that a plugin will require contributions from different authors with expertise in each platform.

A useful technique is to define a common interface as part of the core plugin that each platform can implement independently. So, as described in [a recent post about modern plug-in development](https://medium.com/flutter/modern-flutter-plugin-development-4c3ee015cf5a#1139), we’ve recently adapted the schema for plug-ins to enable platform development to be more easily federated across multiple authors. As part of this work, it’s now possible to [declare explicitly which platforms are supported by a plugin](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms).

We’ve started to build out some of the core plugins using this model, and you’ll find some early examples of the federated model in the [flutter/plugins](https://github.com/flutter/plugins/tree/master/packages/path_provider) repo.

Note that the Windows and Linux plugin APIs are still in flux, so while we encourage exploration, we aren’t ready for general-purpose production support at this time. We’re also working on adding Desktop platform tags on pub.dev.

## Running on Windows: Win32 and UWP

One interesting aspect of the work that we’ve been doing on Windows is experimenting with various architectural approaches. On any platform, Flutter is embedded into a small host container app (an “embedder”), using a similar approach to game engines like Unity. This platform-specific embedder provides an entrypoint, coordinates with the underlying operating system for access to services like rendering surfaces, accessibility and input, and manages the message event loop.

<DashImage figure src="images/1tCqp0X4-8_yDjhbtVbqx-w.webp" />

Windows offers two distinct approaches for creating this embedder. First, the mature Win32 programming model can be used to create the entrypoint for Flutter content; this offers maximum backwards compatibility to platforms such as Windows 7 and builds a standard EXE file that many developers will expect. Conversely, the modern UWP app model is the recommended approach for Windows 10 and offers intriguing opportunities for expanding Flutter support to devices such as Xbox or the upcoming [Windows 10X](https://docs.microsoft.com/en-us/dual-screen/windows/get-dev-tools) operating system.

We’ve been working informally with various contributors to explore different solutions here, and would gladly support a close collaboration with Microsoft to complete a high-quality solution. With the Surface family of devices extended to include Android and Windows, we think Flutter offers Microsoft a compelling platform for building beautiful native experiences that span their entire portfolio.

## Having fun with desktop

This work remains in technical preview, and the APIs and tooling are not yet stable. We’re still tracking plenty of work that we want to complete before we promote desktop support to stable, including improved accessibility and localization support.

If you want to try it out, you’ll need to be on a development channel. Windows and Linux are only available on the `master` branch, which is where active Flutter development takes place. macOS is available on the `dev` branch, which is slightly more stable but not recommended for production use. You can switch channels with `flutter channel master` or `flutter channel dev`, and then use one of these commands to enable support for the platform you’re using:

```plaintext
C:\flutter> flutter config --enable-windows-desktop

$ flutter config --enable-macos-desktop

$ flutter config --enable-linux-desktop
```

We’re already seeing some adventurous developers start to take advantage of Flutter on the desktop to create apps. One of the first Flutter macOS desktop apps that we’ve seen is [Sharezone](https://sharezone.net/), a student planner aimed at the German educational market, which started as a mobile app but has recently added web and desktop versions.

<DashImage figure src="images/0iBeoGqAPyC66-BBe.webp" alt="Sharezone Schulplan — an app for students, educators and parents to track homework, study groups and timetables." caption="Sharezone Schulplan — an app for students, educators and parents to track homework, study groups and timetables." />

We’ll be sharing more about desktop support in the coming weeks; in the meantime, we’d love to hear more about your experiences. If you’re a plugin author, we’d encourage you to start evaluating the work to support these upcoming desktop platforms; if you’ve published an app, why not try running it as a desktop app and let us know how you get on?
