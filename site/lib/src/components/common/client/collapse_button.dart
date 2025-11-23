// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import 'package:universal_web/web.dart' as web;

import '../button.dart';

@client
class CollapseButton extends StatefulComponent {
  const CollapseButton({
    this.classes = const [],
    this.title,
  });

  final String? title;
  final List<String> classes;

  @override
  State<CollapseButton> createState() => _CollapseButtonState();
}

class _CollapseButtonState extends State<CollapseButton> {
  final buttonKey = GlobalNodeKey<web.HTMLButtonElement>();
  bool _collapsed = true;

  void toggleCollapse() {
    setState(() => _collapsed = !_collapsed);

    buttonKey.currentNode
        ?.closest('.code-block-wrapper')
        ?.classList
        .toggle('collapsed');
  }

  @override
  Component build(BuildContext _) {
    return Button(
      ref: buttonKey,
      classes: ['collapse-button', ...component.classes],
      title: component.title,
      icon: 'keyboard_arrow_up',
      onClick: toggleCollapse,
    );
  }
}
