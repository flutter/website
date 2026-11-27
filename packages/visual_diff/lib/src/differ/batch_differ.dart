// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

import '../models/diff_entry.dart';
import '../models/diff_manifest.dart';
import '../models/header_metadata.dart';
import 'pixel_differ.dart';

/// Parses a snapshot filename (e.g. `reference__flutter-cli@desktop.png`)
/// into its constituent route and viewport components.
({String route, String viewport}) parseSnapshotName(String filename) {
  final base = path.basenameWithoutExtension(filename);
  final atIndex = base.indexOf('@');

  final String routeKey;
  final String viewport;

  if (atIndex != -1) {
    routeKey = base.substring(0, atIndex);
    viewport = base.substring(atIndex + 1);
  } else {
    routeKey = base;
    viewport = 'desktop';
  }

  final String route;
  if (routeKey == '__root__') {
    route = '/';
  } else if (routeKey.startsWith('/')) {
    route = routeKey;
  } else {
    final segments = routeKey.split('__');
    route = '/${segments.join('/')}';
  }

  return (route: route, viewport: viewport);
}

String _normalizeTargetRoute(String raw) {
  var route = raw.trim();
  if (!route.startsWith('/')) {
    route = '/$route';
  }
  if (route.length > 1 && route.endsWith('/')) {
    route = route.substring(0, route.length - 1);
  }
  return route;
}

