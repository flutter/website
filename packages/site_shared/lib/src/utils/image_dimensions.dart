// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:mime/mime.dart';

/// Intrinsic pixel dimensions of an image asset.
@immutable
final class ImageDimensions {
  const ImageDimensions({required this.width, required this.height})
    : assert(width > 0),
      assert(height > 0);

  final int width;
  final int height;

  /// Returns dimensions scaled down proportionally to [maxWidth] when
  /// [width] exceeds [maxWidth], or `this` unchanged otherwise.
  ImageDimensions scaledToMaxWidth(int? maxWidth) {
    if (maxWidth == null || maxWidth <= 0 || width <= maxWidth) return this;
    final scaledHeight = math.max(1, (height * maxWidth / width).round());
    return ImageDimensions(width: maxWidth, height: scaledHeight);
  }

  @override
  bool operator ==(Object other) =>
      other is ImageDimensions &&
      other.width == width &&
      other.height == height;

  @override
  int get hashCode => Object.hash(width, height);

  @override
  String toString() => 'ImageDimensions($width, $height)';
}

final Map<String, ImageDimensions?> _dimensionsCache = {};

/// Clears the in-memory [readImageDimensions] cache for testing.
@visibleForTesting
void clearImageDimensionsCache() => _dimensionsCache.clear();

/// Reads the intrinsic pixel dimensions of the image file at [path] by
/// inspecting its binary or SVG header without decoding pixel data.
///
/// Supports PNG, JPEG, GIF, WebP (`VP8`, `VP8L`, `VP8X`), AVIF (`ispe`), and
/// SVG (`width`/`height` or `viewBox`). Returns `null` if the file does not
/// exist or does not declare valid positive dimensions.
ImageDimensions? readImageDimensions(String path) {
  if (_dimensionsCache.containsKey(path)) return _dimensionsCache[path];
  try {
    final result = _readImageDimensionsUncached(path);
    return _dimensionsCache[path] = result;
  } on Object {
    return _dimensionsCache[path] = null;
  }
}

ImageDimensions? _readImageDimensionsUncached(String path) {
  final file = File(path);
  if (!file.existsSync()) return null;

  final RandomAccessFile raf;
  try {
    raf = file.openSync();
  } on FileSystemException {
    return null;
  }

  try {
    final prefix = raf.readSync(64);
    if (prefix.length < 6) return null;

    return switch (_imageMimeResolver.lookup('', headerBytes: prefix)) {
      'image/png' => _readPng(prefix),
      'image/jpeg' => _readJpeg(raf),
      'image/gif' => _readGif(prefix),
      'image/webp' => _readWebp(prefix),
      'image/avif' => _readAvif(raf),
      _
          when lookupMimeType(path) == 'image/avif' &&
              _matchesAt(prefix, 4, _ftypBox) =>
        _readAvif(raf),
      _ when lookupMimeType(path) == 'image/svg+xml' || _looksLikeSvg(prefix) =>
        _readSvg(file),
      _ => null,
    };
  } finally {
    raf.closeSync();
  }
}

const List<int> _ftypBox = [0x66, 0x74, 0x79, 0x70];

/// Extends [MimeTypeResolver]'s built-in PNG, JPEG, GIF, and WebP magic-byte
/// table with ISO-BMFF `ftypavif` and `ftypavis` so misnamed `.png` AVIF
/// assets match before file-extension fallback.
final MimeTypeResolver _imageMimeResolver = MimeTypeResolver()
  ..addMagicNumber(
    const [
      0x00,
      0x00,
      0x00,
      0x00,
      0x66,
      0x74,
      0x79,
      0x70,
      0x61,
      0x76,
      0x69,
      0x66,
    ],
    'image/avif',
    mask: _ftypBrandMask,
  )
  ..addMagicNumber(
    const [
      0x00,
      0x00,
      0x00,
      0x00,
      0x66,
      0x74,
      0x79,
      0x70,
      0x61,
      0x76,
      0x69,
      0x73,
    ],
    'image/avif',
    mask: _ftypBrandMask,
  );

const List<int> _ftypBrandMask = [
  0x00,
  0x00,
  0x00,
  0x00,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
  0xFF,
];

