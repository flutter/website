import 'package:material_ui/material.dart';

class SomeWidget extends StatelessWidget {
  const SomeWidget(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
