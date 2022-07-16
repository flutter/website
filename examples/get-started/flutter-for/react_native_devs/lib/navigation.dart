import 'package:flutter/material.dart';

// #docregion Navigator
class NavigationApp extends StatelessWidget {
  // This widget is the root of your application.
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //...
      routes: <String, WidgetBuilder>{
        '/a': (context) => const UsualNavScreen(),
        '/b': (context) => const DrawerNavScreen(),
      },
      //...
    );
  }
}
// #enddocregion Navigator

class UsualNavScreen extends StatelessWidget {
  const UsualNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}

class DrawerNavScreen extends StatelessWidget {
  const DrawerNavScreen({super.key});

  void navigateRoute(BuildContext context) {
    // #docregion PushNamed
    Navigator.of(context).pushNamed('/a');
    // #enddocregion PushNamed
  }

  void pushNavigator(BuildContext context) {
    // #docregion NavigatorPush
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsualNavScreen(),
      ),
    );
    // #enddocregion NavigatorPush
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// #docregion TabNav
class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController controller = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: const <Tab>[
        Tab(icon: Icon(Icons.person)),
        Tab(icon: Icon(Icons.email)),
      ],
    );
  }
}
// #enddocregion TabNav

class NavigationHomePage extends StatefulWidget {
  const NavigationHomePage({super.key});

  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

// #docregion NavigationHomePageState
class _NavigationHomePageState extends State<NavigationHomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Material(
          color: Colors.blue,
          child: TabBar(
            tabs: const <Tab>[
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                icon: Icon(Icons.email),
              ),
            ],
            controller: controller,
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: const <Widget>[HomeScreen(), TabScreen()],
        ));
  }
}
// #enddocregion NavigationHomePageState

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Home Screen');
  }
}

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Tab Screen');
  }
}

class DrawerExample extends StatelessWidget {
  const DrawerExample({super.key});

  // #docregion Drawer
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: ListTile(
        leading: const Icon(Icons.change_history),
        title: const Text('Screen2'),
        onTap: () {
          Navigator.of(context).pushNamed('/b');
        },
      ),
    );
  }
  // #enddocregion Drawer
}
