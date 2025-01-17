---
title: Create a nested navigation flow
description: How to implement a flow with nested navigation.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/effects/nested_nav"?>

Apps accumulate dozens and then hundreds of routes over time.
Some of your routes make sense as top-level (global) routes.
For example, "/", "profile", "contact", "social_feed" are all
possible top-level routes within your app. 
But, imagine that you defined every possible route in your
top-level `Navigator` widget. The list would be very long,
and many of these routes would 
be better handled nested within another widget.

Consider an Internet of Things (IoT) setup flow for a wireless
light bulb that you control with your app.
This setup flow consists of 4 pages: 
find nearby bulbs, select the bulb that you want to add,
add the bulb, and then complete the setup.
You could orchestrate this behavior from your top-level 
`Navigator` widget. However, it makes more sense to define a second, 
nested `Navigator` widget within your `SetupFlow` widget,
and let the nested `Navigator` take ownership over the 4 pages
in the setup flow. This delegation of navigation facilitates
greater local control, which is 
generally preferable when developing software.

The following animation shows the app's behavior:

![Gif showing the nested "setup" flow](/assets/images/docs/cookbook/effects/NestedNavigator.gif){:.site-mobile-screenshot}

In this recipe, you implement a four-page IoT setup
flow that maintains its own navigation nested beneath
the top-level `Navigator` widget.

## Prepare for navigation

This IoT app has two top-level screens,
along with the setup flow. Define these 
route names as constants so that they can
be referenced within code.

<?code-excerpt "lib/main.dart (routes)"?>
```dart
const routeHome = '/';
const routeSettings = '/settings';
const routePrefixDeviceSetup = '/setup/';
const routeDeviceSetupStart = '/setup/$routeDeviceSetupStartPage';
const routeDeviceSetupStartPage = 'find_devices';
const routeDeviceSetupSelectDevicePage = 'select_device';
const routeDeviceSetupConnectingPage = 'connecting';
const routeDeviceSetupFinishedPage = 'finished';
```

The home and settings screens are referenced with
static names. The setup flow pages, however,
use two paths to create their route names: 
a `/setup/` prefix followed by the name of the specific page.
By combining the two paths, your `Navigator` can determine
that a route name is intended for the setup flow without
recognizing all the individual pages associated with 
the setup flow.

The top-level `Navigator` isn't responsible for identifying
individual setup flow pages. Therefore, your top-level
`Navigator` needs to parse the incoming route name to
identify the setup flow prefix. Needing to parse the route name 
means that you can't use the `routes` property of your top-level
`Navigator`. Instead, you must provide a function for the
`onGenerateRoute` property.

Implement `onGenerateRoute` to return the appropriate widget
for each of the three top-level paths.

<?code-excerpt "lib/main.dart (OnGenerateRoute)"?>
```dart
onGenerateRoute: (settings) {
  final Widget page;
  if (settings.name == routeHome) {
    page = const HomeScreen();
  } else if (settings.name == routeSettings) {
    page = const SettingsScreen();
  } else if (settings.name!.startsWith(routePrefixDeviceSetup)) {
    final subRoute =
        settings.name!.substring(routePrefixDeviceSetup.length);
    page = SetupFlow(
      setupPageRoute: subRoute,
    );
  } else {
    throw Exception('Unknown route: ${settings.name}');
  }

  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
},
```

Notice that the home and settings routes are matched with exact 
route names. However, the setup flow route condition only
checks for a prefix. If the route name contains the setup
flow prefix, then the rest of the route name is ignored
and passed on to the `SetupFlow` widget to process. 
This splitting of the route name is what allows the top-level
`Navigator` to be agnostic toward the various subroutes
within the setup flow.

Create a stateful widget called `SetupFlow` that
accepts a route name.

