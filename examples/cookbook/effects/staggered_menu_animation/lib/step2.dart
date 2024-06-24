import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

// #docregion animation-controller
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
  // #enddocregion animation-controller

  @override
  Widget build(BuildContext context) {
    return Container();
  }
  // #docregion animation-controller
}
// #enddocregion animation-controller
