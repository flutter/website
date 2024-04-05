import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ScreenType { handset, tablet, desktop, watch }

// #docregion FormFactor
class FormFactor {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;
}
// #enddocregion FormFactor

// #docregion getFormFactor
ScreenType getFormFactor(BuildContext context) {
  // Use .shortestSide to detect device type regardless of orientation
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > FormFactor.desktop) return ScreenType.desktop;
  if (deviceWidth > FormFactor.tablet) return ScreenType.tablet;
  if (deviceWidth > FormFactor.handset) return ScreenType.handset;
  return ScreenType.watch;
}
// #enddocregion getFormFactor

// #docregion ScreenSize
enum ScreenSize { small, normal, large, extraLarge }

ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 900) return ScreenSize.extraLarge;
  if (deviceWidth > 600) return ScreenSize.large;
  if (deviceWidth > 300) return ScreenSize.normal;
  return ScreenSize.small;
}
// #enddocregion ScreenSize

class WidgetWithBreakPoints extends StatelessWidget {
  const WidgetWithBreakPoints({super.key});

  List<Widget> _getHandsetChildren() {
    return ([
      const Text('Handset Child 1'),
      const Text('Handset Child 2'),
      const Text('Handset Child 3'),
    ]);
  }

  List<Widget> _getNormalChildren() {
    return ([
      const Text('Normal Child 1'),
      const Text('Normal Child 2'),
      const Text('Normal Child 3'),
    ]);
  }

  Widget widgetSwap(BuildContext context) {
    bool isHandset = MediaQuery.of(context).size.width < 600;

    // #docregion WidgetSwap
    Widget foo = Row(
      children: [
        ...isHandset ? _getHandsetChildren() : _getNormalChildren(),
      ],
    );
    // #enddocregion WidgetSwap

    return foo;
  }

  @override
  Widget build(BuildContext context) {
    // #docregion MediaQuery
    bool isHandset = MediaQuery.of(context).size.width < 600;
    return Flex(
      direction: isHandset ? Axis.vertical : Axis.horizontal,
      children: const [Text('Foo'), Text('Bar'), Text('Baz')],
    );
    // #enddocregion MediaQuery
  }
}
