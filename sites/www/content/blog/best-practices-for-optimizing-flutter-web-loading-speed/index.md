---
title: "Best practices for optimizing Flutter web loading speed"
description: >-
  Explore strategies for reducing Flutter web app load times and
  improving the user experience.
publishDate: 2024-05-06
author: mhclin113
image: images/0_bz3_DRzn9aoB0qD.webp
category: tutorial
layout: blog
---

As a Flutter developer working with the Google Flutter team and personally in my private time, I encounter and understand the concerns regarding the loading speed of Flutter web apps. Optimizing loading speed is crucial for better performance and a positive user experience, especially as Flutter developers expand into web development. This guide offers actionable strategies and best practices to accelerate the performance of your Flutter web apps.

## Rendering

CanvasKit, the default [renderer](https://docs.flutter.dev/platform-integration/web/renderers) for Flutter web applications, offers high performance and pixel-perfect consistency across platforms by leveraging WebGL. This capability is particularly beneficial for complex graphical applications that require rich animations and high fidelity. However, the inherent file size of CanvasKit (around 1.5 MB) can be a drawback, especially for apps where initial load time is critical.

Although the `flutter.js` load API parallelizes the download of CanvasKit and `main.dart.js`, all Flutter widgets have to wait for them to be fully loaded into the browser, potentially leading to noticeable delays before the application becomes interactive. To mitigate these concerns and optimize the loading experience, developers can choose the Wasm rendering mode.

As [WebAssembly support](https://docs.flutter.dev/platform-integration/web/wasm) in Flutter web is considered experimental and subject to change, these steps are for developers willing to experiment with cutting-edge features. Features and commands might evolve, so always refer to the latest Flutter documentation for current practices.

### Compatibility

The `dart:html` package is not supported when building with Wasm. This limitation means you must carefully consider the APIs on which your app depends. Alternatively, the [web package](https://pub.dev/packages/web) is supported by both dart2wasm and dart2js.

### Performance

Wasm not only reduces app size compared to CanvasKit, it’s also faster to start up compared to JavaScript.

## Lazy loading

Dart’s [deferred imports](https://dart.dev/language/libraries#lazily-loading-a-library) allow you to split your code and load parts of it only when needed, reducing the initial load time. The following sections discuss how you can use deferred loading.

### Declare a deferred import

At the top of your Dart file, declare the import that you want to defer. In your import statement, specify `deferred as` followed by an identifier. When you need to use the library, load it asynchronously using the `loadLibrary()` method on the deferred import:

```dart
import 'package:myapp/hello.dart' deferred as hello;

Future<void> loadHelloLibrary() async {
  await hello.loadLibrary();
  hello.sayHi();
}
```

### Call the load function

In your Flutter app, call this function when needed, for example, as a response to user interactions. The following example loads the needed library when the user presses a widget:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            loadHelloLibrary();
          },
          child: Text('Load Feature'),
        ),
      ),
    );
  }
}
```

## Unawaited function calls

In order to reduce the time taken to display the initial widget of your app, try to not `await` for costly futures before calling `runApp`. Some futures can be left un-awaited so they update the UI after they complete. The [`unawaited` function](https://api.flutter.dev/flutter/dart-async/unawaited.html) allows app programmers to explicitly tell the “unawaited futures” lint that those futures are not expected to be awaited. This improvement enhances the user experience during both app startup and page loading by making the app feel more responsive. However, it’s important to manage such functions carefully to avoid issues related to app state consistency and resource management.

```dart
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  unawaited(downloadVideos().then(videos) {
    playlist.add(videos);
  });

  runApp(const MyApp());
}
```

## Media files

### Displaying assets at optimal resolution

Flutter automatically handles [loading assets at the appropriate resolution based on the device’s pixel density](https://docs.flutter.dev/ui/assets/assets-and-images#resolution-aware). This ensures optimal visuals across different screen sizes. While it’s important to optimize assets for efficient delivery, prioritize providing assets at the exact resolutions needed before exploring alternative image formats, as we’ll talk about in the next section.

### Better image compression

PNG and JPG are among the most prevalent image formats used on websites. These formats are renowned for their widespread support and compatibility. However, emerging next-generation formats like [WebP](https://developers.google.com/speed/webp) and [AVIF](https://netflixtechblog.com/avif-for-next-generation-image-coding-b1d75675fe4) offer significant advancements in reducing file sizes without substantially compromising image quality. For instance, a PNG image with an original size of 319 KB can be compressed to just 38 KB in WebP format or, even more impressively, to 10 KB in AVIF format. These reductions in file size are achieved with minimal perceptible loss in quality to the human eye, demonstrating the potential of these formats to enhance website loading speeds while maintaining visual fidelity.

<DashImage figure src="images/0_bz3_DRzn9aoB0qD.webp" alt="PNG 319 KB / WebP 38 KB / AVIF 10 KB" caption="PNG 319 KB / WebP 38 KB / AVIF 10 KB" />

However, it’s important to note that not all browsers support [WebP](https://caniuse.com/webp) and [AVIF](https://caniuse.com/avif) images. Before integrating these formats into your website, verify their compatibility with the browsers your audience uses most frequently. This will help you determine whether these next-generation image formats align with your website’s requirements and audience needs.

## Caching

### Memory, disk, service workers cache

Leveraging the capabilities of memory cache, disk cache, and Service Workers can significantly reduce loading times after the initial page load. This is because these caching mechanisms require files to be loaded once before they can cache them. Memory cache, stored in RAM, offers rapid access speeds but is volatile. On the other hand, disk cache, although slower, provides persistence. Service Workers act as programmable network proxies, enabling sophisticated caching strategies across both memory and disk.

Browsers or operating systems usually manage memory and disk caches automatically, eliminating the need for manual intervention unless there’s a specific requirement to manipulate them programmatically. While Flutter manages Service Workers to some extent, developers have the flexibility to implement custom Service Workers alongside Flutter for enhanced control over caching and network interactions.

### Wasm

Browsers cache Wasm files (like CanvasKit, and soon dart2wasm output) as well as their compiled native code. This means cached Wasm modules load as quickly as native binaries, unlike JavaScript, which requires reparsing, recompilation, and reJIT (Just-In-Time) processing.

While Flutter’s Wasm build option isn’t fully stable yet, adopting modern JS-interop practices benefit you when dart2wasm stabilizes. For example, avoid using legacy libraries like `dart:html` and `dart:js`, and prefer `package:web` and `dart:js_interop`. Also, consider checking whether other packages you are using are compatible with Wasm.

## Preloading

### HTML &lt;head tag&gt;, HTTP response headers

[Preloading assets](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/rel/preload) like images, fonts, and JavaScript files can significantly improve webpage loading speed. By preloading within the HTML `<head>` tag or using HTTP response headers, you instruct the browser to download these resources before they’re needed for rendering. This eliminates delays and ensures a smoother user experience. To preload assets, add the `<link>` tag in the `<head>` section and set the `rel` attribute to `preload`. Only preload assets that are used immediately, optimally in the first screen of your app, otherwise browsers will consider the preloading as a waste of bandwidth.

### HTML &lt;head&gt; tag

```xml
<head>
  <link rel="preload" href="assets/logo.webp" as="image" type="image/webp" />
