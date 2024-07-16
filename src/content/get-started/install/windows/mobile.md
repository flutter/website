---
title: Start building Flutter Android apps on Windows
description: Configure your system to develop Flutter mobile apps on Windows.
short-title: Make Android apps
target: Android
config: WindowsAndroid
devos: Windows
next:
  title: Create a test app
  path: /get-started/test-drive
---

{% include docs/install/reqs/windows/base.md os=devos target=target %}

{% include docs/install/flutter-sdk.md os=devos target=target terminal='PowerShell' -%}

{% include docs/install/compiler/android.md devos=devos target=target attempt='first' %}

{% include docs/install/flutter-doctor.md devos=devos target=target config=config %}

{% include docs/install/next-steps.md devos=devos target=target config=config %}
