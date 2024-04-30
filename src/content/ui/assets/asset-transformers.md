---
title: Transforming assets at build time
description: How to set up automatic transformation of images (and other assets) in your Flutter app.
short-title: Asset transformation
---

You can configure your project to automatically transform assets using
compatible Dart packages.

## Specifying asset transformations

You can describe which assets should transformed and which package should be
used transform them in your `pubspec.yaml` file.

```yaml
flutter:
  assets:
    - path: assets/logo.svg
      transformers:
        - package: vector_graphics_compiler
```

With this configuration, `assets/logo.svg` will be transformed by the
`vector_graphics_compiler` package as it is copied to the build output. This
package precompiles SVG files into an optimized binary files that can be
displayed using the `vector_graphics` package, like so:

<?code-excerpt "ui/assets_and_images/lib/logo.dart (TransformedAsset)"?>
```dart
import 'package:vector_graphics/vector_graphics.dart';

const Widget logo = VectorGraphic(
  loader: AssetBytesLoader('assets/logo.svg'),
);
```

## Asset tranformer features

You can specify a string of arguments to passed to an asset transformer, just like
a command-line program:

```yaml
flutter:
  assets:
    - path: assets/logo.svg
      transformers:
        - package: vector_graphics_compiler
          args: '--tessellate --font-size=14'
```

In addition, asset transformers can be chained, with transformations applying in
the order they are declared. Consider this example using made-up packages:

```yaml
flutter:
  assets:
    - path: assets/bird.png
      transformers:
      - package: grayscale_filter
      - package: png_optimizer
```

Here, `bird.png` is transformed by the `grayscale_filter` package. The output
is then transformed by `png_optimizer`. 

## Writing asset transformer packages

An asset transformer is a Dart [command-line app][] that is invoked with
`dart run` with at least two arguments: `--input`, which contains the path to
the file to transform and `--output`, which is the location where the
transformer code must write its output to.

For a sample Flutter project that uses asset transformation and includes a custom
Dart package that is used as a transformer, check out the [asset_transformers project
in the Flutter samples repo][].

[command-line app]: {{site.dart-site}}/tutorials/server/cmdline
[asset_transformers project in the Flutter samples repo]: {{site.repo.samples}}/tree/main/experimental/asset_transformation