</head>
<body>
  <picture>
    <source src="assets/logo.webp" type="image/webp" />
  </picture>
</body>
```

### HTTP response headers for Firebase hosting

The following code block is a `firebase.json` example with a key/value combo demonstrating how to add HTTP headers for asset preloading.

```json
"headers": [
  {
    "key": "Link",
    "value": "<assets/logo.webp>; rel=preload; as=image"
  }
]
```

### Landing page

Flutter empowers you to build fully interactive landing pages for your app using plain HTML/CSS. While users engage with your landing page, `flutter.js` preloads your Flutter app — ensuring instant launches when the user navigates to the Flutter app. This is especially beneficial for games with a **Play** button and apps that require logging in.

## Loading/splash screen

While we’ve focused on technical optimizations for app loading speed, perceived loading speed is more critical. Your goal should be to make your app *feel fast*.

Loading/splash screens are highly effective in enhancing this perception. By providing visual activity, they reassure users that the app is launching promptly. In contrast, a blank screen breeds uncertainty, potentially leading to frustration and page refreshes.

For the fastest responsiveness, implement your splash screen directly in your `index.html` file using plain CSS/HTML. This minimizes any potential delays.

For an example, check out the [Flutter Gallery implementation](https://github.com/flutter/gallery/blob/cfcb9dbda56697fe8bafe4b64c1a9261dde908ae/web/index.html#L211).

## Conclusion

In this doc, we’ve explored ways to accelerate both the initial loading and rendering performance of your Flutter web app. There are various strategies you can employ, but remember that each solution involves trade-offs. Choose the optimizations that best suit your specific needs and those of your users. By combining these approaches, you’ll create a smoother, more responsive user experience for your Flutter web apps.
