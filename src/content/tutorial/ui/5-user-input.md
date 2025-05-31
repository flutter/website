---
title: User input
description: Accept input from the user with buttons and text fields
permalink: /tutorial/user-input/
---

{%- comment %} TODO(ewindmill) embed video {%- endcomment %}


The app theoretically displays the users guesses in `Tile` widgets,
but it needs a way for users to input those guesses. In this lesson,
build that with two interaction widgets: [`TextField`][] and
[`IconButton`][].

## Callback functions

To allow users to type in their guesses, you'll create a dedicated
widget named `GuessInput`. First, create the basic structure for your
`GuessInput` widget, which should require a callback function called
`onSubmitGuess` as an argument.

Add the following code to your `main.dart` file.

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  @override
  Widget build(BuildContext context) {
    // You'll build the UI in the next steps
    return Container(); // Placeholder
  }
}
```

The type definition of the line `final void Function(String) onSubmitGuess;` 
might look overwhelming if you're new to Dart. 
It declares a `final` member of the class called `onSubmitGuess`, 
whichhas a type of `void Function(String)`. It’s a function that takes a
single `String` argument (the user's guess) and doesn't return any
value (denoted by `void`). 

This callback tells us that the logic that actually handles the user's
guess will be written elsewhere.  It's good practice for interaction
widgets to be passed these functions as callbacks from their parent,
which keeps the interaction widget reusable and decoupled from any
specific functionality. 

By the end of this lesson, the passed in `onGuessSubmitted` function
will be called when a user enters a guess. First, you'll need to build
the visual parts of this widget. This is what the widget will look like.

{%- comment %} TODO(ewindmill) embed video {%- endcomment %}

## The `TextField` widget

Given the text field and button are side-by-side, this a good use case
for a `Row` widget. Replace the placeholder `Container` in your
`build` method with a `Row` containing an `Expanded` `TextField`:

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  @override
  Widget build(BuildContext context) {
     return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

Some of these widgets have been in previous lessons: `Row` and
`Padding`. New, though, is the [`Expanded`][] widget. When a child of
a `Row` (or `Column`) is wrapped in `Expanded`, it tells that child to
fill all the available space along the main axis (horizontal for
`Row`, vertical for `Column`) that hasn't been taken by other
children. This makes the `TextField` stretch to take up all the space
*except* what’s taken by other widgets in the row. 

:::tip Tip
`Expanded` is often the solution to "[unbound width/height][]" exceptions. 
:::

Also new is the `TextField` widget. This widget is the star of the
show in this lesson.  This is the basic Flutter widget for text input. 

Thus far, `TextField` has the following configurations. 

* It’s decorated with a rounded border. Notice that the decoration
  configuration is very similar to how a `Container` and box
  decorations are decorated.  
* Its `maxLength` property is set to 5, which is how many letters are
  allowed in any guess in the game.

## Handling text with `TextEditingController`

Next, you need a way to manage the text that the user types into the
input field. For this, use a [`TextEditingController`][]. 

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  // NEW
  final TextEditingController _textEditingController = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
            ),
          ),
        ),
        // 
      ],
    );
  }
}
```

A `TextEditingController` is used to read, clear, and modify the text
in a `TextField`. To use it, pass it into the `TextField`.

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController, // NEW
            ),
          ),
        ),
      ],
    );
  }
}
```

Now, when a user inputs text, you can capture it with the
`_textEditingController`, but you'll need to know *when* to capture
it. The simplest way to react to input is by using the
`TextField.onSubmitted` argument. This argument accepts a callback,
and the callback will be triggered whenever the user presses the
"Enter" key on the keyboard while the text field has focus.
 
For now, ensure that this works by adding the following callback to
`TextField.onSubmitted`.

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              onSubmitted: (String input) { // NEW
                print(_textEditingController.text); // Temporary
              }
            ),
          ),
        ),
      ],
    );
  }
}
```

In this case, you could print the `input` passed to the `onSubmitted`
callback directly, but in this app will have a better experience if
the text is cleared after each guess, and you need the controller to
do that. Update the code to do this:

:::note
In Dart, it’s good practice to use a [wildcard][] to
hide the input to a function that’ll never be used. The following
example does so.
:::


```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  final TextEditingController _textEditingController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              onSubmitted: (_) { // UPDATED
                print(_textEditingController.text); // Temporary
                _textEditingController.clear(); // NEW
              } 
            ),
          ),
        ),
      ],
    );
  }
}
```

## Input focus

Often, you want a specific input or widget to automatically gain focus
without the user taking action. In this app, for example, the only
thing a user can do is enter a guess, so the `TextField` should be
focused automatically when the app launches.  And after the user
enters a guess, the focus should stay in the `TextField` so they can
enter their next guess. 

To resolve the first focus issue, you only need to set a property on
the `TextField`.

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  final TextEditingController _textEditingController = TextEditingController();
    @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
		          maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
		          controller: _textEditingController,
		          autoFocus: true // NEW
		          onSubmitted: (String input) {
                print(input); // Temporary
                _textEditingController.clear();
              } 
 		        ),
          ),
        ),
      ],
    );
  }
}
```

The second issue requires you to use a [`FocusNode`][], which is used
to manage the keyboard focus in Flutter. You can use it to request
that a `TextField` gain focus (making the keyboard appear on mobile)
or to know when a field has focus. 

First, create a `FocusNode` in the `GuessInput` class:

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode(); // NEW

  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```

