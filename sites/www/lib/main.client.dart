// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/client.dart';

import 'main.client.options.dart';
import 'src/utils/scroll_spy.dart';

void main() {
  Jaspr.initializeApp(options: defaultClientOptions);

  ScrollNotifier.init();

  runApp(const ClientApp());
}
