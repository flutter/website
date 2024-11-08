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
[usePathUrlStrategy][] function provided by the [flutter_web_plugins][] library,
which is part of the Flutter SDK.

You can't directly add `flutter_web_plugins` using `pub add`.
Include it as a Flutter [SDK dependency][] in your `pubspec.yaml` file:

```yaml highlightLines=4-5
dependencies:
  flutter:
    sdk: flutter
  flutter_web_plugins:
    sdk: flutter
```

Then call the `usePathUrlStrategy` function before `runApp`:

```dart highlightLines=4
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(ExampleApp());
}
```

[SDK dependency]: {{site.dart-site}}/tools/pub/dependencies#sdk

## Configuring your web server

PathUrlStrategy uses the [History API][], which requires additional
configuration for web servers.

To configure your web server to support PathUrlStrategy, check your web server's
documentation to rewrite requests to `index.html`. Check your web server's
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
`my_app.dev/flutter_app`, change
this tag to `<base href="/flutter_app/">`.

Relative `base href` tags are supported for release builds but they must take
into account the full URL where the page was served from.
This means a relative `base href` for a request to `/flutter_app/`,
`/flutter_app/nested/route`, and `/flutter_app/nested/route/` will be different
(for example `"."`, `".."`, and `"../.."` respectively).

[hash fragment]: https://en.wikipedia.org/wiki/Uniform_Resource_Locator#Syntax
[`HashUrlStrategy`]: {{site.api}}/flutter/flutter_web_plugins/HashUrlStrategy-class.html
[`PathUrlStrategy`]: {{site.api}}/flutter/flutter_web_plugins/PathUrlStrategy-class.html
[`setUrlStrategy`]: {{site.api}}/flutter/flutter_web_plugins/setUrlStrategy.html
[`url_strategy`]: {{site.pub-pkg}}/url_strategy
[usePathUrlStrategy]: {{site.api}}/flutter/flutter_web_plugins/usePathUrlStrategy.html
[flutter_web_plugins]: {{site.api}}/flutter/flutter_web_plugins/flutter_web_plugins-library.html
[History API]: https://developer.mozilla.org/en-US/docs/Web/API/History_API
[Configure rewrites]: {{site.firebase}}/docs/hosting/full-config#rewrites
