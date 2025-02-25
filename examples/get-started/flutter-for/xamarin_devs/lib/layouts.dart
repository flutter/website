import 'package:flutter/material.dart';

class RowExample extends StatelessWidget {
  const RowExample({super.key});

  // #docregion row
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Row One'),
        Text('Row Two'),
        Text('Row Three'),
        Text('Row Four'),
      ],
    );
  }

  // #enddocregion row
}

class ColumnExample extends StatelessWidget {
  const ColumnExample({super.key});

  // #docregion column
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Column One'),
        Text('Column Two'),
        Text('Column Three'),
        Text('Column Four'),
      ],
    );
    // #enddocregion column
  }
}

class GridExample extends StatelessWidget {
  const GridExample({super.key});

  // #docregion grid
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the list.
      children: List<Widget>.generate(100, (index) {
        return Center(
          child: Text(
            'Item $index',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        );
      }),
    );
  }

  // #enddocregion grid
}

class StackExample extends StatelessWidget {
  const StackExample({super.key});

  // #docregion stack
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: <Widget>[
        Icon(Icons.add_box, size: 24, color: Colors.black),
        Positioned(
          left: 10,
          child: Icon(Icons.add_circle, size: 24, color: Colors.black),
        ),
      ],
    );
  }

  // #enddocregion stack
}

class ScrollViewExample extends StatelessWidget {
  const ScrollViewExample({super.key});

  // #docregion scroll-view
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(child: Text('Long Content'));
  }

  // #enddocregion scroll-view
}

class ListViewExample extends StatelessWidget {
  const ListViewExample({super.key});

  // #docregion list-view
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

  // #enddocregion list-view
}
