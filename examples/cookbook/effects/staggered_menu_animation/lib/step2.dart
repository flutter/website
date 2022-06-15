import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

// #docregion AnimationController
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

// #enddocregion AnimationController

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
