---
title: Configuring the URL strategy on the web
description: Use hash or path URL strategies on the web
---

Flutter web apps support two ways of configuring URL-based navigation on the
web:

**Hash (default)**: Paths are read and written to the [hash fragment][].
  For example, `flutterexample.dev/#/path/to/screen`.
**Path**:  Paths are read and written without a hash. For example,
  `flutterexample.dev/path/to/screen`.
  
These are set using the [setUrlStrategy][] API with either a [HashUrlStrategy][]
or [PathUrlStrategy][].
  
## Configuring the URL strategy

{{site.alert.note}}
  Flutter uses the hash (`/#/`) location strategy by default. These instructions
  are only required if you would like to use the URL path strategy.
{{site.alert.end}}

{{site.alert.note}}
  You can also try the [url_strategy package][] if you would like to skip this
  setup.
{{site.alert.end}}

The `setUrlStrategy` API can only be called on the web. The following
instructions show how to use a conditional import to call this function on the
web, but not on other platforms.

1. Include the `flutter_web_plugins` package and call the [setUrlStrategy][]
  function before your app runs:

```yaml
dependencies:
  flutter_web_plugins:
    sdk: flutter
```

2. Create a `lib/configure_nonweb.dart` file with the following:
```dart
void configureApp() {
  // No-op.
}
```

3. Create a `lib/configure_web.dart` file with the following:

<!--skip-->
```dart
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}
```

4. Use a conditional import to import `configure_web.dart` when the `html` package
  is available, and `configure_nonweb.dart` when it isn't:

<!--skip-->
```dart
import 'package:flutter/material.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() {
  configureApp();
  runApp(MyApp());
}
```

## Hosting a Flutter app at a non-root location

Update the `<base href="/">` tag in `web/index.html` to the path where
your app is hosted. For example, to host your Flutter app at
`myapp.dev/flutter_app`, change
this tag to `<base href="/flutter_app">`.

[Hash fragment]: https://en.wikipedia.org/wiki/Uniform_Resource_Locator#Syntax
[setUrlStrategy]: {{site.master-api}}/flutter/flutter_web_plugins/setUrlStrategy.html
[HashUrlStrategy]: {{site.master-api}}/flutter/flutter_web_plugins/HashUrlStrategy-class.html
[PathUrlStrategy]: {{site.master-api}}/flutter/flutter_web_plugins/PathUrlStrategy-class.html
[url_strategy package]: {{site.pub-pkg}}/url_strategy
