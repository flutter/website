---
title: What's new archive
description: An archive of what's new on the site.
---

This archive contains current and previous announcements of what's new on the
site.

To stay on top of Flutter announcements, including breaking changes, join the
[flutter-announce][] Google group.

## **July 9, 2019**

Flutter 1.7 is live!

For more information, see [Announcing Flutter
1.7]({{site.flutter-medium}}/announcing-flutter-1-7-9cab4f34eacf)
on the [Flutter Medium Publication]({{site.flutter-medium}}),
and the [1.7.8 release
notes]({{site.github}}/flutter/flutter/wiki/Release-Notes-Flutter-1.7.8)
on the [Flutter wiki]({{site.github}}//flutter/flutter/wiki).

New and updated docs on the site include:

* The [Preparing an Android app for release](/docs/deployment/android)
  page is updated to discuss how to build an Android release
  using an app bundle, as well as how to create separate APK
  files for both 32-bit and 64-bit devices.
* The [DevTools](/docs/development/tools/devtools) docs are migrated
  to flutter.dev. If you haven't tried this browser-based suite
  of debugging, performance, memory, and inspection tools that
  work with both Flutter and Dart apps and can be launched from
  Android Studio/IntelliJ _and_ VS Code, please check it out!
* The [Simple app state
  management](/docs/development/data-and-backend/state-mgmt/simple)
  page is updated. The example code in the page now uses the 3.0
  release of the Provider package.
* A new animation recipe, [Animate a page route
  transition](/docs/cookbook/animation/page-route-animation)
  has been added to the [Cookbook](/docs/cookbook).
* The [Debugging](/docs/testing/debugging), 
  [Flutter's build modes](/docs/testing/build-modes),
  [Performance best practices](/docs/testing/best-practices), and
  [Performance profiling](/docs/testing/ui-performance)
  pages are updated to reflect DevTools. A
  [Debugging apps programmatically](/docs/testing/code-debugging)
  page has also been added.

The Flutter 1.7 release includes the new
[RangeSlider]({{site.api}}/flutter/material/RangeSlider-class.html)
component, which allows the user to select both the upper and lower
endpoints in a range of values. For information about this
component and how to customize it, see [Material RangeSlider in
Flutter]({{site.flutter-medium}}/material-range-slider-in-flutter-a285c6e3447d).

## **May 7, 2019, Google I/O Edition**

[Flutter 1.5](https://developers.googleblog.com/2019/05/Flutter-io19.html)
is live!

For more information on updates, see the [release
notes](https://github.com/flutter/flutter/wiki/Release-Notes-Flutter-1.5.4)
or [download the release](/docs/development/tools/sdk/archive).

We are updating DartPad to work with Flutter. Try our new
[Basic Flutter layout codelab](/docs/codelabs/layout-basics)
and tell us what you think!

## **February 26, 2019**

Flutter released [version
1.2](https://developers.googleblog.com/2019/02/launching-flutter-12-at-mobile-world.html)
at Mobile World Congress (MWC) in Barcelona. For more information,
see the [release
notes](https://github.com/flutter/flutter/wiki/Release-Notes---Flutter-1.2.1)
or [download the release](/docs/development/tools/sdk/archive).

In addition, here are some recent new and updated docs:

* We've updated our [state management
  advice](/docs/development/data-and-backend/state-mgmt/intro).
  New pages include an
  [introduction](/docs/development/data-and-backend/state-mgmt/intro),
  [thinking
  declaratively](/docs/development/data-and-backend/state-mgmt/declarative),
  [ephemeral vs app
  state](/docs/development/data-and-backend/state-mgmt/ephemeral-vs-app),
  [simple app state
  management](/docs/development/data-and-backend/state-mgmt/simple),
  and [different state management
  options](/docs/development/data-and-backend/state-mgmt/options).
  Documenting state management is a tricky thing, as there is no
  one-size-fits-all approach. We'd love your feedback on these new docs!
* A new page on [Performance best practices](/docs/testing/best-practices).
* Also at MWC, we announced a preview version of the new Dart DevTools
  for profiling and debugging Dart and Flutter apps.
  You can find the docs on the DevTools wiki (Note: since moved to
  [this site](/docs/development/tools/devtools).)
  In particular, check out the DevTool's [widget inspector][] for
  debugging your UI, or the [timeline view][] for profiling your Flutter
  application. Try them out and let us know what you think!
* An update to the [Performance profiling](/docs/testing/ui-performance)
  page that incorporates the new Dart DevTools UI.
* Updates to the [Android
  Studio/IntelliJ](/docs/development/tools/android-studio)
  and [VS Code](/docs/development/tools/vs-code) pages incorporating info from
  the new Dart DevTools UI.

If you have questions or comments about any of these docs, [file an
issue]({{site.repo.this}}/issues).

[widget inspector]: /docs/development/tools/devtools/inspector
[timeline view]: /docs/development/tools/devtools/timeline

## **November 5, 2018**

Welcome to the revamped Flutter website!

We've spent the last few months redesigning the website and how its
information is organized. We hope you can more easily find the docs
you are looking for. Some of the changes to the website include:

* Revised [front](/) page
* Revised [showcase](/showcase) page
* Revised [community](/community) page
* Revised navigation in the left side bar
* Table of contents on the right side of most pages

Some of the new content includes:

* Deep dive on Flutter internals,
  [Inside Flutter](/docs/resources/inside-flutter)
* [Technical videos](/docs/resources/videos)
* [State management](/docs/development/data-and-backend/state-mgmt)
* [Background Dart
  processes](/docs/development/packages-and-plugins/background-processes)
* [Flutter's build modes](/docs/testing/build-modes)
{% comment %}
* How to connect [a native debugger _and_
  a Dart debugger to your app](/docs/testing/oem-debuggers)
  (not yet complete)
{% endcomment %}

If you have questions or comments about the revamped site, [file an
issue]({{site.repo.this}}/issues).


[flutter-announce]: https://groups.google.com/forum/#!forum/flutter-announce
