import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global/device_type.dart';

class FocusExamplesPage extends StatelessWidget {
  const FocusExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.extraLarge),
      child: Center(
        child: SeparatedColumn(
          separatorBuilder: () => const SizedBox(height: 5),
          mainAxisSize: MainAxisSize.min,
          children: [
            // Basic widget that can accept traversal, built with FocusableActionDetector
            const Text('BasicActionDetector:'),
            const BasicActionDetector(),
            const SizedBox(height: 10),

            // Clickable widget that can accept traversal, built with FocusableActionDetector
            const Text('AdvancedActionDetector:'),
            const ClickableActionDetector(),
            const SizedBox(height: 10),

            // A totally custom control, built by stacking together various widgets
            const Text('CustomControl:'),
            const ClickableControl(),
            _TextListener(),
          ],
        ),
      ),
    );
  }
}

class _TextListener extends StatefulWidget {
  @override
  State<_TextListener> createState() => __TextListenerState();
}

class __TextListenerState extends State<_TextListener> {
  FocusNode focusNode = FocusNode();

  // #docregion focus-keyboard-listener
  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          print(event.logicalKey);
        }
        return KeyEventResult.ignored;
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: const TextField(
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ),
    );
  }
}
// #enddocregion focus-keyboard-listener

class BasicActionDetector extends StatefulWidget {
  const BasicActionDetector({super.key});

  @override
  State<BasicActionDetector> createState() => _BasicActionDetectorState();
}

// #docregion focusable-action-detector
class _BasicActionDetectorState extends State<BasicActionDetector> {
  bool _hasFocus = false;
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onFocusChange: (value) => setState(() => _hasFocus = value),
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<Intent>(
          onInvoke: (intent) {
            print('Enter or Space was pressed!');
            return null;
          },
        ),
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const FlutterLogo(size: 100),
          // Position focus in the negative margin for a cool effect
          if (_hasFocus)
            Positioned(
              left: -4,
              top: -4,
              bottom: -4,
              right: -4,
              child: _roundedBorder(),
            ),
        ],
      ),
    );
  }
}
// #enddocregion focusable-action-detector

/// Uses [FocusableActionDetector]
class ClickableActionDetector extends StatefulWidget {
  const ClickableActionDetector({super.key});

  @override
  State<ClickableActionDetector> createState() =>
      _ClickableActionDetectorState();
}

class _ClickableActionDetectorState extends State<ClickableActionDetector> {
  bool _hasFocus = false;
  late final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      focusNode: _focusNode,
      mouseCursor: SystemMouseCursors.click,
      onFocusChange: (value) => setState(() => _hasFocus = value),
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<Intent>(
          onInvoke: (intent) {
            _submit();
            return null;
          },
        ),
      },
      child: GestureDetector(
        onTap: () {
          _focusNode.requestFocus();
          _submit();
        },
        child: Logo(showBorder: _hasFocus),
      ),
    );
  }

  void _submit() => print('Submit!');
}

// Example of a custom focus widget from scratch
class ClickableControl extends StatelessWidget {
  const ClickableControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Focus(
      // Process keyboard event
      onKeyEvent: _handleKeyDown,
      child: Builder(
        builder: (context) {
          // Check whether we have focus
          bool hasFocus = Focus.of(context).hasFocus;
          // #docregion mouse-region
          // Show hand cursor
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            // Request focus when clicked
            child: GestureDetector(
              onTap: () {
                Focus.of(context).requestFocus();
                _submit();
              },
              child: Logo(showBorder: hasFocus),
            ),
          );
          // #enddocregion mouse-region
        },
      ),
    );
  }

  void _submit() => print('Submit!');

  KeyEventResult _handleKeyDown(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        {
          LogicalKeyboardKey.enter,
          LogicalKeyboardKey.space,
        }.contains(event.logicalKey)) {
      _submit();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key, required this.showBorder});
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Content
        const FlutterLogo(size: 100),
        // Focus effect:
        if (showBorder)
          Positioned(
            left: 0,
            top: -4,
            bottom: -4,
            right: -4,
            child: _roundedBorder(),
          ),
      ],
    );
  }
}

Widget _roundedBorder() => Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.orange),
    borderRadius: BorderRadius.circular(6),
  ),
);

class MyFocusTraversalWidget extends StatelessWidget {
  const MyFocusTraversalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion focus-traversal-group
    return Column(
      children: [
        FocusTraversalGroup(child: MyFormWithMultipleColumnsAndRows()),
        SubmitButton(),
      ],
    );
    // #enddocregion focus-traversal-group
  }
}

class MyFormWithMultipleColumnsAndRows extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyFormWithMultipleColumnsAndRows({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(child: Container());
  }
}

class SubmitButton extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {DoNothingAction /* Submit */},
      child: const Text('Submit'),
    );
  }
}

class MyHoverWidget extends StatefulWidget {
  const MyHoverWidget({super.key, required this.title});

  final String title;

  @override
  State<MyHoverWidget> createState() => _MyHoverWidgetState();
}

class _MyHoverWidgetState extends State<MyHoverWidget> {
  bool _isMouseOver = false;

  @override
  Widget build(BuildContext context) {
    // #docregion mouse-over
    return MouseRegion(
      onEnter: (_) => setState(() => _isMouseOver = true),
      onExit: (_) => setState(() => _isMouseOver = false),
      onHover: (e) => print(e.localPosition),
      child: Container(
        height: 500,
        color: _isMouseOver ? Colors.blue : Colors.black,
      ),
    );
    // #enddocregion mouse-over
  }
}
