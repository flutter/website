---
title: User input & accessibility
description: >-
  A truly adaptive app also handles differences
  in how user input works and also programs
  to help folks with accessibility issues.
---

<?code-excerpt path-base="ui/adaptive_app_demos"?>

It isn't enough to just adapt how your app looks,
you also have to support a variety of user inputs.
The mouse and keyboard introduce input types beyond those
found on a touch device, like scroll wheel, right-click,
hover interactions, tab traversal, and keyboard shortcuts.

Some of these features work by default on Material
widgets. But, if you've created a custom widget,
you might need to implement them directly.

Some features that encompass a well-designed app,
also help users who work with assistive technologies.
For example, aside from being **good app design**,
some features, like tab traversal and keyboard shortcuts,
are _critical for users who work with assistive devices_.
In addition to the standard advice for
[creating accessible apps][], this page covers
info for creating apps that are both
adaptive _and_ accessible.

[creating accessible apps]: /ui/accessibility

## Scroll wheel for custom widgets

Scrolling widgets like `ScrollView` or `ListView`
support the scroll wheel by default, and because
almost every scrollable custom widget is built
using one of these, it works with those as well.

If you need to implement custom scroll behavior,
you can use the [`Listener`][] widget, which lets you
customize how your UI reacts to the scroll wheel.

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (pointer-scroll)"?>
```dart
return Listener(
  onPointerSignal: (event) {
    if (event is PointerScrollEvent) print(event.scrollDelta.dy);
  },
  child: ListView(),
);
```

[`Listener`]: {{site.api}}/flutter/widgets/Listener-class.html

## Tab traversal and focus interactions

Users with physical keyboards expect that they can use
the tab key to quickly navigate an application,
and users with motor or vision differences often rely
completely on keyboard navigation.

There are two considerations for tab interactions:
how focus moves from widget to widget, known as traversal,
and the visual highlight shown when a widget is focused.

Most built-in components, like buttons and text fields,
support traversal and highlights by default.
If you have your own widget that you want included in
traversal, you can use the [`FocusableActionDetector`][] widget
to create your own controls. The [`FocusableActionDetector`][]
widget is helpful for combining focus, mouse input,
and shortcuts together in one widget. You can create
a detector that defines actions and key bindings,
and provides callbacks for handling focus and hover highlights.

<?code-excerpt "lib/pages/focus_examples_page.dart (focusable-action-detector)"?>
```dart
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
```

[`Actions`]: {{site.api}}/flutter/widgets/Actions-class.html
[`Focus`]: {{site.api}}/flutter/widgets/Focus-class.html
[`FocusableActionDetector`]: {{site.api}}/flutter/widgets/FocusableActionDetector-class.html
[`MouseRegion`]: {{site.api}}/flutter/widgets/MouseRegion-class.html
[`Shortcuts`]: {{site.api}}/flutter/widgets/Shortcuts-class.html

### Controlling traversal order

To get more control over the order that
widgets are focused on when the user tabs through,
you can use [`FocusTraversalGroup`][] to define sections
of the tree that should be treated as a group when tabbing.

For example, you might to tab through all the fields in
a form before tabbing to the submit button:

<?code-excerpt "lib/pages/focus_examples_page.dart (focus-traversal-group)"?>
```dart
return Column(
  children: [
    FocusTraversalGroup(child: MyFormWithMultipleColumnsAndRows()),
    SubmitButton(),
  ],
);
```

Flutter has several built-in ways to traverse widgets and groups,
defaulting to the `ReadingOrderTraversalPolicy` class.
This class usually works well, but it's possible to modify this
using another predefined `TraversalPolicy` class or by creating
a custom policy.

[`FocusTraversalGroup`]: {{site.api}}/flutter/widgets/FocusTraversalGroup-class.html

## Keyboard accelerators

In addition to tab traversal, desktop and web users are accustomed
to having various keyboard shortcuts bound to specific actions.
Whether it's the `Delete` key for quick deletions or
`Control+N` for a new document, be sure to consider the different
accelerators your users expect. The keyboard is a powerful
input tool, so try to squeeze as much efficiency from it as you can.
Your users will appreciate it!

