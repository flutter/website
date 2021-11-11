---
title: Web URL strategies
description: How to switch between hash and path location strategies on the web
---

By default, Flutter uses the hash fragment (`#`) of the URL to handle browser
navigation. To configure Flutter to use the path instead, use the
[setUrlStrategy][] function provided by the [flutter_web_plugins][] library in
the SDK.

First, add `flutter_web_plugins` to your `pubspec.yaml`:

```
  flutter_web_plugins:
    sdk: flutter
```

If your Flutter app is web-only, you can call [setUrlStrategy][] before calling
`runApp()`:

```
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}
```

If your app is cross-platform, use Dart's conditional imports feature by using
the [url_strategy][] package or setting them up yourself by creating three
files:

**url_strategy.dart**

```
export 'url_strategy_noop.dart' if (dart.library.html) 'url_strategy_web.dart';
```

**url_strategy_noop.dart**

```
void usePathUrlStrategy() {
  // noop
}
```

**url_strategy_web.dart**

```
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void usePathUrlStrategy() {
  setUrlStrategy(PathUrlStrategy());
}
```

Then, call `setPathUrlStrategy` before `runApp()`:

**main.dart**

```
import 'package:flutter/material.dart';
import 'url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(MyApp());
}
```

Using conditional imports ensures that the `flutter_web_plugins` library is only
loaded when your app is running on the web.

# Configuring your web server

PathUrlStrategy uses the [History API][], which requires additional
configuration for web servers.

To configure your web server to support PathUrlStrategy, check your web server's
documentation to rewrite requests to `index.html`.Check your web server's
documentation for details on how to configure single-page apps.

If you are using Firebase Hosting, choose the "Configure as a single-page app"
option when initializing your project. For more information see Firebase's
[Configure rewrites][] documentation.

The local dev server created by running `flutter run -d chrome` is configured to
handle any path gracefully and fallback to your app's `index.html` file.


[setUrlStrategy]: https://api.flutter.dev/flutter/flutter_web_plugins/setUrlStrategy.html
[flutter_web_plugins]: https://api.flutter.dev/flutter/flutter_web_plugins/flutter_web_plugins-library.html
[url_strategy]: https://pub.dev/packages/url_strategy
[History API]: https://developer.mozilla.org/en-US/docs/Web/API/History_API
[Configure rewrites][]
