import 'dart:math';

import 'package:flutter/material.dart';

import '../global/device_type.dart';
import '../global/targeted_actions.dart';
import '../widgets/buttons.dart';

class AdaptiveGridPage extends StatefulWidget {
  const AdaptiveGridPage({super.key});

  @override
  State<AdaptiveGridPage> createState() => _AdaptiveGridPageState();
}

class _AdaptiveGridPageState extends State<AdaptiveGridPage> {
  final List<int> _listItems = List.generate(100, (index) => index);
  final ScrollController _scrollController = ScrollController();

  List<int> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    // Create a list of widgets to render, inject .isSelected into each item
    Widget buildGridItem(int index) => _GridItem(index,
        isSelected: _selectedItems.contains(index),
        onPressed: _handleItemPressed);
    List<Widget> listChildren = _listItems.map(buildGridItem).toList();
    return TargetedActionBinding(
      actions: {
        SelectAllIntent:
            CallbackAction(onInvoke: (intent) => _handleSelectAllPressed()),
        SelectNoneIntent:
            CallbackAction(onInvoke: (intent) => _handleSelectNonePressed()),
        DeleteIntent: CallbackAction(
            onInvoke: (intent) => _handleDeleteSelectedPressed()),
      },
      child: Column(
        children: [
          Row(
            children: [
              StyledTextButton(
                onPressed: _handleSelectAllPressed,
                child: const Text('Select All'),
              ),
              StyledTextButton(
                onPressed: _handleSelectNonePressed,
                child: const Text('Select None'),
              ),
            ],
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate how many columns we want depending on available space
                int colCount = max(1, (constraints.maxWidth / 250).floor());
                // #docregion scrollbar-always-shown
                return Scrollbar(
                  thumbVisibility: DeviceType.isDesktop,
                  controller: _scrollController,
                  child: GridView.count(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(Insets.extraLarge),
                    childAspectRatio: 1,
                    crossAxisCount: colCount,
                    children: listChildren,
                  ),
                );
                // #enddocregion scrollbar-always-shown
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleSelectAllPressed() =>
      setState(() => _selectedItems = List.from(_listItems));
  void _handleSelectNonePressed() => setState(() => _selectedItems.clear());
  void _handleDeleteSelectedPressed() => setState(() => _selectedItems.clear());

  void _handleItemPressed(int index) {
    setState(() {
      if (_selectedItems.contains(index)) {
        _selectedItems.remove(index);
      } else {
        _selectedItems.add(index);
      }
    });
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem(this.index,
      {required this.isSelected, required this.onPressed});
  final int index;
  final bool isSelected;
  final void Function(int index) onPressed;

  @override
  Widget build(BuildContext context) {
    double borderWidth = isSelected ? 6 : 0;
    return Padding(
      padding: const EdgeInsets.all(Insets.large),
      child: TextButton(
        onPressed: () => onPressed.call(index),
        child: Stack(children: [
          const Center(child: FlutterLogo(size: 64)),
          Container(color: Colors.grey.withValues(alpha: isSelected ? .5 : .7)),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  color: Colors.grey.shade600,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text('Grid Item $index',
                      style: const TextStyle(color: Colors.white)))),
          // Selected border
          Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.blue.shade200, width: borderWidth))),
        ]),
      ),
    );
  }
}

/// Intents to support keyboard shortcuts
class DeleteIntent extends Intent {}

class SelectAllIntent extends Intent {}

class SelectNoneIntent extends Intent {}
