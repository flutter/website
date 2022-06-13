import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// #docregion TypingIndicator
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    super.key,
    this.showIndicator = false,
    this.bubbleColor = const Color(0xFF646b7f),
    this.flashingCircleDarkColor = const Color(0xFF333333),
    this.flashingCircleBrightColor = const Color(0xFFaec1dd),
  });

  final bool showIndicator;
  final Color bubbleColor;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> {
  @override
  Widget build(BuildContext context) {
    // TODO:
    return const SizedBox();
  }
}
// #enddocregion TypingIndicator