const List<int> _ispeFullBox = [
  0x69,
  0x73,
  0x70,
  0x65,
  0x00,
  0x00,
  0x00,
  0x00,
];

bool _matchesAt(Uint8List bytes, int offset, List<int> expected) {
  if (bytes.length < offset + expected.length) return false;
  for (var i = 0; i < expected.length; i++) {
    if (bytes[offset + i] != expected[i]) return false;
  }
  return true;
}

bool _looksLikeSvg(Uint8List prefix) {
  final head = latin1.decode(prefix, allowInvalid: true).trimLeft();
  return head.startsWith('<svg') || head.startsWith('<?xml');
}

ImageDimensions? _validDimensions(int width, int height) =>
    width > 0 && height > 0
    ? ImageDimensions(width: width, height: height)
    : null;

ImageDimensions? _readPng(Uint8List prefix) {
  if (prefix.length < 24) return null;
  if (!_matchesAt(prefix, 12, const [0x49, 0x48, 0x44, 0x52])) return null;
  final view = ByteData.sublistView(prefix);
  return _validDimensions(view.getUint32(16), view.getUint32(20));
}

ImageDimensions? _readGif(Uint8List prefix) {
  if (prefix.length < 10) return null;
  final view = ByteData.sublistView(prefix);
  return _validDimensions(
    view.getUint16(6, Endian.little),
    view.getUint16(8, Endian.little),
  );
}

ImageDimensions? _readWebp(Uint8List prefix) {
  if (prefix.length < 30) return null;
  final chunk = latin1.decode(Uint8List.sublistView(prefix, 12, 16));
  final view = ByteData.sublistView(prefix);
  return switch (chunk) {
    'VP8 ' => _validDimensions(
      view.getUint16(26, Endian.little) & 0x3FFF,
      view.getUint16(28, Endian.little) & 0x3FFF,
    ),
    'VP8L' => _validDimensions(
      1 + (((prefix[22] & 0x3F) << 8) | prefix[21]),
      1 +
          (((prefix[24] & 0x0F) << 10) |
              (prefix[23] << 2) |
              ((prefix[22] & 0xC0) >> 6)),
    ),
    'VP8X' => _validDimensions(
      1 + (prefix[24] | (prefix[25] << 8) | (prefix[26] << 16)),
      1 + (prefix[27] | (prefix[28] << 8) | (prefix[29] << 16)),
    ),
    _ => null,
  };
}

ImageDimensions? _readJpeg(RandomAccessFile raf) {
  var offset = 2;
  while (true) {
    raf.setPositionSync(offset);
    final markerBytes = raf.readSync(4);
    if (markerBytes.length < 4 || markerBytes[0] != 0xFF) return null;

    final step = _jpegMarkerStep(markerBytes);
    if (step == 0) return null;
    if (step > 0) {
      offset += step;
      continue;
    }

    return _readJpegSofDimensions(raf);
  }
}

/// Returns the byte step to advance past a non-SOF marker, `0` if parsing
/// must stop, or `-1` when positioned at a valid SOF segment header.
int _jpegMarkerStep(Uint8List markerBytes) {
  final marker = markerBytes[1];
  if (marker == 0xFF) return 1;
  if (marker == 0x01 || (marker >= 0xD0 && marker <= 0xD7)) return 2;
  if (marker == 0xD9 || marker == 0xDA) return 0;

  final segmentLength = ByteData.sublistView(markerBytes).getUint16(2);
  if (segmentLength < 2) return 0;
  if (_isJpegSofMarker(marker)) return segmentLength >= 7 ? -1 : 0;
  return 2 + segmentLength;
}

ImageDimensions? _readJpegSofDimensions(RandomAccessFile raf) {
  final frame = raf.readSync(5);
  if (frame.length < 5) return null;
  final data = ByteData.sublistView(frame);
  return _validDimensions(data.getUint16(3), data.getUint16(1));
}

bool _isJpegSofMarker(int marker) =>
    marker >= 0xC0 &&
    marker <= 0xCF &&
    marker != 0xC4 &&
    marker != 0xC8 &&
    marker != 0xCC;

