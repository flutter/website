---
title: Impeller rendering engine
description: What is Impeller and how to enable it?
---

:::note
As of the 3.27 release, Impeller is the default
rendering engine for both iOS and Android.
To see _detailed_ info on where Impeller is currently supported,
check out the [Can I use Impeller?][] page.
:::

[Can I use Impeller?]: {{site.main-url}}/go/can-i-use-impeller

## What is Impeller?

Impeller provides a new rendering runtime for Flutter.
Impeller precompiles a [smaller, simpler set of shaders][]
at Engine-build time so they don't compile at runtime.

[smaller, simpler set of shaders]: {{site.repo.flutter}}/issues/77412

For a video introduction to Impeller, check out the following
talk from Google I/O 2023.

{% ytEmbed 'vd5NqS01rlA', 'Introducing Impeller, Flutter\'s new rendering engine' %}

Impeller has the following objectives:

* **Predictable performance**:
  Impeller compiles all shaders and reflection offline at build time.
  It builds all pipeline state objects upfront.
  The engine controls caching and caches explicitly.
* **Instrumentable**:
  Impeller tags and labels all graphics resources,
  such as textures and buffers.
  It can capture and persist animations to disk without affecting
  per-frame rendering performance.
* **Portable**:
  Flutter doesn't tie Impeller to a specific client-rendering API.
  You can author shaders once and convert them to backend-specific
  formats, as necessary.
* **Leverages modern graphics APIs**:
  Impeller uses, but doesn't depend on, features available in
  modern APIs like Metal and Vulkan.
* **Leverages concurrency**:
  Impeller can distribute single-frame workloads across multiple
  threads, if necessary.

## Availability

Where can you use Impeller? For _detailed_ info, check out
the [Can I use Impeller?][] page.

### iOS

Flutter **enables Impeller by default** on iOS.

* To _disable_ Impeller on iOS when debugging,
  pass `--no-enable-impeller` to the `flutter run` command.

  ```console
  flutter run --no-enable-impeller
  ```

* To _disable_ Impeller on iOS when deploying your app,
  add the following tags under the top-level `<dict>` tag in your
  app's `Info.plist` file.

  ```xml
    <key>FLTEnableImpeller</key>
    <false />
  ```

### Android

Flutter **enables Impeller by default** on Android.
On devices that don't support Vulkan,
Impeller will fallback to the the legacy OpenGL renderer.
No action on your part is necessary for this fallback behavior.

* To _disable_ Impeller when debugging,
  pass `--no-enable-impeller` to the `flutter run` command.

  ```console
  flutter run --no-enable-impeller
  ```

* To _disable_ Impeller when deploying your app,
  add the following setting to your project's
  `AndroidManifest.xml` file under the `<application>` tag:

```xml
<meta-data
    android:name="io.flutter.embedding.android.EnableImpeller"
    android:value="false" />
```

### macOS

You can try out Impeller for macOS behind a flag.
In a future release, the ability to opt-out of
using Impeller will be removed.

To enable Impeller on macOS when debugging,
pass `--enable-impeller` to the `flutter run` command.

```console
flutter run --enable-impeller
```

To enable Impeller on macOS when deploying your app,
add the following tags under the top-level
`<dict>` tag in your app's `Info.plist` file.

```xml
  <key>FLTEnableImpeller</key>
  <true />
```

### Bugs and issues

The team continues to improve Impeller support.
If you encounter performance or fidelity issues
with Impeller on any platform,
file an issue in the [GitHub tracker][file-issue].
Prefix the issue title with `[Impeller]` and
include a small reproducible test case.

Please include the following information when
submitting an issue for Impeller:

* The device you are running on,
  including the chip information.
* Screenshots or recordings of any visible issues.
* An [export of the performance trace][].
  Zip the file and attach it to the GitHub issue.

[export of the performance trace]:/tools/devtools/performance#import-and-export
[file-issue]: {{site.github}}/flutter/flutter/issues/new/choose
[Impeller project board]: {{site.github}}/orgs/flutter/projects/21

## Architecture

To learn more details about Impeller's design and architecture,
check out the [README.md][] file in the source tree.

[README.md]: {{site.repo.flutter}}/blob/main/engine/src/flutter/impeller/README.md

## Additional information

* [Frequently asked questions]({{site.repo.flutter}}/blob/main/engine/src/flutter/impeller/docs/faq.md)
* [Impeller's coordinate system]({{site.repo.flutter}}/blob/main/engine/src/flutter/impeller/docs/coordinate_system.md)
* [How to set up Xcode for GPU frame captures with metal]({{site.repo.flutter}}/blob/main/engine/src/flutter/impeller/docs/xcode_frame_capture.md)
* [Learning to read GPU frame captures]({{site.repo.flutter}}/blob/main/engine/src/flutter/impeller/docs/read_frame_captures.md)
* [How to enable metal validation for command line apps]({{site.repo.flutter}}/blob/main/engine/src/flutter/impeller/docs/metal_validation.md)
* [How Impeller works around the lack of uniform buffers in Open GL ES 2.0]({{site.repo.flutter}}/blob/main/engine/src/flutter/impeller/docs/ubo_gles2.md)
* [Guidance for writing efficient shaders]({{site.repo.flutter}}/blob/main/engine/src/flutter/impeller/docs/shader_optimization.md)
* [How color blending works in Impeller]({{site.repo.flutter}}/blob/main/engine/src/flutter/impeller/docs/blending.md)
