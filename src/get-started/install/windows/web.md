---
title: Start building Flutter web apps on Windows
description: Configure your system to develop Flutter web apps on Windows.
short-title: Web app
target: web
config: WindowsWeb
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

{% include docs/install/flutter-doctor.md
   devos=page.devos
   target=page.target config='WindowsWeb'

   -%}

{% include docs/install/next-steps.md
   devos=page.devos
   target=page.target
   config=page.config
   -%}