<?code-excerpt "lib/setupflow.dart (SetupFlow)" replace="/@override\n*.*\n\s*return const SizedBox\(\);\n\s*}/\/\/.../g"?>
```dart
class SetupFlow extends StatefulWidget {
  const SetupFlow({
    super.key,
    required this.setupPageRoute,
  });

  final String setupPageRoute;

  @override
  State<SetupFlow> createState() => SetupFlowState();
}

class SetupFlowState extends State<SetupFlow> {
  //...
}
```

## Display an app bar for the setup flow

The setup flow displays a persistent app bar
that appears across all pages.

Return a `Scaffold` widget from your `SetupFlow`
widget's `build()` method, 
and include the desired `AppBar` widget.

<?code-excerpt "lib/setupflow2.dart (SetupFlow2)"?>
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: _buildFlowAppBar(),
    body: const SizedBox(),
  );
}

PreferredSizeWidget _buildFlowAppBar() {
  return AppBar(
    title: const Text('Bulb Setup'),
  );
}
```

The app bar displays a back arrow and exits the setup
flow when the back arrow is pressed. However,
exiting the flow causes the user to lose all progress. 
Therefore, the user is prompted to confirm whether they
want to exit the setup flow.

Prompt the user to confirm exiting the setup flow,
and ensure that the prompt appears when the user
presses the hardware back button on Android.

<?code-excerpt "lib/prompt_user.dart (PromptUser)"?>
```dart
Future<void> _onExitPressed() async {
  final isConfirmed = await _isExitDesired();

  if (isConfirmed && mounted) {
    _exitSetup();
  }
}

Future<bool> _isExitDesired() async {
  return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                  'If you exit device setup, your progress will be lost.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Leave'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Stay'),
                ),
              ],
            );
          }) ??
      false;
}

void _exitSetup() {
  Navigator.of(context).pop();
}

@override
Widget build(BuildContext context) {
  return PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, _) async {
      if (didPop) return;

      if (await _isExitDesired() && context.mounted) {
        _exitSetup();
      }
    },
    child: Scaffold(
      appBar: _buildFlowAppBar(),
      body: const SizedBox(),
    ),
  );
}

PreferredSizeWidget _buildFlowAppBar() {
  return AppBar(
    leading: IconButton(
      onPressed: _onExitPressed,
      icon: const Icon(Icons.chevron_left),
    ),
    title: const Text('Bulb Setup'),
  );
}
```

When the user taps the back arrow in the app bar,
or presses the back button on Android,
an alert dialog pops up to confirm that the
user wants to leave the setup flow.
If the user presses **Leave**, then the setup flow pops itself 
from the top-level navigation stack.
If the user presses **Stay**, then the action is ignored.

You might notice that the `Navigator.pop()`
is invoked by both the **Leave** and 
**Stay** buttons. To be clear,
this `pop()` action pops the alert dialog off 
the navigation stack, not the setup flow.

## Generate nested routes

The setup flow's job is to display the appropriate
page within the flow.

Add a `Navigator` widget to `SetupFlow`,
and implement the `onGenerateRoute` property.

<?code-excerpt "lib/add_navigator.dart (AddNavigator)"?>
```dart
final _navigatorKey = GlobalKey<NavigatorState>();

void _onDiscoveryComplete() {
  _navigatorKey.currentState!.pushNamed(routeDeviceSetupSelectDevicePage);
}

void _onDeviceSelected(String deviceId) {
  _navigatorKey.currentState!.pushNamed(routeDeviceSetupConnectingPage);
}

void _onConnectionEstablished() {
  _navigatorKey.currentState!.pushNamed(routeDeviceSetupFinishedPage);
}

@override
Widget build(BuildContext context) {
  return PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, _) async {
      if (didPop) return;

      if (await _isExitDesired() && context.mounted) {
        _exitSetup();
      }
    },
    child: Scaffold(
      appBar: _buildFlowAppBar(),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: widget.setupPageRoute,
        onGenerateRoute: _onGenerateRoute,
      ),
    ),
  );
}

