---
title: Create a staggered menu animation
description: How to implement a staggered menu animation.
prev:
  title: Create a shimmer loading effect
  path:  /docs/cookbook/effects/shimmer-loading
next:
  title: Create a typing indicator
  path:  /docs/cookbook/effects/typing-indicator
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

A single app screen might contain multiple animations.
Playing all of the animations at the same time can be
overwhelming. Playing the animations one after the other
can take too long. A better option is to stagger the animations. 
Each animation begins at a different time,
but the animations overlap to create a shorter duration.
In this recipe, you build a drawer menu with animated 
content that is staggered and has a button that pops
in at the bottom.

The following animation shows the app's behavior:

![Staggered Menu Animation Example]({% asset cookbook/effects/StaggeredMenuAnimation.gif @path %}){:.site-mobile-screenshot}

## Create the menu without animations

The drawer menu displays a list of titles,
followed by a Get started button at 
the bottom of the menu.

Define a stateful widget called `Menu`
that displays the list and button 
in static locations.

<!--skip-->
```dart
class Menu extends StatefulWidget {
 @override
 _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
 static const _menuTitles = [
   'Declarative Style',
   'Premade Widgets',
   'Stateful Hot Reload',
   'Native Performance',
   'Great Community',
 ];

 @override
 Widget build(BuildContext context) {
   return Container(
     color: Colors.white,
     child: Stack(
       fit: StackFit.expand,
       children: [
         _buildFlutterLogo(),
         _buildContent(),
       ],
     ),
   );
 }

 Widget _buildFlutterLogo() {...}

 Widget _buildContent() {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       const SizedBox(height: 16),
       ..._buildListItems(),
       const Spacer(),
       _buildGetStartedButton(),
     ],
   );
 }

 List<Widget> _buildListItems() {
   final listItems = <Widget>[];
   for (var i = 0; i < _menuTitles.length; ++i) {
     listItems.add(
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
         child: Text(
           _menuTitles[i],
           textAlign: TextAlign.left,
           style: const TextStyle(
             fontSize: 24,
             fontWeight: FontWeight.w500,
           ),
         ),
       ),
     );
   }
   return listItems;
 }

 Widget _buildGetStartedButton() {
   return SizedBox(
     width: double.infinity,
     child: Padding(
       padding: const EdgeInsets.all(24.0),
       child: RaisedButton(
         shape: const StadiumBorder(),
         color: Colors.blue,
         padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
         onPressed: () {},
         child: const Text(
           'Get Started',
           style: TextStyle(
             color: Colors.white,
             fontSize: 22,
           ),
         ),
       ),
     ),
   );
 }
}
```

## Prepare for animations

Control of the animation timing requires an
`AnimationController`.

Add the `SingleTickerProviderStateMixin`
to the `MenuState` class. Then, declare and
instantiate an `AnimationController`.

<!--skip-->
```dart
class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {

 late AnimationController _staggeredController;

 @override
 void initState() {
   super.initState();

   _staggeredController = AnimationController(
     vsync: this,
   );
 }

 @override
 void dispose() {
   _staggeredController.dispose();
   super.dispose();
 }
}
```

The length of the delay before every animation is
up to you. Define the animation delays,
individual animation durations, and the total 
animation duration.

<!--skip-->
```dart
class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
 static const _initialDelayTime = Duration(milliseconds: 50);
 static const _itemSlideTime = Duration(milliseconds: 250);
 static const _staggerTime = Duration(milliseconds: 50);
 static const _buttonDelayTime = Duration(milliseconds: 150);
 static const _buttonTime = Duration(milliseconds: 500);
 final _animationDuration = _initialDelayTime +
     (_staggerTime * _menuTitles.length) +
     _buttonDelayTime +
     _buttonTime;
}
```

In this case, all the animations are delayed by 50 ms.
After that, list items begin to appear.
Each list item’s appearance is delayed by 50 ms after the 
previous list item begins to slide in.
Each list item takes 250 ms to slide from right to left.
After the last list item begins to slide in,
the button at the bottom waits another 150 ms to pop in.
The button animation takes 500 ms.

