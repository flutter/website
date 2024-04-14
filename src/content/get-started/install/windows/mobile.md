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

{% render docs/install/reqs/windows/base.md, os:devos, target:target -%}

{% render docs/install/flutter-sdk.md, os:devos, target:target, terminal:'PowerShell' -%}

{% render docs/install/compiler/android.md, devos:devos, target:target, attempt:'first' -%}

{% render docs/install/flutter-doctor.md, devos:devos, target:target, config:config -%}

{% render docs/install/next-steps.md, devos:devos, target:target, config:config -%}