Then, use the `FocusNode` to request focus whenever the `TextField` is
submitted after the controller is cleared:

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              autoFocus: true
              focusNode: _focusNode, // NEW
              onSubmitted: (String input) {
                print(input); // Temporary
                _textEditingController.clear();
                _focusNode.requestFocus(); // NEW
              } 
            ),
          ),
        ),
      ],
    );
  }
}
```

Now when you press ‘Enter’ after inputting text, you can continue typing.

## Use the input

Finally, you need to do something with the text the user inputs. Recall that the constructor for the `GuessInput` requires a callback called `onGuessSubmitted`. In the `GuessInput`, you only need to use that callback. Replace the `print` statement with a call to that function.

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              autoFocus: true
              focusNode: _focusNode,
              onSubmitted: (String input) {
                onSubmitGuess(_textEditionController.text.trim())
                _textEditingController.clear();
                _focusNode.requestFocus();
              } 
            ),
          ),
        ),
      ],
    );
  }
}
```

:::note 
`trim` is used to ensure there’s no additional whitespace
entered, which would allow the user to to enter a four letter word
(plus a whitespace).
:::

The remaining needed functionality needs to be handled in the parent
widget, `GamePage`.  In the `build` method of that class, add the
`GuessInput` widget under the `Row` widgets in the `Column`’s
children.

```dart
class GamePage extends StatelessWidget {
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 5.0,
        children: [
          for (var guess in _game.guesses)
            Row(
              spacing: 5.0,
              children: [
                for (var letter in guess) Tile(letter),
              ],
            ),
          GuessInput(
            onSubmitGuess: (String guess) {
              // TODO, handle guess
              print(guess); // Temporary
            }
          ),
        ],
      ),
    );
  }
}
```

For the moment, this only prints the guess to prove that it’s wired up
correctly.  Submitting the guess requires us to use the functionality
of a `StatefulWidget`, which you’ll do in the [`StatefulWidget` lesson][].

## Buttons

To improve the UX on mobile and reflect well-known UI, there should
also be a button that can submit the guess.

{%- comment %}
TODO(ewindmill) embed video
{%- endcomment %}

There are many button widgets built into Flutter, like [`TextButton`][],
[`ElevatedButton`][], and the button you’ll use now: [`IconButton`][].  All of
these buttons (and many other interaction widgets) require two
arguments (in addition to their optional arguments): 

* A callback function passed to `onPressed`.   
* A widget that makes up the content of the button (often a `Text` or `Icon`).

Add an icon button to the row widget’s children list in the
`GuessInput` widget, and give it an [`Icon`][] widget to display. The
`Icon` widget itself requires icon configuration, and in this case the
`padding` property, which sets the padding betweenthe edge of the
button and the icon it wraps, is set to zero. This removes the default
padding and makes the button smaller.

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

    @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(...),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_circle_up),  
        ),
      ],
    );
  }
}
```

The `IconButton.onPressed` callback should look familiar:

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

    @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(...),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_circle_up),
          onPressed: () {
            onSubmitGuess(_textEditingController.text.trim());
            _textEditingController.clear();
            _focusNode.requestFocus();
          },
        ),
      ],
    );
  }
}
```

This method is doing the same as the `onSubmitted` callback on the `TextField`. 

:::note Challenge - Share "on submitted" logic.

You may be thinking, "Shouldn’t we abstract these methods into one
function and pass it to both inputs?" You could, but it wouldn’t be as
clean as you might think because the callbacks to
`IconButton.onPressed` and `TextField.onSubmitted` require different
arguments. That said, if the logic was more complex, it'd be better to
do so. 

**Solution**

```dart
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  void _onSubmit() {
    onSubmitGuess(_textEditingController.text);
    _textEditingController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              focusNode: _focusNode,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              onSubmitted: (String value) {
                _onSubmit();
              },
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_circle_up),
          onPressed: _onSubmit,
        ),
      ],
    );
  }
}
```

::: 


[`TextField`]: {{site.api}}/flutter/material/TextField-class.html
[`IconButton`]: {{site.api}}/flutter/material/IconButton-class.html
[`Expanded`]: {{site.api}}/flutter/widgets/Expanded-class.html
[unbound width/height]: https://www.youtube.com/watch?v=jckqXR5CrPI
[`TextEditingController`]: {{site.api}}/flutter/widgets/TextEditingController-class.html
[wildcard]: {{site.dart-site}}/language/pattern-types#wildcard
[`FocusNode`]: {{site.api}}/flutter/widgets/FocusNode-class.html
[`StatefulWidget` lesson]: /tutorial/stateful-widget
[`Icon`]: {{site.api}}/flutter/material/Icons-class.html
[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html
[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html
[`IconButton`]: {{site.api}}/flutter/material/IconButton-class.html
