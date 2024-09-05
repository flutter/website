# DevTools 2.30.0 release notes

The 2.30.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## Performance updates

* Add an indicator of the rendering engine to the Flutter Frames chart. -
  [#6771](https://github.com/flutter/devtools/pull/6771)

  ![Flutter rendering engine text](/tools/devtools/release-notes/images-2.30.0/flutter_frames_engine_text.png "Text describing the current flutter rendering engine")

* Improve messaging when we do not have analysis data available for a
  Flutter frame. - [#6768](https://github.com/flutter/devtools/pull/6768)

## VS Code Sidebar updates

* The Flutter Sidebar provided to VS Code now has the ability to enable new
  platforms if a device is available for a platform that is not enabled for
  the current project. This also requires a corresponding Dart extension for
  VS Code update to appear. - [#6688](https://github.com/flutter/devtools/pull/6688)

* The DevTools menu in the sidebar now has an entry "Open in Browser"
  that opens DevTools in an external browser window even when VS Code settings
  are set to usually use embedded DevTools. - [#6736](https://github.com/flutter/devtools/pull/6736)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.30.0).
