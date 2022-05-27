---
title: Adding ImageProvider.loadBuffer
description: ImageProviders should now be implemented using the new loadBuffer
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


Landed in version: xxx<br>
In stable release: not yet
Reverted in version: xxx  (OPTIONAL, delete if not used)

## References

{% comment %}
  These links are commented out because they
  cause the GitHubActions (GHA) linkcheck to fail.
  Remove the comment tags once you fill this in with
  real links. Only use the "master-api" include if
  you link to "master-api.flutter.dev".

{% include docs/master-api.md %}

API documentation:

* [`ClassName`][]

Relevant issues:

* [Issue xxxx][]
* [Issue yyyy][]

Relevant PRs:

* [PR title #1][]
* [PR title #2][]
{% endcomment %}

{% comment %}
  Add the links to the end of the file in alphabetical order.
  The following links are commented out because they make
  the GitHubActions (GHA) link checker believe they are broken links,
  but please remove the comment tags before you commit!

  If you are sharing new API that hasn't landed in
  the stable channel yet, use the master channel link.
  To link to docs on the master channel,
  include the following note and make sure that
  the URL includes the master link (as shown below).

  Here's an example of defining a stable (site.api) link
  and a master channel (master-api) link.

<!-- Stable channel link: -->
[`ClassName`]: {{site.api}}/flutter/[link_to_relevant_page].html

<!-- Master channel link: -->
{% include docs/master-api.md %}

[`ClassName`]: {{site.master-api}}/flutter/[link_to_relevant_page].html

[Issue xxxx]: {{site.repo.flutter}}/issues/[link_to_actual_issue]
[Issue yyyy]: {{site.repo.flutter}}/issues/[link_to_actual_issue]
[PR title #1]: {{site.repo.flutter}}/pull/[link_to_actual_pr]
[PR title #2]: {{site.repo.flutter}}/pull/[link_to_actual_pr]
{% endcomment %}