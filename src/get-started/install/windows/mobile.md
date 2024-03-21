---
title: Start building Flutter Android apps on Windows
description: Configure your system to develop Flutter mobile apps on Windows.
short-title: Make Android apps
target: mobile
config: WindowsAndroid
devos: Windows
next:
  title: Create a test app
  path: /get-started/test-drive
---

{% include docs/install/reqs/windows/base.md
   os=page.devos
   target=page.target
   -%}

{% include docs/install/flutter-sdk.md
   os=page.devos
   target=page.target
   terminal='PowerShell'
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
