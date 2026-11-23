// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as p;

extension AssetExtension on BuildContext {
  String asset(String path, {int? width}) {
    return resolveAsset(path, aspect: width);
  }
}

class TrackingAssetTransformer implements AssetTransformer {
  TrackingAssetTransformer() {
    _trackingFile.writeAsStringSync('');
  }

  final File _trackingFile = File(p.join('tool', 'used_assets.txt'));

  @override
  Asset transform(Asset asset, [Object? _]) {
    _trackingFile.writeAsStringSync('${asset.path}\n', mode: .append);
    return asset;
  }
}

class ResizingAssetTransformer implements AssetTransformer {
  const ResizingAssetTransformer();

  @override
  Asset transform(Asset asset, [Object? aspect]) {
    final width = aspect is int ? aspect : null;

    if (width == null) {
      return asset;
    }

    final inputExt = p.extension(asset.path).toLowerCase();

    // AVIF isn't supported by the image package.
    if (inputExt == '.avif') {
      return asset;
    }

    final headerDecoder = img.findDecoderForNamedImage(asset.path);
    if (headerDecoder == null) {
      return asset;
    }

    try {
      final sourceBytes = asset.readAsBytes();
      final decodedSource = _decodeSourceForResize(
        asset.path,
        headerDecoder,
        sourceBytes,
        width,
      );
      if (decodedSource == null) {
        return asset;
      }

      final resized = img.resize(
        decodedSource.image,
        width: width,
        maintainAspect: true,
        interpolation: img.Interpolation.average,
      );

      final (encoder, outputExt) = _encoderForExtension(
        inputExt,
        losslessWebP: decodedSource.losslessWebP,
      );
      final bytes = encoder.encode(resized);
      if (bytes.lengthInBytes >= sourceBytes.lengthInBytes) {
        return asset;
      }

      final outPath = p.setExtension(asset.path, '.w$width$outputExt');
      return Asset.fromBytes(outPath, bytes);
    } catch (e, st) {
      print('[ERROR] Failed to process image: ${asset.path}');
      print(e);
      print(st);

      return asset;
    }
  }
}

/// Decodes [sourceBytes] for resizing to [targetWidth] pixels wide,
/// or returns `null` if the image is already that narrow,
/// is an animated WebP, or can't be decoded.
///
/// To skip a full decode when possible,
/// [headerDecoder] first reads only the image header.
///
/// The returned image has any palette expanded to RGBA,
/// and `losslessWebP` indicates whether the source is a lossless WebP,
/// so the resized image can be encoded the same way.
({img.Image image, bool losslessWebP})? _decodeSourceForResize(
  String assetPath,
  img.Decoder headerDecoder,
  Uint8List sourceBytes,
  int targetWidth,
) {
  final info = headerDecoder.startDecode(sourceBytes);
  if (info != null && info.width <= targetWidth) {
    return null;
  }

  // Keep animated WebPs as is, since decoding and
  // re-encoding every frame is slow and memory intensive.
  if (info is img.WebPInfo && info.hasAnimation) {
    return null;
  }

  // Decode with a fresh decoder instance because stateful decoders such as
  // PngDecoder append to internal chunk/frame lists on each startDecode call.
  var image = img.decodeNamedImage(assetPath, sourceBytes);
  if (image == null || image.width <= targetWidth) {
    return null;
  }

  if (image.hasPalette) {
    // Expand indexed-color images before resizing and re-encoding.
    image = image.convert(format: img.Format.uint8, numChannels: 4);
  }

  final losslessWebP =
      info is img.WebPInfo && info.format == img.WebPFormat.lossless;
  return (image: image, losslessWebP: losslessWebP);
}

/// Returns the encoder and output file extension for
/// a resized image whose source has the [inputExt] extension.
///
/// WebP images are encoded losslessly if [losslessWebP] is `true`.
/// Formats without a matching encoder are converted to PNG.
(img.Encoder, String) _encoderForExtension(
  String inputExt, {
  required bool losslessWebP,
}) => switch (inputExt) {
  '.png' => (img.PngEncoder(level: 6), inputExt),
  '.jpg' || '.jpeg' => (img.JpegEncoder(quality: 100), inputExt),
  '.gif' => (img.GifEncoder(samplingFactor: 30), inputExt),
  '.webp' => (
    img.WebPEncoder(lossless: losslessWebP, quality: 85, method: 4),
    inputExt,
  ),
  _ => (img.PngEncoder(level: 6), '.png'),
};
