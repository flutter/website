---
title: Embedding Flutter on the web
short-title: Embedding Flutter web
description: Learn the different ways to embed Flutter views into web content.
---

Flutter views and web content can be composed to produce a web application
in different ways. Choose one of the following depending on your use-case:

* A Flutter view controls the full page (full-screen mode)
* Adding Flutter views to an existing web application (embedded mode)

## Full-screen mode

In full screen mode, the Flutter web application takes control of the whole
browser window and covers its viewport completely when rendering. This is the
default embedding mode for Flutter, and no additional configuration is needed.

```html highlightLines=6
<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <script src="flutter_bootstrap.js" defer></script>
  </body>
</html>
```

When Flutter web is bootstrapped without referencing `multiViewEnabled` or a 
`hostElement`, it uses full-screen mode.

To learn more about the `flutter_bootstrap.js` file,
check out [Customize app initialization][].

[Customize app initialization]: {{site.docs}}/platform-integration/web/initialization/

### `iframe` embedding

Full-screen mode is recommended when embedding a Flutter web application in an
`iframe`. The page that embeds the `iframe` can size and position it as needed,
and Flutter will fill it completely.

```html
<iframe src="https://url-to-your-flutter/index.html"></iframe>
```

To learn more about the pros and cons of an `iframe`,
check out the [Inline Frame element][] docs on MDN.

[Inline Frame element]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe

## Embedded mode

Flutter web applications can also render content into an arbitrary number of
elements (commonly `div`s) of another web application; this is called "embedded
mode" (or "multi-view").

In this mode:

* A Flutter web application can launch, but doesn't render until the first
"view" is added, with `addView`.
* The host application can add or remove views from the embedded Flutter web
   application.
* The Flutter application is notified when views are added or removed,
  so it can adjust its widgets accordingly.

### Enable multi-view mode

Enable multi-view mode setting `multiViewEnabled: true` in the
`initializeEngine` method as shown:

```js highlightLines=8
// flutter_bootstrap.js
{% raw %}{{flutter_js}}{% endraw %}
{% raw %}{{flutter_build_config}}{% endraw %}

_flutter.loader.load({
  onEntrypointLoaded: async function onEntrypointLoaded(engineInitializer) {
    let engine = await engineInitializer.initializeEngine({
      multiViewEnabled: true, // Enables embedded mode.
    });
    let app = await engine.runApp();
    // Make this `app` object available to your JS app.
  }
});
```

### Manage Flutter views from JS

To add or remove views, use the `app` object returned by the `runApp` method:

```js highlightLines=2-4,7
// Adding a view...
let viewId = app.addView({
  hostElement: document.querySelector('#some-element'),
});

// Removing viewId...
let viewConfig = flutterApp.removeView(viewId);
```

### Handling view changes from Dart

View additions and removals are surfaced to Flutter through the
[`didChangeMetrics` method][] of the `WidgetsBinding` class.

The complete list of views attached to your Flutter app is available
through the `WidgetsBinding.instance.platformDispatcher.views` iterable. These
views are of [type `FlutterView`][].

To render content into each `FlutterView`, your Flutter app needs to create a
[`View` widget][]. `View` widgets can be grouped together under a
[`ViewCollection` widget][].

The following example, from the _Multi View Playground_, encapsulates
the above in a `MultiViewApp` widget that can be used as the root widget for
your app. A [`WidgetBuilder` function][] runs for each `FlutterView`:

```dart highlightLines=25,39,46-49,56-61,72
// multi_view_app.dart

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show FlutterView;
import 'package:flutter/widgets.dart';

/// Calls [viewBuilder] for every view added to the app to obtain the widget to
/// render into that view. The current view can be looked up with [View.of].
class MultiViewApp extends StatefulWidget {
  const MultiViewApp({super.key, required this.viewBuilder});

  final WidgetBuilder viewBuilder;

  @override
  State<MultiViewApp> createState() => _MultiViewAppState();
}

class _MultiViewAppState extends State<MultiViewApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateViews();
  }

  @override
  void didUpdateWidget(MultiViewApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Need to re-evaluate the viewBuilder callback for all views.
    _views.clear();
    _updateViews();
  }

  @override
  void didChangeMetrics() {
    _updateViews();
  }

  Map<Object, Widget> _views = <Object, Widget>{};

  void _updateViews() {
    final Map<Object, Widget> newViews = <Object, Widget>{};
    for (final FlutterView view in WidgetsBinding.instance.platformDispatcher.views) {
      final Widget viewWidget = _views[view.viewId] ?? _createViewWidget(view);
      newViews[view.viewId] = viewWidget;
    }
    setState(() {
      _views = newViews;
    });
  }

  Widget _createViewWidget(FlutterView view) {
    return View(
      view: view,
      child: Builder(
        builder: widget.viewBuilder,
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewCollection(views: _views.values.toList(growable: false));
  }
}
```

