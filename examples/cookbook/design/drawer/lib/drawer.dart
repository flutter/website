import 'package:flutter/material.dart';

void drawerStart() {
  // #docregion DrawerStart
  Scaffold(
    drawer: null, // Add a Drawer here in the next step.
  );
  // #enddocregion DrawerStart
}

void drawerEmpty() {
  // #docregion DrawerEmpty
  Scaffold(
    drawer: Drawer(
      child: null, // Populate the Drawer in the next step.
    ),
  );
  // #enddocregion DrawerEmpty
}

void drawerListview() {
  // #docregion DrawerListView
  Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ),
  );
  // #enddocregion DrawerListView
}

void drawerClose() {
  Builder(
    builder: (context) {
      return Drawer(
        child: ListView(
          children: [
            // #docregion CloseDrawer
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            // #enddocregion CloseDrawer
          ],
        ),
      );
    },
  );
}
