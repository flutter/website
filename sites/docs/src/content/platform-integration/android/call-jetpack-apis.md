---
title: "Calling JetPack APIs"
description: "Use the latest Android APIs from your Dart code"
---

<?code-excerpt path-base="platform_integration"?>

Flutter apps running on Android can always make use of the
latest APIs on the first day they are released on Android, no
matter what. This page outlines available ways to invoke
Android-specific APIs.

## Use an existing solution

In most scenarios, you can use a plugin (as shown in the next section)
to invoke native APIs without writing any custom boilerplate or
glue code yourself.

### Use a plugin

Using a plugin is often the easiest way to access native
APIs, regardless of where your Flutter app is running. To
use plugins, visit [pub.dev][pub] and search for
the topic you need. Most native features, including accessing
common hardware like GPS, the camera, or step counters are
supported by robust plugins.

For complete guidance on adding plugins to your Flutter app,
see the [Using packages documentation][packages].

[packages]: /packages-and-plugins/using-packages
[pub]: {{site.pub}}

Not all native features are supported by plugins, especially
immediately after their release. In any scenario where
your desired native feature is not covered by a package on
[pub.dev][pub], continue on to the following sections.

## Creating a custom solution

Not all scenarios and APIs will be supported by
existing solutions; but luckily, you can always add whatever
support you need. The next sections describe two different
ways to call native code from Dart.

:::note
Neither solution below is inherently better or worse than
existing plugins, because all plugins use one of the following
two options.
:::

### Call native code directly via FFI

The most direct and efficient way to invoke native APIs is by
calling the API directly, via FFI. This links your Dart executable
to any specified native code at compile-time, allowing you to
call it directly from the UI thread through generated bindings.
On Android, [JNIgen][jnigen] generates Dart bindings for Java and
Kotlin APIs, and [FFIgen][ffigen] generates bindings for C APIs.

For complete guidance on calling native code directly from
your Flutter app, consult the [Native interop documentation][interop].

[interop]: /interop
[ffigen]: /interop/ffigen
[jnigen]: /interop/jnigen


### Add a MethodChannel

[`MethodChannel`][methodchannels-api-docs]s are an alternate
way Flutter apps can invoke arbitrary native code.
Unlike the FFI solution described in the previous step,
MethodChannels are always asynchronous, which
might or might not matter to you, depending on your use case. As
with FFI and direct calls to native code, using a `MethodChannel`
requires a small amount of glue code to translate your Dart objects
into native objects, and then back again. In most cases,
[Pigeon][pigeon] is helpful in generating this glue code.

For complete guidance on adding MethodChannels to your Flutter
app, consult the [`MethodChannel`s documentation][methodchannels].

[methodchannels]: /platform-integration/platform-channels
[methodchannels-api-docs]: {{site.api}}/flutter/services/MethodChannel-class.html
[pigeon]: /interop/pigeon
