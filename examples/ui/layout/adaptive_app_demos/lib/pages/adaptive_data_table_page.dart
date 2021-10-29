import 'package:adaptive_app_demos/global/styling.dart';
import 'package:adaptive_app_demos/widgets/scroll_view_with_scrollbars.dart';
import 'package:flutter/material.dart';

class AdaptiveDataTablePage extends StatelessWidget {
  final List<int> items = List.generate(100, (index) => index);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool showCol2 = constraints.maxWidth > 300;
        bool showCol3 = constraints.maxWidth > 600;
        bool showCol4 = constraints.maxWidth > 900;
        return Column(children: [
          Row(
            children: [
              _TableHeader("Column 1"),
              if (showCol2) _TableHeader("Column 2"),
              if (showCol3) _TableHeader("Column 3"),
              if (showCol4) _TableHeader("Column 4"),
            ],
          ),
          Expanded(
            child: ScrollViewWithScrollbars(
              child: Column(
                children: items.map((i) {
                  return Container(
                    color: i % 2 == 0 ? Colors.grey.shade300 : null,
                    child: Row(
                      children: [
                        _TableRowItem("Item $i, Column 1"),
                        if (showCol2) _TableRowItem("Item $i, Column 2"),
                        if (showCol3) _TableRowItem("Item $i, Column 3"),
                        if (showCol4) _TableRowItem("Item $i, Column 4"),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ]);
      },
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader(this.label, {Key? key}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Padding(
          padding: EdgeInsets.all(Insets.medium),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
}

class _TableRowItem extends StatelessWidget {
  const _TableRowItem(this.label, {Key? key}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Insets.medium, vertical: Insets.extraLarge),
          child: Text(label)));
}
