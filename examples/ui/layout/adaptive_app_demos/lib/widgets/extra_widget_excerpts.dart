import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

Widget LayoutBuilderWidget() {
  // #docregion LayoutBuilder
  Widget foo = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
    bool useVerticalLayout = constraints.maxWidth < 400.0;
    return Flex(
      children: [
        Text("Hello"),
        Text("World"),
      ],
      direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
    );
  });
  // #enddocregion LayoutBuilder

  return foo;
}

class ScrollListen extends StatelessWidget {
  Widget scrollListener(BuildContext) {
    // #docregion PointerScroll
    return Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) print(event.scrollDelta.dy);
        },
        child: ListView());
    // #enddocregion PointerScroll
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

// #docregion Shortcuts
// Define a class for each type of shortcut action you want
class CreateNewItemIntent extends Intent {
  const CreateNewItemIntent();
}

Widget build(BuildContext context) {
  return Shortcuts(
    // Bind intents to key combinations
    shortcuts: <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.keyN, control: true):
          CreateNewItemIntent(),
    },
    child: Actions(
      // Bind intents to an actual method in your code
      actions: <Type, Action<Intent>>{
        CreateNewItemIntent: CallbackAction<CreateNewItemIntent>(
            onInvoke: (CreateNewItemIntent intent) => _createNewItem()),
      },
      // Your sub-tree must be wrapped in a focusNode, so it can take focus.
      child: Focus(
        autofocus: true,
        child: Container(),
      ),
    ),
  );
}
// #enddocregion Shortcuts

void _createNewItem() {
  DoNothingAction;
}

class MyWidget extends StatefulWidget {
  MyWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // #docregion MultiSelectShift
  static bool get isSpanSelectModifierDown =>
      isKeyDown({LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.shiftRight});
  // #enddocregion MultiSelectShift

  // #docregion MultiSelectModifierDown
  static bool get isMultiSelectModifierDown {
    bool isDown = false;
    if (Platform.isMacOS) {
      isDown = isKeyDown(
          {LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.metaRight});
    } else {
      isDown = isKeyDown(
          {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.controlRight});
    }
    return isDown;
  }
  // #enddocregion MultiSelectModifierDown

  // #docregion HandleKey
  void _handleKey(event) {
    if (event is RawKeyDownEvent) {
      bool isShiftDown = isKeyDown({
        LogicalKeyboardKey.shiftLeft,
        LogicalKeyboardKey.shiftRight,
      });
      if (isShiftDown && event.logicalKey == LogicalKeyboardKey.keyN) {
        _createNewItem();
      }
    }
  }
  // #enddocregion HandleKey

  // #docregion KeysPressed
  static bool isKeyDown(Set<LogicalKeyboardKey> keys) {
    return keys.intersection(RawKeyboard.instance.keysPressed).isNotEmpty;
  }
  // #enddocregion KeysPressed

  // #docregion RawKeyboard
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_handleKey);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKey);
    super.dispose();
  }
  // #enddocregion RawKeyboard

  @override
  Widget build(BuildContext context) {
    isSpanSelectModifierDown;
    isMultiSelectModifierDown;

    return Text("Hello World!");
  }
}

Widget SelectableTextWidget() {
  // #docregion SelectableText
  return SelectableText('Select me!');
  // #enddocregion SelectableText
}

Widget RichTextSpan() {
  // #docregion RichTextSpan
  return SelectableText.rich(
    TextSpan(
      children: [
        TextSpan(text: 'Hello'),
        TextSpan(text: 'Bold', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
  // #enddocregion RichTextSpan
}

Widget TooltipWidget() {
  // #docregion Tooltip
  return const Tooltip(
    message: 'I am a Tooltip',
    child: Text('Hover over the text to show a tooltip.'),
  );
  // #enddocregion Tooltip
}
