// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dash_media_convert/dash_media_convert.dart';
import 'package:path/path.dart' as path;

import '../utils.dart';

final class OptimizeImagesCommand extends Command<int> {
  static const String _maxWidthOption = 'max-width';
  static const String _lossyPngFlag = 'lossy-png';

  OptimizeImagesCommand() {
    argParser
      ..addOption(
        _maxWidthOption,
        // Twice the widest content column on the sites.
        defaultsTo: '2400',
        valueHelp: 'pixels',
        help: 'Resize images wider than this many pixels. Use 0 to not resize.',
      )
      ..addFlag(
        _lossyPngFlag,
        negatable: false,
        help: 'Encode PNGs lossily at quality 85. Defaults to lossless.',
      );
  }

  @override
  String get description =>
      'Convert the specified PNG and JPEG images to WebP, '
      'replacing the originals.';

  @override
  String get name => 'optimize-images';

  @override
  String get invocation => '${super.invocation} <image paths...>';

  @override
  Future<int> run() async {
    final argResults = this.argResults!;
    final maxWidth = int.tryParse(argResults.option(_maxWidthOption)!);
    if (maxWidth == null || maxWidth < 0) {
      usageException('--$_maxWidthOption must be a non-negative integer.');
    }

    final images = argResults.rest;
    if (images.isEmpty) {
      usageException(
        'Specify the paths of the images to optimize, '
        'either absolute or relative to the repository root.',
      );
    }
    final resolvedRoot = Directory(repositoryRoot).resolveSymbolicLinksSync();
    final imagePaths = <String>[];
    for (final image in images) {
      // Absolute paths are kept as is by `path.join`.
      final imagePath = path.normalize(path.join(repositoryRoot, image));
      if (!File(imagePath).existsSync()) {
        usageException('$image doesn\'t exist.');
      }
      try {
        // Resolve symbolic links so that
        // the image isn't outside the repository.
        // As `validateImagePaths` rejects images that are symbolic links,
        // the WebP image written next to it is in the same directory.
        final source = File(imagePath).resolveSymbolicLinksSync();
        if (!path.isWithin(resolvedRoot, source)) {
          usageException('$image is outside the repository.');
        }
      } on FileSystemException catch (e) {
        usageException('Can\'t resolve $image: ${e.message}.');
      }
      imagePaths.add(imagePath);
    }
    if (validateImagePaths(imagePaths) case final problem?) {
      usageException(problem);
    }

    final ImageOptimizer optimizer;
    try {
      optimizer = await ImageOptimizer.create(
        maxWidth: maxWidth == 0 ? null : maxWidth,
        lossyPng: argResults.flag(_lossyPngFlag),
      );
    } on CwebpException catch (e) {
      stderr.writeln('Error: ${e.message}');
      return 1;
    }

    final results = await optimizer.optimizeFiles(imagePaths);

    var failed = false;
    var optimizedAny = false;
    for (final (:imagePath, :outputPath, :result) in results) {
      final image = path.relative(imagePath, from: repositoryRoot);
      switch (result) {
        case WebpConverted(:final summary):
          optimizedAny = true;
          final output = path.relative(outputPath, from: repositoryRoot);
          print('Converted $image to $output: $summary.');
        case WebpSkipped(:final reason):
          print('Kept $image because ${reason.description}.');
        case WebpFailed(:final message):
          failed = true;
          stderr.writeln('Error: Can\'t optimize $image because $message.');
      }
    }

    if (optimizedAny) {
      print(
        '\nUpdate any references to the converted images '
        'to use their .webp file extension.',
      );
    }

    return failed ? 1 : 0;
  }
}
