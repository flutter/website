---
title: Defer component loading
description: How to defer component loading for improved download performance.
---

If you have a large, enterprise app that runs on
Android devices and takes a long time to load,
you can split your compiled app and assets into modules
(also called _bundles_) that are dynamically downloaded
and installed at runtime. This feature, called
_deferred component loading_, results in smaller
initial installed APK size,
dynamic download of large features,
and the capability for locale specific code
and features to be only installed when necessary.

{{site.alert.note}}
  The deferred loading feature described here is
  available for Android. This advanced feature leverages
  the Play Store's ability to serve
  [Android app bundles][] on demand, and is intended
  for large, enterprise apps.
  The Apple App Store doesn't currently offer an
  equivalent feature for downloading modules.
  Therefore, to achieve this ability on iOS is
  an even more advanced topic and is not covered here.
{{site.alert.end}}

To implement deferred components requires the following.

First, prepare your code:

* For any libraries that you want to defer loading,
  identify them with the [`deferred as`][] modifier
  when importing them;
  this modifier is part of the Dart language.

```dart
import 'package:greetings/hello.dart' deferred as hello;
```

* To load a deferred library, either call 
  [`loadLibrary()`][] on the library import prefix,
  or use the [`DeferredComponent`][] utility class
  that uses platform channels to install components
  by name.
  [PENDING: I could only find a loadLibrary method
  in the dart:mirrors package?!?]

* Identify your deferred components in the pubspec file.
  
Once your code is prepared, build your app for deployment.
[PENDING: I was somewhat confused by which commands are
actually used.]

```terminal
flutter deferred-components setup   ## opt-in to dynamic features
flutter build deferred-components-aab
```


[Android app bundles]: {{site.android-dev}}/guide/app-bundle
[`deferred as`]: {{site.dart-site}}/guides/language/language-tour#lazily-loading-a-library
[`DeferredComponent`]: {{site.api}}/flutter/services/DeferredComponent-class.html
[`loadLibrary()`]: {{site.dart-api}}/stable/dart-mirrors/LibraryDependencyMirror/loadLibrary.html
