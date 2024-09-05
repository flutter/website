# DevTools 2.28.1 release notes

The 2.28.1 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## General updates

* Added support for DevTools extensions.
  This means if you are debugging an app that depends on `package:foo`,
  and `package:foo` provides a DevTools extension,
  you will see a "Foo" tab display in DevTools
  that you can use to debug your app.
  To provide a DevTools extension for your pub package,
  check out the getting started guide for
  [package:devtools_extensions](https://pub.dev/packages/devtools_extensions)!

![Example DevTools extension](/tools/devtools/release-notes/images-2.28.1/example_devtools_extension.png "Example DevTools extension for package:foo_package")

* Fixed theming bug in isolate selector -
  [#6403](https://github.com/flutter/devtools/pull/6403)
* Fixed isolate bug where main isolate was not reselecting on hot restart -
  [#6436](https://github.com/flutter/devtools/pull/6436)
* Show the hot reload button for Dart server apps that support hot reload -
  [#6341](https://github.com/flutter/devtools/pull/6341)
* Fixed exceptions on hot restart -
  [#6451](https://github.com/flutter/devtools/pull/6451),
  [#6450](https://github.com/flutter/devtools/pull/6450)

## Inspector updates

* Fixed bug where inspector service calls were done on the selected isolate,
  instead of the main isolate -
  [#6434](https://github.com/flutter/devtools/pull/6434)

## Logging updates

* Improved responsiveness of the top bar on the Logging view -
  [#6281](https://github.com/flutter/devtools/pull/6281)

* Added the ability to copy filtered logs -
  [#6260](https://github.com/flutter/devtools/pull/6260)

  ![The copy button on the Logging view to the right of the filter tool](/tools/devtools/release-notes/images-2.28.1/logger_copy.png "The Logging view copy button")

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.28.1).
