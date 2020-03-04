---
title: Supporting Xcode 11.4
description: How to migrate existing Flutter iOS projects to Xcode 11.4.
---

{{site.alert.note}}
  You might be directed to this page if the tool detects that your project
  doesn't support Xcode 11.4.
{{site.alert.end}}

To developer Flutter apps for iOS, you need a Mac with Xcode.
Xcode 11.4 changes the way frameworks are linked and embedded, and
you may [experience issues switching between iOS devices and simulators][].
Flutter v1.15.3 and later will automatically migrate your Xcode project.

If you need to manually upgrade:
1. From the Flutter app directory, open `ios/Runner.xcworkspace` in Xcode.
1. In the Navigator pane, locate the Flutter group and remove App.framework
and Flutter.framework.
{% include app-figure.md image="development/ios-project-migration/navigator.png" alt="Remove Frameworks in Xcode Navigator" %}

1. In the Runner target build settings > Build Phases > Link Binary With Libraries
confirm App.framework and Flutter.framework are no longer present. Also confirm
in Build Phases > Embed Frameworks.
{% include app-figure.md image="development/ios-project-migration/framework-build-phase.png" alt="Confirm Frameworks Removed from Build Phases" %}

1. The Runner target build settings > Build Phases > Thin Binary script becomes:
```sh
/bin/sh "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" embed
/bin/sh "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" thin
```
{% include app-figure.md image="development/ios-project-migration/script-phase.png"alt="Update Thin Binary Script Build Phase" %}

1. In the Runner target build settings > Build Settings > Other Linker Arguments (`OTHER_LDFLAGS`)
add `$(inherited) -framework Flutter`.
{% include app-figure.md image="development/ios-project-migration/linker-arguments.png" alt="Update Other Linker Arguments Build Setting" %}

[experience issues switching between iOS devices and the simulator]: https://github.com/flutter/flutter/issues/50568
