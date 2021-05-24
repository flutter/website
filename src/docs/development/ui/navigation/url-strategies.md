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
  
These are set using the [`setUrlStrategy`][] API with
either a [`HashUrlStrategy`][] or [`PathUrlStrategy`][].
  
## Configuring the URL strategy

{{site.alert.note}}
  By default, Flutter uses the hash (`/#/`) location strategy.
  These instructions are only required if you want to use
  the URL path strategy.

  Instead of using these setup instructions,
  you can also use the [`url_strategy`][] package.
{{site.alert.end}}

The `setUrlStrategy` API can only be called on the web.
The following instructions show how to use a conditional
import to call this function on the web,
but not on other platforms.

<ol markdown="1">
<li markdown="1">Include the `flutter_web_plugins` package and call the
   [`setUrlStrategy`][] function before your app runs:

  ```yaml
  dependencies:
    flutter_web_plugins:
      sdk: flutter
  ```
</li>

<li markdown="1">Create a `lib/configure_nonweb.dart` file with the
   following code:

  ```dart
  void configureApp() {
    // No-op.
  }
  ```
</li>

<li markdown="1">Create a `lib/configure_web.dart` file with the
   following code:

  <!--skip-->
  ```dart
  import 'package:flutter_web_plugins/flutter_web_plugins.dart';

  void configureApp() {
    setUrlStrategy(PathUrlStrategy());
  }
  ```
</li>

<li markdown="1">Open `lib/main.dart` and conditionally import
   `configure_web.dart` when the `html` package
   is available, or `configure_nonweb.dart` when it isn't:

  <!--skip-->
  ```dart
  import 'package:flutter/material.dart';
  import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

  void main() {
    configureApp();
  runApp(MyApp());
  }
  ```
</li>
</ol>

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