/// Fast bitwise comparison of two byte buffers using 64-bit word chunks.
bool _bytesEqual(Uint8List a, Uint8List b) {
  if (identical(a, b)) return true;
  if (a.lengthInBytes != b.lengthInBytes) return false;
  if (a.offsetInBytes % 8 != 0 || b.offsetInBytes % 8 != 0) {
    for (var i = 0; i < a.lengthInBytes; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
  final wordsA = a.buffer.asUint64List(a.offsetInBytes, a.lengthInBytes ~/ 8);
  final wordsB = b.buffer.asUint64List(b.offsetInBytes, b.lengthInBytes ~/ 8);
  for (var i = 0; i < wordsA.length; i++) {
    if (wordsA[i] != wordsB[i]) return false;
  }
  final offset = wordsA.length * 8;
  for (var i = offset; i < a.lengthInBytes; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

@visibleForTesting
bool bytesEqualForTesting(Uint8List a, Uint8List b) => _bytesEqual(a, b);

/// Reads width and height directly from PNG IHDR chunk (bytes 16-23)
/// without decompressing image pixel data.
({int width, int height}) _readPngDimensions(Uint8List bytes) {
  if (bytes.length >= 24 &&
      bytes[0] == 0x89 &&
      bytes[1] == 0x50 &&
      bytes[2] == 0x4E &&
      bytes[3] == 0x47) {
    final width =
        (bytes[16] << 24) | (bytes[17] << 16) | (bytes[18] << 8) | bytes[19];
    final height =
        (bytes[20] << 24) | (bytes[21] << 16) | (bytes[22] << 8) | bytes[23];
    return (width: width, height: height);
  }
  return (width: 0, height: 0);
}

/// Executes batch pixel diffing across entire snapshot directories
/// and compiles a [DiffManifest].
final class BatchDiffer {
  final PixelDiffer pixelDiffer;

  const BatchDiffer({this.pixelDiffer = const PixelDiffer()});

  /// Compares all PNG snapshots between [baselineDir] and [currentDir],
  /// writes diff PNG masks to [diffOutputDir], and saves [DiffManifest]
  /// to [manifestFile].
  ///
  /// When [targetRoutes] is provided, only snapshots matching those routes
  /// are diffed, and their results are merged into [manifestFile].
  Future<DiffManifest> run({
    required Directory baselineDir,
    required Directory currentDir,
    required Directory diffOutputDir,
    required File manifestFile,
    required String site,
    required String baseRef,
    Set<String>? targetRoutes,
    Set<String>? targetViewports,
    Map<String, HeaderMetadata>? baselineMetadata,
    Map<String, HeaderMetadata>? currentMetadata,
    bool verbose = false,
    void Function(String message)? onProgress,
  }) async {
    final log = onProgress ?? print;

    if (!diffOutputDir.existsSync()) {
      diffOutputDir.createSync(recursive: true);
    }

    final baselineFiles = <String, File>{};
    if (baselineDir.existsSync()) {
      for (final entity in baselineDir.listSync()) {
        if (entity is File && entity.path.endsWith('.png')) {
          baselineFiles[path.basename(entity.path)] = entity;
        }
      }
    }

    final currentFiles = <String, File>{};
    if (currentDir.existsSync()) {
      for (final entity in currentDir.listSync()) {
        if (entity is File && entity.path.endsWith('.png')) {
          currentFiles[path.basename(entity.path)] = entity;
        }
      }
    }

    // Load persisted header metadata if present.
    final baselineMetaMap = <String, HeaderMetadata>{};
    final baselineMetaFile = File(path.join(baselineDir.path, 'metadata.json'));
    if (baselineMetaFile.existsSync()) {
      try {
        final json = jsonDecode(
          baselineMetaFile.readAsStringSync(),
        ) as Map<String, dynamic>;
        for (final entry in json.entries) {
          baselineMetaMap[entry.key] = HeaderMetadata.fromJson(
            entry.value as Map<String, dynamic>,
          );
        }
      } catch (_) {}
    }
    if (baselineMetadata != null) {
      baselineMetaMap.addAll(baselineMetadata);
    }

    final currentMetaMap = <String, HeaderMetadata>{};
    final currentMetaFile = File(path.join(currentDir.path, 'metadata.json'));
    if (currentMetaFile.existsSync()) {
      try {
        final json = jsonDecode(
          currentMetaFile.readAsStringSync(),
        ) as Map<String, dynamic>;
        for (final entry in json.entries) {
          currentMetaMap[entry.key] = HeaderMetadata.fromJson(
            entry.value as Map<String, dynamic>,
          );
        }
      } catch (_) {}
    }
    if (currentMetadata != null) {
      currentMetaMap.addAll(currentMetadata);
      // Persist current metadata map to file.
      try {
        const encoder = JsonEncoder.withIndent('  ');
        final json = currentMetaMap.map((k, v) => MapEntry(k, v.toJson()));
        currentMetaFile.writeAsStringSync(encoder.convert(json));
      } catch (_) {}
    }

    final allFilenames = <String>{
      ...baselineFiles.keys,
      ...currentFiles.keys,
    }.toList()..sort();

    final normalizedTargets = targetRoutes?.map(_normalizeTargetRoute).toSet();

    final List<String> filenamesToDiff;
    if (normalizedTargets != null && normalizedTargets.isNotEmpty) {
      filenamesToDiff = allFilenames.where((f) {
        final parsed = parseSnapshotName(f);
        if (!normalizedTargets.contains(parsed.route)) {
          return false;
        }
        if (targetViewports != null &&
            targetViewports.isNotEmpty &&
            !targetViewports.contains(parsed.viewport)) {
          return false;
        }
        return true;
      }).toList();

      log(
        '🔍 Comparing ${filenamesToDiff.length} snapshots for '
        '${normalizedTargets.length} targeted route(s) in pure Dart...',
      );
    } else if (targetViewports != null && targetViewports.isNotEmpty) {
      filenamesToDiff = allFilenames.where((f) {
        final parsed = parseSnapshotName(f);
        return targetViewports.contains(parsed.viewport);
      }).toList();

      log(
        '🔍 Comparing ${filenamesToDiff.length} snapshots for viewport(s) '
        '${targetViewports.join(', ')} in pure Dart...',
      );
    } else {
      filenamesToDiff = allFilenames;
      log('🔍 Comparing ${filenamesToDiff.length} snapshots in pure Dart...');
    }

    final entries = <DiffEntry>[];
    final stopwatch = Stopwatch()..start();

    for (var i = 0; i < filenamesToDiff.length; i++) {
      final filename = filenamesToDiff[i];
      final parsed = parseSnapshotName(filename);
      final id = path.basenameWithoutExtension(filename);

      final baselineFile = baselineFiles[filename];
      final currentFile = currentFiles[filename];

      final bMeta = baselineMetaMap[parsed.route];
      final cMeta = currentMetaMap[parsed.route];
      final headerDiff = HeaderDiff.compare(bMeta, cMeta);

      if (baselineFile == null && currentFile != null) {
        // Newly added screenshot.
        final bytes = currentFile.readAsBytesSync();
        final dims = _readPngDimensions(bytes);
        final int w;
        final int h;
        if (dims.width > 0 && dims.height > 0) {
          w = dims.width;
          h = dims.height;
        } else {
          final currentImg = img.decodePng(bytes);
          w = currentImg?.width ?? 0;
          h = currentImg?.height ?? 0;
        }

        entries.add(
          DiffEntry(
            id: id,
            route: parsed.route,
            viewport: parsed.viewport,
            filename: filename,
            status: DiffStatus.added,
            diffPercentage: 100.0,
            diffPixels: w * h,
            totalPixels: w * h,
            width: w,
            height: h,
            currentRelativePath: path.join('current', filename),
            baselineMetadata: bMeta,
            currentMetadata: cMeta,
            headerDiff: headerDiff,
          ),
        );
        log('  🟢 [${i + 1}/${filenamesToDiff.length}] Added: $filename');
      } else if (baselineFile != null && currentFile == null) {
        // Removed screenshot.
        final bytes = baselineFile.readAsBytesSync();
        final dims = _readPngDimensions(bytes);
        final int w;
        final int h;
        if (dims.width > 0 && dims.height > 0) {
          w = dims.width;
          h = dims.height;
        } else {
          final baselineImg = img.decodePng(bytes);
          w = baselineImg?.width ?? 0;
          h = baselineImg?.height ?? 0;
        }

        entries.add(
          DiffEntry(
            id: id,
            route: parsed.route,
            viewport: parsed.viewport,
            filename: filename,
            status: DiffStatus.removed,
            diffPercentage: 100.0,
            diffPixels: w * h,
            totalPixels: w * h,
            width: w,
            height: h,
            baselineRelativePath: path.join('baseline', filename),
            baselineMetadata: bMeta,
            currentMetadata: cMeta,
            headerDiff: headerDiff,
          ),
        );
        log('  🔴 [${i + 1}/${filenamesToDiff.length}] Removed: $filename');
      } else if (baselineFile != null && currentFile != null) {
        final baselineBytes = baselineFile.readAsBytesSync();
        final currentBytes = currentFile.readAsBytesSync();

        // FAST PATH: Identical PNG bytes guarantees 100% identical pixel
        // content.
        if (baselineBytes.length == currentBytes.length &&
            _bytesEqual(baselineBytes, currentBytes)) {
          final dims = _readPngDimensions(currentBytes);
          final oldDiff = File(path.join(diffOutputDir.path, filename));
          if (oldDiff.existsSync()) {
            oldDiff.deleteSync();
          }

          entries.add(
            DiffEntry(
              id: id,
              route: parsed.route,
              viewport: parsed.viewport,
              filename: filename,
              status: DiffStatus.unchanged,
              diffPercentage: 0.0,
              diffPixels: 0,
              totalPixels: dims.width * dims.height,
              width: dims.width,
              height: dims.height,
              baselineRelativePath: path.join('baseline', filename),
              currentRelativePath: path.join('current', filename),
              baselineMetadata: bMeta,
              currentMetadata: cMeta,
              headerDiff: headerDiff,
            ),
          );

          if (headerDiff.hasDiff) {
            log(
              '  ℹ️  [${i + 1}/${filenamesToDiff.length}] Meta changed: '
              '$filename (title: ${headerDiff.titleChanged}, '
              'meta: ${headerDiff.metaChanges.length})',
            );
          } else if (normalizedTargets != null || verbose) {
            log(
              '  ✓ [${i + 1}/${filenamesToDiff.length}] Unchanged: $filename',
            );
          }
          continue;
        }

        // Byte diff detected: decode PNGs and evaluate pixel differences.
        final baselineImg = img.decodePng(baselineBytes);
        final currentImg = img.decodePng(currentBytes);

        if (baselineImg == null || currentImg == null) {
          stderr.writeln('  ⚠️ Failed to decode PNG for $filename');
          continue;
        }

        final diffResult = pixelDiffer.compare(baselineImg, currentImg);

        if (diffResult.hasDiff) {
          final diffPngBytes = img.encodePng(diffResult.diffImage!);
          final diffFile = File(path.join(diffOutputDir.path, filename));
          diffFile.writeAsBytesSync(diffPngBytes);

          entries.add(
            DiffEntry(
              id: id,
              route: parsed.route,
              viewport: parsed.viewport,
              filename: filename,
              status: DiffStatus.changed,
              diffPercentage: diffResult.diffPercentage,
              diffPixels: diffResult.diffPixels,
              totalPixels: diffResult.totalPixels,
              width: diffResult.diffImage!.width,
              height: diffResult.diffImage!.height,
              baselineRelativePath: path.join('baseline', filename),
              currentRelativePath: path.join('current', filename),
              diffRelativePath: path.join('diff', filename),
              boundingBox: diffResult.boundingBox,
              baselineMetadata: bMeta,
              currentMetadata: cMeta,
              headerDiff: headerDiff,
            ),
          );
          final pctStr = diffResult.diffPercentage.toStringAsFixed(2);
          log(
            '  ⚠️ [${i + 1}/${filenamesToDiff.length}] Changed ($pctStr% '
            '| ${diffResult.diffPixels} px): $filename',
          );
        } else {
          final oldDiff = File(path.join(diffOutputDir.path, filename));
          if (oldDiff.existsSync()) {
            oldDiff.deleteSync();
          }

          entries.add(
            DiffEntry(
              id: id,
              route: parsed.route,
              viewport: parsed.viewport,
              filename: filename,
              status: DiffStatus.unchanged,
              diffPercentage: 0.0,
              diffPixels: 0,
              totalPixels: diffResult.totalPixels,
              width: baselineImg.width,
              height: baselineImg.height,
              baselineRelativePath: path.join('baseline', filename),
              currentRelativePath: path.join('current', filename),
              baselineMetadata: bMeta,
              currentMetadata: cMeta,
              headerDiff: headerDiff,
            ),
          );

          if (headerDiff.hasDiff) {
            log(
              '  ℹ️  [${i + 1}/${filenamesToDiff.length}] Meta changed: '
              '$filename (title: ${headerDiff.titleChanged}, '
              'meta: ${headerDiff.metaChanges.length})',
            );
          } else if (normalizedTargets != null || verbose) {
            log(
              '  ✓ [${i + 1}/${filenamesToDiff.length}] Unchanged: $filename',
            );
          }
        }
      }
    }

    stopwatch.stop();
    final elapsed = (stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1);

    var allEntries = entries;
    if (normalizedTargets != null && normalizedTargets.isNotEmpty) {
      final existingEntriesMap = <String, DiffEntry>{};
      if (manifestFile.existsSync()) {
        try {
          final existingManifest = DiffManifest.loadFromFile(manifestFile);
          for (final e in existingManifest.entries) {
            existingEntriesMap[e.id] = e;
          }
        } catch (_) {}
      }

      // Ensure every non-targeted snapshot known in baseline is preserved in
      // the manifest so targeted runs never drop routes.
      for (final filename in allFilenames) {
        final id = path.basenameWithoutExtension(filename);
        final parsed = parseSnapshotName(filename);
        if (normalizedTargets.contains(parsed.route)) continue;

        if (!existingEntriesMap.containsKey(id)) {
          final bFile = baselineFiles[filename];
          final cFile = currentFiles[filename];
          if (bFile != null && cFile != null) {
            final dims = _readPngDimensions(bFile.readAsBytesSync());
            existingEntriesMap[id] = DiffEntry(
              id: id,
              route: parsed.route,
              viewport: parsed.viewport,
              filename: filename,
              status: DiffStatus.unchanged,
              diffPercentage: 0.0,
              diffPixels: 0,
              totalPixels: dims.width * dims.height,
              width: dims.width,
              height: dims.height,
              baselineRelativePath: path.join('baseline', filename),
              currentRelativePath: path.join('current', filename),
            );
          } else if (bFile != null) {
            final dims = _readPngDimensions(bFile.readAsBytesSync());
            existingEntriesMap[id] = DiffEntry(
              id: id,
              route: parsed.route,
              viewport: parsed.viewport,
              filename: filename,
              status: DiffStatus.unchanged,
              diffPercentage: 0.0,
              diffPixels: 0,
              totalPixels: dims.width * dims.height,
              width: dims.width,
              height: dims.height,
              baselineRelativePath: path.join('baseline', filename),
              currentRelativePath: path.join('baseline', filename),
            );
          }
        }
      }

      final targetedIds = entries.map((e) => e.id).toSet();
      final remainingExisting = existingEntriesMap.values
          .where(
            (e) =>
                !targetedIds.contains(e.id) &&
                !normalizedTargets.contains(e.route),
          )
          .toList();
      allEntries = [...remainingExisting, ...entries];
    }

    // Sort entries: changed first (highest diff % first),
    // then added, removed, then unchanged.
    allEntries.sort((a, b) {
      if (a.status != b.status) {
        final order = {
          DiffStatus.changed: 0,
          DiffStatus.added: 1,
          DiffStatus.removed: 2,
          DiffStatus.unchanged: 3,
        };
        return (order[a.status] ?? 4).compareTo(order[b.status] ?? 4);
      }
      return b.diffPercentage.compareTo(a.diffPercentage);
    });

    final manifest = DiffManifest.fromEntries(
      site: site,
      baseRef: baseRef,
      entries: allEntries,
    );

    manifest.saveToFile(manifestFile);
    if (normalizedTargets != null && normalizedTargets.isNotEmpty) {
      log(
        '✨ Visual diff updated for ${normalizedTargets.length} route(s) '
        'in ${elapsed}s: ${manifest.changedCount} changed, '
        '${manifest.metadataChangedCount} meta changed, '
        '${manifest.addedCount} added, ${manifest.removedCount} removed, '
        '${manifest.unchangedCount} unchanged.',
      );
    } else {
      log(
        '✨ Visual diff complete in ${elapsed}s: '
        '${manifest.changedCount} changed, '
        '${manifest.metadataChangedCount} meta changed, '
        '${manifest.addedCount} added, ${manifest.removedCount} removed, '
        '${manifest.unchangedCount} unchanged.',
      );
    }

    return manifest;
  }
}
