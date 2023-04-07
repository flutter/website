import 'package:flutter/material.dart';

class RowExample extends StatelessWidget {
  const RowExample({super.key});

  // #docregion Row
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text('Row One'),
        Text('Row Two'),
        Text('Row Three'),
        Text('Row Four'),
      ],
    );
  }
  // #enddocregion Row
}

class ColumnExample extends StatelessWidget {
  const ColumnExample({super.key});

  // #docregion Column
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text('Column One'),
        Text('Column Two'),
        Text('Column Three'),
        Text('Column Four'),
      ],
    );
    // #enddocregion Column
  }
}

class GridExample extends StatelessWidget {
  const GridExample({super.key});

  // #docregion Grid
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the list.
      children: List<Widget>.generate(
        100,
        (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
        },
      ),
    );
  }
  // #enddocregion Grid
}

class StackExample extends StatelessWidget {
  const StackExample({super.key});

  // #docregion Stack
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const <Widget>[
        Icon(
          Icons.add_box,
          size: 24.0,
          color: Colors.black,
        ),
        Positioned(
          left: 10.0,
          child: Icon(
            Icons.add_circle,
            size: 24.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
  // #enddocregion Stack
}

class ScrollViewExample extends StatelessWidget {
  const ScrollViewExample({super.key});

  // #docregion ScrollView
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Text('Long Content'),
    );
  }
  // #enddocregion ScrollView
}

class ListViewExample extends StatelessWidget {
  const ListViewExample({super.key});

  // #docregion ListView
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        Text('Row One'),
        Text('Row Two'),
        Text('Row Three'),
        Text('Row Four'),
      ],
    );
  }
  // #enddocregion ListView
}
