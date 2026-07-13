// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

/// Throws a [FormatException] with [message] when [condition] is false.
void checkFormat(bool condition, String message) {
  if (!condition) throw FormatException(message);
}

/// Returns `true` when [value] contains at least one non-whitespace character.
bool isNotBlank(String value) => value.trim().isNotEmpty;

/// Returns `true` when all values are non-empty after trimming.
bool allNotBlank(Iterable<String> values) => values.every(isNotBlank);

/// Returns `true` when [value] is an absolute HTTP(S) URL with a host.
bool isAbsoluteHttpUrl(String value, {bool requireHttps = false}) {
  final uri = Uri.tryParse(value);
  return uri != null &&
      uri.host.isNotEmpty &&
      (requireHttps
          ? uri.scheme == 'https'
          : uri.scheme == 'http' || uri.scheme == 'https');
}

/// Returns `true` when [value] is an absolute HTTP(S) URL or
/// a root-relative site path.
bool isAbsoluteHttpUrlOrBaseHrefRelativePath(String value) =>
    isAbsoluteHttpUrl(value) || isBaseHrefRelativePath(value);

/// Returns `true` when [value] is a root-relative path that can resolve
/// against `<base href>` (for example `/events/foo`).
bool isBaseHrefRelativePath(String value) {
  final uri = Uri.tryParse(value);
  return uri != null &&
      value.startsWith('/') &&
      !uri.hasScheme &&
      !uri.hasAuthority;
}

/// Returns `true` when [value] points to an image asset under `images/`.
bool looksLikeImageAssetPath(String value) {
  final uri = Uri.tryParse(value);
  return uri != null &&
      value.startsWith('images/') &&
      !uri.hasScheme &&
      !uri.hasAuthority &&
      hasImageFileExtension(value);
}

final _imageFileExtensionPattern = RegExp(
  r'\.(avif|gif|jpe?g|png|svg|webp)$',
  caseSensitive: false,
);

/// Returns `true` when [value] ends in a supported image file extension.
bool hasImageFileExtension(String value) {
  final uri = Uri.tryParse(value);
  final path = uri?.path ?? value;
  return _imageFileExtensionPattern.hasMatch(path);
}

/// Returns `true` when [value] is a root-relative image path.
bool looksLikeRootRelativeImagePath(String value) =>
    isBaseHrefRelativePath(value) && hasImageFileExtension(value);

final _hexColorPattern = RegExp(r'^#[0-9a-fA-F]{6}([0-9a-fA-F]{2})?$');

/// Returns `true` when [value] is `#RRGGBB` or `#RRGGBBAA`.
bool isHexColor(String value) => _hexColorPattern.hasMatch(value);
