// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Whether [slugify] should preserve underscores instead of replacing them
/// with hyphens. Defaults to false.
bool preserveUnderscoresInSlugify = false;

/// Converts the specified [text] into a standardized URL slug
/// that can be used as the ID for headers and other anchors in HTML.
///
/// If [preserveUnderscores] is specified, it overrides the global
/// [preserveUnderscoresInSlugify] setting.
String slugify(String text, {bool? preserveUnderscores}) {
  final shouldPreserve = preserveUnderscores ?? preserveUnderscoresInSlugify;
  final punctuation = shouldPreserve
      ? _slugifyPunctuationPreserveUnderscores
      : _slugifyPunctuationToReplace;
  final unsupported = shouldPreserve
      ? _slugifyUnsupportedPreserveUnderscores
      : _slugifyUnsupportedToRemove;

  return text
      .toLowerCase()
      .trim()
      .replaceAll(punctuation, '-')
      .replaceAll(unsupported, '')
      .replaceAll(_slugifyCharsToCombine, '-')
      .replaceAll(_slugifyHyphenTrim, '');
}

final RegExp _slugifyPunctuationToReplace = RegExp(r'[:._]');
final RegExp _slugifyPunctuationPreserveUnderscores = RegExp(r'[:.]');

final RegExp _slugifyUnsupportedToRemove = RegExp(
  r'[^\p{L}\p{N}\s:.-]',
  unicode: true,
);
final RegExp _slugifyUnsupportedPreserveUnderscores = RegExp(
  r'[^\p{L}\p{N}\s:._-]',
  unicode: true,
);

final RegExp _slugifyCharsToCombine = RegExp(r'[\s-]+');
final RegExp _slugifyHyphenTrim = RegExp(r'^-+|-+$');
