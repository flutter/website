import 'dart:io' show Platform;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget layoutBuilderWidget() {
  // #docregion layout-builder
  Widget foo = LayoutBuilder(
    builder: (context, constraints) {
      bool useVerticalLayout = constraints.maxWidth < 400;
      return Flex(
        direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
        children: const [Text('Hello'), Text('World')],
      );
    },
  );
  // #enddocregion layout-builder

  return foo;
}

class ScrollListen extends StatelessWidget {
  const ScrollListen({super.key});

  Widget scrollListener(BuildContext context) {
    // #docregion pointer-scroll
    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) print(event.scrollDelta.dy);
      },
      child: ListView(),
    );
    // #enddocregion pointer-scroll
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

// #docregion shortcuts
// Define a class for each type of shortcut action you want
class CreateNewItemIntent extends Intent {
  const CreateNewItemIntent();
}

Widget build(BuildContext context) {
  return Shortcuts(
    // Bind intents to key combinations
    shortcuts: const <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.keyN, control: true):
          CreateNewItemIntent(),
    },
    child: Actions(
      // Bind intents to an actual method in your code
      actions: <Type, Action<Intent>>{
        CreateNewItemIntent: CallbackAction<CreateNewItemIntent>(
          onInvoke: (intent) => _createNewItem(),
        ),
      },
      // Your sub-tree must be wrapped in a focusNode, so it can take focus.
      child: Focus(autofocus: true, child: Container()),
    ),
  );
}
// #enddocregion shortcuts

void _createNewItem() {
  // ignore: unnecessary_statements
  DoNothingAction;
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key, required this.title});

  final String title;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // #docregion multi-select-shift
  static bool get isSpanSelectModifierDown =>
      isKeyDown({LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.shiftRight});
  // #enddocregion multi-select-shift

  // #docregion multi-select-modifier-down
  static bool get isMultiSelectModifierDown {
    bool isDown = false;
    if (Platform.isMacOS) {
      isDown = isKeyDown({
        LogicalKeyboardKey.metaLeft,
        LogicalKeyboardKey.metaRight,
      });
    } else {
      isDown = isKeyDown({
        LogicalKeyboardKey.controlLeft,
        LogicalKeyboardKey.controlRight,
      });
    }
    return isDown;
  }
  // #enddocregion multi-select-modifier-down

  // #docregion handle-key
  bool _handleKey(KeyEvent event) {
    bool isShiftDown = isKeyDown({
      LogicalKeyboardKey.shiftLeft,
      LogicalKeyboardKey.shiftRight,
    });

    if (isShiftDown && event.logicalKey == LogicalKeyboardKey.keyN) {
      _createNewItem();
      return true;
    }

    return false;
  }
  // #enddocregion handle-key

  // #docregion keys-pressed
  static bool isKeyDown(Set<LogicalKeyboardKey> keys) {
    return keys
        .intersection(HardwareKeyboard.instance.logicalKeysPressed)
        .isNotEmpty;
  }
  // #enddocregion keys-pressed

  // #docregion hardware-keyboard
  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKey);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKey);
    super.dispose();
  }
  // #enddocregion hardware-keyboard

  @override
  Widget build(BuildContext context) {
    isSpanSelectModifierDown;
    isMultiSelectModifierDown;

    return const Text('Hello World!');
  }
}

Widget selectableTextWidget() {
  // #docregion selectable-text
  return const SelectableText('Select me!');
  // #enddocregion selectable-text
}

Widget richTextSpan() {
  // #docregion rich-text-span
  return const SelectableText.rich(
    TextSpan(
      children: [
        TextSpan(text: 'Hello'),
        TextSpan(
          text: 'Bold',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
  // #enddocregion rich-text-span
}

Widget tooltipWidget() {
  // #docregion tooltip
  return const Tooltip(
    message: 'I am a Tooltip',
    child: Text('Hover over the text to show a tooltip.'),
  );
  // #enddocregion tooltip
}
