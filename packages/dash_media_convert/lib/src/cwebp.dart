// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:ffi' show Abi;
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_data_home/dart_data_home.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'cwebp_pins.dart';
import 'utils.dart';

/// The environment variable that, when set to the path of
/// a `cwebp` executable, is used instead of the pinned version.
const String _overrideEnvironmentVariable = 'CWEBP_PATH';

/// How to use an installed `cwebp` when the pinned version can't be installed.
const String _overrideHint =
    'To use an already installed cwebp instead, '
    'set $_overrideEnvironmentVariable to its path.';

/// A `cwebp` executable that's been verified and is ready to run.
final class Cwebp {
  Cwebp._({required this.executablePath, required this.version});

  /// The path to the `cwebp` executable.
  final String executablePath;

  /// The version reported by `cwebp -version`, such as `1.6.0`.
  final String version;

  /// The default directories to install the pinned `cwebp` binary to,
  /// in order of preference.
  ///
  /// The binary is shared between repositories in
  /// this package's directory in the Dart data home,
  /// falling back to the `.dart_tool` directory of the
  /// current pub workspace if the data home isn't writable.
  static List<String> get _defaultToolCacheDirectories => [
    p.join(getDartDataHome(packageName), 'cwebp'),
    // The package config is in the workspace's `.dart_tool` directory.
    if (Isolate.packageConfigSync case final packageConfig?)
      p.join(p.dirname(p.fromUri(packageConfig)), 'cwebp'),
  ];

  /// Finds or installs the `cwebp` executable to use.
  ///
  /// If the `CWEBP_PATH` environment variable is set,
  /// the executable it points to is used as is.
  /// Otherwise the pinned version of `cwebp` for the current platform is
  /// downloaded into [toolCacheDirectory], or the first default directory
  /// it can be installed to and run from, if it isn't already there.
  /// The binary is verified against the checksums in `cwebp_pins.dart`
  /// every time it's resolved.
  static Future<Cwebp> resolve({
    String? toolCacheDirectory,
    void Function(String message) log = print,
  }) async {
    final overridePath = Platform.environment[_overrideEnvironmentVariable];
    if (overridePath != null && overridePath.isNotEmpty) {
      final version = await _readVersion(overridePath);
      log(
        'Using cwebp $version from $_overrideEnvironmentVariable '
        '($overridePath) instead of the pinned $pinnedCwebpVersion.',
      );
      return Cwebp._(executablePath: overridePath, version: version);
    }

    final platform = currentCwebpPlatform;
    final pin = cwebpPins[platform];
    if (pin == null) {
      throw CwebpException(
        'No prebuilt cwebp is available for $platform. '
        'Install cwebp $pinnedCwebpVersion or later and set '
        '$_overrideEnvironmentVariable to its path.',
      );
    }

    final directories = toolCacheDirectory == null
        ? _defaultToolCacheDirectories
        : [toolCacheDirectory];
    for (final directory in directories) {
      try {
        return await _resolvePinned(pin, platform, directory, log);
      } on FileSystemException catch (e) {
        log('Can\'t install and run cwebp from $directory: ${e.message}');
      }
    }

    throw CwebpException('Failed to install cwebp. $_overrideHint');
  }

  static Future<Cwebp> _resolvePinned(
    CwebpPin pin,
    String platform,
    String toolCacheDirectory,
    void Function(String message) log,
  ) async {
    // Other versions in the directory aren't deleted,
    // since repositories sharing it might pin different versions.
    final executablePath = p.join(
      toolCacheDirectory,
      '$pinnedCwebpVersion-$platform',
      p.posix.basename(pin.binaryPathInArchive),
    );

    if (!await _hasExpectedHash(executablePath, pin.binarySha256)) {
      // Fail before downloading if the directory isn't writable.
      Directory(p.dirname(executablePath)).createSync(recursive: true);
      log('Downloading cwebp $pinnedCwebpVersion for $platform...');
      await _install(pin, executablePath);
    }

    final String version;
    try {
      version = await _readVersion(executablePath);
    } on CwebpException catch (e) {
      // The directory might not allow running executables,
      // such as if its file system is mounted with `noexec`,
      // so report it as a problem with the directory.
      throw FileSystemException(e.message, executablePath);
    }
    if (version != pinnedCwebpVersion) {
      throw CwebpException(
        'Expected cwebp $pinnedCwebpVersion at $executablePath, '
        'but it reports version $version.',
      );
    }

    return Cwebp._(executablePath: executablePath, version: version);
  }
}

/// An error finding, installing, or running `cwebp`.
final class CwebpException implements Exception {
  CwebpException(this.message);

  final String message;