ImageDimensions? _readAvif(RandomAccessFile raf) {
  raf.setPositionSync(0);
  final header = raf.readSync(4096);
  for (var i = 4; i <= header.length - 16; i++) {
    if (_matchesAt(header, i, _ispeFullBox)) {
      final view = ByteData.sublistView(header, i + 8, i + 16);
      return _validDimensions(view.getUint32(0), view.getUint32(4));
    }
  }
  return null;
}

final RegExp _svgOpenTagPattern = RegExp(
  r'<svg\b([^>]*)>',
  caseSensitive: false,
  dotAll: true,
);
final RegExp _svgWidthPattern = RegExp(
  r'''(?<![-\w:])width\s*=\s*["']\s*([0-9]+(?:\.[0-9]+)?)(?:px)?\s*["']''',
  caseSensitive: false,
);
final RegExp _svgHeightPattern = RegExp(
  r'''(?<![-\w:])height\s*=\s*["']\s*([0-9]+(?:\.[0-9]+)?)(?:px)?\s*["']''',
  caseSensitive: false,
);
final RegExp _svgViewBoxPattern = RegExp(
  r'''(?<![-\w:])viewBox\s*=\s*["']\s*[-+0-9.]+[\s,]+[-+0-9.]+[\s,]+([0-9]+(?:\.[0-9]+)?)[\s,]+([0-9]+(?:\.[0-9]+)?)\s*["']''',
  caseSensitive: false,
);

ImageDimensions? _readSvg(File file) {
  final String content;
  try {
    content = file.readAsStringSync();
  } on FileSystemException {
    return null;
  }

  final svgTag = _svgOpenTagPattern.firstMatch(content);
  if (svgTag == null) return null;
  final attrs = svgTag.group(1)!;

  final explicitW = _parseSvgNumber(_svgWidthPattern.firstMatch(attrs));
  final explicitH = _parseSvgNumber(_svgHeightPattern.firstMatch(attrs));
  if (explicitW != null && explicitH != null) {
    return _validDimensions(explicitW.round(), explicitH.round());
  }

  final viewBox = _svgViewBoxPattern.firstMatch(attrs);
  if (viewBox == null) return null;
  final vbW = double.tryParse(viewBox.group(1)!);
  final vbH = double.tryParse(viewBox.group(2)!);
  if (vbW == null ||
      vbH == null ||
      !vbW.isFinite ||
      !vbH.isFinite ||
      vbW <= 0 ||
      vbH <= 0) {
    return null;
  }

  if (explicitW != null) {
    final scaledH = explicitW * vbH / vbW;
    if (!scaledH.isFinite) return null;
    return _validDimensions(explicitW.round(), scaledH.round());
  }
  if (explicitH != null) {
    final scaledW = explicitH * vbW / vbH;
    if (!scaledW.isFinite) return null;
    return _validDimensions(scaledW.round(), explicitH.round());
  }
  return _validDimensions(vbW.round(), vbH.round());
}

double? _parseSvgNumber(RegExpMatch? match) {
  if (match == null) return null;
  final value = double.tryParse(match.group(1)!);
  return value != null && value.isFinite && value > 0 ? value : null;
}

final RegExp _inlineWidthPropertyPattern = RegExp(
  r'(?:^|;)\s*width\s*:',
  caseSensitive: false,
);

/// Builds the normalized inline CSS `style` string for a `<DashImage>`
/// component's `img-style`, `width`, and `height` [attributes], appending
/// `width: auto;` on height-only overrides so intrinsic HTML dimensions do not
/// distort the image's aspect ratio.
String buildDashImageStyle(Map<String, String> attributes) {
  final rawWidth = attributes['width']?.trim();
  final rawHeight = attributes['height']?.trim();
  final hasExplicitWidth =
      (rawWidth != null && rawWidth.isNotEmpty) ||
      _inlineWidthPropertyPattern.hasMatch(attributes['img-style'] ?? '');

  return [
        ?attributes['img-style'],
        if (rawWidth != null && rawWidth.isNotEmpty) 'width: $rawWidth',
        if (rawHeight != null && rawHeight.isNotEmpty) ...[
          'height: $rawHeight',
          if (!hasExplicitWidth) 'width: auto',
        ],
      ]
      .map((style) => style.trim())
      .where((style) => style.isNotEmpty)
      .map((style) => style.endsWith(';') ? style : '$style;')
      .join(' ');
}
