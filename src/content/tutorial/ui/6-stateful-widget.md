---
title: Stateful widgets
description: Learn about StatefulWidgets and rebuilding Flutter UI.
permalink: /tutorial/stateful-widget/
sitemap: false

---

{%- comment %} TODO(ewindmill) embed video {%- endcomment %}

So far, your app displays a grid and an input field, but the grid
doesn't yet update to reflect the user’s guesses. When this app is
complete, each tile in the next unfilled row should update after each
submitted user guess by:

* Displaying the correct letter.
* Changing color to reflect whether the letter is correct (green), is
  in the word but at an incorrect position (yellow), or doesn't appear
  in the word at all (grey).

To handle this dynamic behavior, you need to convert `GamePage` from a
`StatelessWidget` to a [`StatefulWidget`][].

## Why stateful widgets?

When a widget's appearance or data needs to change during its
 lifetime, you need a `StatefulWidget` and a companion `State` object.
While the `StatefulWidget` itself is still immutable (its properties
can't change after creation), the `State` object is long-lived, can
hold mutable data, and can be rebuilt when that data changes, causing
the UI to update.

For example, the following widget tree imagines a simple app
that has a counter that increases when the button is pressed,
and uses a stateful widget.

<img src='/assets/images/docs/tutorial/widget_tree_stateful.png' alt="A diagram of a widget tree with a stateful widget and state object.">

Here is the basic `StatefulWidget` structure (don't do anything yet):

```dart
class ExampleWidget extends StatefulWidget {
  ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
   return Container();
  }
}
```

## Convert `GamePage` to a stateful widget

To convert the `GamePage` widget (or any other) from
a stateless widget to a stateful widget, do the following steps:

1. Change `GamePage` to extend `StatefulWidget` instead of
   `StatelessWidget`.
2. Create a new class named `_GamePageState`, that extends
   `State<GamePage>`. This new class will hold the mutable state and
   the `build` method. Move the `build` method and all properties
   *instantiated on the widget*  from `GamePage` to the state object.
3. Implement the `createState()` method in `GamePage`, which returns
   an instance of `_GamePageState`.

:::tip Quick assists

You don't have to manually do this work, as the Flutter plugins for
VS Code and IntelliJ provides ["quick assists"][], which will do this
conversion for you.

:::

Your modified code should look like this:

```dart
class GamePage extends StatefulWidget {
  GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (var guess in _game.guesses)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var letter in guess)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
                    child: Tile(letter),
                  )
              ],
            ),
          GuessInput(
            onSubmitGuess: (_) {
              // TODO, handle guess
              print(guess); // Temporary
            },
          ),
        ],
      ),
    );
  }
}
```

## Updating the UI with `setState`

Whenever you mutate a `State` object, you must call [`setState`][] to
signal the framework to update the user interface and call the
`State`'s `build` method again.

In this app, when a user makes a guess, the word they guessed is saved
on the `Game` object, which is a property on the `GamePage` class, and
therefore is state that might change and require the UI to update.
When this state is mutated, the grid should be re-drawn to show the
user’s guess.

To implement this, update the callback function passed to
`GuessInput`. The function needs to call `setState` and, within
`setState`, it needs to execute the logic to determine whether the users
guess was correct.

:::note

The game logic is abstracted away into the [`Game` object][], and
outside of the scope of this tutorial.

:::

Update your code:

```dart
class GamePage extends StatefulWidget {
  GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (var guess in _game.guesses)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var letter in guess)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
                    child: Tile(letter),
                  )
              ],
            ),
          GuessInput(
           onSubmitGuess: (String guess) {
              setState(() { // NEW
                _game.guess(guess);
              });
            },
          ),
        ],
      ),
    );
  }
}
```

Now, when you type a legal guess into the `TextInput` and submit it,
the application will reflect the user’s guess. If you were to call
`_game.guess(guess)` *without* a calling `setState`, the internal game
data would change, but Flutter wouldn't know it needs to repaint the
screen, and the user wouldn't see any updates.

["quick assists"]: /tools/android-studio#assists-quick-fixes
[`StatefulWidget`]: {{site.api}}/flutter/widgets/StatefulWidget-class.html
[`setState`]: {{site.api}}/flutter/widgets/State/setState.html
[`Game` object]: https://github.com/flutter/demos
