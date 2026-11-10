// DartPad doesn't support `material_ui` yet,
// so this example imports Material from the Flutter SDK.
// To run locally, depend on `material_ui` and use this import instead:
// import 'package:material_ui/material_ui.dart';
// ignore: deprecated_member_use until DartPad supports material_ui.
import 'package:flutter/material.dart';

void main() {
  runApp(const TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          // #docregion TabBarView
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
          // #enddocregion TabBarView
        ),
      ),
    );
  }
}
