---
title: Add Linux devtools to Flutter from Android start
description: Configure your system to develop Flutter mobile apps also on Linux.
short-title: When you started with Android
---

To add Linux desktop as a Flutter app target, follow this procedure.

## Install Linux compilation tools

1. Allocate a minimum of 5 GB of storage for the Linux compiliation tools.

{% include docs/install/reqs/linux/install-desktop-tools.md
devos='Linux' target='desktop' %}

{% include docs/install/flutter-doctor.md
   target='Linux'
   devos='Linux'
   config='LinuxDesktopAndroid' %}
