---
title: AppBar with a custom bottom widget
description: An example that uses an AppBar at the bottom of the page.
deprecated: true
---

Any widget with a PreferredSize can appear at the bottom of an AppBar.

<p>
  <div class="container-fluid">
    <div class="row">
      <div class="col-lg-4">
        <div class="panel">
          <div class="panel-body">
            <img style="border:1px solid #000000" src="https://storage.googleapis.com/flutter-catalog/cb4a54db8fb3726bf4293b9cc5cb12ce16883803/app_bar_bottom_small.png" alt="Android screenshot" class="img-fluid">
          </div>
          <!-- <div class="panel-footer">
            Android screenshot
          </div> -->
        </div>
      </div>
    </div>
  </div>
</p>

Typically an AppBar's bottom widget is a TabBar however any widget with a
PreferredSize can be used. In this app, the app bar's bottom widget is a
TabPageSelector that displays the relative position of the selected page
in the app's TabBarView. The arrow buttons in the toolbar part of the app
bar and they select the previous or the next page.

Try this app out by creating a new project with `flutter create` and
replacing the contents of `lib/main.dart` with the following code.

```dart
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class AppBarBottomSample extends StatefulWidget {
  @override
  _AppBarBottomSampleState createState() => _AppBarBottomSampleState();
}

class _AppBarBottomSampleState extends State<AppBarBottomSample>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: choices.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AppBar Bottom Widget'),
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _nextPage(-1);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              tooltip: 'Next choice',
              onPressed: () {
                _nextPage(1);
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: TabPageSelector(controller: _tabController),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChoiceCard(choice: choice),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(AppBarBottomSample());
}
```

## See also

* The [Components-Tabs]({{site.material}}/guidelines/components/tabs.html)
  section of the [Material Design]({{site.material}}) specification.
* The source code in
  [examples/catalog/lib/app_bar_bottom.dart]({{site.repo.flutter}}/tree/{{site.branch}}/examples/catalog/lib/animated_list.dart).
