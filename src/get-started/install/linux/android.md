---
title: Start building Flutter Android apps on Linux
description: Configure your system to develop Flutter mobile apps on Linux and Android.
short-title: Make Android apps
target: Android
config: LinuxAndroid
devos: Linux
next:
  title: Create a test app
  path: /get-started/test-drive
---

{% include docs/install/reqs/linux/base.md
   os=page.devos
   target=page.target
   -%}

{% include docs/install/flutter-sdk.md
   os=page.devos
   target=page.target
   terminal='Terminal'
   -%}

{% include docs/install/compiler/android.md
   devos=page.devos
   target=page.target
   attempt='first'
   -%}

{% include docs/install/flutter-doctor.md
   devos=page.devos
   target=page.target
   config=page.config
   -%}

{% include docs/install/next-steps.md
   devos=page.devos
   target=page.target
   config=page.config
   -%}
