# DevTools 2.42.0 release notes

The 2.42.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).

## General updates

* Added "View licenses" shortcut to the About dialog. - [#8610](https://github.com/flutter/devtools/pull/8610)

## Inspector updates

* Enabled the new inspector by default. This can be disabled in the inspector settings. - [#8650](https://github.com/flutter/devtools/pull/8650)
    ![Legacy inspector setting](/tools/devtools/release-notes/images-2.42.0/legacy_inspector_setting.png "Legacy inspector setting")
* Fixed an issue where selecting an implementation widget on the device while implementation widgets were hidden in the [new inspector](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.40.1#inspector-updates) showed an error. - [#8625](https://github.com/flutter/devtools/pull/8625)
* Enabled auto-refreshes of the widget tree on hot-reloads and navigation events by default. This can be disabled in the inspector settings. - [#8646](https://github.com/flutter/devtools/pull/8646)
    ![Auto-refresh setting](/tools/devtools/release-notes/images-2.42.0/inspector_auto_refresh_setting.png "Inspector auto-refresh setting")

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.42.0).