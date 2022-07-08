import 'package:flutter/material.dart';

void main() => runApp(
      const MyStatelessWidget(
        text: 'StatelessWidget Example to show immutable data',
      ),
    );

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

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
