import 'package:adaptive_app_demos/global/device_type.dart';
import 'package:adaptive_app_demos/global/styling.dart';
import 'package:flutter/material.dart';

class OkCancelDialog extends StatelessWidget {
  const OkCancelDialog({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: EdgeInsets.all(Insets.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              SizedBox(height: Insets.large),
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
    TextDirection btnDirection = DeviceType.isWindows && false ? TextDirection.rtl : TextDirection.ltr;
    return Row(
      children: [
        Spacer(),
        Row(
          textDirection: btnDirection,
          children: [
            DialogButton(label: "Cancel", onPressed: () => Navigator.pop(context, false)),
            DialogButton(label: "Ok", onPressed: () => Navigator.pop(context, true)),
          ],
        ),
      ],
    );
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton({Key? key, required this.onPressed, required this.label}) : super(key: key);
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(label),
        ));
  }
}