  @override
  String toString() => 'CwebpException: $message';
}

/// The download and checksums of a prebuilt `cwebp` binary for one platform.
final class CwebpPin {
  const CwebpPin({
    required this.archiveName,
    required this.archiveSha256,
    required this.binarySha256,
  });

  /// The file name of the release archive in the libwebp downloads bucket.
  final String archiveName;

  /// The expected SHA-256 hash of the downloaded release archive.
  final String archiveSha256;

  /// The expected SHA-256 hash of the `cwebp` executable in the archive.
  ///
  /// This is checked every time the cached binary is used,
  /// so a corrupted or modified cache entry is never executed.
  final String binarySha256;

  bool get _isZip => archiveName.endsWith('.zip');

  /// The URL to download the release archive from.
  Uri get archiveUrl => Uri.https(
    'storage.googleapis.com',
    '/downloads.webmproject.org/releases/webp/$archiveName',
  );

  /// The path of the `cwebp` executable within the extracted archive.
  String get binaryPathInArchive {
    final directory = archiveName.replaceFirst(RegExp(r'\.(tar\.gz|zip)$'), '');
    return '$directory/bin/${_isZip ? 'cwebp.exe' : 'cwebp'}';
  }

  /// Extracts the `cwebp` executable from the release archive in
  /// [archiveBytes], without verifying either checksum.
  Uint8List extractBinary(Uint8List archiveBytes) {
    final archive = _isZip
        ? ZipDecoder().decodeBytes(archiveBytes)
        : TarDecoder().decodeBytes(
            const GZipDecoder().decodeBytes(archiveBytes),
          );
    return archive.findFile(binaryPathInArchive)?.readBytes() ??
        (throw CwebpException(
          '$archiveName doesn\'t contain $binaryPathInArchive.',
        ));
  }
}

/// The key into [cwebpPins] for the platform this code is running on,
/// such as `macos_arm64`.
String get currentCwebpPlatform => Abi.current().toString();

Future<String> _readVersion(String executablePath) async {
  final ProcessResult result;
  try {
    result = await Process.run(executablePath, const ['-version']);
  } on ProcessException catch (e) {
    throw CwebpException('Failed to run cwebp at $executablePath: $e');
  }

  if (result.exitCode != 0) {
    throw CwebpException(
      'Failed to run cwebp at $executablePath:\n${result.stderr}',
    );
  }

  // The first line is the libwebp version, such as `1.6.0`.
  return (result.stdout as String).trim().split('\n').first.trim();
}

Future<bool> _hasExpectedHash(String filePath, String expectedSha256) async {
  final file = File(filePath);
  if (!file.existsSync()) return false;
  final digest = await sha256.bind(file.openRead()).single;
  return digest.toString() == expectedSha256;
}

/// Downloads and verifies the archive described by [pin],
/// then extracts its `cwebp` executable to [executablePath].
///
/// The executable is written to a temporary file that's
/// renamed into place only once it's complete and verified, so an
/// interrupted install never leaves a partial or unverified executable behind.
Future<void> _install(CwebpPin pin, String executablePath) async {
  final archiveBytes = await _download(pin.archiveUrl);
  _verifySha256(archiveBytes, pin.archiveSha256, '${pin.archiveUrl}');

  final binaryBytes = pin.extractBinary(archiveBytes);
  _verifySha256(
    binaryBytes,
    pin.binarySha256,
    '${pin.binaryPathInArchive} in ${pin.archiveName}',
  );

  await writeFileAtomically(executablePath, (temporaryPath) async {
    await File(temporaryPath).writeAsBytes(binaryBytes, flush: true);
    if (!Platform.isWindows) {
      final chmod = await Process.run('chmod', ['755', temporaryPath]);
      if (chmod.exitCode != 0) {
        throw FileSystemException(
          'Failed to mark cwebp executable: '
          '${(chmod.stderr as String).trim()}',
          temporaryPath,
        );
      }
    }
  });
}

/// Throws a [CwebpException] if the SHA-256 hash of [bytes],
/// the contents of [description], isn't [expectedSha256].
void _verifySha256(List<int> bytes, String expectedSha256, String description) {
  final actualSha256 = sha256.convert(bytes).toString();
  if (actualSha256 != expectedSha256) {
    throw CwebpException(
      'Checksum mismatch for $description.\n'
      '  Expected: $expectedSha256\n'
      '  Actual:   $actualSha256',
    );
  }
}

Future<Uint8List> _download(Uri url) async {
  try {
    return await http.readBytes(url);
  } on Exception catch (e) {
    throw CwebpException('Failed to download $url: $e\n$_overrideHint');
  }
}
