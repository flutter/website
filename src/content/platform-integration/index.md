---
title: Build for and integrate with multiple platforms
shortTitle: Platform integration
description: >-
  Learn how to develop for different platforms and
  integrate with platform-specific features in Flutter apps.
---

Flutter enables you to build, test, and deploy beautiful, natively compiled,
multi-platform applications from a single codebase.

## Overview

Flutter and its core packages often automatically support and integrate
with Flutter's officially [supported platforms][].
Some platforms require you to [set up additional tooling](#setup),
but once your development environment is set up,
Flutter apps are usually functional across platforms out of the box.

Occasionally you need to integrate with platform-specific functionality.
For example, you might want to use a native library that's
only available on iOS and iPadOS.
For many use cases, you can find and use one of the many [Flutter plugins][]
provided by the Flutter team and the amazing Flutter community.
If none of them meet your needs, you can
[write platform-specific code][] and even [create your own plugin][].

:::tip
If you're exploring building your app for multiple platforms,
also consider building your UI with [adaptive and responsive design][] in mind.
:::

[supported platforms]: /reference/supported-platforms
[Flutter plugins]: /packages-and-plugins/using-packages
[write platform-specific code]: /platform-integration/platform-channels
[create your own plugin]: /packages-and-plugins/developing-packages
[adaptive and responsive design]: /ui/adaptive-responsive/

## Set up platform development {:#setup}

While Flutter apps can be built for a variety of [supported platforms][]
with little to no modifications to your code,
your development environment might require additional setup
when targeting a new platform.

To set up development for an additional platform,
select the platform from the following:

<div class="card-grid">
  <a class="card outlined-card" href="/platform-integration/android/setup">
    <div class="card-header">
      <span class="card-title">Target Android</span>
      <span class="card-subtitle">On any device</span>
    </div>
    <div class="card-content">
      <p>Set up your development environment to build Flutter apps for Android.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/ios/setup">
    <div class="card-header">
      <span class="card-title">Target iOS</span>
      <span class="card-subtitle">On macOS only</span>
    </div>
    <div class="card-content">
      <p>Set up your development environment to build Flutter apps for iOS.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/web/setup">
    <div class="card-header">
      <span class="card-title">Target Web</span>
      <span class="card-subtitle">On any device</span>
    </div>
    <div class="card-content">
      <p>Set up your development environment to build Flutter apps for the web.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/windows/setup">
    <div class="card-header">
      <span class="card-title">Target Windows</span>
      <span class="card-subtitle">On Windows only</span>
    </div>
    <div class="card-content">
      <p>Set up your development environment to build Flutter apps for Windows.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/macos/setup">
    <div class="card-header">
      <span class="card-title">Target macOS</span>
      <span class="card-subtitle">On macOS only</span>
    </div>
    <div class="card-content">
      <p>Set up your development environment to build Flutter apps for macOS.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/linux/setup">
    <div class="card-header">
      <span class="card-title">Target Linux</span>
      <span class="card-subtitle">On Linux only</span>
    </div>
    <div class="card-content">
      <p>Set up your development environment to build Flutter apps for Linux.</p>
    </div>
  </a>
</div>

## Integrate with each platform {:#integrate}

If the situation you're trying to solve is not
covered by an existing [Flutter plugin][],
check out the following guides to learn how to
integrate with each of the supported platforms.

[Flutter plugin]: /packages-and-plugins/using-packages#searching-for-packages

### Integrate with Android {:#android}

Learn how to add custom integrations with Android to your Flutter app.

<div class="card-grid">
  <a class="card outlined-card" href="/platform-integration/android/splash-screen">
    <div class="card-header">
      <span class="card-title">Add a splash screen</span>
    </div>
    <div class="card-content">
      <p>Learn how to add a splash screen to your app on Android.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/android/predictive-back">
    <div class="card-header">
      <span class="card-title">Support predictive back</span>
    </div>
    <div class="card-content">
      <p>Learn how to add the predictive back gesture to your app on Android.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/android/call-jetpack-apis">
    <div class="card-header">
      <span class="card-title">Call JetPack APIs</span>
    </div>
    <div class="card-content">
      <p>Learn how the latest Android APIs in your app from Dart.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/android/c-interop">
    <div class="card-header">
      <span class="card-title">Bind to native code</span>
    </div>
    <div class="card-content">
      <p>Learn how to bind to native C code from your app on Android.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/android/platform-views">
    <div class="card-header">
      <span class="card-title">Embed an Android view</span>
    </div>
    <div class="card-content">
      <p>Learn how to host native Android views in your app.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/android/compose-activity">
    <div class="card-header">
      <span class="card-title">Launch a Compose activity</span>
    </div>
    <div class="card-content">
      <p>Learn how to launch a Jetpack Compose activity from your app.</p>
    </div>
  </a>
</div>

### Integrate with iOS {:#ios}

Learn how to add custom integrations with iOS to your Flutter app.

<div class="card-grid">
  <a class="card outlined-card" href="/platform-integration/ios/launch-screen">
    <div class="card-header">
      <span class="card-title">Add a launch screen</span>
    </div>
    <div class="card-content">
      <p>Learn how to add a launch screen to your app on iOS.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/ios/apple-frameworks">
    <div class="card-header">
      <span class="card-title">Leverage system frameworks</span>
    </div>
    <div class="card-content">
      <p>Learn about plugins that support functionality from native iOS frameworks.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/ios/c-interop">
    <div class="card-header">
      <span class="card-title">Bind to native code</span>
    </div>
    <div class="card-content">
      <p>Learn how to bind to native C, Objective-C, and Swift code from your app.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/ios/platform-views">
    <div class="card-header">
      <span class="card-title">Embed an iOS view</span>
    </div>
    <div class="card-content">
      <p>Learn how to host native iOS views in your app.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/ios/app-extensions">
    <div class="card-header">
      <span class="card-title">Add an app extension</span>
    </div>
    <div class="card-content">
      <p>Learn how to add an iOS app extension to your app.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/ios/ios-latest">
    <div class="card-header">
      <span class="card-title">Support new iOS features</span>
    </div>
    <div class="card-content">
      <p>Learn about Flutter's support for new or upcoming iOS features.</p>
    </div>
  </a>
</div>

### Integrate with the web {:#web}

Learn how to add custom integrations with the
web platform to your Flutter app.

<div class="card-grid">
  <a class="card outlined-card" href="/platform-integration/web/initialization">
    <div class="card-header">
      <span class="card-title">Customize app initialization</span>
    </div>
    <div class="card-content">
      <p>Customize how your Flutter app is initialized on the web.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/android/c-interop">
    <div class="card-header">
      <span class="card-title">Bind to native code</span>
    </div>
    <div class="card-content">
      <p>Learn how to bind to native C code from your app on Android.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/web/web-content-in-flutter">
    <div class="card-header">
      <span class="card-title">Embed web content</span>
    </div>
    <div class="card-content">
      <p>Learn how to embed native web content in your app.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/web/embedding-flutter-web">
    <div class="card-header">
      <span class="card-title">Embed your app</span>
    </div>
    <div class="card-content">
      <p>Learn how to embed your Flutter app in another web app.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/web/wasm/">
    <div class="card-header">
      <span class="card-title">Compile to WebAssembly</span>
    </div>
    <div class="card-content">
      <p>Learn how to take advantage of WebAssembly in your Flutter web app.</p>
    </div>
  </a>
  <a class="card outlined-card" href="{{site.dart-site}}/interop/js-interop" target="_blank">
    <div class="card-header">
      <span class="card-title">
        <span>Interop with JavaScript</span>
        <span class="material-symbols" aria-hidden="true" style="font-size: 1rem;" translate="no">open_in_new</span>
      </span>
    </div>
    <div class="card-content">
      <p>Learn how to integrate with JavaScript from your Dart code.</p>
    </div>
  </a>
</div>

### Integrate with Windows {:#windows}

Learn how to add custom integrations with Windows to your Flutter app.

<div class="card-grid">
  <a class="card outlined-card" href="/platform-integration/windows/building/#integrating-with-windows">
    <div class="card-header">
      <span class="card-title">Bind to native code</span>
    </div>
    <div class="card-content">
      <p>Learn how to bind to native C code from your app on Windows.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/windows/building/#distributing-windows-apps">
    <div class="card-header">
      <span class="card-title">Distribute your app</span>
    </div>
    <div class="card-content">
      <p>Learn about different options for distributing your app on Windows.</p>
    </div>
  </a>
  <a class="card outlined-card" href="platform-integration/windows/building#supporting-windows-ui-guidelines">
    <div class="card-header">
      <span class="card-title">Follow Windows UI conventions</span>
    </div>
    <div class="card-content">
      <p>Learn different techniques to integrate with the Windows look and feel.</p>
    </div>
  </a>
</div>

### Integrate with macOS {:#macos}

Learn how to add custom integrations with macOS to your Flutter app.

<div class="card-grid">
  <a class="card outlined-card" href="/platform-integration/macos/c-interop">
    <div class="card-header">
      <span class="card-title">Bind to native code</span>
    </div>
    <div class="card-content">
      <p>Learn how to bind to native C, Objective-C, and Swift code from your app.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/macos/platform-views">
    <div class="card-header">
      <span class="card-title">Embed a macOS view</span>
    </div>
    <div class="card-content">
      <p>Learn how to host native macOS views in your app.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/macos/building#entitlements-and-the-app-sandbox">
    <div class="card-header">
      <span class="card-title">Set up macOS entitlements</span>
    </div>
    <div class="card-content">
      <p>Learn how to enable specific capabilities and services for your app.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/macos/building#integrating-with-macos-look-and-feel">
    <div class="card-header">
      <span class="card-title">Integrate with the macOS visual style</span>
    </div>
    <div class="card-content">
      <p>Learn different techniques to integrate with the macOS look and feel.</p>
    </div>
  </a>
</div>

### Integrate with Linux {:#linux}

Learn how to add custom integrations with Linux to your Flutter app.

<div class="card-grid">
  <a class="card outlined-card" href="/platform-integration/linux/building#integrate-with-linux">
    <div class="card-header">
      <span class="card-title">Bind to native code</span>
    </div>
    <div class="card-content">
      <p>Learn how to use and bind to native Linux libraries and code.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/platform-integration/linux/building#prepare-linux-apps-for-distribution">
    <div class="card-header">
      <span class="card-title">Prepare for distribution</span>
    </div>
    <div class="card-content">
      <p>Prepare your Flutter app for distributing to Linux users.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/deployment/linux/">
    <div class="card-header">
      <span class="card-title">Deploy to the Snap Store</span>
    </div>
    <div class="card-content">
      <p>Learn how to deploy your Linux desktop app to the Snap Store.</p>
    </div>
  </a>
</div>
