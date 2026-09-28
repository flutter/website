// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Image formats that can be converted to WebP.
enum SourceImageFormat { png, jpeg }

/// Basic information about a PNG or JPEG image,
/// read from its headers without reading its image data.
final class SourceImageInfo {
  const SourceImageInfo({
    required this.format,
    required this.width,
    required this.height,
    this.isAnimated = false,
  });

  /// Reads the headers of the PNG or JPEG image at [path].
  ///
  /// Returns `null` if the file isn't a PNG or JPEG image or
  /// its headers are malformed.
  static SourceImageInfo? readFile(String path) {
    final file = File(path).openSync();
    try {
      return _readPng(file) ?? _readJpeg(file);
    } finally {
      file.closeSync();
    }
  }

  final SourceImageFormat format;
  final int width;
  final int height;

  /// Whether this is an animated PNG (APNG).
  ///
  /// `cwebp` doesn't preserve its animation.
  final bool isAnimated;
}

/// Reads [length] bytes at [position] in [file],
/// returning `null` if the file ends first.
Uint8List? _readAt(RandomAccessFile file, int position, int length) {
  file.setPositionSync(position);
  final bytes = file.readSync(length);
  return bytes.length == length ? bytes : null;
}

/// Whether [bytes] begins with [prefix].
bool _startsWith(Uint8List bytes, List<int> prefix) {
  if (bytes.length < prefix.length) return false;
  for (var i = 0; i < prefix.length; i += 1) {
    if (bytes[i] != prefix[i]) return false;
  }
  return true;
}

const List<int> _pngSignature = [
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
];

SourceImageInfo? _readPng(RandomAccessFile file) {
  // The signature, then the IHDR chunk's length, type, width, and height.
  final header = _readAt(file, 0, 24);
  if (header == null || !_startsWith(header, _pngSignature)) return null;
  if (_chunkType(header, 12) != 'IHDR') return null;

  // An animated PNG has an `acTL` chunk before its first `IDAT` chunk.
  var isAnimated = false;
  var offset = 8;
  while (true) {
    final chunkHeader = _readAt(file, offset, 8);
    if (chunkHeader == null) break;
    final length = ByteData.sublistView(chunkHeader).getUint32(0);
    final type = _chunkType(chunkHeader, 4);
    if (type == 'IDAT' || type == 'IEND') break;
    if (type == 'acTL') isAnimated = true;
    // Skip the length, type, data, and CRC.
    offset += 12 + length;
  }

  final data = ByteData.sublistView(header);
  return SourceImageInfo(
    format: .png,
    width: data.getUint32(16),
    height: data.getUint32(20),
    isAnimated: isAnimated,
  );
}

String _chunkType(Uint8List bytes, int offset) =>
    latin1.decode(Uint8List.sublistView(bytes, offset, offset + 4));

SourceImageInfo? _readJpeg(RandomAccessFile file) {
  final start = _readAt(file, 0, 2);
  if (start == null || !_startsWith(start, const [0xFF, 0xD8])) return null;

  var offset = 2;
  while (true) {
    // The marker, followed by the segment length if it has one.
    final markerBytes = _readAt(file, offset, 4);
    if (markerBytes == null || markerBytes[0] != 0xFF) return null;
    final marker = markerBytes[1];

    // Skip fill bytes and markers without a length.
    if (marker == 0xFF) {
      offset += 1;
      continue;
    }
    if (marker == 0x01 || (marker >= 0xD0 && marker <= 0xD7)) {
      offset += 2;
      continue;
    }
    // Stop at the end of the image or the start of the image data,
    // since the frame header must come before either.
    if (marker == 0xD9 || marker == 0xDA) return null;

    // The length includes itself, but not the marker.
    final segmentLength = ByteData.sublistView(markerBytes).getUint16(2);
    if (segmentLength < 2) return null;

    // Start of frame markers, excluding DHT (C4), JPG (C8), and DAC (CC).
    if (marker >= 0xC0 &&
        marker <= 0xCF &&
        marker != 0xC4 &&
        marker != 0xC8 &&
        marker != 0xCC) {
      // The sample precision, then the height and width.
      final frame = segmentLength >= 7 ? _readAt(file, offset + 4, 5) : null;
      if (frame == null) return null;
      final data = ByteData.sublistView(frame);
      return SourceImageInfo(
        format: .jpeg,
        height: data.getUint16(1),
        width: data.getUint16(3),
      );
    }

    offset += 2 + segmentLength;
  }
}
