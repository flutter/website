// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../../analytics/analytics.dart';
import '../button.dart';

/// Provides the user options to provide feedback on the specified page.
@client
final class FeedbackComponent extends StatefulComponent {
  const FeedbackComponent({required this.issueUrl});

  final String issueUrl;

  @override
  State<FeedbackComponent> createState() => _FeedbackComponentState();
}

final class _FeedbackComponentState extends State<FeedbackComponent> {
  _FeedbackState feedback = _FeedbackState.none;

  void _provideFeedback({required bool helpful}) {
    if (!kIsWeb) return;

    setState(
      () => feedback = helpful
          ? _FeedbackState.helpful
          : _FeedbackState.unhelpful,
    );
    analytics.sendFeedback(helpful);
  }

  @override
  Component build(BuildContext context) {
    return div(id: 'page-feedback', [
      div(classes: 'feedback', [
        div([Component.text(feedback.introduction)]),
        ...switch (feedback) {
          _FeedbackState.none => [
            div(classes: 'feedback-buttons', [
              Button(
                icon: 'thumb_up',
                title: 'Yes, this page was helpful.',
                onClick: () => _provideFeedback(helpful: true),
              ),
              Button(
                icon: 'thumb_down',
                title: 'No, this page was not helpful or had an issue',
                onClick: () => _provideFeedback(helpful: false),
              ),
            ]),
          ],
          _FeedbackState.helpful => [
            Button(
              content: 'Provide details',
              icon: 'feedback',
              title: 'Provide detailed feedback.',
              href: component.issueUrl,
              attributes: const {'target': '_blank', 'rel': 'noopener'},
            ),
          ],
          _FeedbackState.unhelpful => [
            Button(
              content: 'Provide details',
              icon: 'bug_report',
              title: 'Provide feedback or report an issue.',
              href: component.issueUrl,
              attributes: const {'target': '_blank', 'rel': 'noopener'},
            ),
          ],
        },
      ]),
    ]);
  }
}

enum _FeedbackState {
  none('Was this page\'s content helpful?'),
  helpful('Thank you for your feedback!'),
  unhelpful(
    'Thank you for your feedback! '
    'Please let us know what we can do to improve.',
  );

  const _FeedbackState(this.introduction);

  final String introduction;
}
