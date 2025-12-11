// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../button.dart';
import '../dropdown.dart';

@client
final class PageHeaderOptions extends StatefulComponent {
  const PageHeaderOptions({
    required this.title,
    this.sourceUrl,
    this.issueUrl,
    super.key,
  });

  final String title;
  final String? sourceUrl;
  final String? issueUrl;

  @override
  State<PageHeaderOptions> createState() => _PageHeaderOptionsState();
}

final class _PageHeaderOptionsState extends State<PageHeaderOptions> {
  bool _isShareSupported = false;

  @override
  void initState() {
    super.initState();
    _checkShareSupport();
  }

  void _checkShareSupport() {
    if (kIsWeb) {
      try {
        // Check if the share API is available.
        _isShareSupported = web.window.navigator.canShare(_shareData);
      } catch (_) {
        _isShareSupported = false;
      }
      setState(() {});
    }
  }

  String get _currentBaseUrl =>
      web.window.location.origin + web.window.location.pathname;

  web.ShareData get _shareData => web.ShareData(
    url: _currentBaseUrl,
    title: component.title,
  );

  @override
  Component build(BuildContext _) => Dropdown(
    id: 'page-header-options',
    toggle: const Button(icon: 'more_vert', title: 'View page options.'),
    content: nav(
      classes: 'dropdown-menu',
      attributes: {
        'role': 'menu',
      },
      [
        ul(
          [
            li(
              [
                if (_isShareSupported)
                  Button(
                    icon: 'share',
                    content: 'Share page',
                    onClick: () {
                      web.window.navigator.share(_shareData).toDart.ignore();
                    },
                  )
                else
                  Button(
                    icon: 'copy',
                    content: 'Copy link',
                    onClick: () {
                      web.window.navigator.clipboard
                          .writeText(_currentBaseUrl)
                          .toDart
                          .ignore();
                    },
                  ),
              ],
            ),
            if (component.sourceUrl case final sourceUrl?)
              li(
                [
                  Button(
                    icon: 'docs',
                    content: 'View source',
                    href: sourceUrl,
                    attributes: const {
                      'target': '_blank',
                      'rel': 'noopener',
                    },
                  ),
                ],
              ),
            if (component.issueUrl case final issueUrl?)
              li(
                [
                  Button(
                    icon: 'bug_report',
                    content: 'Report issue',
                    href: issueUrl,
                    attributes: const {
                      'target': '_blank',
                      'rel': 'noopener',
                    },
                  ),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}