For more information, check out [`WidgetsBinding` mixin][] in the API docs, or
the [Multi View Playground repo][] that was used during development.

[`didChangeMetrics` method]: {{site.api}}/flutter/widgets/WidgetsBindingObserver/didChangeMetrics.html
[Multi View Playground repo]: {{site.github}}/goderbauer/mvp
[type `FlutterView`]: {{site.api}}/flutter/dart-ui/FlutterView-class.html
[`View` widget]: {{site.api}}/flutter/widgets/View-class.html
[`ViewCollection` widget]: {{site.api}}/flutter/widgets/ViewCollection-class.html
[`WidgetsBinding` mixin]: {{site.api}}/flutter/widgets/WidgetsBinding-mixin.html
[`WidgetBuilder` function]: {{site.api}}/flutter/widgets/WidgetBuilder.html

### Identifying views

Each `FlutterView` has an identifier assigned by Flutter when
attached. This `viewId` can be used to uniquely identify each view, retrieve
its initial configuration, or decide what to render in it.

The `viewId` of the rendered `FlutterView` can be retrieved from
its `BuildContext` like this:

```dart highlightLines=4-5
class SomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the `viewId` where this Widget is being built:
    final int viewId = View.of(context).viewId;
    // ...
```

Read more about the [`View.of` constructor][].

[`View.of` constructor]: {{site.api}}/flutter/widgets/View/of.html

### Initial view configuration

Flutter views can receive any initialization data from JS when starting up.
The values are passed through the `initialData` property of the `addView`
method, as shown:

```js highlightLines=4-7
// Adding a view with initial data...
let viewId = app.addView({
  hostElement: someElement,
  initialData: {
    greeting: 'Hello, world!',
    randomValue: Math.floor(Math.random() * 100),
  }
});
```

In Dart, the `initialData` is available as a `JSAny` object, accessible through
the top-level `views` property in the `dart:ui_web` library. The data is
accessed through the `viewId` of the current view,  as shown:

```dart
final initialData = ui_web.views.getInitialData(viewId) as YourJsInteropType;
```

To learn how to define the `YourJsInteropType` class to map the `initialData`
object passed from JS so it's type-safe in your Dart program, check out:
[JS Interoperability][] on dart.dev.

[JS Interoperability]: {{site.dart-site}}/interop/js-interop

### View constraints

By default, an embedded Flutter web view considers the size of its `hostElement`
as an immutable property, and tightly constrains its layout to the available
space.

On the web, it's common for the intrinsic size of an element to affect the
layout of the page (like `img` or `p` tags that can reflow content around
them).

When adding a view to Flutter web, you might configure it with constraints that
inform Flutter of how the view needs to be laid out:

```js highlightLines=4-8
// Adding a view with initial data...
let viewId = app.addView({
  hostElement: someElement,
  viewConstraints: {
    maxWidth: 320,
    minHeight: 0,
    maxHeight: Infinity,
  }
});
```

The view constraints passed from JS need to be compatible with the CSS styling
of the `hostElement` where Flutter is being embedded. For example, Flutter
won’t try to "fix" contradictory constants like passing  `max-height: 100px`
in CSS, but `maxHeight: Infinity` to Flutter.

To learn more, check out the [`ViewConstraints` class][],
and [Understanding constraints][].

[`ViewConstraints` class]: {{site.api}}/flutter/dart-ui/ViewConstraints-class.html
[Understanding constraints]: {{site.docs}}/ui/layout/constraints

## Custom element (`hostElement`)

_Between Flutter 3.10 and 3.24_<br />
You can embed a single-view Flutter web app into any HTML element of your web
page.

To tell Flutter web which element to render into, pass an object with a `config`
field to the `_flutter.loader.load` function that specifies a `HTMLElement` as
the `hostElement`.

```js highlightLines=3
_flutter.loader.load({
  config: {
    hostElement: document.getElementById('flutter_host'),
  }
});
```

To learn more about other configuration options,
check out [Customizing web app initialization][].

:::version-note
This method of specifying the `hostElement` is superseded by the
**Embedded mode** described above, **please consider migrating to it**.
To learn how to configure the `hostElement` in earlier Flutter versions,
reference [Legacy web app initialization][].
:::

[Customizing web app initialization]: {{site.docs}}/platform-integration/web/initialization
[Legacy web app initialization]: {{site.docs}}/platform-integration/web/initialization-legacy
