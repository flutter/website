import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ScreenType { Handset, Tablet, Desktop, Watch }

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
  if (deviceWidth > FormFactor.desktop) return ScreenType.Desktop;
  if (deviceWidth > FormFactor.tablet) return ScreenType.Tablet;
  if (deviceWidth > FormFactor.handset) return ScreenType.Handset;
  return ScreenType.Watch;
}
// #enddocregion getFormFactor

// #docregion ScreenSize
enum ScreenSize { Small, Normal, Large, ExtraLarge }

ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 900) return ScreenSize.ExtraLarge;
  if (deviceWidth > 600) return ScreenSize.Large;
  if (deviceWidth > 300) return ScreenSize.Normal;
  return ScreenSize.Small;
}
// #enddocregion ScreenSize

class widgetWithBreakPoints extends StatelessWidget {
  List<Widget> _getHandsetChildren() {
    return ([
      Text('Handset Child 1'),
      Text('Handset Child 2'),
      Text('Handset Child 3'),
    ]);
  }

  List<Widget> _getNormalChildren() {
    return ([
      Text('Normal Child 1'),
      Text('Normal Child 2'),
      Text('Normal Child 3'),
    ]);
  }

  Widget WidgetSwap(BuildContext context) {
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
        children: [Text('Foo'), Text('Bar'), Text('Baz')],
        direction: isHandset ? Axis.vertical : Axis.horizontal);
    // #enddocregion MediaQuery
  }
}
