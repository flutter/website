import 'package:flutter/material.dart';

void main() => runApp(
      const MyStatelessWidget(
        text: 'StatelessWidget Example to show immutable data',
      ),
    );

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
