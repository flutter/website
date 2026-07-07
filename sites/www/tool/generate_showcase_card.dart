// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';
import 'package:image/image.dart';

void main(List<String> args) {
  if (args.length < 2) {
    stderr.writeln(
      'Usage: dart run tool/generate_showcase_card.dart <input_logo_path> <output_card_path>',
    );
    exit(1);
  }

  final inputPath = args[0];
  final outputPath = args[1];

  final file = File(inputPath);
  if (!file.existsSync()) {
    stderr.writeln('Error: Input file does not exist at $inputPath');
    exit(1);
  }

  final bytes = file.readAsBytesSync();
  final image = decodeImage(bytes);

  if (image == null) {
    stderr.writeln('Failed to decode image at $inputPath');
    exit(1);
  }

  print('Original dimensions: ${image.width}x${image.height}');

  // Target case study card dimensions:
  const targetWidth = 1450;
  const targetHeight = 1080;

  // We want to scale the logo so it fits comfortably within the target area.
  // 80% of the box width/height max.
  final maxLogoWidth = (targetWidth * 0.8).toInt();
  final maxLogoHeight = (targetHeight * 0.8).toInt();

  // Calculate the aspect ratios.
  final logoRatio = image.width / image.height;
  final boxRatio = maxLogoWidth / maxLogoHeight;

  final int newWidth;
  final int newHeight;
  if (logoRatio > boxRatio) {
    newWidth = maxLogoWidth;
    newHeight = (maxLogoWidth / logoRatio).toInt();
  } else {
    newHeight = maxLogoHeight;
    newWidth = (maxLogoHeight * logoRatio).toInt();
  }

  final resizedLogo = copyResize(
    image,
    width: newWidth,
    height: newHeight,
    interpolation: Interpolation.cubic,
  );

  final bgColor = ColorRgba8(255, 255, 255, 255);
  final canvas = Image(
    width: targetWidth,
    height: targetHeight,
    format: Format.uint8,
    numChannels: 4,
  );
  fill(canvas, color: bgColor);

  // Center the resized logo on the canvas.
  final x = (targetWidth - newWidth) ~/ 2;
  final y = (targetHeight - newHeight) ~/ 2;

  compositeImage(canvas, resizedLogo, dstX: x, dstY: y);

  // Save the result.
  final outFile = File(outputPath);
  // Ensure the output directory exists.
  outFile.parent.createSync(recursive: true);
  outFile.writeAsBytesSync(encodePng(canvas));

  print(
    'Saved padded card to ${outFile.path} (${canvas.width}x${canvas.height})',
  );
}
