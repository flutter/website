import 'package:flutter/material.dart';

// #docregion CustomButton
class CustomButton extends StatelessWidget {
  final String label;

  CustomButton(this.label);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}
// #enddocregion CustomButton

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  // #docregion UseCustomButton
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton("Hello"),
    );
  }
  // #enddocregion UseCustomButton
}
