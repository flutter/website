import 'package:flutter/material.dart';

// #docregion custom-button
class CustomButton extends StatelessWidget {
  const CustomButton(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(label));
  }
}
// #enddocregion custom-button

class UseCustomButton extends StatelessWidget {
  const UseCustomButton({super.key});

  // #docregion use-custom-button
  @override
  Widget build(BuildContext context) {
    return const Center(child: CustomButton('Hello'));
  }

  // #enddocregion use-custom-button
}
