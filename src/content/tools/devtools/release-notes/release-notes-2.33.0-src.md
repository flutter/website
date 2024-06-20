# DevTools 2.33.0 release notes

The 2.33.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools).

## General updates

* Improved overall usability by making the DevTools UI more dense.
  This significantly improves the user experience when using
  DevTools embedded in an IDE. - [#7030](https://github.com/flutter/devtools/pull/7030)
* Removed the "Dense mode" setting. - [#7086](https://github.com/flutter/devtools/pull/7086)
* Added support for filtering with regular expressions in
  the Logging, Network, and CPU profiler pages. - [#7027](https://github.com/flutter/devtools/pull/7027)
* Add a DevTools server interaction for getting the DTD URI. - [#7054](https://github.com/flutter/devtools/pull/7054), [#7164](https://github.com/flutter/devtools/pull/7164)
* Enabled expression evaluation with scope for the web,
  allowing evaluation of inspected widgets. - [#7144](https://github.com/flutter/devtools/pull/7144)
* Update `package:vm_service` constraint to `^14.0.0`. - [#6953](https://github.com/flutter/devtools/pull/6953)
* Onboarding DevTools to [`package:unified_analytics`](https://pub.dev/packages/unified_analytics) for
  unified telemetry logging across Flutter and Dart tooling. - [#7084](https://github.com/flutter/devtools/pull/7084)

## Debugger updates

* Fixed off by one error causing profiler hits to be
  rendered on the wrong lines. - [#7178](https://github.com/flutter/devtools/pull/7178)
* Improved contrast of line numbers when
  displaying code coverage hits in dark mode. - [#7178](https://github.com/flutter/devtools/pull/7178)
* Improved contrast of profiling details when
  displaying profiler hits in dark mode. - [#7178](https://github.com/flutter/devtools/pull/7178)
* Fixed syntax highlighting for comments when
  the source file uses `\r\n` line endings [#7190](https://github.com/flutter/devtools/pull/7190)
* Re-establish breakpoints after a hot-restart. - [#7205](https://github.com/flutter/devtools/pull/7205)

## VS Code Sidebar updates

* Do not show DevTools release notes in the Flutter sidebar. - [#7166](https://github.com/flutter/devtools/pull/7166)

## DevTools Extension updates

* Added support for connecting to the Dart Tooling Daemon from
  the simulated DevTools environment. - [#7133](https://github.com/flutter/devtools/pull/7133)
* Added help buttons to the VM Service and DTD connection text fields in
  the simulated DevTools environment. - [#7133](https://github.com/flutter/devtools/pull/7133)
* Fixed an issue with not detecting extensions for
  test files in subdirectories. - [#7174](https://github.com/flutter/devtools/pull/7174)
* Added an example of creating an extension for a pure Dart package. - [#7196](https://github.com/flutter/devtools/pull/7196)
* Updated the `README.md` and `example/README.md` with
  more complete documentation. - [#7237](https://github.com/flutter/devtools/pull/7237), [#7261](https://github.com/flutter/devtools/pull/7261)
* Added a `devtools_extensions validate` command to
  validate extension requirements during development. - [#7257](https://github.com/flutter/devtools/pull/7257)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.33.0).
