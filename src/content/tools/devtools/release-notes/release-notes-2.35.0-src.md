# DevTools 2.35.0 release notes

The 2.35.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview]({{site.url}}/tools/devtools/overview).

## General updates

* Changed to a single button for starting and stopping
  recording on the Network screen and CPU profiler screen. - [#7573](https://github.com/flutter/devtools/pull/7573)
  
  ![A screen shot of the CPU profiler tab, with the new recording button.](/tools/devtools/release-notes/images-2.35.0/profiler_recording.png)
  ![A screen shot of the network tab, with the new recording button.](/tools/devtools/release-notes/images-2.35.0/network_recording.png)

## Inspector updates

* Add a preference for the default inspector view - [#6949](https://github.com/flutter/devtools/pull/6949)

## Memory updates

* Replaced total size with reachable size in snapshot list. - [#7493](https://github.com/flutter/devtools/pull/7493)

## Debugger updates

* During a hot-restart, `pause_isolates_on_start` and only
  `resume` the app once breakpoints are set. - [#7234](https://github.com/flutter/devtools/pull/7234)

## Network profiler updates

* Added text selection in text viewer for requests and responses. - [#7596](https://github.com/flutter/devtools/pull/7596)
* Added a JSON copy experience to the JSON viewer. - [#7596](https://github.com/flutter/devtools/pull/7596)
  
  ![The new JSON copy experience in the JSON viewer](/tools/devtools/release-notes/images-2.35.0/json_viewer_copy.png)
  
* Fixed a bug where stopping and starting network recording listed requests that
  happened while not recording. - [#7626](https://github.com/flutter/devtools/pull/7626)

## Deep links tool updates

* Improve layout for narrow screens. - [#7524](https://github.com/flutter/devtools/pull/7524)
* Add error handling for missing schemes and domains - [#7559](https://github.com/flutter/devtools/pull/7559)

## VS Code Sidebar updates

* Added a DevTools section with a list of tools and extensions that
  are available without a debug session. -
  [#7598](https://github.com/flutter/devtools/pull/7598), [#7604](https://github.com/flutter/devtools/pull/7604)

## DevTools Extension updates

* Support DevTools extensions that do not require a running app, and
  detect them from the user's IDE workspace. - [#7612](https://github.com/flutter/devtools/pull/7612)
* Deprecate the `DevToolsExtension.requiresRunningApplication` field in
  favor of the new optional `requiresConnection` field that
  can be added to an extension's `config.yaml` file. -
  [#7611](https://github.com/flutter/devtools/pull/7611), [#7602](https://github.com/flutter/devtools/pull/7602)
* Detect extensions for all types of run targets in a package. -
  [#7533](https://github.com/flutter/devtools/pull/7533), [#7535](https://github.com/flutter/devtools/pull/7535)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.35.0).