With each delay and animation duration defined,
the total duration is calculated so that it can be
used to calculate the individual animation times.

The desired animation times are shown in the following diagram:

![Animation Timing Diagram]({% asset cookbook/effects/TimingDiagram.png @path %}){:.site-mobile-screenshot}

To animate a value during a subsection of a larger animation,
Flutter provides the `Interval` class.
An `Interval` takes a start time percentage and an end 
time percentage. That `Interval` can then be used to
animate a value between those start and end times,
instead of using the entire animation’s start and 
end times. For example, given an animation that takes 1 second, 
an interval from 0.2 to 0.5 would start at 200 ms
(20%) and end at 500 ms (50%). 

Declare and calculate each list item’s `Interval` and the 
bottom button `Interval`.

<!--skip-->
```dart
class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
 final List<Interval> _itemSlideIntervals = [];
 late Interval _buttonInterval;

 @override
 void initState() {
   super.initState();

   _createAnimationIntervals();

   _staggeredController = AnimationController(
     vsync: this,
     duration: _animationDuration,
   );
 }

 void _createAnimationIntervals() {
   for (var i = 0; i < _menuTitles.length; ++i) {
     final startTime = _initialDelayTime + (_staggerTime * i);
     final endTime = startTime + _itemSlideTime;
     _itemSlideIntervals.add(
       Interval(
         startTime.inMilliseconds / _animationDuration.inMilliseconds,
         endTime.inMilliseconds / _animationDuration.inMilliseconds,
       ),
     );
   }

   final buttonStartTime =
       Duration(milliseconds: (_menuTitles.length * 50)) + _buttonDelayTime;
   final buttonEndTime = buttonStartTime + _buttonTime;
   _buttonInterval = Interval(
     buttonStartTime.inMilliseconds / _animationDuration.inMilliseconds,
     buttonEndTime.inMilliseconds / _animationDuration.inMilliseconds,
   );
 }
}
```

## Animate the list items and button

The staggered animation plays as soon as the menu becomes visible.

Start the animation in `initState()`.

<!--skip-->
```dart
@override
void initState() {
  super.initState();

  _createAnimationIntervals();

  _staggeredController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  )..forward();
}
```

Each list item slides from right to left and
fades in at the same time.

Use the list item’s `Interval` and an `easeOut`
curve to animate the opacity and translation
values for each list item.

<!--skip-->
```dart
List<Widget> _buildListItems() {
 final listItems = <Widget>[];
 for (var i = 0; i < _menuTitles.length; ++i) {
   listItems.add(
     AnimatedBuilder(
       animation: _staggeredController,
       builder: (context, child) {
         final animationPercent = Curves.easeOut.transform(
           _itemSlideIntervals[i].transform(_staggeredController.value),
         );
         final opacity = animationPercent;
         final slideDistance = (1.0 - animationPercent) * 150;

         return Opacity(
           opacity: opacity,
           child: Transform.translate(
             offset: Offset(slideDistance, 0),
             child: child,
           ),
         );
       },
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
         child: Text(
           _menuTitles[i],
           textAlign: TextAlign.left,
           style: const TextStyle(
             fontSize: 24,
             fontWeight: FontWeight.w500,
           ),
         ),
       ),
     ),
   );
 }
 return listItems;
}
```

Use the same approach to animate the opacity and
scale of the bottom button. This time, use an
`elasticOut` curve to give the button a springy effect.

<!--skip-->
```dart
Widget _buildGetStartedButton() {
 return SizedBox(
   width: double.infinity,
   child: Padding(
     padding: const EdgeInsets.all(24.0),
     child: AnimatedBuilder(
       animation: _staggeredController,
       builder: (context, child) {
         final animationPercent = Curves.elasticOut.transform(
             _buttonInterval.transform(_staggeredController.value));
         final opacity = animationPercent.clamp(0.0, 1.0);
         final scale = (animationPercent * 0.5) + 0.5;

         return Opacity(
           opacity: opacity,
           child: Transform.scale(
             scale: scale,
             child: child,
           ),
         );
       },
       child: RaisedButton(
         shape: const StadiumBorder(),
         color: Colors.blue,
         padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
         onPressed: () {},
         child: const Text(
           'Get Started',
           style: TextStyle(
             color: Colors.white,
             fontSize: 22,
           ),
         ),
       ),
     ),
   ),
 );
}
```

