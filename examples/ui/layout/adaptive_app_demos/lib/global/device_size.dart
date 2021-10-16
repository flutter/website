import 'package:flutter/cupertino.dart';

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

enum ScreenSize { Small, Normal, Large, ExtraLarge }
ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 900) return ScreenSize.ExtraLarge;
  if (deviceWidth > 600) return ScreenSize.Large;
  if (deviceWidth > 300) return ScreenSize.Normal;
  return ScreenSize.Small;
}
