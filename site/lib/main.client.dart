// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:js_interop';

import 'package:jaspr/client.dart';
import 'package:universal_web/web.dart' as web;

import 'main.client.options.dart';
import 'src/client/global_scripts.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultClientOptions,
  );

  if (web.document.readyState == 'loading') {
    web.document.addEventListener('DOMContentLoaded', setUpSite.toJS);
  } else {
    setUpSite();
  }

  runApp(
    const ClientApp(),
  );
}
