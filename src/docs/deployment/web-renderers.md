---
title: Web renderers
description: How to choose a web renderer for running and building a web app.
---

When running and building apps for the web, you can choose between two different
rendering modes. Additionally, Flutter provides an "auto" mode that can switch
between them based on the device. This page describes these renderers and how to
choose the best one for your needs. The two renderers are:

**HTML**
  : Uses a combination of HTML elements, CSS, Canvas elements, and SVG
  elements. This renderer has a smaller download size, 200KB for a simple app.

**CanvasKit**
  : Uses Skia compiled to WebAssembly and rendered to WebGL. This
  renderer is fully consistent with Flutter mobile and desktop, has faster
  performance, and is less likely to have differences across browsers, but adds
  about 2MB in download size.

## Command line flags

The `--web-renderer` command line option takes one of three values, `html`,
`canvaskit`, or `auto`.

Choose the **html** renderer when optimizing for code size over performance on
desktop and mobile devices.

Choose the **canvaskit** renderer for applications that prioritize performance
and pixel-perfect consistency.

Choose the **auto** option (default) to switch between `html` on mobile browsers
and `canvaskit` on desktop browsers.

This flag can be used with the `run` or `build` subcommands. For example:

```
flutter run -d chrome --web-renderer html
flutter build web --web-renderer canvaskit
```

## Examples

Run in Chrome using the default renderer option (`auto`):

```
flutter run -d chrome
```

Build your app in release mode, using just the CanvasKit renderer:

```
flutter build web --web-renderer canvaskit --release
```

Run  your app in profile mode using the HTML renderer:

```
flutter run -d chrome --web-renderer html --profile
```
