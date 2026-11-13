// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'review_client_script.dart';
import 'review_config.dart';

final String _cachedReviewClientScript = buildReviewClientScript();

/// Builds the `<script>` components required to mount the visual review overlay
/// on [page].
///
/// Returns an empty `const []` list whenever [ReviewConfig.isEnabled] (or
/// [ReviewEnvironment.isEnabled] when [environment] is overridden in tests) is
/// `false`, guaranteeing zero emitted bytes in production deployments and
/// standard CI builds.
List<Component> buildReviewOverlayComponents(
  Page page, {
  required String defaultSite,
  required String contentRootPrefix,
  ReviewEnvironment? environment,
}) {
  final effectiveEnv = environment ?? const ReviewEnvironment.fromEnvironment();
  if (environment == null) {
    if (!ReviewConfig.isEnabled) {
      return const [];
    }
  } else if (!effectiveEnv.isEnabled) {
    return const [];
  }

  final configMap = buildReviewPageConfigMap(
    page,
    defaultSite: defaultSite,
    contentRootPrefix: contentRootPrefix,
    environment: effectiveEnv,
  );
  final encodedConfig = encodeReviewJsonForHtml(configMap);

  return [
    script(
      id: 'dash-review-config',
      attributes: const {'type': 'application/json'},
      content: encodedConfig,
    ),
    script(
      id: 'dash-review-script',
      defer: true,
      content: _cachedReviewClientScript,
    ),
  ];
}
