---
title: Display images on the web
short-title: Web images
description: Learn how to load and display images on the web.
---

The web supports the standard [`Image`][] widget and the more 
advanced [`dart:ui/Image`][] class (where more fine-grained control 
is needed to display images).
However, because web browsers are built to run untrusted code safely,
there are certain limitations in what you can do with images compared
to mobile and desktop platforms. This page explains these limitations
and offers ways to work around them.

[`Image`]: {{site.api}}/flutter/widgets/Image-class.html
[`dart:ui/Image`]: {{site.api}}/flutter/dart-ui/Image-class.html

:::note
For information on how to optimize web loading speed,
check out the (free) article on Medium,
[Best practices for optimizing Flutter web loading speed][article].

[article]: {{site.flutter-medium}}/best-practices-for-optimizing-flutter-web-loading-speed-7cc0df14ce5c
:::

## Background

The web offers several methods for displaying images:

- The built-in [`<img>`][] and [`<picture>`][] HTML elements
- The [`drawImage`][] method on the [`<canvas>`][] element
- Custom image codec that renders to a WebGL canvas

Each option has its own benefits and drawbacks.
For example, the built-in elements fit nicely among
other HTML elements, and they automatically take
advantage of browser caching, and built-in image
optimization and memory management.
They allow you to safely display images from arbitrary sources
(more on than in the CORS section below).
`drawImage` is great when the image must fit within
other content rendered using the `<canvas>` element.
You also gain control over image sizing and,
when the CORS policy allows it, read the pixels
of the image back for further processing.
Finally, WebGL gives you the highest degree of
control over the image. Not only can you read the pixels and
apply custom image algorithms, but you can also use GLSL for
hardware-acceleration.

[`<img>`]: https://developer.mozilla.org/docs/Web/HTML/Element/img
[`<picture>`]: https://developer.mozilla.org/docs/Web/HTML/Element/picture
[`drawImage`]: https://developer.mozilla.org/docs/Web/API/CanvasRenderingContext2D/drawImage
[`<canvas>`]: https://developer.mozilla.org/docs/Web/HTML/Element/canvas

## Cross-Origin Resource Sharing (CORS)

[CORS][] is a mechanism that browsers use to control how
one site accesses the resources of another site. It is
designed such that, by default, one web-site is not
allowed to make HTTP requests to another site using
[XHR][] or [`fetch`][].  
This prevents scripts on another site from acting on
behalf of the user and from gaining access to another
site's resources without permission.

On the web, Flutter renders apps using the CanvasKit
or skwasm (when using Wasm) renderers. These both rely
on WebGL. WebGL requires access to the raw image data
(bytes) in order to be able to render the image.
Therefore, images must only come from servers that
have a CORS policy configured to work with the domain
that serves your application.

:::note   
For more information about web renderers, see
[Web renderers][].
:::

:::version-note
The HTML web renderer has fewer CORS limitations, but does
not support the full feature set as the WebGL renderers do.

The HTML renderer will be deprecated and removed in a 
future Flutter version. Therefore, the HTML method to render
images using `<img>` & `<picture>` elements will no longer be
applicable to Flutter (without a platform view).
:::

[CORS]: https://developer.mozilla.org/docs/Web/HTTP/CORS
[XHR]: https://developer.mozilla.org/docs/Web/API/XMLHttpRequest
[`fetch`]: https://developer.mozilla.org/docs/Web/API/Fetch_API/Using_Fetch
[Web renderers]: /platform-integration/web/renderers

## Solutions

There are multiple solutions to workaround CORS restrictions
in Flutter.

### In-memory, asset, and same-origin network images

If the app has the bytes of the encoded image in memory,
provided as an [asset][], or stored on the
same server that serves the application
(also known as _same-origin_), no extra effort is necessary.
The image can be displayed using
[`Image.memory`][], [`Image.asset`][], or [`Image.network`][].

[asset]: /ui/assets/assets-and-images
[`Image.memory`]: {{site.api}}/flutter/widgets/Image/Image.memory.html
[`Image.asset`]: {{site.api}}/flutter/widgets/Image/Image.asset.html
[`Image.network`]: {{site.api}}/flutter/widgets/Image/Image.network.html

### Host images in a CORS-enabled CDN

Typically, content delivery networks (CDN)
can be configured to customize what domains
are allowed to access your content.
For example, Firebase site hosting allows
[specifying a custom][custom-header] `Access-Control-Allow-Origin`
header in the `firebase.json` file.

[custom-header]: {{site.firebase}}/docs/hosting/full-config#headers

### Use a CORS proxy if you have no control over the origin server

If the image server cannot be configured to allow CORS
requests from your application,
you might still be able to load images by proxying
the requests through another server. This requires that the
intermediate server has sufficient access to load the images.

This method can be used in situations when the original
image server serves images publicly,
but is not configured with the correct CORS headers.

Examples:

* Using [CloudFlare Workers][].
* Using [Firebase Functions][].

[CloudFlare Workers]: https://developers.cloudflare.com/workers/examples/cors-header-proxy
[Firebase Functions]: {{site.github}}/7kfpun/cors-proxy

### Use a HTML platform view

If none of the other solutions work for your app, Flutter
supports embedding raw HTML inside the app using
[`HtmlElementView`][].  Use it to create an `<img>`
element to render the image from another domain.

[`HtmlElementView`]: {{site.api}}/flutter/widgets/HtmlElementView-class.html
