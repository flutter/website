// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';

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
  TrackingAssetTransformer();

  final _trackingFile = File(
    p.join('tool', 'used_assets.txt'),
  ).openWrite(mode: FileMode.write);

  @override
  Asset transform(Asset asset, [Object? aspect]) {
    _trackingFile.writeln(asset.path);
    return asset;
  }
}

class ResizingAssetTransformer implements AssetTransformer {
  @override
  Asset transform(Asset asset, [Object? aspect]) {
    final width = aspect is int ? aspect : null;

    if (width == null) {
      return asset;
    }

    final inputExt = p.extension(asset.path).toLowerCase();

    // WebP and AVIF are not supported by the image package.
    if (inputExt case '.webp' || '.avif') {
      return asset;
    }

    final decoder = img.findDecoderForNamedImage(asset.path);
    if (decoder == null) {
      return asset;
    }

    try {
      var image = decoder.decode(asset.readAsBytes());
      if (image == null) {
        return asset;
      }

      if (image.hasPalette) {
        // Expand indexed-color images before resizing and re-encoding.
        image = image.convert(format: img.Format.uint8, numChannels: 4);
      }

      if (image.width <= width) {
        return asset;
      } else {
        final resized = img.resize(
          image,
          width: width,
          maintainAspect: true,
          interpolation: img.Interpolation.average,
        );

        final (encoder, outputExt) = switch (inputExt) {
          '.png' => (img.PngEncoder(level: 6), inputExt),
          '.jpg' || '.jpeg' => (img.JpegEncoder(quality: 100), inputExt),
          '.gif' => (img.GifEncoder(samplingFactor: 30), inputExt),
          _ => (img.PngEncoder(level: 6), '.png'),
        };

        final bytes = encoder.encode(resized);
        final originalSize = asset.readAsBytes().lengthInBytes;
        final newSize = bytes.lengthInBytes;

        // Prevent increasing the file size.
        if (newSize >= originalSize) {
          return asset;
        }

        final outPath = p.setExtension(asset.path, '.w$width$outputExt');
        return Asset.fromBytes(outPath, bytes);
      }
    } catch (e, st) {
      print('[ERROR] Failed to process image: ${asset.path}');
      print(e);
      print(st);

      return asset;
    }
  }
}
