# DevTools 2.14.0 release notes

The 2.14.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## General updates

* Added a link to the new DevTools
  [Discord channel](https://discord.com/channels/608014603317936148/958862085297672282)
  in the About DevTools dialog -
  [#4102](https://github.com/flutter/devtools/pull/4102)

  ![about-devtools](/tools/devtools/release-notes/images-2.14.0/image1.png "about devtools")

## Network updates

* Added "Copy as URL" and "Copy as cURL" actions for
  selected requests in the network profiler
  (special thanks to [@jankuss](https://github.com/jankuss)!) -
  [#4113](https://github.com/flutter/devtools/pull/4113)

  ![network-request-copy-actions](/tools/devtools/release-notes/images-2.14.0/image2.png "network request copy actions")

## Flutter inspector updates

* Added a setting to control whether hovering over a widget
  in the inspector displays its properties and values in a hover card -
  [#4090](https://github.com/flutter/devtools/pull/4090)

## Debugger updates

* Added auto complete suggestions in the console
  (special thanks to [@jankuss](https://github.com/jankuss)!) -
  [#4062](https://github.com/flutter/devtools/pull/4062)

  ![auto-complete-suggestions](/tools/devtools/release-notes/images-2.14.0/image3.png "auto complete suggestions")

* Added the option to copy the full file path for a selected library -
  [#4147](https://github.com/flutter/devtools/pull/4147)
* Fixed formatting in the debugger exception menu -
  [#4066](https://github.com/flutter/devtools/pull/4066)

## Memory updates

* Fixed formatting for memory values in the heap tree view -
  [#4153](https://github.com/flutter/devtools/pull/4153)
* Fixed a bug that was preventing GC events from
  showing up in the memory chart -
  [#4131](https://github.com/flutter/devtools/pull/4131)

## Performance updates

* Warn users that the rendering layer toggles in the
  "More Debugging Options" menu are not available for profile mode apps -
  [#4075](https://github.com/flutter/devtools/pull/4075)

## Full commit history

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.13.1...v2.14.0).
