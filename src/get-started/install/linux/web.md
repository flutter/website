---
title: Start building Flutter web apps on Linux
description: Configure your system to develop Flutter web apps on Linux.
short-title: Make web apps
target: Web
config: LinuxWeb
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
   terminal='a shell'
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
