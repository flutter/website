import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AbsorbKeysExample extends StatelessWidget {
  const AbsorbKeysExample({super.key, required this.child});

  final Widget child;

  // #docregion AbsorbKeysExample
  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: (node, event) => KeyEventResult.handled,
      canRequestFocus: false,
      child: child,
    );
  }
  // #enddocregion AbsorbKeysExample
}

class NoAExample extends StatelessWidget {
  const NoAExample({super.key});

  // #docregion NoAExample
  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: (node, event) {
        return (event.logicalKey == LogicalKeyboardKey.keyA)
            ? KeyEventResult.handled
            : KeyEventResult.ignored;
      },
      child: const TextField(),
    );
  }
  // #enddocregion NoAExample
}

class BuilderExample extends StatelessWidget {
  const BuilderExample({super.key});

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
            order: const NumericFocusOrder(2),
            child: TextButton(
              child: const Text('ONE'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          FocusTraversalOrder(
            order: const NumericFocusOrder(1),
            child: TextButton(
              child: const Text('TWO'),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          FocusTraversalOrder(
            order: const NumericFocusOrder(3),
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
