# DevTools 2.9.1 release notes

The 2.9.1 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## Debugger updates

* Improve support for inspecting large lists and maps in
  the Debugger variables pane - [#3497](https://github.com/flutter/devtools/pull/3497)

  ![Inspection before](/tools/devtools/release-notes/images-2.9.1/image1.png "Inspection before")

  ![Inspection after](/tools/devtools/release-notes/images-2.9.1/image2.png "Inspection after")

* Added support for selecting objects in the program explorer outline view.
  Selecting an object will automatically scroll the source code
  in the debugger to the selected object -
  [#3480](https://github.com/flutter/devtools/pull/3480)

## Performance updates

* Fix bugs with performance page search and improve performance -
  [#3515](https://github.com/flutter/devtools/pull/3515)
* Added an enhanced tooltip for flutter frames -
  [#3493](https://github.com/flutter/devtools/pull/3493)

  ![Flutter frame tooltips](/tools/devtools/release-notes/images-2.9.1/image3.png "Flutter frame tooltips")

## Full commit history

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.8.0...v2.9.1).
