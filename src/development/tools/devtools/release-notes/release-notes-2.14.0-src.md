# DevTools 2.14.0 release notes

Dart & Flutter DevTools - A Suite of Performance Tools for Dart and Flutter

## General Updates
* Added a link to the new DevTools [Discord channel](https://discord.com/channels/608014603317936148/958862085297672282)
in the About DevTools dialog - [#4102](https://github.com/flutter/devtools/pull/4102)

![about-devtools]({{site.url}}/development/tools/devtools/release-notes/images-2.14.0/image1.png "about devtools")

## Network Updates
* Added "Copy as URL" and "Copy as cURL" actions for selected requests in the network profiler (special thanks to
[@jankuss](https://github.com/jankuss)!)- [#4113](https://github.com/flutter/devtools/pull/4113)

![network-request-copy-actions]({{site.url}}/development/tools/devtools/release-notes/images-2.14.0/image2.png "network request copy actions")

## Flutter Inspector Updates
* Added a setting to control whether hovering over a widget in the inspector displays its properties and values in a
hover card - [#4090](https://github.com/flutter/devtools/pull/4090)

## Debugger Updates
* Added auto complete suggestions in the console (special thanks to [@jankuss](https://github.com/jankuss)!) - 
[#4062](https://github.com/flutter/devtools/pull/4062)

![auto-complete-suggestions]({{site.url}}/development/tools/devtools/release-notes/images-2.14.0/image3.png "auto complete suggestions")

* Added the option to copy the full file path for a selected library - [#4147](https://github.com/flutter/devtools/pull/4147)
* Fixed formatting in the debugger exception menu - [#4066](https://github.com/flutter/devtools/pull/4066)

## Memory Updates
* Fixed formatting for memory values in the heap tree view - [#4153](https://github.com/flutter/devtools/pull/4153)
* Fixed a bug that was preventing GC events from showing up in the memory chart - 
[#4131](https://github.com/flutter/devtools/pull/4131)

## Performance Updates
* Warn users that the rendering layer toggles in the "More Debugging Options" menu are not available for profile mode 
apps - [#4075](https://github.com/flutter/devtools/pull/4075)

## Changelog
More details about changes and fixes are available in our
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md).
