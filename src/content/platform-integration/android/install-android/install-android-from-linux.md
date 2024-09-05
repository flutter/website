---
title: Add Android as a target platform for Flutter from Linux start
description: Configure your Mac to develop Flutter mobile apps for Android.
short-title: Starting from Linux desktop
---

To add Android as a Flutter app target for Linux, follow this procedure.

## Install Android Studio

1. Allocate a minimum of 7.5 GB of storage for Android Studio.
   Consider allocating 10 GB of storage for an optimal configuration.

1. Install the following prequisite packages for Android Studio:
    `libc6:i386`, `libncurses5:i386`, `libstdc++6:i386`, `lib32z1`, `libbz2-1.0:i386`

    ```console
    $ sudo apt-get install \
        libc6:i386 libncurses5:i386 \
        libstdc++6:i386 lib32z1 \
        libbz2-1.0:i386
    ```

1. Install [Android Studio][] {{site.appmin.android_studio}} or later
   to debug and compile Java or Kotlin code for Android.
   Flutter requires the full version of Android Studio.

{% include docs/install/compiler/android.md target='linux' devos='Linux' attempt='first' %}

{% include docs/install/flutter-doctor.md target='Android' devos='Linux' config='LinuxDesktopAndroid' %}

[Android Studio]: https://developer.android.com/studio/install#linux
