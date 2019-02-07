import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:state_mgmt/src/passing_callbacks.dart' as callbacks;
import 'package:state_mgmt/src/performance.dart' as performance;
import 'package:state_mgmt/src/scoped_model.dart';
import 'package:state_mgmt/src/set_state.dart' as set_state;

// #docregion main
void main() {
  final cart = CartModel();

  // You could optionally connect [cart] with some database here.

  runApp(
    ScopedModel<CartModel>(
      model: cart,
      child: MyApp(),
    ),
  );
}
// #enddocregion main

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Management Code Excerpts',
      home: Material(
        child: SafeArea(
          child: PageView(
            children: [
              set_state.MyHomepage(),
              MyHomepage(),
              callbacks.MyHomepage(),
              performance.MyHomepage(),
            ],
          ),
        ),
      ),
    );
  }
}
