// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
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
    this.markdownUrl,
    this.sourceUrl,
    this.issueUrl,
    super.key,
  });

  final String title;
  final String? markdownUrl;
  final String? sourceUrl;
  final String? issueUrl;

  @override
  State<PageHeaderOptions> createState() => _PageHeaderOptionsState();
}

final class _PageHeaderOptionsState extends State<PageHeaderOptions> {
  static const String _optionsId = 'page-header-options';
  static const String _copyStatusId = '$_optionsId-copy-status';

  bool _isShareSupported = false;
  _MarkdownCopyState _markdownCopyState = _MarkdownCopyState.idle;
  Timer? _markdownCopyResetTimer;

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

  /// Loads the Markdown at [markdownUrl].
  ///
  /// Throws if the request doesn't return a successful status code.
  Future<String> _loadMarkdown(String markdownUrl) async {
    final response = await http.get(Uri.parse(markdownUrl));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError(
        'Unable to load Markdown from $markdownUrl (${response.statusCode}).',
      );
    }

    return utf8.decode(response.bodyBytes);
  }

  /// Copies the page's Markdown at [markdownUrl] and
  /// updates the copy button's progress state.
  void _copyMarkdown(String markdownUrl) {
    if (!kIsWeb || _markdownCopyState.isBusy) return;

    _markdownCopyResetTimer?.cancel();
    final Future<JSAny?> copyOperation;
    try {
      // Hand the clipboard the still-pending Markdown instead of awaiting it
      // first, so the write is issued synchronously and keeps user activation.
      final markdown = {
        'text/plain': _loadMarkdown(markdownUrl).then((md) => md.toJS).toJS,
      }.jsify();
      copyOperation = web.window.navigator.clipboard
          .write([web.ClipboardItem(markdown! as JSObject)].toJS)
          .toDart;
    } catch (_) {
      setState(() => _markdownCopyState = _MarkdownCopyState.failed);
      _scheduleMarkdownCopyReset();
      return;
    }

    setState(() => _markdownCopyState = _MarkdownCopyState.copying);
    unawaited(_completeMarkdownCopy(copyOperation));
  }

  Future<void> _completeMarkdownCopy(Future<JSAny?> copyOperation) async {
    late final _MarkdownCopyState result;
    try {
      await copyOperation;
      result = _MarkdownCopyState.copied;
    } catch (_) {
      result = _MarkdownCopyState.failed;
    }

    if (!mounted) return;
    setState(() => _markdownCopyState = result);
    _scheduleMarkdownCopyReset();
  }

  void _scheduleMarkdownCopyReset() {
    _markdownCopyResetTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }
      setState(() => _markdownCopyState = _MarkdownCopyState.idle);
    });
  }

  @override
  void dispose() {
    _markdownCopyResetTimer?.cancel();
    super.dispose();
  }

  @override
  Component build(BuildContext _) => Dropdown(
    id: _optionsId,
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
                    icon: 'link',
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
            if (component.markdownUrl case final markdownUrl?) ...[
              li(
                [
                  Button(
                    icon: _markdownCopyState.icon,
                    content: 'Copy as Markdown',
                    title: 'Copy this page as Markdown to your clipboard.',
                    attributes: {
                      'aria-describedby': _copyStatusId,
                      // Native `disabled` drops focus and closes the dropdown.
                      if (_markdownCopyState.isBusy) ...{
                        'aria-busy': 'true',
                        'aria-disabled': 'true',
                      },
                    },
                    onClick: () => _copyMarkdown(markdownUrl),
                  ),
                  span(
                    id: _copyStatusId,
                    classes: 'copy-markdown-status',
                    attributes: const {
                      'role': 'status',
                      'aria-live': 'polite',
                      'aria-atomic': 'true',
                    },
                    [.text(_markdownCopyState.announcement)],
                  ),
                ],
              ),
              li(
                [
                  Button(
                    icon: 'markdown',
                    content: 'View as Markdown',
                    href: markdownUrl,
                    attributes: const {
                      'target': '_blank',
                      'rel': 'noopener',
                    },
                  ),
                ],
              ),
              if (component.issueUrl != null) const DropdownDivider(),
            ],
            if (component.sourceUrl case final sourceUrl?)
              li(
                [
                  Button(
                    icon: 'docs',
                    content: 'Open on GitHub',
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
                    content: 'Report an issue',
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

/// The current UI state of the "Copy as Markdown" action.
enum _MarkdownCopyState {
  /// The action is ready to copy Markdown.
  idle('content_copy', ''),

  /// The Markdown is being loaded and copied.
  copying('progress_activity', 'Copying Markdown.'),

  /// The Markdown was copied successfully.
  copied('check', 'Markdown copied.'),

  /// Loading or copying the Markdown failed.
  failed('error', "Couldn't copy Markdown.");

  const _MarkdownCopyState(this.icon, this.announcement);

  /// The button icon to display for this state.
  final String icon;

  /// The status to announce to assistive technologies for this state.
  final String announcement;

  /// Whether the action is waiting for the copy to finish.
  bool get isBusy => this == copying;
}
