// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'embedded_dartpad.dart';

import 'extract_content.dart' if (dart.library.io) 'extract_content_vm.dart';

/// Prepares a code block that will be replaced with an embedded
/// DartPad when the site is loaded.
final class DartPadWrapper extends StatefulComponent {
  DartPadWrapper({
    super.key,
    required this.content,
    required this.title,
    this.theme,
    this.height,
    this.runAutomatically = false,
  });

  final String content;
  final String title;
  final String? theme;
  final String? height;
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
      height: component.height,
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

  String content = '';

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // During hydration, extract the content from the pre-rendered code block.
      content = extractContent(context as Element);
    }
  }

  @override
  Component build(BuildContext context) {
    if (!kIsWeb) {
      // During pre-rendering, get the content from the nearest DartPadWrapper.
      final content = context
          .findAncestorStateOfType<_DartPadWrapperState>()
          ?.component
          .content;
      return pre([
        code(
          attributes: {'title': component.title},
          [text(content ?? '')],
        ),
      ]);
    }

    return Component.wrapElement(
      attributes: {
        'height': ?component.height,
        'title': component.title,
      },
      child: EmbeddedDartPad.create(
        iframeId: _frameId,
        theme: switch (component.theme) {
          'auto' => DartPadTheme.auto,
          'dark' => DartPadTheme.dark,
          _ => DartPadTheme.light,
        },
        embedLayout: true,
        runAutomatically: component.runAutomatically,
        code: content,
      ),
    );
  }
}
