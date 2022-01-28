---
title: Configuring the URL strategy on the web
description: Use hash or path URL strategies on the web
---

Flutter web apps support two ways of configuring
URL-based navigation on the web:

**Hash (default)**
: Paths are read and written to the [hash fragment][].
For example, `flutterexample.dev/#/path/to/screen`.

**Path**
:  Paths are read and written without a hash. For example,
`flutterexample.dev/path/to/screen`.

## Configuring the URL strategy

To configure Flutter to use the path instead, use the
[setUrlStrategy][] function provided by the [flutter_web_plugins][] library in
the SDK.

The `setUrlStrategy` API can only be called on the web.
The following instructions show how to use a conditional
import to call this function on the web,
but not on other platforms.

{{site.alert.note}}
By default, Flutter uses the hash (`/#/`) location strategy.
These instructions are only required if you want to use
the URL path strategy.

Instead of using these setup instructions,
you can also use the [`url_strategy`][] package.
{{site.alert.end}}

## Web setup

First, add `flutter_web_plugins` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_web_plugins:
    sdk: flutter
```

Then call [setUrlStrategy][] before `runApp()`:

```
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}
```

## Cross platform setup
If your app is cross-platform, use Dart's conditional imports feature by
creating three files:

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

## Configuring your web server

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

## Hosting a Flutter app at a non-root location

Update the `<base href="/">` tag in `web/index.html`
to the path where your app is hosted.
For example, to host your Flutter app at
`myapp.dev/flutter_app`, change
this tag to `<base href="/flutter_app/">`.


[hash fragment]: https://en.wikipedia.org/wiki/Uniform_Resource_Locator#Syntax
[`HashUrlStrategy`]: {{site.api}}/flutter/flutter_web_plugins/HashUrlStrategy-class.html
[`PathUrlStrategy`]: {{site.api}}/flutter/flutter_web_plugins/PathUrlStrategy-class.html
[`setUrlStrategy`]: {{site.api}}/flutter/flutter_web_plugins/setUrlStrategy.html
[`url_strategy`]: {{site.pub-pkg}}/url_strategy
[setUrlStrategy]: https://api.flutter.dev/flutter/flutter_web_plugins/setUrlStrategy.html
[flutter_web_plugins]: https://api.flutter.dev/flutter/flutter_web_plugins/flutter_web_plugins-library.html
[History API]: https://developer.mozilla.org/en-US/docs/Web/API/History_API
[Configure rewrites]: {{site.url}}/development/ui/navigation/url-strategies
