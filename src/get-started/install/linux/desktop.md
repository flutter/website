---
title: Start building Flutter native desktop apps on Linux
description: Configure your system to develop Flutter desktop apps on Linux.
short-title: Make Linux desktop apps
target: desktop
config: LinuxDesktop
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
