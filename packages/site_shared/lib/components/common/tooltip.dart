// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../util.dart';
import '../utils/global_event_listener.dart';

class Tooltip extends StatefulComponent {
  const Tooltip({
    required this.target,
    required this.content,
    super.key,
  });

  final Component target;
  final Component? content;

  @override
  State<Tooltip> createState() => _TooltipState();
}

class _TooltipState extends State<Tooltip> {
  static final bool _isTouchscreen =
      kIsWeb && web.window.matchMedia('(pointer: coarse)').matches;

  final GlobalNodeKey<web.HTMLElement> _wrapperKey = GlobalNodeKey();
  final GlobalNodeKey<web.HTMLElement> _targetKey = GlobalNodeKey();
  final GlobalNodeKey<web.HTMLElement> _tooltipKey = GlobalNodeKey();

  bool _isVisible = false;
  double _tooltipOffset = 0;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      setupTooltip();
    }
  }

  void setupTooltip() {
    context.binding.addPostFrameCallback(ensureVisible);

    // Reposition tooltips on window resize.
    web.EventStreamProviders.resizeEvent.forTarget(web.window).listen((_) {
      ensureVisible();
    });
  }

  /// Adjust the tooltip position to ensure it is fully inside the
  /// ancestor .content element.
  void ensureVisible() {
    final target = _targetKey.currentNode;
    final tooltip = _tooltipKey.currentNode;
    if (tooltip == null || target == null) return;

    setState(() {
      _tooltipOffset = calculateTooltipOffset(target, tooltip);
    });
  }

  @override
  Component build(BuildContext context) {
    return span(
      key: _wrapperKey,
      classes: 'tooltip-wrapper',
      [
        span(
          key: _targetKey,
          classes: 'tooltip-target',
          events: {
            if (_isTouchscreen)
              'click': (e) {
                if (!_isVisible) {
                  setState(() => _isVisible = true);
                  e.preventDefault();
                }
              },
          },
          [component.target],
        ),
        if (component.content case final content?)
          GlobalEventListener(
            // Close tooltip when clicking outside of this wrapper.
            onClick: _isTouchscreen
                ? (e) {
                    if (_wrapperKey.currentNode?.contains(
                          e.target as web.Node?,
                        ) ==
                        true) {
                      return;
                    }
                    setState(() => _isVisible = false);
                  }
                : null,
            // On touchscreen devices, close tooltips when scrolling.
            onScroll: _isTouchscreen
                ? (_) {
                    setState(() => _isVisible = false);
                  }
                : null,
            span(
              key: _tooltipKey,
              classes: ['tooltip', if (_isVisible) 'visible'].toClasses,
              styles: Styles(
                raw: {
                  'left': _tooltipOffset == 0
                      ? '50%'
                      : _tooltipOffset > 0
                      ? 'calc(50% + ${_tooltipOffset}px)'
                      : 'calc(50% - ${_tooltipOffset.abs()}px)',
                },
              ),
              [
                content,
              ],
            ),
          ),
      ],
    );
  }
}

double calculateTooltipOffset(web.HTMLElement target, web.HTMLElement tooltip) {
  final targetRect = target.getBoundingClientRect();
  final tooltipRect = tooltip.getBoundingClientRect();
  final containerRect = tooltip.closest('.content')?.getBoundingClientRect();

  final targetCenter = targetRect.left + (targetRect.width / 2);
  final tooltipWidth = tooltipRect.width;

  final initialLeft = targetCenter - (tooltipWidth / 2);
  final initialRight = targetCenter + (tooltipWidth / 2);

  final containerLeft = containerRect?.left ?? 0.0;
  final containerRight = containerRect?.right ?? web.window.innerWidth;

  if (initialLeft < containerLeft) {
    return containerLeft - initialLeft;
  } else if (initialRight > containerRight) {
    return containerRight - initialRight;
  } else {
    return 0;
  }
}
