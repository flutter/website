// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart' as path;

void main() async {
  final usedAssetsFile = File(path.join('tool', 'used_assets.txt'));
  if (!usedAssetsFile.existsSync()) {
    print('Error: tool/used_assets.txt not found.');
    exit(1);
  }

  final usedAssets = usedAssetsFile.readAsLinesSync().toSet();

  final contentDir = Directory('content');
  if (!contentDir.existsSync()) {
    print('Error: content/ directory not found.');
    exit(1);
  }

  final assetExtensions = {
    '.png',
    '.jpg',
    '.jpeg',
    '.gif',
    '.svg',
    '.mp4',
    '.mov',
    '.webm',
    '.ico',
    '.webp',
  };

  final unusedAssets = <String>[];
  var totalAssets = 0;

  await for (final entity in contentDir.list(recursive: true)) {
    if (entity is File) {
      final ext = p.extension(entity.path).toLowerCase();
      if (assetExtensions.contains(ext)) {
        totalAssets++;
        final relativePath = p.relative(entity.path, from: contentDir.path);
        if (!usedAssets.contains(relativePath)) {
          unusedAssets.add(relativePath);
        }
      }
    }
  }

  print('--- Asset Usage Report ---');
  print('Total assets found in content/: $totalAssets');
  print('Used assets (from used_assets.txt): ${usedAssets.length}');
  print('Unused assets found: ${unusedAssets.length}');
  print('');

  if (unusedAssets.isNotEmpty) {
    print('Unused Assets:');
    for (final asset in unusedAssets.sortedBy((a) => a.toLowerCase())) {
      print(' - $asset');
    }
  } else {
    print('No unused assets found!');
  }
}
