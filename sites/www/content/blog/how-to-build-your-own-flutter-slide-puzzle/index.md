---
title: "How to build your own Flutter slide puzzle"
description: >-
  By now you’ve probably read through the Flutter Puzzle Hack challenge and are
  already thinking of how to push your creativity to new…
publishDate: 2022-01-20
author: verygoodopensource
image: images/1r5DaUW3Cdoad6GQBwWIh3Q.webp
category: tutorial
layout: blog
---

<DashImage figure src="images/1r5DaUW3Cdoad6GQBwWIh3Q.webp" />

By now you’ve probably read through the [Flutter Puzzle Hack](https://flutterhack.devpost.com/) challenge and are already thinking of how to push your creativity to new limits. We’re here to give you some more info about how the sample codebase is structured and give you some ideas for creating your contest submission.

## Slide puzzle architecture

The provided source code implements a layered architecture with `flutter_bloc` to manage the state. Blocs handle everything from the game logic to theming. All state is managed in a consistent way; for any updates to the logic of the puzzle, you’ll only need to find the corresponding bloc and update it. The reset and shuffle game buttons, timer, and countdown are all separate blocs, so these might be other places where you consider implementing something creative: maybe an hourglass for a timer? Or a snazzy shuffle sequence?

Note that all of the game logic is contained within a single bloc called `PuzzleBloc`. This will update with events such as tapping a tile to move the puzzle tile with `TileTapped` event or resetting the puzzle board completely with `PuzzleReset`. Each time a puzzle is updated, a new puzzle state is emitted.

```dart
class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this._size, {this.random}) : super(const PuzzleState() {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileTapped>(_onTileTapped);
    on<PuzzleReset>(_onPuzzleReset);
  }

  void _onPuzzleInitialized(
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) {...}
  void _onTileTapped(
    TileTapped event,
    Emitter<PuzzleState> emit,
  ) {...}
  void _onPuzzleReset(
    PuzzleReset event,
    Emitter<PuzzleState> emit,
  ) {...}
}
```

## Customizing the theme

The sample puzzle code contains both a Simple and Dashatar theme. These can be used as a jumping off point for your own customizations — borrow as much as you need, or start from scratch. How you implement your puzzle is up to you! One place you may consider getting creative is the puzzle theming.

<DashImage figure src="images/0BHUg3jHaaIRFW_5O.webp" />

All of the theming in the demo happens at the top of the `PuzzlePage`. It is abstracted, so you’ll only need to update the theme elements in one place and have the changes reflected everywhere. Both the Simple and Dashatar themes define a range of options such as screen background, menu, logo, buttons, text colors, whether the theme displays a timer (present in the Dashatar theme, but not in the Simple theme), and more. You can find these in the “dashatar” and “simple” directories at the root of the repository.

```dart
/// {@template simple_theme}
/// The simple puzzle theme.
/// {@endtemplate}
class SimpleTheme extends PuzzleTheme {
  /// {@macro simple_theme}
  const SimpleTheme() : super();

  @override
  Color get backgroundColor => PuzzleColors.white;

  @override
  Color get buttonColor => PuzzleColors.primary6;

  @override
  Color get hoverColor => PuzzleColors.primary3;

  @override
  Color get pressedColor => PuzzleColors.primary7;

  ...
}
```

Each puzzle theme has a `LayoutDelegate` that computes the layout of this theme. You can create new themes by reusing the same layout objects and only adjusting some theme options. For more advanced designs, the whole theme `LayoutDelegate` can be customized. For example, you can override the `backgroundBuilder` to make a custom background, displayed only on a large screen.

```dart
@override
Widget backgroundBuilder(PuzzleState state) {
  return Positioned(
    bottom: 74,
    right: 50,
    child: ResponsiveLayoutBuilder(
      small: (_, child) => const SizedBox(),
      medium: (_, child) => const SizedBox(),
      large: (_, child) => const DashatarThemePicker(),
    ),
  );
}
```

## Implementing animations

Animations are a great element to explore in your slide puzzle. While the Simple theme does not contain any animations, the Dashatar code implements a few animations, some of which are [staggered](https://docs.flutter.dev/development/ui/animations/staggered-animations). These animations are driven by a single animation controller adjusted with [`Interval`](https://api.flutter.dev/flutter/animation/Interval-class.html) to delay the animation and [`Tween`](https://api.flutter.dev/flutter/animation/Tween-class.html) to define the range of values of the animation. This can be seen in the success state of the Dashatar puzzle where multiple widgets appear sequentially by animating their offset and opacity. Similarly, each tick of the countdown timer slowly grows in and then fades out just as the next tick is about to appear using the same technique.

<DashImage figure src="images/0YPUf0ml0ggq7RJIL.webp" />

Most of the animations in the Dashatar theme are implicit. This means that there is no need to write the whole animation yourself, as widgets animate changes to properties on their own. As an example, take a look at the `DashatarPuzzleTile` widget for how to animate the movement of tiles when the user taps a tile. Whenever a tile is tapped, its current position is updated and transitioned over the given `movementDuration` thanks to implicitly animated `AnimatedAlign`.

```dart
class DashatarPuzzleTile extends StatelessWidget {
  // ...

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: FractionalOffset(
        (tile.currentPosition.x - 1) / (size - 1),
        (tile.currentPosition.y - 1) / (size - 1),
      ),
      duration: movementDuration,
      curve: Curves.easeInOut,
      child: ResponsiveLayoutBuilder(...),
    );
  }
}
```

## Designing for the web

The sample puzzle was built for the web. It implements responsive design for three screen sizes: small, medium, and large. In addition, there is a `ResponsiveLayoutBuilder` that uses a wrapper around the Flutter `LayoutBuilder` widget, which allows you to specify different widgets based on the different breakpoints.

Since we targeted the web, there are some additional considerations to keep in mind. The app pre-caches images and some audio to help optimize performance during the game. When a user arrives at the default Simple puzzle game, the assets for the Dashatar version load in the background (we took a similar approach with loading all of the props for [I/O Photo Booth](https://github.com/flutter/photobooth)). This will make sure that once the user navigates to the Dashatar theme, most assets will already be loaded, ensuring a smooth user experience.

While the app is at home on the web, you could challenge yourself to explore creative ways to make the puzzle extend to multiple platforms. What might your puzzle look like on mobile and desktop? How can you adapt your ideas for multiple platforms?

## Accessibility

The slide puzzle was built with accessibility in mind. Users are able to use a keyboard to interact with the puzzle. This is done with `RawKeyboardListener`, a widget that calls a callback whenever the user presses or releases a key on a keyboard. Users can also interact with the app using screen readers. This is done with [semantic labels](https://api.flutter.dev/flutter/widgets/Semantics-class.html). There are also tooltips that appear for some actions using the `Tooltip` widget. If you’re building your slide puzzle submission from scratch, we highly recommend making your puzzle accessible to all users by using similar strategies above.

## Additional ideas

Feel free to use the demo codebase as a foundation for your submission. Or, you can implement a new idea from scratch. The important thing is that your submission is a working slide puzzle — but how you get there is up to you!

The Simple and Dashatar examples should give you some ideas of where you can customize, or cool things you can create on your own. One interesting idea we explored was projecting the [Flutter Plasma created by Felix Blaschke](https://flutterplasma.dev/) onto the puzzle tiles. The plasma effect can be achieved using the `CustomPaint` widget wrapped with a `Transform` widget and animated with an `AnimationController`. You can find an [example of the plasma renderer used in the demos here](https://github.com/felixblaschke/sa3_liquid/blob/main/lib/liquid/plasma/plasma.dart).

<DashImage figure src="images/04sa1RI3GzrlpRcQ4.webp" />

Another idea would be to fetch images or other data from an API. For example, you could use the [Google Photos API](https://developers.google.com/photos) to make a slide puzzle using photos from one of your favorite Google Photos albums. The sky is the limit with this challenge!

View the sample puzzle code [here](https://github.com/VGVentures/slide_puzzle). Share your creations with us on Twitter with the #FlutterPuzzleHack. We can’t wait to see what you create!
