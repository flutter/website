---
title: Browser-native text layout with WebParagraph
description: >-
  Try WebParagraph, Flutter's experimental text layout engine for the web
  that uses the browser's own text APIs instead of a bundled copy of them.
shortTitle: WebParagraph
---

WebParagraph is a new implementation of Flutter's text layout system
(`ParagraphBuilder`, `Paragraph`, and related `dart:ui` APIs) for the web.
Instead of shipping a text stack inside the CanvasKit WebAssembly bundle,
WebParagraph delegates text shaping, measurement, and font fallback to
the browser through the [Enhanced TextMetrics API][enhanced-textmetrics].

:::experimental
WebParagraph is experimental and off by default.
It works only in Chromium-based browsers that expose the `TextCluster` API,
which is behind a flag.
Text layout and rendering details can change between Flutter releases.
Don't ship production apps with WebParagraph enabled.
:::

[enhanced-textmetrics]: https://chromestatus.com/feature/5075532483657728

## Why WebParagraph

Browsers already contain a complete text layout system,
but it isn't exposed to web apps in a way that Flutter can use.
As a result, every Flutter web app bundles a copy of
HarfBuzz, FreeType, a WOFF2 decoder, and font management code,
and downloads fallback fonts at runtime to cover glyphs
that the bundled fonts don't have.

WebParagraph removes that duplication:

- **Smaller download**: The `webparagraph` CanvasKit variant omits
  SkParagraph, SkShaper, HarfBuzz, FreeType, and the WOFF2 decoder.
- **No fallback font downloads**: The browser resolves missing glyphs
  from fonts already installed on the user's device,
  so Flutter doesn't fetch fallback fonts from the network.
- **No tofu**: Characters that the bundled fonts don't cover
  render with the browser's own fallback instead of as empty boxes.
- **Platform emoji**: Emoji render with the platform's emoji font,
  such as Apple Color Emoji on macOS.

For the list of issues WebParagraph is designed to resolve,
visit the [WebParagraph umbrella issue][umbrella].

[umbrella]: {{site.repo.flutter}}/issues/172561

## Requirements

WebParagraph is used only when all of the following are true.
If any condition isn't met, the `preferWebParagraph` flag has no effect
and Flutter uses its default text layout.

Flutter version
: Use the latest stable release of Flutter.

Renderer
: WebParagraph runs on the CanvasKit renderer, which is used by
  JavaScript builds of your app.
  The Skwasm renderer used by WebAssembly builds doesn't support it yet.
  If you build with `--wasm`, set `renderer: 'canvaskit'` in your
  Flutter configuration so the loader picks the JavaScript build.

Browser
: A Chromium-based browser (Chrome, Edge, and others) with the
  `TextCluster` API available.
  In Chrome, the API is behind the
  **Experimental Web Platform features** flag:
  open `chrome://flags/#enable-experimental-web-platform-features`,
  set it to **Enabled**, and relaunch the browser.
  To check when Chrome enables the API by default, visit the
  [Enhanced Canvas TextMetrics status page][enhanced-textmetrics].

To confirm the browser exposes the API,
run the following in the DevTools console:

```js
typeof TextCluster !== 'undefined'
```

## Enable WebParagraph

Enable WebParagraph by setting `preferWebParagraph: true` in your app's
[Flutter configuration][].
The simplest way is a custom `flutter_bootstrap.js` file
in your app's `web/` directory:

```js title="web/flutter_bootstrap.js" highlightLines=6
{% raw %}{{flutter_js}}{% endraw %}
{% raw %}{{flutter_build_config}}{% endraw %}

_flutter.loader.load({
  config: {
    preferWebParagraph: true,
  },
});
```

If you build with `--wasm`,
also force the CanvasKit renderer:

```js title="web/flutter_bootstrap.js" highlightLines=6-7
{% raw %}{{flutter_js}}{% endraw %}
{% raw %}{{flutter_build_config}}{% endraw %}

_flutter.loader.load({
  config: {
    renderer: 'canvaskit',
    preferWebParagraph: true,
  },
});
```

[Flutter configuration]: /platform-integration/web/initialization#customize-the-flutter-loader

### Run the app

`flutter run -d chrome` launches Chrome with a separate user profile,
so the flag you set in `chrome://flags` doesn't apply to it.
Pass the Chrome command-line switch through `flutter run` instead:

```console
$ flutter run -d chrome --web-browser-flag=--enable-experimental-web-platform-features
```

To test a release build, build the app and serve the output directory:

```console
$ flutter build web
```

Then open the app in a browser where you enabled the
**Experimental Web Platform features** flag.

### Verify that WebParagraph is active

When WebParagraph is active, the loader downloads the
`webparagraph` variant of CanvasKit instead of the regular one.
Open the **Network** panel in DevTools and filter by `canvaskit`.
You should see requests for `canvaskit/webparagraph/canvaskit.js`
and `canvaskit/webparagraph/canvaskit.wasm`.

If you instead see `canvaskit/chromium/canvaskit.wasm` or
`canvaskit/canvaskit.wasm`, one of the [requirements](#requirements)
isn't met.

## Report issues

If text renders differently with WebParagraph than without it,
file an issue in the [Flutter repository][new-issue]
with a minimal reproduction and the Chrome version you used,
and mention WebParagraph in the title.
Follow the [umbrella issue][umbrella] for progress updates.

[new-issue]: {{site.repo.flutter}}/issues/new/choose