Route<Widget> _onGenerateRoute(RouteSettings settings) {
  final page = switch (settings.name) {
    routeDeviceSetupStartPage => WaitingPage(
        message: 'Searching for nearby bulb...',
        onWaitComplete: _onDiscoveryComplete,
      ),
    routeDeviceSetupSelectDevicePage => SelectDevicePage(
        onDeviceSelected: _onDeviceSelected,
      ),
    routeDeviceSetupConnectingPage => WaitingPage(
        message: 'Connecting...',
        onWaitComplete: _onConnectionEstablished,
      ),
    routeDeviceSetupFinishedPage => FinishedPage(
        onFinishPressed: _exitSetup,
      ),
    _ => throw StateError('Unexpected route name: ${settings.name}!')
  };

  return MaterialPageRoute(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}
```

The `_onGenerateRoute` function works the same as
for a top-level `Navigator`. A `RouteSettings`
object is passed into the function,
which includes the route's `name`.
Based on that route name,
one of four flow pages is returned.

The first page, called `find_devices`,
waits a few seconds to simulate network scanning.
After the wait period, the page invokes its callback. 
In this case, that callback is `_onDiscoveryComplete`.
The setup flow recognizes that, when device discovery
is complete, the device selection page should be shown.
Therefore, in `_onDiscoveryComplete`, the `_navigatorKey` 
instructs the nested `Navigator` to navigate to the
`select_device` page.

The `select_device` page asks the user to select a
device from a list of available devices. In this recipe,
only one device is presented to the user. 
When the user taps a device, the `onDeviceSelected`
callback is invoked. The setup flow recognizes that,
when a device is selected, the connecting page 
should be shown. Therefore, in `_onDeviceSelected`,
the `_navigatorKey` instructs the nested `Navigator`
to navigate to the `"connecting"` page.

The `connecting` page works the same way as the
`find_devices` page. The `connecting` page waits
for a few seconds and then invokes its callback. 
In this case, the callback is `_onConnectionEstablished`.
The setup flow recognizes that, when a connection is established,
the final page should be shown. Therefore,
in `_onConnectionEstablished`, the `_navigatorKey` 
instructs the nested `Navigator` to navigate to the
`finished` page.

The `finished` page provides the user with a **Finish**
button. When the user taps **Finish**,
the `_exitSetup` callback is invoked, which pops the entire 
setup flow off the top-level `Navigator` stack,
taking the user back to the home screen.

Congratulations!
You implemented nested navigation with four subroutes.

## Interactive example

Run the app:

* On the **Add your first bulb** screen,
  click the FAB, shown with a plus sign, **+**.
  This brings you to the **Select a nearby device**
  screen. A single bulb is listed.
* Click the listed bulb. A **Finished!** screen appears.
* Click the **Finished** button to return to the
  first screen.

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter nested navigation hands-on example in DartPad" run="true" height="640px"
import 'package:flutter/material.dart';

const routeHome = '/';
const routeSettings = '/settings';
const routePrefixDeviceSetup = '/setup/';
const routeDeviceSetupStart = '/setup/$routeDeviceSetupStartPage';
const routeDeviceSetupStartPage = 'find_devices';
const routeDeviceSetupSelectDevicePage = 'select_device';
const routeDeviceSetupConnectingPage = 'connecting';
const routeDeviceSetupFinishedPage = 'finished';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      ),
      onGenerateRoute: (settings) {
        final Widget page;
        if (settings.name == routeHome) {
          page = const HomeScreen();
        } else if (settings.name == routeSettings) {
          page = const SettingsScreen();
        } else if (settings.name!.startsWith(routePrefixDeviceSetup)) {
          final subRoute =
              settings.name!.substring(routePrefixDeviceSetup.length);
          page = SetupFlow(
            setupPageRoute: subRoute,
          );
        } else {
          throw Exception('Unknown route: ${settings.name}');
        }

        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return page;
          },
          settings: settings,
        );
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

@immutable
class SetupFlow extends StatefulWidget {
  static SetupFlowState of(BuildContext context) {
    return context.findAncestorStateOfType<SetupFlowState>()!;
  }

  const SetupFlow({
    super.key,
    required this.setupPageRoute,
  });

  final String setupPageRoute;

  @override
  SetupFlowState createState() => SetupFlowState();
}

class SetupFlowState extends State<SetupFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  void _onDiscoveryComplete() {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupSelectDevicePage);
  }

  void _onDeviceSelected(String deviceId) {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupConnectingPage);
  }

  void _onConnectionEstablished() {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupFinishedPage);
  }

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();

    if (isConfirmed && mounted) {
      _exitSetup();
    }
  }

  Future<bool> _isExitDesired() async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text(
                    'If you exit device setup, your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Stay'),
                  ),
                ],
              );
            }) ??
        false;
  }

  void _exitSetup() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        if (await _isExitDesired() && context.mounted) {
          _exitSetup();
        }
      },
      child: Scaffold(
        appBar: _buildFlowAppBar(),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.setupPageRoute,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route<Widget> _onGenerateRoute(RouteSettings settings) {
    final page = switch (settings.name) {
      routeDeviceSetupStartPage => WaitingPage(
          message: 'Searching for nearby bulb...',
          onWaitComplete: _onDiscoveryComplete,
        ),
      routeDeviceSetupSelectDevicePage => SelectDevicePage(
          onDeviceSelected: _onDeviceSelected,
        ),
      routeDeviceSetupConnectingPage => WaitingPage(
          message: 'Connecting...',
          onWaitComplete: _onConnectionEstablished,
        ),
      routeDeviceSetupFinishedPage => FinishedPage(
          onFinishPressed: _exitSetup,
        ),
      _ => throw StateError('Unexpected route name: ${settings.name}!')
    };

    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: _onExitPressed,
        icon: const Icon(Icons.chevron_left),
      ),
      title: const Text('Bulb Setup'),
    );
  }
}

class SelectDevicePage extends StatelessWidget {
  const SelectDevicePage({
    super.key,
    required this.onDeviceSelected,
  });

  final void Function(String deviceId) onDeviceSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select a nearby device:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateColor.resolveWith((states) {
                      return const Color(0xFF222222);
                    }),
                  ),
                  onPressed: () {
                    onDeviceSelected('22n483nk5834');
                  },
                  child: const Text(
                    'Bulb 22n483nk5834',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaitingPage extends StatefulWidget {
  const WaitingPage({
    super.key,
    required this.message,
    required this.onWaitComplete,
  });

  final String message;
  final VoidCallback onWaitComplete;

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
    _startWaiting();
  }

  Future<void> _startWaiting() async {
    await Future<dynamic>.delayed(const Duration(seconds: 3));

    if (mounted) {
      widget.onWaitComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 32),
              Text(widget.message),
            ],
          ),
        ),
      ),
    );
  }
}

class FinishedPage extends StatelessWidget {
  const FinishedPage({
    super.key,
    required this.onFinishPressed,
  });

  final VoidCallback onFinishPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF222222),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.lightbulb,
                      size: 140,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Bulb added!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.resolveWith((states) {
                      return const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12);
                    }),
                    backgroundColor: WidgetStateColor.resolveWith((states) {
                      return const Color(0xFF222222);
                    }),
                    shape: WidgetStateProperty.resolveWith((states) {
                      return const StadiumBorder();
                    }),
                  ),
                  onPressed: onFinishPressed,
                  child: const Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF222222),
                ),
                child: Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 140,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Add your first bulb',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(routeDeviceSetupStart);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Welcome'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, routeSettings);
          },
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(8, (index) {
            return Container(
              width: double.infinity,
              height: 54,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF222222),
              ),
            );
          }),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Settings'),
    );
  }
}
```
