# DevTools 2.7.0 release notes

The 2.7.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools).

## General updates

* Improvements for initial page load time -
  [#3309](https://github.com/flutter/devtools/pull/3309)
* Fix a couple scrollbar-related issues -
  [#3393](https://github.com/flutter/devtools/pull/3393),
  [#3401](https://github.com/flutter/devtools/pull/3401)

## Debugger updates

* Add an open file dialog (ctrl / cmd + p) -
  [#3342](https://github.com/flutter/devtools/pull/3342),
  [#3354](https://github.com/flutter/devtools/pull/3354),
  [#3371](https://github.com/flutter/devtools/pull/3371),
  [#3384](https://github.com/flutter/devtools/pull/3384)

  ![Open file dialog](/tools/devtools/release-notes/images-2.7.0/image1.gif "Open file dialog")

* Add a copy button to the call stack view -
  [#3334](https://github.com/flutter/devtools/pull/3334)

  ![Call stack view](/tools/devtools/release-notes/images-2.7.0/image2.png "Call stack view")

## CPU profiler updates

* Added functionality to load an app startup profile for Flutter apps.
  This profile will contain CPU samples from the initialization
  of the Dart VM up until the first Flutter frame has been rendered -
  [#3357](https://github.com/flutter/devtools/pull/3357)

  ![Profile button](/tools/devtools/release-notes/images-2.7.0/image3.png "Profile button")

  When the app startup profile has been loaded,
  you will see that the "AppStartUp" user tag is selected for the profile.
  You can also load the app startup profile
  by selecting this user tag filter, when present,
  in the list of available user tags.
  
  ![User tag example](/tools/devtools/release-notes/images-2.7.0/image4.png "User tag example")

* Added multi-isolate support.
  Select which isolate you want to profile
  from the isolate selector at the bottom of the page -
  [#3362](https://github.com/flutter/devtools/pull/3362)

  ![isolate selector](/tools/devtools/release-notes/images-2.7.0/image5.png "isolate selector")

* Add class names to CPU stack frames in the profiler -
  [#3385](https://github.com/flutter/devtools/pull/3385)

  ![Class names](/tools/devtools/release-notes/images-2.7.0/image6.png "Class names")

## Full commit history

To find a complete list of changes since the previous release,
check out 
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.6.0...v2.7.0).
