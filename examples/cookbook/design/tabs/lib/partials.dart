// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TabBarDemo1 extends StatelessWidget {
  const TabBarDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion TabController
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(),
      ),
    );
    // #enddocregion TabController
  }
}

class TabBarDemo2 extends StatelessWidget {
  const TabBarDemo2({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion Tabs
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
          ),
        ),
      ),
    );
    // #enddocregion Tabs
  }
}
