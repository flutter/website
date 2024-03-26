---
title: Input for adaptive apps
description: >
  xxx
---

## Handling input

It isn't enough to just adapt how your app looks,
you also have to support varying user inputs.
The mouse and keyboard introduce input types beyond those
found on a touch device—like scroll wheel, right-click,
hover interactions, tab traversal, and keyboard shortcuts.

### Scroll wheel

Scrolling widgets like `ScrollView` or `ListView`
support the scroll wheel by default, and because
almost every scrollable custom widget is built
using one of these, it works with those as well.

If you need to implement custom scroll behavior,
you can use the [`Listener`][] widget, which lets you
customize how your UI reacts to the scroll wheel.

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (PointerScroll)"?>
```dart
return Listener(
  onPointerSignal: (event) {
    if (event is PointerScrollEvent) print(event.scrollDelta.dy);
  },
  child: ListView(),
);
```

[`Listener`]: {{site.api}}/flutter/widgets/Listener-class.html

### Tab traversal and focus interactions

Users with physical keyboards expect that they can use
the tab key to quickly navigate your application,
and users with motor or vision differences often rely
completely on keyboard navigation.

There are two considerations for tab interactions:
how focus moves from widget to widget, known as traversal,
and the visual highlight shown when a widget is focused.

Most built-in components, like buttons and text fields,
support traversal and highlights by default.
If you have your own widget that you want included in
traversal, you can use the [`FocusableActionDetector`][] widget
to create your own controls. It combines the functionality
of [`Actions`][], [`Shortcuts`][], [`MouseRegion`][], and
[`Focus`][] widgets to create a detector that defines actions
and key bindings, and provides callbacks for handling focus
and hover highlights.

<?code-excerpt "lib/pages/focus_examples_page.dart (_BasicActionDetectorState)"?>
```dart
class _BasicActionDetectorState extends State<BasicActionDetector> {
  bool _hasFocus = false;
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onFocusChange: (value) => setState(() => _hasFocus = value),
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<Intent>(onInvoke: (intent) {
          print('Enter or Space was pressed!');
          return null;
        }),
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
            )
        ],
      ),
    );
  }
}
```

[`Actions`]: {{site.api}}/flutter/widgets/Actions-class.html
[`Focus`]: {{site.api}}/flutter/widgets/Focus-class.html
[`FocusableActionDetector`]: {{site.api}}/flutter/widgets/FocusableActionDetector-class.html
[`MouseRegion`]: {{site.api}}/flutter/widgets/MouseRegion-class.html
[`Shortcuts`]: {{site.api}}/flutter/widgets/Shortcuts-class.html

#### Controlling traversal order

To get more control over the order that
widgets are focused on when the user presses tab,
you can use [`FocusTraversalGroup`][] to define sections
of the tree that should be treated as a group when tabbing.

For example, you might to tab through all the fields in
a form before tabbing to the submit button:

<?code-excerpt "lib/pages/focus_examples_page.dart (FocusTraversalGroup)"?>
```dart
return Column(children: [
  FocusTraversalGroup(
    child: MyFormWithMultipleColumnsAndRows(),
  ),
  SubmitButton(),
]);
```

Flutter has several built-in ways to traverse widgets and groups,
defaulting to the `ReadingOrderTraversalPolicy` class.
This class usually works well, but it's possible to modify this
using another predefined `TraversalPolicy` class or by creating
a custom policy.

[`FocusTraversalGroup`]: {{site.api}}/flutter/widgets/FocusTraversalGroup-class.html

### Keyboard accelerators

In addition to tab traversal, desktop and web users are accustomed
to having various keyboard shortcuts bound to specific actions.
Whether it's the `Delete` key for quick deletions or
`Control+N` for a new document, be sure to consider the different
accelerators your users expect. The keyboard is a powerful
input tool, so try to squeeze as much efficiency from it as you can.
Your users will appreciate it!

Keyboard accelerators can be accomplished in a few ways in Flutter
depending on your goals.

If you have a single widget like a `TextField` or a `Button` that
already has a focus node, you can wrap it in a [`KeyboardListener`][]
or a [`Focus`][] widget and listen for keyboard events:

<?code-excerpt "lib/pages/focus_examples_page.dart (focus-keyboard-listener)"?>
```dart
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
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
```

If you'd like to apply a set of keyboard shortcuts to a
large section of the tree, you can use the [`Shortcuts`][] widget:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (Shortcuts)"?>
```dart
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
      child: Focus(
        autofocus: true,
        child: Container(),
      ),
    ),
  );
}
```

The [`Shortcuts`][] widget is useful because it only
allows shortcuts to be fired when this widget tree
or one of its children has focus and is visible.

The final option is a global listener. This listener
can be used for always-on, app-wide shortcuts or for
panels that can accept shortcuts whenever they're visible
(regardless of their focus state). Adding global listeners
is easy with [`HardwareKeyboard`][]:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (hardware-keyboard)"?>
```dart
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
```

To check key combinations with the global listener,
you can use the `HardwareKeyboard.instance.logicalKeysPressed` set.
For example, a method like the following can check whether any
of the provided keys are being held down:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (KeysPressed)"?>
```dart
static bool isKeyDown(Set<LogicalKeyboardKey> keys) {
  return keys
      .intersection(HardwareKeyboard.instance.logicalKeysPressed)
      .isNotEmpty;
}
```

Putting these two things together,
you can fire an action when `Shift+N` is pressed:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (HandleKey)"?>
```dart
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
```

One note of caution when using the static listener,
is that you often need to disable it when the user
is typing in a field or when the widget it's associated with
is hidden from view.
Unlike with `Shortcuts` or `KeyboardListener`,
this is your responsibility to manage. This can be especially
important when you're binding a Delete/Backspace accelerator for
`Delete`, but then have child `TextFields` that the user
might be typing in.

[`HardwareKeyboard`]: {{site.api}}/flutter/services/HardwareKeyboard-class.html
[`KeyboardListener`]: {{site.api}}/flutter/widgets/KeyboardListener-class.html

### Mouse enter, exit, and hover

On desktop, it's common to change the mouse cursor
to indicate the functionality about the content the
mouse is hovering over. For example, you usually see
a hand cursor when you hover over a button,
or an `I` cursor when you hover over text.

The Material Component set has built-in support
for your standard button and text cursors.
To change the cursor from within your own widgets,
use [`MouseRegion`][]:

<?code-excerpt "lib/pages/focus_examples_page.dart (MouseRegion)"?>
```dart
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
```

`MouseRegion` is also useful for creating custom
rollover and hover effects:

<?code-excerpt path-base="ui/layout/adaptive_app_demos"?>

<?code-excerpt "lib/pages/focus_examples_page.dart (MouseOver)"?>
```dart
return MouseRegion(
  onEnter: (_) => setState(() => _isMouseOver = true),
  onExit: (_) => setState(() => _isMouseOver = false),
  onHover: (e) => print(e.localPosition),
  child: Container(
    height: 500,
    color: _isMouseOver ? Colors.blue : Colors.black,
  ),
);
```
