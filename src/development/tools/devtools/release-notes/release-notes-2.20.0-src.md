# DevTools 2.20.0 release notes

Dart & Flutter DevTools&emdash;A suite of performance tools
for Dart and Flutter

## CPU profiler updates

* Add support for grouping samples by tag -
  [#4693](https://github.com/flutter/devtools/pull/4693)

  ![samples by tag]({{site.url}}/development/tools/devtools/release-notes/images-2.20.0/4693.png "samples by tag")

* Enable guidelines for tree view -
  [#4722](https://github.com/flutter/devtools/pull/4722)

  ![guidelines]({{site.url}}/development/tools/devtools/release-notes/images-2.20.0/4722.png "guidelines")

* Rename "Profile granularity" to "CPU sampling rate"
  and move down to the area it relates to -
  [#4803](https://github.com/flutter/devtools/pull/4722)

  ![sampling rate]({{site.url}}/development/tools/devtools/release-notes/images-2.20.0/4803.png "sampling rate")


## Memory updates

* Retire the **Analysis** tab -
  [#4714](https://github.com/flutter/devtools/pull/4714)

* Add a new tab, **Diff**, to enable memory leak detection
  and troubleshooting by comparing heap snapshots,
  and providing insights about the number of instances,
  shallow size, retained size, and retaining paths -
  [#4714](https://github.com/flutter/devtools/pull/4714)

  ![diff]({{site.url}}/development/tools/devtools/release-notes/images-2.20.0/4714.png "Diff in Memory tab")

## Debugger updates

* Support for inspecting more types of instances in the
  variables viewer (Expandos, Types, TypeArguments,
  Parameters, Closures + closure Contexts,
  WeakProperty, Function, FunctionType, ReceivePort,
  Closure, RegExp) -
  [#4760](https://github.com/flutter/devtools/pull/4760)

* Add support for displaying coverage in CodeView -
  [#4700](https://github.com/flutter/devtools/pull/4700)

  ![coverage]({{site.url}}/development/tools/devtools/release-notes/images-2.20.0/4700.png "coverage in CodeView")

## Network updates

* Display request data if content type is not json
  (thanks to leungpuikuen@!) -
  [#4602](https://github.com/flutter/devtools/pull/4602)

## Changelog

More details about changes and fixes are available in the DevTools
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md).
