// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:js_interop';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../models/diff_entry.dart';

/// Flicker / Toggle viewer that flips between Baseline and Current in-place.
class ToggleViewer extends StatefulComponent {
  final DiffEntry entry;
  final bool initialShowCurrent;

  const ToggleViewer({
    required this.entry,
    this.initialShowCurrent = false,
    super.key,
  });

  @override
  State<ToggleViewer> createState() => _ToggleViewerState();
}

class _ToggleViewerState extends State<ToggleViewer> {
  late bool showCurrent;
  JSFunction? _spaceListener;

  @override
  void initState() {
    super.initState();
    showCurrent = component.initialShowCurrent;

    if (kIsWeb) {
      _spaceListener = ((web.KeyboardEvent e) {
        if (e.key == ' ') {
          e.preventDefault();
          toggle();
        }
      }).toJS;
      web.window.addEventListener('keydown', _spaceListener!);
    }
  }

  @override
  void dispose() {
    if (kIsWeb && _spaceListener != null) {
      web.window.removeEventListener('keydown', _spaceListener!);
    }
    super.dispose();
  }

  void toggle() {
    setState(() {
      showCurrent = !showCurrent;
    });
  }

  @override
  Component build(BuildContext context) {
    final entry = component.entry;
    final baselineSrc = entry.baselineRelativePath != null
        ? '/${entry.baselineRelativePath}'
        : null;
    final currentSrc = entry.currentRelativePath != null
        ? '/${entry.currentRelativePath}'
        : null;

    final activeSrc = showCurrent
        ? (currentSrc ?? baselineSrc)
        : (baselineSrc ?? currentSrc);
    final activeLabel = showCurrent ? 'CURRENT (AFTER)' : 'BASELINE (BEFORE)';

    return div(
      classes: 'vd-toggle-wrapper',
      events: {'click': (_) => toggle()},
      attributes: const {'style': 'cursor: pointer;'},
      [
        if (activeSrc != null)
          img(
            classes: 'vd-toggle-img',
            src: activeSrc,
            alt: activeLabel,
          ),
        div(
          classes: 'vd-toggle-indicator',
          attributes: {
            'style': showCurrent
                ? 'border-color: #3fb950; color: #3fb950;'
                : 'border-color: #2f81f7; color: #58a6ff;',
          },
          [
            .text('$activeLabel (Click or Space to toggle)'),
          ],
        ),
      ],
    );
  }
}
