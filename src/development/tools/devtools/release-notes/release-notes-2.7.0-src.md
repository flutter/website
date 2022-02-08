# DevTools 2.7.0 release notes

Dart & Flutter DevTools - A Suite of Performance Tools for Dart and Flutter

## General Updates

* Improvements for initial page load time -
  [#3309](https://github.com/flutter/devtools/pull/3309)
* Fix a couple scrollbar-related issues -
  [#3393](https://github.com/flutter/devtools/pull/3393),
  [#3401](https://github.com/flutter/devtools/pull/3401)

## Debugger Updates
* Add an open file dialog (ctrl / cmd + p) -
  [#3342](https://github.com/flutter/devtools/pull/3342),
  [#3354](https://github.com/flutter/devtools/pull/3354),
  [#3371](https://github.com/flutter/devtools/pull/3371),
  [#3384](https://github.com/flutter/devtools/pull/3384)

![Open file dialog]({{site.url}}/development/tools/devtools/release-notes/images-2.7.0/image1.gif "Open file dialog")

* Add a copy button to the call stack view -
  [#3334](https://github.com/flutter/devtools/pull/3334)

![Call stack view]({{site.url}}/development/tools/devtools/release-notes/images-2.7.0/image2.png "Call stack view")

## CPU Profiler Updates

* Added functionality to load an app startup profile for Flutter apps.
  This profile will contain CPU samples from the initialization
  of the Dart VM up until the first Flutter frame has been rendered. -
  [#3357](https://github.com/flutter/devtools/pull/3357)

![Profile button]({{site.url}}/development/tools/devtools/release-notes/images-2.7.0/image3.png "Profile button")

When the app startup profile has been loaded,
you will see that the "AppStartUp" user tag is selected for the profile.
You can also load the app startup profile
by selecting this user tag filter, when present,
in the list of available user tags.

![User tag example]({{site.url}}/development/tools/devtools/release-notes/images-2.7.0/image4.png "User tag examplel")

* Added multi-isolate support.
  Select which isolate you want to profile
  from the isolate selector at the bottom of the page. -
  [#3362](https://github.com/flutter/devtools/pull/3362)

![isolate selector]({{site.url}}/development/tools/devtools/release-notes/images-2.7.0/image5.png "isolate selector")

* Add class names to CPU stack frames in the profiler -
  [#3385](https://github.com/flutter/devtools/pull/3385)

![Class names]({{site.url}}/development/tools/devtools/release-notes/images-2.7.0/image6.png "Class names")

## Changelog

More details about changes and fixes are available in our [changelog][].

[changelog]: https://github.com/flutter/devtools/blob/master/CHANGELOG.md
