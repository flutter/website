---
title: Embedding web content into a Flutter web app
short-title: Web content in Flutter
description: Learn how to load and display images on the web.
---

In some cases, Flutter web applications need to embed web content not
rendered by Flutter. For example, embedding a `google_maps_flutter` view
(which uses the Google Maps JavaScript SDK) or a `video_player`
(which uses a standard `video` element).

Flutter web can render arbitrary web content within the boundaries of a `Widget`,
and the primitives used to implement the example packages mentioned previously,
are available to all Flutter web applications.

## `HtmlElementView`

The `HtmlElementView` Flutter widget reserves a space in the layout to be
filled with any HTML Element. It has two constructors:

* `HtmlElementView.fromTagName`.
* `HtmlElementView` and `registerViewFactory`.

### `HtmlElementView.fromTagName`

The [`HtmlElementView.fromTagName` constructor][] creates an HTML Element from
its `tagName`, and provides an `onElementCreated` method to configure that
element before it's injected into the DOM:

```dart
// Create a `video` tag, and set its `src` and some `style` properties...
HtmlElementView.fromTag('video', onElementCreated: (Object video) {
  video as web.HTMLVideoElement;
  video.src = 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4';
  video.style.width = '100%';
  video.style.height = '100%';
  // other customizations to the element...
});
```

To learn more about the way to interact with DOM APIs,
check out the [`HTMLVideoElement` class] in [`package:web`][].

To learn more about the video `Object` that is cast to `web.HTMLVideoElement`,
check out Dart's [JS Interoperability][] documentation.

[`HtmlElementView.fromTagName` constructor]: {{site.api}}/flutter/widgets/HtmlElementView/HtmlElementView.fromTagName.html
[`HTMLVideoElement` class]: {{site.pub}}/documentation/web/latest/web/HTMLVideoElement-extension-type.html
[`package:web`]: {{site.pub-pkg}}/web

### `HtmlElementView` and `registerViewFactory`

If you need more control over generating the HTML code you inject, you can use
the primitives that Flutter uses to implement the `fromTagName` constructor. In
this scenario, register your own HTML Element factory for each type of HTML
content that needs to be added to your app.

The resulting code is more verbose, and has two steps per platform view type:

1. Register the HTML Element Factory using
`platformViewRegistry.registerViewFactory` provided by `dart:ui_web.`  
2. Place the widget with the desired `viewType`  with
`HtmlElementView('viewType')` in your app's widget tree.

For more details about this approach, check out
[`HtmlElementView` widget][] docs.

[`HtmlElementView` widget]: {{site.api}}/flutter/widgets/HtmlElementView-class.html

## `package:webview_flutter`

Embedding a full HTML page inside a Flutter app is such a common feature, that
the Flutter team offers a plugin to do so:

* [`package:webview_flutter`][]

The **not endorsed** web implementation of the plugin,
[`package:webview_flutter_web`][], is implemented with the same primitives
described above, and Dart's [JS Interoperability][] APIs.

[JS Interoperability]: {{site.dart-site}}/interop/js-interop
[`package:webview_flutter`]: {{site.pub}}/packages/webview_flutter
[`package:webview_flutter_web`]: {{site.pub}}/packages/webview_flutter_web
