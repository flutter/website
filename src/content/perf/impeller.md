---
title: Impeller rendering engine
description: What is Impeller and how to enable it?
---

## What is Impeller?

Impeller provides a new rendering runtime for Flutter.
The Flutter team's believes this solves Flutter's
[early-onset jank][] issue.
Impeller precompiles a [smaller, simpler set of shaders][]
at Engine-build time so they don't compile at runtime.

[early-onset jank]: {{site.repo.flutter}}/projects/188
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

Where can you use Impeller?

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

The team continues to improve iOS support.
If you encounter performance or fidelity issues
with Impeller on iOS,
file an issue in the [GitHub tracker][file-issue].
Prefix the issue title with `[Impeller]` and
include a small reproducible test case.

[file-issue]: {{site.repo.flutter}}/issues/new/choose

### macOS

As of the 3.19 release,
you can try out Impeller for macOS behind a flag.
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

### Android

As of the 3.22 release, Impeller on Android with Vulkan
is a release candidate. On devices that don't support Vulkan,
Impeller will fallback to the the legacy OpenGL renderer. No
action on your part is necessary for this fallback behavior.
Consider trying Impeller on Android before it becomes the default
on stable, you can explicitly opt into it.

:::secondary Does your device support Vulkan?
You can determine whether your Android device
supports Vulkan at [checking for Vulkan support][vulkan].
:::

To try out Impeller on Vulkan-capable Android devices,
pass `--enable-impeller` to `flutter run`:

```console
flutter run --enable-impeller
```

Or, you can add the following setting to your project's
`AndroidManifest.xml` file under the `<application>` tag:

```xml
<meta-data
    android:name="io.flutter.embedding.android.EnableImpeller"
    android:value="true" />
```

[vulkan]: https://docs.vulkan.org/guide/latest/checking_for_support.html#_android

### Bugs and issues

For the full list of Impeller's known bugs
and missing features,
the most up-to-date information is on the
[Impeller project board][] on GitHub.

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
[Impeller project board]: {{site.github}}/orgs/flutter/projects/21

## Architecture

To learn more details about Impeller's design and architecture,
check out the [README.md][] file in the source tree.

[README.md]: {{site.repo.engine}}/blob/main/impeller/README.md

## Additional information

* [Frequently asked questions]({{site.repo.engine}}/blob/main/impeller/docs/faq.md)
* [Impeller's coordinate system]({{site.repo.engine}}/blob/main/impeller/docs/coordinate_system.md)
* [How to set up Xcode for GPU frame captures with metal]({{site.repo.engine}}/blob/main/impeller/docs/xcode_frame_capture.md)
* [Learning to read GPU frame captures]({{site.repo.engine}}/blob/main/impeller/docs/read_frame_captures.md)
* [How to enable metal validation for command line apps]({{site.repo.engine}}/blob/main/impeller/docs/metal_validation.md)
* [How Impeller works around the lack of uniform buffers in Open GL ES 2.0]({{site.repo.engine}}/blob/main/impeller/docs/ubo_gles2.md)
* [Guidance for writing efficient shaders]({{site.repo.engine}}/blob/main/impeller/docs/shader_optimization.md)
* [How color blending works in Impeller]({{site.repo.engine}}/blob/main/impeller/docs/blending.md)
