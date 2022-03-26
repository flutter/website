// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

// #docregion delays
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

// #enddocregion delays

  static const _menuTitles = [
    'Declarative Style',
    'Premade Widgets',
    'Stateful Hot Reload',
    'Native Performance',
    'Great Community',
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
