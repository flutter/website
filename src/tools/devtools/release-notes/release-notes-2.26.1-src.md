# DevTools 2.26.1 release notes

Dart & Flutter DevTools&mdash;A suite of performance tools
for Dart and Flutter

## General updates

- Added a new "Home" screen in DevTools that either shows the "Connect" dialog
  or a summary of your connected app, depending on
  the connection status in DevTools.
  Keep an eye on this screen for cool new features in the future.
  This change also enables support for static tooling
  (tools that don't require a connected app) in DevTools -
  [#6010](https://github.com/flutter/devtools/pull/6010)

  ![home screen]({{site.url}}/tools/devtools/release-notes/images-2.26.1/home_screen.png "DevTools home screen")

- Fixed overlay notifications so that they
  cover the area that their background blocks -
  [#5975](https://github.com/flutter/devtools/pull/5975)

## Memory updates

- Added a context menu to rename or delete a heap snapshot from the list -
  [#5997](https://github.com/flutter/devtools/pull/5997)
- Warn users when HTTP logging may be affecting their app's memory consumption -
  [#5998](https://github.com/flutter/devtools/pull/5998)

## Debugger updates

- Improvements to text selection and copy behavior in
  the code view, console, and variables windows -
  [#6020](https://github.com/flutter/devtools/pull/6020)

## Network profiler updates

- Added a selector to customize the display type
  of text and json responses (thanks to @hhacker1999!) -
  [#5816](https://github.com/flutter/devtools/pull/5816)

## Full commit history

More details about changes and fixes are available from the
[DevTools git log](https://github.com/flutter/devtools/commits/master).