Congratulations!
You have an animated menu where the appearance of each 
list item is staggered, followed by a bottom button that
pops into place.

## Interactive example

<!--skip-->
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: const ExampleStaggeredAnimations(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class ExampleStaggeredAnimations extends StatefulWidget {
  const ExampleStaggeredAnimations({
    Key? key,
  }) : super(key: key);

  @override
  _ExampleStaggeredAnimationsState createState() =>
      _ExampleStaggeredAnimationsState();
}

class _ExampleStaggeredAnimationsState extends State<ExampleStaggeredAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController _drawerSlideController;

  @override
  void initState() {
    super.initState();

    _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _drawerSlideController.dispose();
    super.dispose();
  }

  bool _isDrawerOpen() {
    return _drawerSlideController.value == 1.0;
  }

  bool _isDrawerOpening() {
    return _drawerSlideController.status == AnimationStatus.forward;
  }

  bool _isDrawerClosed() {
    return _drawerSlideController.value == 0.0;
  }

  void _toggleDrawer() {
    if (_isDrawerOpen() || _isDrawerOpening()) {
      _drawerSlideController.reverse();
    } else {
      _drawerSlideController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildContent(),
          _buildDrawer(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Flutter Menu',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: [
        AnimatedBuilder(
          animation: _drawerSlideController,
          builder: (context, child) {
            return IconButton(
              onPressed: _toggleDrawer,
              icon: _isDrawerOpen() || _isDrawerOpening()
                  ? const Icon(
                      Icons.clear,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildContent() {
    // Put page content here.
    return const SizedBox();
  }

  Widget _buildDrawer() {
    return AnimatedBuilder(
      animation: _drawerSlideController,
      builder: (context, child) {
        return FractionalTranslation(
          translation: Offset(1.0 - _drawerSlideController.value, 0.0),
          child: _isDrawerClosed() ? const SizedBox() : Menu(),
        );
      },
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  static const _menuTitles = [
    'Declarative style',
    'Premade widgets',
    'Stateful hot reload',
    'Native performance',
    'Great community',
  ];

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration = _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
      _buttonDelayTime +
      _buttonTime;

  late AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];
  late Interval _buttonInterval;

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuTitles.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }

    final buttonStartTime =
        Duration(milliseconds: (_menuTitles.length * 50)) + _buttonDelayTime;
    final buttonEndTime = buttonStartTime + _buttonTime;
    _buttonInterval = Interval(
      buttonStartTime.inMilliseconds / _animationDuration.inMilliseconds,
      buttonEndTime.inMilliseconds / _animationDuration.inMilliseconds,
    );
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildFlutterLogo(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildFlutterLogo() {
    return const Positioned(
      right: -100,
      bottom: -30,
      child: Opacity(
        opacity: 0.2,
        child: FlutterLogo(
          size: 400,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ..._buildListItems(),
        const Spacer(),
        _buildGetStartedButton(),
      ],
    );
  }

  List<Widget> _buildListItems() {
    final listItems = <Widget>[];
    for (var i = 0; i < _menuTitles.length; ++i) {
      listItems.add(
        AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            final animationPercent = Curves.easeOut.transform(
              _itemSlideIntervals[i].transform(_staggeredController.value),
            );
            final opacity = animationPercent;
            final slideDistance = (1.0 - animationPercent) * 150;

            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(slideDistance, 0),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
            child: Text(
              _menuTitles[i],
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
    return listItems;
  }

  Widget _buildGetStartedButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            final animationPercent = Curves.elasticOut.transform(
                _buttonInterval.transform(_staggeredController.value));
            final opacity = animationPercent.clamp(0.0, 1.0);
            final scale = (animationPercent * 0.5) + 0.5;

            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: child,
              ),
            );
          },
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              primary: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
            ),
            onPressed: () {},
            child: const Text(
              'Get started',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```
