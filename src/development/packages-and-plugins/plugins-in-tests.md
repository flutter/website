---
title: Plugins in Flutter tests
short-title: Plugin tests
description: Adding plugin as part of your Flutter tests.
---

Almost all [Flutter plugins][] have two parts:

* Dart code, which provides the API your code calls.
* Code written in a platform-specific (or "host") language,
  such as Kotlin or Swift, which implements those APIs.

In fact, the native (or host) language code distinguishes
a plugin package from a standard package.

[Flutter plugins]: {{site.url}}/development/packages-and-plugins/using-packages

Building and registering the host portion of a plugin
is part of the Flutter application build process,
so plugins only work when your code is running
in your application, such as with `flutter run`
or when running [integration tests][].
When running [Dart unit tests][] or
[widget tests][], the host code isn’t available.
If the code you are testing calls any plugins,
this often results in errors like the following:

```console
MissingPluginException(No implementation found for method someMethodName on channel some_channel_name)
```

[Dart unit tests]: {{site.url}}/cookbook/testing/unit/introduction
[integration tests]: {{site.url}}/cookbook/testing/integration/introduction
[widget tests]: {{site.api}}/flutter/flutter_test/flutter_test-library.html

{{site.alert.note}}
  Plugin implementations that [only use Dart][]
  will work in unit tests. This is an implementation
  detail of the plugin, however,
  so tests shouldn't rely on it.
{{site.alert.end}}

[only use Dart]: {{site.url}}/development/packages-and-plugins/developing-packages#dart-only-platform-implementations

When unit testing code that uses plugins,
there are several options to avoid this exception.
The following solutions are listed in order of preference.

## Wrap the plugin

In most cases, the best approach is to wrap plugin
calls in your own API,
and provide a way of [mocking][] your own API in tests.

This has several advantages:

* If the plugin API changes,
  you won’t need to update your tests.
* You are only testing your own code,
  so your tests can’t fail due to behavior of
  a plugin you're using.
* You can use the same approach regardless of
  how the plugin is implemented,
  or even for non-plugin package dependencies.

[mocking]: {{site.url}}/cookbook/testing/unit/mocking

## Mock the plugin’s public API

If the plugin’s API is already based on class instances,
you can mock it directly, with the following caveats:

* This won’t work if the plugin uses
  non-class functions or static methods.
* Tests will need to be updated when
  the plugin API changes.

## Mock the plugin’s platform interface

If the plugin is a [federated plugin][],
it will include a platform interface that allows
registering implementations of its internal logic.
You can register a mock of that platform interface
implementation instead of the public API with the
following caveats:

* This won’t work if the plugin isn't federated.
* Your tests will include part of the plugin's code,
  so plugin behavior could cause problems for your tests.
  For instance, if a plugin writes files as part of an
  internal cache, your test behavior might change
  based on whether you had run the test previously.
* Tests might need to be updated when the platform interface changes.

An example of when this might be necessary is
mocking the implementation of a plugin used by
a package that you rely on,
rather than your own code,
so you can’t change how it’s called.
However, if possible,
you should mock the dependency that uses the plugin instead.

[federated plugin]: {{site.url}}/development/packages-and-plugins/developing-packages#federated-plugins

## Mock the platform channel

If the plugin uses [platform channels][],
you can mock the platform channels using
[`TestDefaultBinaryMessenger`][].
This should only be used if, for some reason,
none of the methods above are available,
as it has several drawbacks:

* Only implementations that use platform channels
  can be mocked. This means that if some implementations
  don’t use platform channels,
  your tests will unexpectedly use
  real implementations when run on some platforms.
* Platform channels are usually internal implementation
  details of plugins.
  They might change substantially even
  in a bugfix update to a plugin,
  breaking your tests unexpectedly.
* Platform channels might differ in each implementation
  of a federated plugin. For instance,
  you might set up mock platform channels to
  make tests pass on a Windows machine,
  then find that they fail if run on macOS or Linux.
* Platform channels aren't strongly typed.
  For example, method channels often use dictionaries
  and you have to read the plugin’s implementation
  to know what the key strings and value types are.

Because of these limitations, `TestDefaultBinaryMessenger`
is mainly useful in the internal tests
of plugin implementations,
rather than tests of code using plugins.

[platform channels]: {{site.url}}/development/platform-integration/platform-channels
[`TestDefaultBinaryMessenger`]: {{site.api}}/flutter/flutter_test/TestDefaultBinaryMessenger-class.html
