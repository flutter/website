---
title: Raw images on Web uses correct origin and colors
description: Raw images directly decoded by calling the Web engine functions now uses the correct pixel format and starts from the top left corner.

---

## Summary

How raw images are rendered on Web has been corrected
and is now consistent with that on other platforms.
This breaks legacy apps that had to feed incorrect data
to `ui.ImageDescriptor.raw` or `ui.decodeImageFromPixels`,
causing the resulting images to be upside-down
and incorrectly colored
(whose red and blue channels are swapped.)

## Context

The "pixel stream" that Flutter uses internally
has always been defined as the same format:
for each pixel, four 8-bit channels are packed in the order defined
by a `format` argument, then grouped in a row,
from left to right, then rows from top to bottom.

However, Flutter for Web, or more specifically, the HTML renderer,
used to implement it in a wrong way
due to incorrect understanding of the BMP format specification.
As a result, if the app or library uses
`ui.ImageDescriptor.raw` or `ui.decodeImageFromPixels`,
it had to feed pixels from bottom to top and swap their red and blue channels
(for example, with the `ui.PixelFormat.rgba8888` format,
the first 4 bytes of the data were considered the blue, green, red, and alpha channels
of the first pixel instead.)

This bug has been fixed by [engine#29593][].
But apps and libraries will have to correct how their data are generated.

## Description of change

The `pixels` argument of `ui.ImageDescriptor.raw` or `ui.decodeImageFromPixels`
now uses the correct pixel order described by `format`,
and originates from the top left corner.

Images rendered by directly calling these two functions
Legacy code that invokes these functions directly might
find their images upside down and colored incorrectly.

## Migration guide

If the app uses the latest version of Flutter and experiences this situation,
the most direct solution is to manually flip the image, and use the alternate
pixel format. However, this is unlikely the most optimized solution,
since such pixel data are usually constructed from other sources,
allowing flipping during the construction process.

Code before migration:

<!-- skip -->
```dart
import 'dart:typed_data';
import 'dart:ui' as ui;

// Parse `image` as a displayable image.
//
// Each byte in `image` is a pixel channel, in the order of blue, green, red,
// and alpha, starting from the bottom left corner and going row first.
Future<ui.Image> parseMyImage(Uint8List image, int width, int height) async {
  final ui.ImageDescriptor descriptor = ui.ImageDescriptor.raw(
    await ui.ImmutableBuffer.fromUint8List(image),
    width: width,
    height: height,
    pixelFormat: ui.PixelFormat.rgba8888,
  );
  return (await (await descriptor.instantiateCodec()).getNextFrame()).image;
}
```

Code after migration:

<!-- skip -->
```dart
import 'dart:typed_data';
import 'dart:ui' as ui;

Uint8List verticallyFlipImage(Uint8List sourceBytes, int width, int height) {
  final Uint32List source = Uint32List.sublistView(ByteData.sublistView(sourceBytes));
  final Uint32List result = Uint32List(source.length);
  int sourceOffset = 0;
  int resultOffset = 0;
  for (final int row = height - 1; row >= 0; row -= 1) {
    sourceOffset = width * row;
    for (final int col = 0; col < width; col += 1) {
      result[resultOffset] = source[sourceOffset];
      resultOffset += 1;
      sourceOffset += 1;
    }
  }
  return Uint8List.sublistView(ByteData.sublistView(sourceBytes))
}

Future<ui.Image> parseMyImage(Uint8List image, int width, int height) async {
  final Uint8List correctedImage = verticallyFlipImage(image, width, height);
  final ui.ImageDescriptor descriptor = ui.ImageDescriptor.raw(
    await ui.ImmutableBuffer.fromUint8List(correctedImage),
    width: width,
    height: height,
    pixelFormat: ui.PixelFormat.rgba8888,
  );
  return (await (await descriptor.instantiateCodec()).getNextFrame()).image;
}
```

A trickier situation is when you're writing a library,
and you want this library to work on both the most recent Flutter
and a pre-patch one.
In that case, you can decide whether the behavior has been changed
by letting it decode a single pixel first.

Code after migration:

<!-- skip -->
```dart
Uint8List verticallyFlipImage(Uint8List sourceBytes, int width, int height) {
  // Same as the example above.
}

late Future<bool> imageRawUsesCorrectBehavior = (() async {
  final ui.ImageDescriptor descriptor = ui.ImageDescriptor.raw(
    await ui.ImmutableBuffer.fromUint8List(Uint8List.fromList(<int>[0xED, 0, 0, 0])),
    width: 1, height: 1, pixelFormat: ui.PixelFormat.rgba8888);
  final ui.Image image = (await (await descriptor.instantiateCodec()).getNextFrame()).image;
  final Uint8List resultPixels = Uint8List.sublistView(
    (await image.toByteData(format: ui.ImageByteFormat.rawStraightRgba))!);
  return resultPixels[0] == 0xED;
})();

Future<ui.Image> parseMyImage(Uint8List image, int width, int height) async {
  final Uint8List correctedImage = (await imageRawUsesCorrectBehavior) ?
    verticallyFlipImage(image, width, height) : image;
  final ui.ImageDescriptor descriptor = ui.ImageDescriptor.raw(
    await ui.ImmutableBuffer.fromUint8List(correctedImage), // Use the corrected image
    width: width,
    height: height,
    pixelFormat: ui.PixelFormat.bgra8888, // Use the alternate format
  );
  return (await (await descriptor.instantiateCodec()).getNextFrame()).image;
}
```

## Timeline

Landed in version: 2.9.0-0.0.pre<br>
In stable release: not yet

## References

API documentation:

* [`decodeImageFromPixels`][]
* [`ImageDescriptor.raw`][]

Relevant issues:

* [[Web] Regression in Master - PDF display distorted due to change in BMP Encoder][]
* [[web] ImageDescriptor.raw flips and inverts images (partial reason included)][]

Relevant PRs:

* [[Web] Reland: Fix BMP encoder][]

<!-- Stable channel link: -->
[`decodeImageFromPixels`]: {{site.api}}/flutter/dart-ui/decodeImageFromPixels.html
[`ImageDescriptor.raw`]: {{site.api}}/flutter/dart-ui/ImageDescriptor/ImageDescriptor.raw.html

[[Web] Regression in Master - PDF display distorted due to change in BMP Encoder]: {{site.repo.flutter}}/issues/93615
[[web] ImageDescriptor.raw flips and inverts images (partial reason included)]: {{site.repo.flutter}}/issues/89610

[engine#29593]: {{site.repo.engine}}/pull/29593
[[Web] Reland: Fix BMP encoder]: {{site.repo.engine}}/pull/29593
