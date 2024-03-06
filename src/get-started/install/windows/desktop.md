---
title: Start building Flutter native desktop apps on Windows
description: Configure your system to develop Flutter desktop apps on Windows.
short-title: Windows Desktop app
target: desktop
config: WindowsDesktop
devos: Windows
next:
  title: Create a test app
  path: /get-started/test-drive
---

{% include docs/install/reqs/windows/base.md target=page.target os=page.devos -%}

{% include docs/install/flutter-sdk.md target=page.target os=page.devos terminal='PowerShell' -%}

{% include docs/install/flutter-doctor.md target=page.target devos=page.devos platform=page.target compiler='Visual Studio' config=page.config -%}

{% include docs/install/next-steps.md devos=page.devos target=page.target config=page.config -%}
