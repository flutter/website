import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mgmt/src/passing_callbacks.dart' as callbacks;
import 'package:state_mgmt/src/performance.dart' as performance;
import 'package:state_mgmt/src/provider.dart';
import 'package:state_mgmt/src/set_state.dart' as set_state;

// #docregion main
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}
// #enddocregion main

Map<String, WidgetBuilder> _routes = {
  '/setstate': (context) => set_state.HelperScaffoldWrapper(),
  '/provider': (context) => MyHomepage(),
  '/callbacks': (context) => callbacks.MyHomepage(),
  '/perf': (context) => performance.MyHomepage(),
};

// #docregion multi-provider-main
void multiProviderMain() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        Provider(create: (context) => SomeOtherClass()),
      ],
      child: MyApp(),
    ),
  );
}
// #enddocregion multi-provider-main

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

class SomeOtherClass {}

class _Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple state management')),
      body: Wrap(
        children: _routes.keys
            .map((name) => TextButton(
                onPressed: () => Navigator.pushNamed(context, name),
                child: Text(name)))
            .toList(growable: false),
      ),
    );
  }
}