Keyboard accelerators can be accomplished in a few ways in Flutter,
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
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ),
    );
  }
}
```

To apply a set of keyboard shortcuts to a large section
of the tree, use the [`Shortcuts`][] widget:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (shortcuts)"?>
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
      child: Focus(autofocus: true, child: Container()),
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

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (keys-pressed)"?>
```dart
static bool isKeyDown(Set<LogicalKeyboardKey> keys) {
  return keys
      .intersection(HardwareKeyboard.instance.logicalKeysPressed)
      .isNotEmpty;
}
```

Putting these two things together,
you can fire an action when `Shift+N` is pressed:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (handle-key)"?>
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
is typing in a field or when the widget it's
associated with is hidden from view.
Unlike with `Shortcuts` or `KeyboardListener`,
this is your responsibility to manage. This can be especially
important when you're binding a Delete/Backspace accelerator for
`Delete`, but then have child `TextFields` that the user
might be typing in.

[`HardwareKeyboard`]: {{site.api}}/flutter/services/HardwareKeyboard-class.html
[`KeyboardListener`]: {{site.api}}/flutter/widgets/KeyboardListener-class.html

## Mouse enter, exit, and hover for custom widgets {:#custom-widgets}

On desktop, it's common to change the mouse cursor
to indicate the functionality about the content the
mouse is hovering over. For example, you typically see
a hand cursor when you hover over a button,
or an `I` cursor when you hover over text.

Flutter's Material buttons handle basic focus states
for standard button and text cursors.
(A notable exception is if you change the default styling
of the Material buttons to set the `overlayColor` to transparent.)

Implement a focus state for any custom buttons or
gesture detectors in your app.
If you change the default Material button styles,
test for keyboard focus states and
implement your own, if needed.

To change the cursor from within your custom widgets,
use [`MouseRegion`][]:

<?code-excerpt "lib/pages/focus_examples_page.dart (mouse-region)"?>
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

<?code-excerpt "lib/pages/focus_examples_page.dart (mouse-over)"?>
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

For an example that changes the button style
to outline the button when it has focus,
check out the [button code for the Wonderous app][].
The app modifies the [`FocusNode.hasFocus`][]
property to check whether the button has focus
and, if so, adds an outline.

[button code for the Wonderous app]: {{site.github}}/gskinnerTeam/flutter-wonderous-app/blob/8a29d6709668980340b1b59c3d3588f123edd4d8/lib/ui/common/controls/buttons.dart#L143
[`FocusNode.hasFocus`]: {{site.api}}/flutter/widgets/FocusNode/hasFocus.html

## Visual density

You might consider enlarging the "hit area"
of a widget to accommodate a touch screen, for example.

Different input devices offer various levels of precision,
which necessitate differently-sized hit areas.
Flutter's `VisualDensity` class makes it easy to adjust the
density of your views across the entire application,
for example, by making a button larger
(and therefore easier to tap) on a touch device.

When you change the `VisualDensity` for
your `MaterialApp`, `MaterialComponents`
that support it animate their densities to match.
By default, both horizontal and vertical densities
are set to 0.0, but you can set the densities to any
negative or positive value that you want.
By switching between different
densities, you can easily adjust your UI.

![Adaptive scaffold](/assets/images/docs/ui/adaptive-responsive/adaptive_scaffold.webp){:width="100%"}

To set a custom visual density,
inject the density into your `MaterialApp` theme:

<?code-excerpt "lib/main.dart (visual-density)"?>
```dart
double densityAmt = touchMode ? 0.0 : -1.0;
VisualDensity density = VisualDensity(
  horizontal: densityAmt,
  vertical: densityAmt,
);
return MaterialApp(
  theme: ThemeData(visualDensity: density),
  home: MainAppScaffold(),
  debugShowCheckedModeBanner: false,
);
```

To use `VisualDensity` inside your own views,
you can look it up:

<?code-excerpt "lib/pages/adaptive_reflow_page.dart (visual-density-own-view)"?>
```dart
VisualDensity density = Theme.of(context).visualDensity;
```

Not only does the container react automatically to changes
in density, it also animates when it changes.
This ties together your custom components,
along with the built-in components,
for a smooth transition effect across the app.

As shown, `VisualDensity` is unit-less,
so it can mean different things to different views.
In the following example, 1 density unit equals 6 pixels,
but this is totally up to you to decide.
The fact that it is unit-less makes it quite versatile,
and it should work in most contexts.

It's worth noting that the Material generally
use a value of around 4 logical pixels for each
visual density unit. For more information about the
supported components, see the [`VisualDensity`][] API.
For more information about density principles in general,
see the [Material Design guide][].

[Material Design guide]: {{site.material2}}/design/layout/applying-density.html#usage
[`VisualDensity`]: {{site.api}}/flutter/material/VisualDensity-class.html
