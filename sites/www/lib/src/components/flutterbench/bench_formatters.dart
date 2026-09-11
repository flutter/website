// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

/// Shared number formatting for FlutterBench result surfaces.
library;

/// Formats a token count as a compact, human-readable string.
String formatTokens(int count) {
  if (count <= 0) return '—';
  if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
  if (count >= 1000) return '${(count / 1000).toStringAsFixed(0)}k';
  return count.toString();
}

/// Formats a US dollar amount, keeping enough precision for sub-cent costs.
String formatCost(double? costUsd) {
  if (costUsd == null) return '—';
  if (costUsd == 0) return r'$0';
  if (costUsd < 0.01) return '\$${costUsd.toStringAsFixed(4)}';
  return '\$${costUsd.toStringAsFixed(3)}';
}

/// Formats a duration in seconds as minutes and seconds.
String formatDuration(double? seconds) {
  if (seconds == null) return '—';
  if (seconds < 60) return '${seconds.round()}s';

  final minutes = seconds ~/ 60;
  final remainder = (seconds - minutes * 60).round();
  return '${minutes}m ${remainder}s';
}

/// Formats a 0–1 reward score to two decimal places.
String formatScore(double? score) =>
    score == null ? '—' : score.toStringAsFixed(2);
