import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AbsorbKeysExample extends StatelessWidget {
  AbsorbKeysExample({required this.child});
  final Widget child;

// #docregion AbsorbKeysExample
  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (node, event) => KeyEventResult.handled,
      canRequestFocus: false,
      child: child,
    );
  }
// #enddocregion AbsorbKeysExample
}

class NoAExample extends StatelessWidget {
// #docregion NoAExample
  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (node, event) {
        return (event.logicalKey == LogicalKeyboardKey.keyA)
            ? KeyEventResult.handled
            : KeyEventResult.ignored;
      },
      child: TextField(),
    );
  }
// #enddocregion NoAExample
}

class BuilderExample extends StatelessWidget {
// #docregion BuilderExample
  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Builder(
        builder: (context) {
          final bool hasPrimary = Focus.of(context).hasPrimaryFocus;
          print('Building with primary focus: $hasPrimary');
          return const SizedBox(width: 100, height: 100);
        },
      ),
    );
  }
// #enddocregion BuilderExample
}

// #docregion OrderedButtonRowExample
class OrderedButtonRow extends StatelessWidget {
  const OrderedButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Row(
        children: <Widget>[
          const Spacer(),
          FocusTraversalOrder(
            order: NumericFocusOrder(2.0),
            child: TextButton(
              child: const Text('ONE'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          FocusTraversalOrder(
            order: NumericFocusOrder(1.0),
            child: TextButton(
              child: const Text('TWO'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          FocusTraversalOrder(
            order: NumericFocusOrder(3.0),
            child: TextButton(
              child: const Text('THREE'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
// #enddocregion OrderedButtonRowExample
