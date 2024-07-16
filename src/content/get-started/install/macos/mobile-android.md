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

{% include docs/install/reqs/macos/base.md os=devos target=target %}

{% include docs/install/flutter-sdk.md os=devos target=target terminal='Terminal' %}

{% include docs/install/compiler/android.md devos=devos target=target attempt='first' %}

{% include docs/install/flutter-doctor.md devos=devos target=target config=config %}

{% include docs/install/next-steps.md devos=devos target=target config=config %}
