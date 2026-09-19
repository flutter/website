// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

final RegExp _allDigits = RegExp(r'^\d+$');

/// Word-level overrides for tokens whose readable casing isn't a simple
/// capitalize-first-letter (brand names, version codes, OpenAI's lowercase
/// "o" model line).
const Map<String, String> _wordOverrides = {
  'gpt': 'GPT',
  'deepseek': 'DeepSeek',
  'v2': 'V2',
  'v3': 'V3',
  'r1': 'R1',
  'o1': 'o1',
  'o3': 'o3',
  '4o': '4o',
};

/// Formats a raw FlutterBench model identifier (e.g. `gpt-5`,
/// `claude-3-5-haiku`, `gemini-3.5-pro`) into a human-readable display name
/// (e.g. `GPT 5`, `Claude 3.5 Haiku`, `Gemini 3.5 Pro`).
String formatModelName(String rawModelName) {
  final tokens = rawModelName.split('-').where((t) => t.isNotEmpty).toList();
  final words = <String>[];

  var i = 0;
  while (i < tokens.length) {
    final token = tokens[i];
    if (_allDigits.hasMatch(token)) {
      final versionParts = [token];
      var j = i + 1;
      while (j < tokens.length && _allDigits.hasMatch(tokens[j])) {
        versionParts.add(tokens[j]);
        j++;
      }
      words.add(versionParts.join('.'));
      i = j;
      continue;
    }
    words.add(_formatWord(token));
    i++;
  }

  return words.join(' ');
}

String _formatWord(String word) {
  final lower = word.toLowerCase();
  final override = _wordOverrides[lower];
  if (override != null) return override;
  return lower[0].toUpperCase() + lower.substring(1);
}
