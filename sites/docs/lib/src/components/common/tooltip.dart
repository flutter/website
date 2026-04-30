// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../util.dart';
import '../util/global_event_listener.dart';

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
  static final isTouchscreen =
      kIsWeb && web.window.matchMedia('(pointer: coarse)').matches;

  final wrapperKey = GlobalNodeKey<web.HTMLElement>();
  final targetKey = GlobalNodeKey<web.HTMLElement>();
  final tooltipKey = GlobalNodeKey<web.HTMLElement>();

  bool isVisible = false;
  double tooltipOffset = 0.0;

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
    final target = targetKey.currentNode;
    final tooltip = tooltipKey.currentNode;
    if (tooltip == null || target == null) return;

    setState(() {
      tooltipOffset = calculateTooltipOffset(target, tooltip);
    });
  }

  @override
  Component build(BuildContext context) {
    return span(
      key: wrapperKey,
      classes: 'tooltip-wrapper',
      [
        span(
          key: targetKey,
          classes: 'tooltip-target',
          events: {
            if (isTouchscreen)
              'click': (e) {
                if (!isVisible) {
                  setState(() => isVisible = true);
                  e.preventDefault();
                }
              },
          },
          [component.target],
        ),
        if (component.content case final content?)
          GlobalEventListener(
            // Close tooltip when clicking outside of this wrapper.
            onClick: isTouchscreen
                ? (e) {
                    if (wrapperKey.currentNode?.contains(
                          e.target as web.Node?,
                        ) ==
                        true) {
                      return;
                    }
                    setState(() => isVisible = false);
                  }
                : null,
            // On touchscreen devices, close tooltips when scrolling.
            onScroll: isTouchscreen
                ? (_) {
                    setState(() => isVisible = false);
                  }
                : null,
            span(
              key: tooltipKey,
              classes: ['tooltip', if (isVisible) 'visible'].toClasses,
              styles: Styles(
                raw: {
                  'left': tooltipOffset == 0
                      ? '50%'
                      : tooltipOffset > 0
                      ? 'calc(50% + ${tooltipOffset}px)'
                      : 'calc(50% - ${tooltipOffset.abs()}px)',
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
