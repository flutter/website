# DevTools 2.32.0 release notes

The 2.32.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## General updates

* Improved overall usability by making the DevTools UI more dense.
  This significantly improves the user experience when using
  DevTools embedded in an IDE. - [#7030](https://github.com/flutter/devtools/pull/7030)
* Removed the "Dense mode" setting. - [#7086](https://github.com/flutter/devtools/pull/7086)
* Added support for filtering with regular expressions in the
  Logging, Network, and CPU profiler pages - [#7027](https://github.com/flutter/devtools/pull/7027)
* Add a DevTools server interaction for getting the DTD uri. - [#7054](https://github.com/flutter/devtools/pull/7054)

## Memory updates

* Supported allocation tracing for Flutter profile builds and
  Dart AOT compiled applications. - [#7058](https://github.com/flutter/devtools/pull/7058)
* Supported import of memory snapshots. - [#6974](https://github.com/flutter/devtools/pull/6974)

## Debugger updates

* Highlighted `extension type` as a declaration keyword,
  highlight the `$` in identifier interpolation as part of the interpolation,
  and properly highlight comments within type arguments. - [#6837](https://github.com/flutter/devtools/pull/6837)

## Logging updates

* Added toggle filters to filter out noisy Flutter and Dart logs - [#7026](https://github.com/flutter/devtools/pull/7026)

    ![Logging view filters](/tools/devtools/release-notes/images-2.32.0/logging_toggle_filters.png "Toggle filters for logging screen")

* Added a scrollbar to the details pane. - [#6917](https://github.com/flutter/devtools/pull/6917)

## DevTools extension updates

* Added a description and documentation link to the `devtools_options.yaml` file
  that is created in a user's project. - [#7052](https://github.com/flutter/devtools/pull/7052)
* Updated the Simulated DevTools Environment Panel to be collapsible
  (thanks to @victoreronmosele!) - [#7062](https://github.com/flutter/devtools/pull/7062)
* Integrated DevTools extensions with the new Dart Tooling Daemon.
  This will allow DevTools extensions to access public methods registered by
  other DTD clients, such as an IDE, as well as access a minimal file system API
  for interacting with the development project. - [#7108](https://github.com/flutter/devtools/pull/7108)

## VS Code sidebar updates

* Fixed an issue that prevented the VS code sidebar from
  loading in recent `beta` and `main` builds. - [#6984](https://github.com/flutter/devtools/pull/6984)
* Showed DevTools extensions as an option from the
  debug sessions DevTools dropdown, when available. [#6709](https://github.com/flutter/devtools/pull/6709)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.32.0).
