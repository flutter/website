---
title: Xcode 11.4 Support
description: How to migrate existing Flutter iOS projects to Xcode 11.4.
---

{{site.alert.note}}
  You might be directed to this page if Flutter detects that your project
  doesn't support Xcode 11.4.
{{site.alert.end}}

To develop Flutter apps for iOS, you need a Mac with Xcode installed.
Xcode 11.4 changed the way frameworks are linked and embedded,
and you may [see the following errors when switching between
iOS devices and simulators:][errors]

```
Building for iOS, but the linked and embedded framework 'App.framework' was built for iOS Simulator.
```
or
```
Building for iOS Simulator, but the linked and embedded framework 'App.framework' was built for iOS.
```

Flutter v1.15.3 and later automatically migrates your Xcode project.

If you need to manually upgrade your project, use the following steps:

<ol markdown="1">
<li markdown="1">From the Flutter app directory,
    open `ios/Runner.xcworkspace` in Xcode.
</li>
<li markdown="1">In the **Navigator** pane, locate the
    **Flutter** group and remove `App.framework`
    and `Flutter.framework`.
{% include app-figure.md image="development/ios-project-migration/navigator.png" alt="Remove Frameworks in Xcode Navigator" %}
</li>

<li markdown="1">In the Runner target build settings
    **Build Phases > Link Binary With Libraries**
    confirm `App.framework` and `Flutter.framework`
    are no longer present. Also confirm
    in **Build Phases > Embed Frameworks**.
{% include app-figure.md image="development/ios-project-migration/framework-build-phase.png" alt="Confirm Frameworks Removed from Build Phases" %}
</li>

<li markdown="1">Change the Runner target build settings
    **Build Phases > Thin Binary** script as follows:
```sh
/bin/sh "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" embed
/bin/sh "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" thin
```
{% include app-figure.md image="development/ios-project-migration/script-phase.png" alt="Update Thin Binary Script Build Phase" %}
</li>

<li markdown="1">In the Runner target **Build Settings >
    Other Linker Flags** (`OTHER_LDFLAGS`)
    add `$(inherited) -framework Flutter`.
{% include app-figure.md image="development/ios-project-migration/linker-arguments.png" alt="Update Other Linker Arguments Build Setting" %}
</li>
</ol>

{{site.alert.tip}}
  If you are using Flutter plugins, you can now delete the line
  `install! 'cocoapods', :disable_input_output_paths => true` from `ios/Podfile`
  to improve compilation time. Flutter projects created after v1.15.4 will not
  contain this line.
{{site.alert.end}}

[errors]: https://github.com/flutter/flutter/issues/50568
