---
title: Start building Flutter Android apps on macOS
description: Configure your system to develop Flutter mobile apps on macOS and Android.
short-title: macOS Android development
target: Android
config: macOSAndroid
devos: macOS
next:
  title: Create a test app
  path: /get-started/test-drive
---

{% include docs/install/reqs/macos/base.md target=page.target os=page.devos -%}

{% include docs/install/flutter-sdk.md target=page.target os=page.devos terminal='Terminal' -%}

{% include docs/install/compiler/android.md target=page.target os=page.devos -%}

{% include docs/install/flutter-doctor.md target=page.target devos=page.devos compiler='Android Studio' config=page.config -%}

{% include docs/install/next-steps.md devos=page.devos target=page.target config=page.config -%}
