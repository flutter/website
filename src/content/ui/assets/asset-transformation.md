---
title: Transforming assets at build time
description: How to set up automatic transformation of images (and other assets) in your Flutter app.
short-title: Asset transformation
---

You can configure your project to automatically transform assets
at build time using compatible Dart packages.

## Specifying asset transformations

In the `pubspec.yaml` file, list the assets to be transformed and the associated
transformer package.

```yaml
flutter:
  assets:
    - path: assets/logo.svg
      transformers:
        - package: vector_graphics_compiler
```

With this configuration, `assets/logo.svg` is transformed by the
[`vector_graphics_compiler`][] package as it is copied to the build output. This
package precompiles SVG files into an optimized binary files that can be
displayed using the [`vector_graphics`][] package, like so:

<?code-excerpt "ui/assets_and_images/lib/logo.dart (TransformedAsset)"?>
```dart
import 'package:vector_graphics/vector_graphics.dart';

const Widget logo = VectorGraphic(
  loader: AssetBytesLoader('assets/logo.svg'),
);
```

### Passing arguments to asset transformers

To pass a string of arguments to an asset transformer,
also specify that in the pubspec:

```yaml
flutter:
  assets:
    - path: assets/logo.svg
      transformers:
        - package: vector_graphics_compiler
          args: ['--tessellate', '--font-size=14']
```

### Chaining asset transformers

Asset transformers can be chained and are applied in
the order they are declared.
Consider the following example using imaginary packages:

```yaml
flutter:
  assets:
    - path: assets/bird.png
      transformers:
        - package: grayscale_filter
        - package: png_optimizer
```

Here, `bird.png` is transformed by the `grayscale_filter` package.
The output is then transformed by the `png_optimizer` package before being
bundled into the built app.

## Writing asset transformer packages

An asset transformer is a Dart [command-line app][] that is invoked with
`dart run` with at least two arguments: `--input`, which contains the path to
the file to transform and `--output`, which is the location where the
transformer code must write its output to.

If the transformer applications finishes with a non-zero exit code, the build
fails with error message explaining that transformation of the asset failed.
Anything written to the [`stderr`] stream of the process by the transformer is
included in the error message.

## Sample

For a sample Flutter project that uses asset transformation and includes a custom
Dart package that is used as a transformer, check out the
[asset_transformers project in the Flutter samples repo][].

[command-line app]: {{site.dart-site}}/tutorials/server/cmdline
[asset_transformers project in the Flutter samples repo]: {{site.repo.samples}}/tree/main/asset_transformation
[`vector_graphics_compiler`]: {{site.pub}}/packages/vector_graphics_compiler
[`vector_graphics`]: {{site.pub}}//packages/vector_graphics
[`stderr`]: {{site.api}}/flutter/dart-io/Process/stderr.html
