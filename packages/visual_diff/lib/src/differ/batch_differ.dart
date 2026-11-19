// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

import '../models/diff_entry.dart';
import '../models/diff_manifest.dart';
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

      if (baselineFile == null && currentFile != null) {
        // Newly added screenshot.
        final bytes = currentFile.readAsBytesSync();
        final currentImg = img.decodePng(bytes);
        final w = currentImg?.width ?? 0;
        final h = currentImg?.height ?? 0;

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
          ),
        );
        log('  🟢 [${i + 1}/${filenamesToDiff.length}] Added: $filename');
      } else if (baselineFile != null && currentFile == null) {
        // Removed screenshot.
        final bytes = baselineFile.readAsBytesSync();
        final baselineImg = img.decodePng(bytes);
        final w = baselineImg?.width ?? 0;
        final h = baselineImg?.height ?? 0;

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
          ),
        );
        log('  🔴 [${i + 1}/${filenamesToDiff.length}] Removed: $filename');
      } else if (baselineFile != null && currentFile != null) {
        // Exists in both: run pixel diff.
        final baselineBytes = baselineFile.readAsBytesSync();
        final currentBytes = currentFile.readAsBytesSync();

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
            ),
          );
          if (normalizedTargets != null || verbose) {
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
    if (normalizedTargets != null &&
        normalizedTargets.isNotEmpty &&
        manifestFile.existsSync()) {
      try {
        final existingManifest = DiffManifest.loadFromFile(manifestFile);
        final targetedIds = entries.map((e) => e.id).toSet();
        final remainingExisting = existingManifest.entries
            .where(
              (e) =>
                  !targetedIds.contains(e.id) &&
                  !normalizedTargets.contains(e.route),
            )
            .toList();
        allEntries = [...remainingExisting, ...entries];
      } catch (_) {
        allEntries = entries;
      }
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
        'in ${elapsed}s: ${manifest.changedCount} total changed, '
        '${manifest.addedCount} added, ${manifest.removedCount} removed, '
        '${manifest.unchangedCount} unchanged.',
      );
    } else {
      log(
        '✨ Visual diff complete in ${elapsed}s: '
        '${manifest.changedCount} changed, '
        '${manifest.addedCount} added, '
        '${manifest.removedCount} removed, '
        '${manifest.unchangedCount} unchanged.',
      );
    }

    return manifest;
  }
}
