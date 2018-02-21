---
layout: page
title: "Get Started: Setup Flutter"
permalink: /get-started/setup-flutter/
---

This page describes how to setup your development environment to run Flutter
apps.

<ul class="ostabs__top-bar">
    <li class="ostab-link current" data-tab="tab-os-install-windows">Windows</li>
    <li class="ostab-link" data-tab="tab-os-install-mac">Mac</li>
    <li class="ostab-link" data-tab="tab-os-install-linux">Linux</li>
</ul>


<div id="tab-os-install-windows" class="ostabs__content current" markdown="1">

## Download and install Flutter SDK

* Download the latest [*not ready yet*]().
* Install the downloaded SDK:
  * In Windows Explorer, navigate to 'Downloads'
  * Double click `flutter-sdk.zip`
  * Click Extract
  * Place the extracted files in your desired directory

{% include /get-started/privacy_note.md %}

{% include /get-started/android_setup.md %}

## iOS setup

Running Flutter app on iOS is unfortunately not supported on Windows.

</div>

<div id="tab-os-install-mac" class="ostabs__content" markdown="1">

## Download and install Flutter SDK

* Download the latest [beta SDK archive](https://storage.googleapis.com/flutter_infra/releases/dev/macos/flutter_macos_v0.1.2-dev.tar.xz).
* Install the downloaded SDK:
```terminal
cd /users/Obiwan/development/
tar -xf /users/Obiwan/downloads/flutter_macos_v0.1.2-dev.tar.xz
cd flutter
export PATH=`pwd`/flutter/bin:$PATH
```

{% include /get-started/privacy_note.md %}

{% include /get-started/android_setup.md %}

{% include setup/ios-setup.md %}

</div>

<div id="tab-os-install-linux" class="ostabs__content" markdown="1">

## Download and install Flutter SDK

* Download the latest [beta SDK archive](https://storage.googleapis.com/flutter_infra/releases/dev/macos/flutter_linux_v0.1.2-dev.tar.xz).
* Install the downloaded SDK:
```terminal
cd /users/Obiwan/development/
tar -xf /users/Obiwan/downloads/flutter_linux_v0.1.2-dev.tar.xz
cd flutter
export PATH=`pwd`/flutter/bin:$PATH
```

{% include /get-started/privacy_note.md %}

{% include /get-started/android_setup.md %}

## iOS setup

Running Flutter app on iOS is unfortunately not supported on Linux.

</div>

## Next step

Now that you have the Flutter framework setup, select an editor.

[Next step: Setup Editor](/get-started/setup-editor/)

