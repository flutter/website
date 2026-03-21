// Copyright (c) 2023. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:math' as math show min;

import 'package:meta/meta.dart';

/// A tool to extract declared docregions from specified source files.
///
/// Caches all docregions parsed from files, so consider
/// creating a new one for each file you're injecting in to.
final class ExcerptExtractor {
  /// A cache of file paths to to the regions found within them.
  ///
  /// If the value a pile path points to is `null`,
  /// the file couldn't be found or read.
  final Map<String, Map<String, Region>?> _regionCacheByPath = {};

  /// Extract the region with the specified [regionName] from
  /// the file located at the specified [path].
  ///
  /// If a file does not exist at that location or the [regionName]
  /// does not exist either, a `ExtractException` will be thrown.
  @useResult
  Future<Region> extractRegion(String path, String regionName) async {
    if (!_regionCacheByPath.containsKey(path)) {
      _regionCacheByPath[path] = await _extractAllRegions(path);
    }
    final regions = _regionCacheByPath[path];
    if (regions == null) {
      throw ExtractException('No file exists at $path.');
    }

    final region = regions[regionName];
    if (region == null) {
      throw ExtractException(
        'The region "$regionName" does not exist in the file at $path.',
      );
    }

    return region;
  }

  @useResult
  Future<Map<String, Region>?> _extractAllRegions(String path) async {
    final file = File(path);
    if (!(await file.exists())) {
      return null;
    }

    final lines = await file.readAsLines();
    if (lines.isEmpty) {
      return const {};
    }

    final regionContent = <String, Region>{_entireFileRegionName: Region._()};
    final currentRegions = <String>{_entireFileRegionName};

    for (var lineIndex = 0; lineIndex < lines.length; lineIndex += 1) {
      final line = lines[lineIndex];
      final trimmedLine = line.trimLeft();
      final indent = line.length - trimmedLine.length;

      final directive = _docRegionDirective.firstMatch(trimmedLine);
      if (directive != null) {
        final isEnd = directive.namedGroup('end') != null;
        final rawRegionNames = directive.namedGroup('regions');
        if (rawRegionNames == null) {
          throw const ExtractException(
            'A docregion comment must specify at least one region!',
          );
        }
        final regionNames = rawRegionNames.split(',');
        for (final rawRegionName in regionNames) {
          final regionName = rawRegionName.trim();
          if (regionName.isEmpty) {
            throw const ExtractException(
              'docregion comment tried to use an empty region name.',
            );
          }
          if (isEnd) {
            final removed = currentRegions.remove(regionName);
            if (!removed) {
              throw ExtractException(
                'enddocregion tried to close the '
                "unopened '$regionName' region!",
              );
            }
          } else {
            if (regionContent[regionName] case final region?) {
              // If the region already exists, add a plaster line.
              region._addPlaster(indent);
            } else {
              regionContent[regionName] = Region._();
            }

            currentRegions.add(regionName);
          }
        }
      } else {
        // Just a normal line.
        for (final region in currentRegions) {
          regionContent[region]!._addLine(line, indent);
        }
      }
    }

    currentRegions.remove(_entireFileRegionName);
    if (currentRegions.isNotEmpty) {
      throw ExtractException('Regions $currentRegions were not closed.');
    }

    return regionContent;
  }
}

/// The contents of a docregion found in a file.
final class Region {
  /// The untransformed text lines or plaster lines of the docregion.
  final List<_RegionLine> _lines = [];

  /// The minimum indent seen in this region.
  ///
  /// `99999` is the initial value as no line should be longer than that...
  int _minIndent = 99999;

  /// Creates a [Region] with the specified indentation,
  /// usually from the docregion comment.
  Region._();

  /// Adds the specified [line] with the specified [indent]
  /// to the contents of the region.
  void _addLine(String line, int indent) {
    _lines.add(_StringLine(line));

    // Ignore the indent of blank lines.
    if (line.trim().isNotEmpty) {
      _minIndent = math.min(_minIndent, indent);
    }
  }

  /// Adds a line where a plaster could be inserted
  /// as well as the [directiveIndent] of the directive adding it.
  ///
  /// This is usually when a docregion is closed and opened again.
  void _addPlaster(int directiveIndent) {
    _lines.add(_PlasterLine(directiveIndent));
  }

  /// Builds a list of strings from the region,
  /// replacing lines marked as plasters with the
  /// specified [plaster] content,
  /// and applying the minimum indentation to each line.
  ///
  /// If [plaster] is `null` or `'none'`,
  /// the plaster lines are not included at all.
  @useResult
  Iterable<String> linesWithPlaster(final String? plaster) {
    final updatedLines = <String>[];
    final includePlaster = plaster != null && plaster != 'none';

    for (final line in _lines) {
      switch (line) {
        case _PlasterLine(:final directiveIndent):
          if (includePlaster) {
            final minimizedDirectiveIndent = directiveIndent - _minIndent;
            updatedLines.add('${' ' * minimizedDirectiveIndent}$plaster');
          }
        case _StringLine(:final line):
          if (_minIndent == 0 || line.length < _minIndent) {
            updatedLines.add(line);
          } else {
            updatedLines.add(line.substring(_minIndent));
          }
      }
    }

    return updatedLines;
  }
}

sealed class _RegionLine {}

final class _StringLine extends _RegionLine {
  final String line;

  _StringLine(this.line);
}

final class _PlasterLine extends _RegionLine {
  final int directiveIndent;

  _PlasterLine(this.directiveIndent);
}

/// An exception thrown when a [ExcerptExtractor]
/// failed to extract a region.
@immutable
final class ExtractException implements Exception {
  /// The error causing the exception during extraction.
  final String error;

  /// Create a [ExtractException] with the specified [error].
  const ExtractException(this.error);

  @override
  String toString() => error;
}

const String _entireFileRegionName = '';

final RegExp _docRegionDirective = RegExp(
  r'^.*?#(?<end>end)?docregion\s(?<regions>[a-zA-Z0-9,_\-\s]+).*?$',
);
