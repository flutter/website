// ignore_for_file: non_constant_identifier_names

/// Shows 3 types of layout:
/// - A vertical for narrow screens
/// - Wide for wide screens
/// - A mixed mode
library;

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';

import '../global/device_type.dart';
import '../widgets/scroll_view_with_scrollbars.dart';

enum ReflowMode { vertical, horizontal, mixed }

class AdaptiveReflowPage extends StatelessWidget {
  const AdaptiveReflowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        /// Decide which mode to show in
        ReflowMode reflowMode = ReflowMode.mixed;
        if (constraints.maxWidth < 800) {
          reflowMode = ReflowMode.vertical;
        } else if (constraints.maxHeight < 800) {
          reflowMode = ReflowMode.horizontal;
        }
        // In mixed mode, use a mix of Colum and Row
        if (reflowMode == ReflowMode.mixed) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _ContentPanel1()),
                    Expanded(child: _ContentPanel2()),
                  ],
                ),
              ),
              Expanded(child: _ContentPanel3()),
            ],
          );
        }
        // In vertical or horizontal mode, use a ExpandedScrollingFlex with the same set of children
        else {
          Axis direction = reflowMode == ReflowMode.horizontal
              ? Axis.horizontal
              : Axis.vertical;
          return ExpandedScrollingFlex(
            scrollViewBuilder: (axis, child) =>
                ScrollViewWithScrollbars(axis: axis, child: child),
            direction: direction,
            children: [
              _ContentPanel1(),
              _ContentPanel2(),
              _ContentPanel3(),
            ].map((c) => Expanded(child: c)).toList(),
          );
        }
      },
    );
  }
}

/// For demo purposes, simulate 3 different content areas
Widget _ContentPanel1() => const _ContentPanel('Panel 1');
Widget _ContentPanel2() => const _ContentPanel('Panel 2');
Widget _ContentPanel3() => const _ContentPanel('Panel 3');

class _ContentPanel extends StatelessWidget {
  const _ContentPanel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    // #docregion visual-density-own-view
    VisualDensity density = Theme.of(context).visualDensity;
    // #enddocregion visual-density-own-view
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300, minWidth: 300),
      child: Padding(
        padding: EdgeInsets.all(Insets.large + density.vertical * 6),
        child: Container(
          alignment: Alignment.center,
          color: Colors.purple.shade100,
          child: Text(label),
        ),
      ),
    );
  }
}
