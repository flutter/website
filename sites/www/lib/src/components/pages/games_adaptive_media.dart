// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

@client
class GamesAdaptiveMedia extends StatelessComponent {
  const GamesAdaptiveMedia({
    required this.mobileAssets,
    required this.desktopAssets,
    super.key,
  });

  final Map<String, String> mobileAssets;
  final Map<String, String> desktopAssets;

  @override
  Component build(BuildContext context) {
    return switch (!kIsWeb || web.window.innerWidth < 1024) {
      true => div(classes: 'img-container', [
        for (final asset in mobileAssets.entries)
          img(src: asset.value, alt: asset.key),
      ]),
      false => div(classes: 'gif-container', [
        for (final asset in desktopAssets.entries)
          img(src: asset.value, alt: asset.key),
      ]),
    };
  }
}
