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

Map<String, WidgetBuilder> _routes = {
  '/setstate': (context) => set_state.HelperScaffoldWrapper(),
  '/scoped': (context) => MyHomepage(),
  '/callbacks': (context) => callbacks.MyHomepage(),
  '/perf': (context) => performance.MyHomepage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Management Code Excerpts',
      routes: _routes,
      home: Material(
        child: _Menu(),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple state management')),
      body: Wrap(
        children: _routes.keys
            .map((name) => FlatButton(
                onPressed: () => Navigator.pushNamed(context, name),
                child: Text(name)))
            .toList(growable: false),
      ),
    );
  }
}
