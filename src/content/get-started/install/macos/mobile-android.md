---
title: Start building Flutter Android apps on macOS
description: Configure your system to develop Flutter mobile apps on macOS and Android.
short-title: Make Android apps
target: Android
config: macOSAndroid
devos: macOS
next:
  title: Create a test app
  path: /get-started/test-drive
---

{% render docs/install/reqs/macos/base.md, os:devos, target:target -%}

{% render docs/install/flutter-sdk.md, os:devos, target:target, terminal:'Terminal' -%}

{% render docs/install/compiler/android.md, devos:devos, target:target, attempt:'first' -%}

{% render docs/install/flutter-doctor.md, devos:devos, target:target, config:config -%}

{% render docs/install/next-steps.md, devos:devos, target:target, config:config -%}
