// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../src/utils/retake_element.dart';
import 'embedded_dartpad.dart';

/// Prepares a code block that will be replaced with an embedded
/// DartPad when the site is loaded.
final class DartPadWrapper extends StatefulComponent {
  DartPadWrapper({
    super.key,
    required this.content,
    required this.title,
    required this.height,
    this.theme,
    this.runAutomatically = false,
  }) : assert(height > 0);

  final String content;
  final String title;
  final String? theme;

  /// The height of the embedded DartPad in pixels.
  final int height;

  final bool runAutomatically;

  @override
  State<StatefulComponent> createState() => _DartPadWrapperState();
}

final class _DartPadWrapperState extends State<DartPadWrapper> {
  @override
  Component build(BuildContext context) {
    return DartPadInjector(
      title: component.title,
      theme: component.theme,
      height: '${component.height}px',
      runAutomatically: component.runAutomatically,
      // We don't pass the content here, so it's not part of the client
      // component data. It will be retrieved by DartPadInjector automatically.
    );
  }
}

@client
class DartPadInjector extends StatefulComponent {
  const DartPadInjector({
    required this.title,
    this.theme,
    this.height,
    this.runAutomatically = false,
    super.key,
  });

  final String title;
  final String? theme;

  /// The CSS height of the embedded DartPad, such as `520px`.
  final String? height;

  final bool runAutomatically;

  @override
  State<DartPadInjector> createState() => _DartPadInjectorState();
}

class _DartPadInjectorState extends State<DartPadInjector> {
  static int _injectedIndex = 0;

  final String _frameId = () {
    final nextId = _injectedIndex;
    _injectedIndex += 1;
    return 'embedded-dartpad-$nextId';
  }();

  String _content = '';

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // During hydration, extract the content from the pre-rendered code block.
      _content = extractContent(context as Element);
    }
  }

  @override
  Component build(BuildContext context) {
    // Give the pre-rendered placeholder and the hydrated iframe
    // the same class and height so they reserve the same space.
    const classes = 'embedded-dartpad';
    final styles = Styles(raw: {'height': component.height ?? '400px'});

    if (!kIsWeb) {
      // During pre-rendering, get the content from the nearest DartPadWrapper.
      final content = context
          .findAncestorStateOfType<_DartPadWrapperState>()
          ?.component
          .content;
      return pre(
        classes: classes,
        styles: styles,
        [
          code(
            attributes: {'title': component.title},
            [.text(content ?? '')],
          ),
        ],
      );
    }

    return .apply(
      classes: classes,
      styles: styles,
      attributes: {'title': component.title},
      child: EmbeddedDartPad.create(
        iframeId: _frameId,
        theme: switch (component.theme) {
          'auto' => DartPadTheme.auto,
          'dark' => DartPadTheme.dark,
          _ => DartPadTheme.light,
        },
        embedLayout: true,
        runAutomatically: component.runAutomatically,
        code: _content,
      ),
    );
  }
}
