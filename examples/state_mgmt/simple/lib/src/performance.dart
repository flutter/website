import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

class AnotherMonstrousWidget extends SomeExpensiveWidget {
  const AnotherMonstrousWidget({super.child, super.key});
}

class ChildUsingDescendant extends StatelessWidget {
  const ChildUsingDescendant({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion child
    return Consumer<CartModel>(
      builder: (context, cart, child) => Stack(
        children: [
          // Use SomeExpensiveWidget here, without rebuilding every time.
          ?child,
          Text('Total price: ${cart.totalPrice}'),
        ],
      ),
      // Build the expensive widget here.
      child: const SomeExpensiveWidget(),
    );
    // #enddocregion child
  }
}

class DescendantInLeafNodeGood extends StatelessWidget {
  const DescendantInLeafNodeGood({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion leaf-descendant
    // DO THIS
    return HumongousWidget(
      // ...
      child: AnotherMonstrousWidget(
        // ...
        child: Consumer<CartModel>(
          builder: (context, cart, child) {
            return Text('Total price: ${cart.totalPrice}');
          },
        ),
      ),
    );
    // #enddocregion leaf-descendant
  }
}

class DescendantNotInLeafNodeBad extends StatelessWidget {
  const DescendantNotInLeafNodeBad({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion non-leaf-descendant
    // DON'T DO THIS
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return HumongousWidget(
          // ...
          child: AnotherMonstrousWidget(
            // ...
            child: Text('Total price: ${cart.totalPrice}'),
          ),
        );
      },
    );
    // #enddocregion non-leaf-descendant
  }
}

class HumongousWidget extends SomeExpensiveWidget {
  const HumongousWidget({super.child, super.key});
}

class MyHomepage extends StatelessWidget {
  const MyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          ChildUsingDescendant(),
          DescendantNotInLeafNodeBad(),
          DescendantInLeafNodeGood(),
          NonRebuildingGood(),
        ],
      ),
    );
  }
}

class NonRebuildingGood extends StatelessWidget {
  const NonRebuildingGood({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _onPressed(context),
      child: const Text('Add'),
    );
  }

  void _onPressed(BuildContext context) {
    // #docregion non-rebuilding
    Provider.of<CartModel>(context, listen: false).removeAll();
    // #enddocregion non-rebuilding
  }
}

class SomeExpensiveWidget extends StatelessWidget {
  const SomeExpensiveWidget({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // Imagine this is a huge build method. You don't want to rebuild it
    // every time that total price changes.
    return Container(color: Colors.yellow, child: child);
  }
}
