---
title: Building macOS apps with Flutter
description: Platform-specific considerations for building for macOS with Flutter.
toc: true
short-title: macOS development
---

This page discusses considerations unique to building
macOS apps with Flutter, including shell integration
and distribution of macOS apps through the Apple Store.

## Integrating with macOS look and feel

While you can use any visual style or theme you choose
to build a macOS app, you might want to adapt your app
to more fully align with the macOS look and feel.
Flutter includes the [Cupertino] widget set,
which provides a set of widgets for
the current iOS design language.
Many of these widgets, including sliders,
switches and segmented controls,
are also appropriate for use on macOS.

Alternatively, you might find the [macos_ui][]
package a good fit for your needs.
This package provides widgets and themes that
implement the macOS design language,
including a `MacosWindow` frame and scaffold,
toolbars, pulldown and
pop-up buttons, and modal dialogs.

[Cupertino]: {{site.url}}/development/ui/widgets/cupertino
[macos_ui]: {{site.pub}}/packages/macos_ui

## Building macOS apps

To distribute your macOS application, you can either
[distribute it through the macOS App Store][],
or you can distribute the `.app` itself,
perhaps from your own website.
As of macOS 10.14.5, you need to notarize
your macOS application before distributing
it outside of the macOS App Store.

The first step in both of the above processes
involves working with your application inside of Xcode.
To be able to compile your application from inside of
Xcode you first need to build the application for release
using the `flutter build` command, then open the
Flutter macOS Runner application.

```bash
flutter build macos
open macos/Runner.xcworkspace
```

Once inside of Xcode, follow either Apple's
[documentation on notarizing macOS Applications][], or
[on distributing an application through the App Store][].
You should also read through the
[macOS-specific support](#macos-specific-support)
section below to understand how entitlements,
the App Sandbox, and the Hardened Runtime
impact your distributable application.

[Build and release a macOS app][] provides a more detailed
step-by-step walkthrough.

[distribute it through the macOS App Store]: {{site.apple-dev}}/macos/submit/
[documentation on notarizing macOS Applications]:{{site.apple-dev}}/documentation/xcode/notarizing_macos_software_before_distribution
[on distributing an application through the App Store]: https://help.apple.com/xcode/mac/current/#/dev067853c94
[Build and release a macOS app]: {{site.url}}/deployment/macos

## Entitlements and the App Sandbox

macOS builds are configured by default to be signed,
and sandboxed with App Sandbox.
This means that if you want to confer specific
capabilities or services on your macOS app,
such as the following:

* Accessing the internet
* Capturing movies and images from the built-in camera
* Accessing files

Then you must set up specific _entitlements_ in Xcode.
The following section tells you how to do this.

### Setting up entitlements

Managing sandbox settings is done in the
`macos/Runner/*.entitlements` files. When editing
these files, you shouldn't remove the original
`Runner-DebugProfile.entitlements` exceptions
(that support incoming network connections and JIT),
as they're necessary for the `debug` and `profile`
modes to function correctly.

If you're used to managing entitlement files through
the **Xcode capabilities UI**, be aware that the capabilities
editor updates only one of the two files or,
in some cases, it creates a whole new entitlements
file and switches the project to use it for all configurations.
Either scenario causes issues. We recommend that you
edit the files directly. Unless you have a very specific
reason, you should always make identical changes to both files.

If you keep the App Sandbox enabled (which is required if you
plan to distribute your application in the [App Store][]),
you need to manage entitlements for your application
when you add certain plugins or other native functionality.
For instance, using the [`file_chooser`][] plugin
requires adding either the
`com.apple.security.files.user-selected.read-only` or
`com.apple.security.files.user-selected.read-write` entitlement.
Another common entitlement is
`com.apple.security.network.client`,
which you must add if you make any network requests.

Without the `com.apple.security.network.client` entitlement,
for example, network requests fail with a message such as:

```terminal
flutter: SocketException: Connection failed
(OS Error: Operation not permitted, errno = 1),
address = example.com, port = 443
```

{{site.alert.secondary}}
  **Important:** The `com.apple.security.network.server`
  entitlement, which allows incoming network connections,
  is enabled by default only for `debug` and `profile`
  builds to enable communications between Flutter tools
  and a running app. If you need to allow incoming
  network requests in your application,
  you must add the `com.apple.security.network.server`
  entitlement to `Runner-Release.entitlements` as well,
  otherwise your application will work correctly for debug or
  profile testing, but will fail with release builds.
{{site.alert.end}}

For more information on these topics,
see [App Sandbox][] and [Entitlements][]
on the Apple Developer site.

[App Sandbox]: {{site.apple-dev}}/documentation/security/app_sandbox
[App Store]: {{site.apple-dev}}/app-store/submissions/
[Entitlements]: {{site.apple-dev}}/documentation/bundleresources/entitlements
[`file_chooser`]: {{site.github}}/google/flutter-desktop-embedding/tree/master/plugins/file_chooser

## Hardened Runtime

If you choose to distribute your application outside
of the App Store, you need to notarize your application
for compatibility with macOS 10.15+.
This requires enabling the Hardened Runtime option.
Once you have enabled it, you need a valid signing
certificate in order to build.

By default, the entitlements file allows JIT for
debug builds but, as with App Sandbox, you might
need to manage other entitlements.
If you have both App Sandbox and Hardened
Runtime enabled, you might need to add multiple
entitlements for the same resource.
For instance, microphone access would require both
`com.apple.security.device.audio-input` (for Hardened Runtime)
and `com.apple.security.device.microphone` (for App Sandbox).

For more information on this topic,
see [Hardened Runtime][] on the Apple Developer site.

[Hardened Runtime]: {{site.apple-dev}}/documentation/security/hardened_runtime
