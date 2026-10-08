// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:io';
import 'dart:math';

final Random _random = Random();

/// Creates the file at [path] by calling [write] to write it to
/// a temporary path in the same directory, then renaming it into place,
/// so an interrupted write never leaves a partial file behind.
Future<void> writeFileAtomically(
  String path,
  Future<void> Function(String temporaryPath) write,
) async {
  // Because the temporary file is in the same directory,
  // the rename is atomic on the same file system.
  final unique = '$pid-${_random.nextInt(1 << 32).toRadixString(16)}';
  final temporaryFile = File('$path.$unique.tmp');
  try {
    await write(temporaryFile.path);
    await temporaryFile.rename(path);
  } finally {
    try {
      temporaryFile.deleteSync();
    } on FileSystemException {
      // The file was renamed into place or already cleaned up.
    }
  }
}
