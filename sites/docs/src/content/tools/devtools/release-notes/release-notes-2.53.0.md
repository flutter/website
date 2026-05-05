---
title: DevTools 2.53.0 release notes
shortTitle: 2.53.0 release notes
breadcrumb: 2.53.0
showToc: false
---

# DevTools 2.53.0 release notes

The 2.53.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).

## General updates

- Switched default compiler for DevTools to `dart2wasm`. -
  [#9530](https://github.com/flutter/devtools/pull/9530)

## Performance updates

- Increased profile data limit from 64MB to 2GB, fixing issue where panel
  wouldn't load for large profiles. -
  [#9540](https://github.com/flutter/devtools/pull/9540)

## Advanced developer mode updates

- Fixed issue preventing CPU profiles from loading when "advanced developer
  mode" was enabled. - [#9528](https://github.com/flutter/devtools/pull/9528)

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.53.0).
