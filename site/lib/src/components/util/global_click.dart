// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

final class GlobalClickListener extends StatefulComponent {
  const GlobalClickListener(this.child, {required this.onClick});

  final Component child;
  final void Function(web.MouseEvent) onClick;

  @override
  State<GlobalClickListener> createState() => _GlobalClickListenerState();
}

class _GlobalClickListenerState extends State<GlobalClickListener> {
  @override
  void initState() {
    if (kIsWeb) {
      web.document.addEventListener('click', component.onClick.toJS);
    }

    super.initState();
  }

  @override
  Component build(BuildContext _) => component.child;
}
