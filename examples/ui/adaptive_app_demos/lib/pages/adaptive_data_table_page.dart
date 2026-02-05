import 'package:flutter/material.dart';

import '../global/device_type.dart';
import '../widgets/scroll_view_with_scrollbars.dart';

class AdaptiveDataTablePage extends StatelessWidget {
  AdaptiveDataTablePage({super.key});

  final List<int> items = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool showCol2 = constraints.maxWidth > 300;
        bool showCol3 = constraints.maxWidth > 600;
        bool showCol4 = constraints.maxWidth > 900;
        return Column(
          children: [
            Row(
              children: [
                const _TableHeader('Column 1'),
                if (showCol2) const _TableHeader('Column 2'),
                if (showCol3) const _TableHeader('Column 3'),
                if (showCol4) const _TableHeader('Column 4'),
              ],
            ),
            Expanded(
              child: ScrollViewWithScrollbars(
                child: Column(
                  children: items.map((i) {
                    return Container(
                      color: i.isEven ? Colors.grey.shade300 : null,
                      child: Row(
                        children: [
                          _TableRowItem('Item $i, Column 1'),
                          if (showCol2) _TableRowItem('Item $i, Column 2'),
                          if (showCol3) _TableRowItem('Item $i, Column 3'),
                          if (showCol4) _TableRowItem('Item $i, Column 4'),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(Insets.medium),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

class _TableRowItem extends StatelessWidget {
  const _TableRowItem(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.medium,
        vertical: Insets.extraLarge,
      ),
      child: Text(label),
    ),
  );
}
