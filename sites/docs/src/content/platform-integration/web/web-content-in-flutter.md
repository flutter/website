---
title: Embedding web content into a Flutter web app
shortTitle: Web content in Flutter
description: >-
  Learn how to embed web content, understand DOM slot layering,
  and handle pointer events in Flutter web apps.
---

In some cases, Flutter web applications need to embed web content not
rendered by Flutter. For example, embedding a `google_maps_flutter` view
(which uses the Google Maps JavaScript SDK) or a `video_player`
(which uses a standard `video` element).

Flutter web can render arbitrary web content
within the boundaries of a `Widget`,
and the primitives used to implement the example packages mentioned previously
are available to all Flutter web applications.

## HtmlElementView

The `HtmlElementView` Flutter widget reserves a space in the layout to be
filled with any HTML element. It has two constructors:

* `HtmlElementView.fromTagName`
* `HtmlElementView` and `registerViewFactory`

### `HtmlElementView.fromTagName`

The [`HtmlElementView.fromTagName` constructor][] creates an HTML element from
its `tagName`, and provides an `onElementCreated` method to configure that
element before it's injected into the DOM:

```dart
// Create a `video` tag, and set its `src` and some `style` properties...
HtmlElementView.fromTagName(
  tagName: 'video',
  onElementCreated: (Object video) {
    video as web.HTMLVideoElement;
    video.src =
        'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4';
    video.style.width = '100%';
    video.style.height = '100%';
    // other customizations to the element...
  },
);
```

To learn more about how to interact with DOM APIs,
check out the [`HTMLVideoElement` class] in [`package:web`][].

To learn more about the video `Object` that is cast to `web.HTMLVideoElement`,
check out Dart's [JS Interoperability][] documentation.

### `HtmlElementView` and `registerViewFactory`

If you need more control over generating the HTML code you inject,
you can use the primitives that Flutter uses to implement
the `fromTagName` constructor.
In this scenario, register your own HTML element factory
for each type of HTML content that you add to your app.

The resulting code has two steps per platform view type:

1. Register the HTML element factory using
   `platformViewRegistry.registerViewFactory` provided by `dart:ui_web`.
1. Place the widget with the desired `viewType` using
   `HtmlElementView(viewType: 'viewType')` in your app's widget tree.

For more details about this approach, check out the
[`HtmlElementView` widget][] docs.

## Fixing hit testing issues

Because of how Flutter web performs hit testing,
underlying platform views might sometimes swallow
pointer events before they can reach Flutter.

To prevent losing pointer events intended for Flutter widgets,
use the [`package:pointer_interceptor`][] package.

The [`PointerInterceptor`][] widget creates
an empty, transparent platform view
and places it directly behind its child widget in paint order.
This transparent element catches browser pointer events
before they reach the underlying `HtmlElementView`,
allowing Flutter's gesture framework to handle the interaction as expected.

### Add the dependency

Add `pointer_interceptor` to your `pubspec.yaml` file:

```yaml
dependencies:
  pointer_interceptor: ^0.10.1+2
```

### Wrap interactive widgets

To make an individual interactive widget clickable over an `HtmlElementView`
(such as a [`FloatingActionButton`][] or [`ElevatedButton`][]),
wrap the widget with `PointerInterceptor`:

```dart
PointerInterceptor(
  child: FloatingActionButton(
    onPressed: () {
      // Handle button press
    },
    child: const Icon(Icons.add),
  ),
)
```

### Wrap layout and overlay containers

When you use overlay components that cover a platform view,
such as a [`Drawer`][], dialog, or popup menu,
wrap the container widget in a `PointerInterceptor`:

```dart
Scaffold(
  drawer: PointerInterceptor(
    child: Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Handle navigation
            },
          ),
        ],
      ),
    ),
  ),
  body: HtmlElementView.fromTagName(tagName: 'iframe'),
)
```

### Conditionally intercept events

The `intercepting` property lets you enable or disable pointer interception
based on a boolean condition:

```dart
PointerInterceptor(
  intercepting: isOverlayVisible,
  child: ElevatedButton(
    onPressed: () {
      // Handle button press
    },
    child: const Text('Submit'),
  ),
)
```

When `intercepting` is `false`, `PointerInterceptor` renders its `child`
directly without creating an extra platform view in the DOM.

### Debug interceptor bounds

The `PointerInterceptor` widget includes a `debug` property.
Setting `debug: true` renders a visible colored overlay
over the interceptor area,
helping you verify the size and position of the intercepted region:

```dart
PointerInterceptor(
  debug: true,
  child: ElevatedButton(
    onPressed: () {},
    child: const Text('Click me'),
  ),
)
```

## `package:webview_flutter`

Embedding a full HTML page inside a Flutter app is a common requirement.
The Flutter team offers a plugin for this purpose:

* [`package:webview_flutter`][]

[JS Interoperability]: {{site.dart-site}}/interop/js-interop
[`Drawer`]: {{site.api}}/flutter/material/Drawer-class.html
[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html
[`FloatingActionButton`]: {{site.api}}/flutter/material/FloatingActionButton-class.html
[`HtmlElementView.fromTagName` constructor]: {{site.api}}/flutter/widgets/HtmlElementView/HtmlElementView.fromTagName.html
[`HtmlElementView` widget]: {{site.api}}/flutter/widgets/HtmlElementView-class.html
[`HTMLVideoElement` class]: {{site.pub}}/documentation/web/latest/web/HTMLVideoElement-extension-type.html
[`package:pointer_interceptor`]: {{site.pub-pkg}}/pointer_interceptor
[`package:web`]: {{site.pub-pkg}}/web
[`package:webview_flutter`]: {{site.pub-pkg}}/webview_flutter
[`package:webview_flutter_web`]: {{site.pub-pkg}}/webview_flutter_web
[`PointerInterceptor`]: {{site.pub-api}}/pointer_interceptor/latest/pointer_interceptor/PointerInterceptor-class.html
