---
title: Add Android as a target platform for Flutter from Web on ChromeOS start
description: Configure your ChromeOS system to develop Flutter mobile apps for Android.
short-title: Starting from Web on ChromeOS
---

To add Android as a Flutter app target for ChromeOS, follow this procedure.

## Install Android Studio

1. Allocate a minimum of 7.5 GB of storage for Android Studio.
   Consider allocating 10 GB of storage for an optimal configuration.

1. Install the following prerequisite packages for Android Studio:

    ```console
    $ sudo apt-get install libc6:amd64 libstdc++6:amd64 lib32z1 libbz2-1.0:amd64
    ```

1. Install [Android Studio][] {{site.appmin.android_studio}} or later
   to debug and compile Java or Kotlin code for Android.
   Flutter requires the full version of Android Studio.

{% include docs/install/compiler/android.md target='linux' devos='ChromeOS' attempt="first" -%}

{% include docs/install/flutter-doctor.md target='Android' devos='ChromeOS' config='ChromeOSAndroidWeb' %}

[Android Studio]: https://developer.android.com/studio/install#linux
