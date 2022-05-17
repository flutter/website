import 'package:flutter/material.dart';

import '../global/device_type.dart';

class StyledTextButton extends StatelessWidget {
  const StyledTextButton(
      {super.key, required this.onPressed, required this.child});
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(Insets.small)),
            textStyle: MaterialStateProperty.all(TextStyles.buttonText2)),
        onPressed: onPressed,
        child: child);
  }
}

class SecondaryMenuButton extends StatelessWidget {
  const SecondaryMenuButton({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return StyledTextButton(
      onPressed: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Text(label),
      ),
    );
  }
}

class SelectedPageButton extends StatelessWidget {
  const SelectedPageButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.isSelected});
  final VoidCallback? onPressed;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? Colors.grey.shade200 : null,
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(Insets.large),
          child: Text(label, style: TextStyles.buttonText1, maxLines: 1),
        ),
      ),
    );
  }
}
