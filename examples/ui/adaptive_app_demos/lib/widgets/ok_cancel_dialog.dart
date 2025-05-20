import 'package:flutter/material.dart';

import '../global/device_type.dart';

class OkCancelDialog extends StatelessWidget {
  const OkCancelDialog({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(Insets.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              const SizedBox(height: Insets.large),
              _OkCancelButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OkCancelButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // #docregion row-text-direction
    TextDirection btnDirection = DeviceType.isWindows
        ? TextDirection.rtl
        : TextDirection.ltr;
    return Row(
      children: [
        const Spacer(),
        Row(
          textDirection: btnDirection,
          children: [
            DialogButton(
              label: 'Cancel',
              onPressed: () => Navigator.pop(context, false),
            ),
            DialogButton(
              label: 'Ok',
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      ],
    );
    // #enddocregion row-text-direction
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton({super.key, required this.onPressed, required this.label});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(label),
      ),
    );
  }
}
