# DevTools 2.45.0 release notes

The 2.45.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).

## General updates

* Added a memory pressure warning that allows you to reduce the memory usage of
DevTools in order to avoid an OOM crash. -
[#8989](https://github.com/flutter/devtools/pull/8989),
[#8997](https://github.com/flutter/devtools/pull/8997),
[#8998](https://github.com/flutter/devtools/pull/8998)

* Fixed various memory leaks and lifecycle issues. - 
[#8901](https://github.com/flutter/devtools/pull/8901),
[#8902](https://github.com/flutter/devtools/pull/8902),
[#8907](https://github.com/flutter/devtools/pull/8907),
[#8917](https://github.com/flutter/devtools/pull/8917),
[#8932](https://github.com/flutter/devtools/pull/8932),
[#8933](https://github.com/flutter/devtools/pull/8933),
[#8934](https://github.com/flutter/devtools/pull/8934),
[#8935](https://github.com/flutter/devtools/pull/8935),
[#8937](https://github.com/flutter/devtools/pull/8937),
[#8953](https://github.com/flutter/devtools/pull/8953),
[#8969](https://github.com/flutter/devtools/pull/8969),
[#8970](https://github.com/flutter/devtools/pull/8970),
[#8975](https://github.com/flutter/devtools/pull/8975)

* Fix a bug with the review history on disconnect experience. -
[#8985](https://github.com/flutter/devtools/pull/8985)

* Fixed bug where DevTools would automatically resume instead of
pausing on breakpoint on connection. - 
[#8991](https://github.com/flutter/devtools/pull/8991)

* Prevented text inputs from stealing focus from the IDE. - 
[#9091](https://github.com/flutter/devtools/pull/9091)

## Inspector updates

* Fixed bug where errors in the inspector tree (e.g. RenderFlex overflow
errors) were not removed after a hot-reload. - 
[#9106](https://github.com/flutter/devtools/pull/9106)

## Debugger updates

* Combine the Pause and Resume buttons into a single button. -
[#9095](https://github.com/flutter/devtools/pull/9095)

## Deep links tool updates

* Fixed an issue with Windows file paths showing incorrectly in the Deep Links
page [#9027](https://github.com/flutter/devtools/pull/9027).

* Fixed an issue with the Deep Links page crashing when no iOS configuration is
present [#9027](https://github.com/flutter/devtools/pull/9027).

## Full commit history

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.45.0).
