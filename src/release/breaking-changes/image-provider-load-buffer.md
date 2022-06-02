---
title: Adding ImageProvider.loadBuffer
description: ImageProviders must now be implemented using the new loadBuffer
API instead of the existing load API.
---

## Summary

* `ImageProvider` now has a method called `loadBuffer` which functions
   similarly to `load`, except that it decodes from an `ui.ImmutableBuffer`.
* `ui.ImmutableBuffer` can now be created directly from an asset key.
* The `AssetBundle` classes can now load an `ui.ImmutableBuffer`.
* The `PaintingBinding` now has a method called
  `instantiateImageCodecFromBuffer` which functions similarly to
  `instantiateImageCodec`.
* `ImageProvider.load` is now deprecated, it will be removed in a future
   release.
* `PaintingBinding.instantiateImageCodec` is now deprecated, it will be removed
   in a future release.

## Context

`ImageProvider.loadBuffer` is a new method that must be implemented in order to
load images. This API allows asset-based image loading to be performed faster
and with less memory impact on application.

## Description of change

When loading asset images, previously the image provider API required multiple
copies of the compressed data. First, when opening the asset the data was
copied into the external heap and exposed to Dart as a typed data array. Then
that typed data array was eventually converted into an `ui.ImmutableBuffer`
which internally copies the data into a second structure for decoding.

With the addition of `ui.ImmutableBuffer.fromAsset`, compressed image bytes can
be loaded directly into the structure used for decoding. Utilizing this
requires changes to the byte loading pipeline of `ImageProvider`. This process
is also faster, because it bypasses some additional scheduling overhead of the
previous method channel based loader.

`ImageProvider.loadBuffer` otherwise has the same contract as
`ImageProvider.load`, except it provides a new decoding callback that expects
an `ui.ImmutableBuffer` instead of a `Uint8List`. For `ImageProvider` classes
that acquire bytes from places other than assets, the convience method
`ui.ImmutableBuffer.fromUint8List` can be used for compatibility.

## Migration guide

Class which subclass `ImageProvider` must implement the `loadBuffer` method for
loading assets. Classes which delegate to or call the methods of an
`ImageProvider` directly must use `loadBuffer` instead of `load`.

Code before migration:

<!-- skip -->
```dart
class MyImageProvider extends ImageProvider<MyImageProvider> {
  @override
  ImageStreamCompleter load(MyImageProvider key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
        codec: _loadData(key, decode),
    );
  }

  Future<ui.Codec> _loadData(MyImageProvider key, DecoderCallback decode) async {
    final Uint8List bytes = await bytesFromSomeApi();
    return decode(bytes);
  }
}

class MyDelegatingProvider extends ImageProvider<MyDelegatingProvider> {
  MyDelegatingProvider(this.provider);

  final ImageProvder provider;

  @override
  ImageStreamCompleter load(MyDelegatingProvider key, DecoderCallback decode) {
    return provider.load(key, decode);
  }
}
```

Code after migration:

<!-- skip -->
```dart
class MyImageProvider extends ImageProvider<MyImageProvider> {
  @override
  ImageStreamCompleter loadBuffer(MyImageProvider key, DecoderBufferCallback decode) {
    return MultiFrameImageStreamCompleter(
        codec: _loadData(key, decode),
    );
  }

  Future<ui.Codec> _loadData(MyImageProvider key, DecoderBufferCallback decode) async {
    final Uint8List bytes = await bytesFromSomeApi();
    final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    return decode(buffer);
  }
}

class MyDelegatingProvider extends ImageProvider<MyDelegatingProvider> {
  MyDelegatingProvider(this.provider);

  final ImageProvder provider;

  @override
  ImageStreamCompleter loadBuffer(MyDelegatingProvider key, DecoderCallback decode) {
    return provider.loadBuffer(key, decode);
  }
}
```

In both cases you may choose to keep the previous implementation of `ImageProvider.load`
to give users of your code time to migrate as well.

## Timeline

Landed in version: 3.1.0-0.0.pre.976
In stable release: not yet

## References

API documentation:

* [`ImmutableBuffer`]: {{site.master-api}}/flutter/dart-ui/ImmutableBuffer-class.html
* [`ImageProvider`]: {{site.master-api}}/painting/ImageProvider-class.html

Relevant PRs:

* [Use immutable buffer for loading asset images]: {{site.repo.flutter}}/pull/103496
