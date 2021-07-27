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
      child: const MyApp(),
    ),
  );
}
// #enddocregion main

Map<String, WidgetBuilder> _routes = {
  '/setstate': (context) => const set_state.HelperScaffoldWrapper(),
  '/provider': (context) => const MyHomepage(),
  '/callbacks': (context) => const callbacks.MyHomepage(),
  '/perf': (context) => const performance.MyHomepage(),
};

// #docregion multi-provider-main
void multiProviderMain() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        Provider(create: (context) => SomeOtherClass()),
      ],
      child: const MyApp(),
    ),
  );
}
// #enddocregion multi-provider-main

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Management Code Excerpts',
      routes: _routes,
      home: const Material(
        child: _Menu(),
      ),
    );
  }
}

class SomeOtherClass {}

class _Menu extends StatelessWidget {
  const _Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple state management'),
      ),
      body: Wrap(
        children: [
          for (final name in _routes.keys)
            TextButton(
              onPressed: () => Navigator.pushNamed(context, name),
              child: Text(name),
            )
        ],
      ),
    );
  }
}
