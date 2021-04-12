import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mgmt/src/provider.dart';

class AnotherMonstrousWidget extends SomeExpensiveWidget {
  AnotherMonstrousWidget({Widget? child}) : super(child: child);
}

class ChildUsingDescendant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // #docregion child
    return Consumer<CartModel>(
      builder: (context, cart, child) => Stack(
            children: [
              // Use SomeExpensiveWidget here, without rebuilding every time.
              if (child != null) child,
              Text("Total price: ${cart.totalPrice}"),
            ],
          ),
      // Build the expensive widget here.
      child: SomeExpensiveWidget(),
    );
    // #enddocregion child
  }
}

class DescendantInLeafNode_Good extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // #docregion leafDescendant
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
    // #enddocregion leafDescendant
  }
}

class DescendantNotInLeafNode_Bad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // #docregion nonLeafDescendant
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
    // #enddocregion nonLeafDescendant
  }
}

class HumongousWidget extends SomeExpensiveWidget {
  HumongousWidget({Widget? child}) : super(child: child);
}

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ChildUsingDescendant(),
          DescendantNotInLeafNode_Bad(),
          DescendantInLeafNode_Good(),
          NonRebuilding_Good(),
        ],
      ),
    );
  }
}

class NonRebuilding_Good extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _onPressed(context),
      child: Text("Add"),
    );
  }

  void _onPressed(BuildContext context) {
    // #docregion nonRebuilding
    Provider.of<CartModel>(context, listen: false).removeAll();
    // #enddocregion nonRebuilding
  }
}

class SomeExpensiveWidget extends StatelessWidget {
  final Widget? child;

  SomeExpensiveWidget({this.child});

  @override
  Widget build(BuildContext context) {
    // Imagine this is a huge build method. You don't want to rebuild it
    // every time that total price changes.
    return Container(
      color: Colors.yellow,
      child: child,
    );
  }
}
