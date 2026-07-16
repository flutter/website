---
title: "I/O Pinball Powered by Flutter and Firebase"
description: "Take Flutter game development to the next level"
publishDate: 2022-05-10
author: verygoodopensource
image: images/1yuiVVfFOuPnrsHcUx7xf_Q.webp
category: story
layout: blog
---

<DashImage figure src="images/1yuiVVfFOuPnrsHcUx7xf_Q.webp" />

For Google I/O, we teamed up with the Flutter team to reimagine a classic pinball game built using Flutter and Firebase. Here’s how we brought [I/O Pinball](https://pinball.flutter.dev/) to life on the web with the help of the Flame game engine.

## Game development essentials

The Flutter framework is a great choice for building games driven by user interaction, such as puzzles and word games. When it comes to games that use a game loop, [Flame](https://docs.flame-engine.org/), a 2D game engine built on top of Flutter, can be a helpful tool. I/O Pinball uses Flame’s out-of-the-box features, such as animations, physics, collision detection, and more, while also leveraging the infrastructure of the Flutter framework. If you can build an app with Flutter, you already have the foundation you need to build games with Flame.

<DashImage figure src="images/1Qyyvx52AjpBRuI8MeZ7cAg.webp" />

## Game loop

In conventional apps, screens are usually visually static until there is an event or interaction from the user. With games, the inverse is true — the UI is rendered continuously and the state of the game constantly changes. Flame provides a game widget, which internally manages the game loop so that the UI is constantly rendering in a performant way. The `Game` class contains the implementation of the game components and logic, which is passed to the `GameWidget` in the widget tree. In I/O Pinball, the game loop reacts to the position and state of the ball on the playfield and applies the necessary effects if the ball collides with an object or falls out of play.

```dart
@override
void update(double dt) {
  super.update(dt);

  final direction = -parent.body.linearVelocity.normalized();
  angle = math.atan2(direction.x, -direction.y);
  size = (_textureSize / 45) *
    parent.body.fixtures.first.shape.radius;
}
```

## Rendering a 3D space with 2D components

One of the challenges of building I/O Pinball was figuring out how to create a 3D effect using only 2D elements. Components are ordered to determine how they render on the screen. For example, as the ball is launched up the ramp, the ball’s order increases, so that it appears to be on top of the ramp.

<DashImage figure src="images/103SErV-PT46HyU9nmuwd7g.webp" />

The ball, plunger, both flippers, and the Chrome Dino are elements with a dynamic body, which are affected by the world’s physics. The ball also changes size depending on its position on the board. As the ball moves to the top of the board, it shrinks in size to appear farther away from the user’s perspective. In addition, the gravity on the ball is adjusted to take into account the angle of the pinball machine, so that the ball falls faster on an incline.

```dart
/// Scales the ball's body and sprite according to its position on the board.
class BallScalingBehavior extends Component with ParentIsA<Ball> {
  @override
  void update(double dt) {
    super.update(dt);
    final boardHeight = BoardDimensions.bounds.height;
    const maxShrinkValue = BoardDimensions.perspectiveShrinkFactor;

    final standardizedYPosition = parent.body.position.y +   (boardHeight / 2);
    final scaleFactor = maxShrinkValue +
        ((standardizedYPosition / boardHeight) * (1 - maxShrinkValue));

parent.body.fixtures.first.shape.radius = (Ball.size.x / 2) * scaleFactor;

final ballSprite = parent.descendants().whereType<SpriteComponent>();
    if (ballSprite.isNotEmpty) {
      ballSprite.single.scale.setValues(
        scaleFactor,
        scaleFactor,
      );
    }
  }
}
```

## Physics with Forge 2D

I/O Pinball heavily relies upon the [`forge2d`](https://pub.dev/packages/forge2d) package maintained by the Flame team. This package ports the open source [Box2D physics engine](https://box2d.org/) into Dart so that it can be easily integrated with Flutter. We used `forge2d` to power the physics of the game, for example collision detection between objects (`Fixtures`) on the playfield.

`forge2D` allows us to listen to when collisions between `Fixtures` occur. We then add `ContactCallbacks` to `Fixtures` to be notified when contact happens between two elements. For example, when the ball (which has a `Fixture` with a `CircleShape`) comes in contact with a bumper (which has a `Fixture` with an `EllipseShape`), the score increases. On these callbacks we can set exactly where contact begins and ends, so that when two elements come in contact with another, a collision occurs.

```dart
@override
Body createBody() {
  final shape = CircleShape()..radius = size.x / 2;
  final bodyDef = BodyDef(
    position: initialPosition,
    type: BodyType.dynamic,
    userData: this,
  );

  return world.createBody(bodyDef)
    ..createFixtureFromShape(shape, 1);
}
```

## Sprite sheet animations

There are a few elements on the pinball playfield, such as Android, Dash, Sparky, and Chrome Dino, which are animated. For these, we used sprite sheets, which are included in the Flame engine with the `SpriteAnimationComponent`. For each element, we had a file with the image in various orientations, the number of frames in the file, and the time between frames. Using this data, the `SpriteAnimationComponent` in Flame compiles all of the images together on a loop so that the element appears animated.

<DashImage figure src="images/1l1WjOu97J6hfDTO0KgzKlA.webp" alt="Sprite sheet example" caption="Sprite sheet example" />

```dart
final spriteSheet = gameRef.images.fromCache(
  Assets.images.android.spaceship.animatronic.keyName,
);

const amountPerRow = 18;
const amountPerColumn = 4;
final textureSize = Vector2(
  spriteSheet.width / amountPerRow,
  spriteSheet.height / amountPerColumn,
);
size = textureSize / 10;

animation = SpriteAnimation.fromFrameData(
  spriteSheet,
  SpriteAnimationData.sequenced(
    amount: amountPerRow * amountPerColumn,
    amountPerRow: amountPerRow,
    stepTime: 1 / 24,
    textureSize: textureSize,
  ),
);
```

## A closer look at the I/O Pinball Codebase

## Leaderboard with live results from Firebase

The I/O Pinball leaderboard displays the top scores of players around the world in real time. Users can also share their scores to Twitter and Facebook. We use Firebase [Cloud Firestore](https://firebase.google.com/docs/firestore) to track the top ten scores and fetch them to display on the leaderboard. When a new score is written to the leaderboard, a [Cloud Function](https://firebase.google.com/docs/functions) resorts the scores in descending order and removes any scores not currently in the top ten.

<DashImage figure src="images/1vD6H6j8WKFxS5RJf8Z0EDA.webp" />

```dart
/// Acquires top 10 [LeaderboardEntryData]s.
Future<List<LeaderboardEntryData>> fetchTop10Leaderboard() async {
  try {
    final querySnapshot = await _firebaseFirestore
      .collection(_leaderboardCollectionName)
      .orderBy(_scoreFieldName, descending: true)
      .limit(_leaderboardLimit)
      .get();
    final documents = querySnapshot.docs;
    return documents.toLeaderboard();
  } on LeaderboardDeserializationException {
    rethrow;
  } on Exception catch (error, stackTrace) {
    throw FetchTop10LeaderboardException(error, stackTrace);
  }
}
```

## Building for the web

It can be easier to build a responsive game compared to a conventional app. The pinball playfield simply needs to scale to the size of the device. For I/O Pinball, we zoom based on the size of your device on a fixed ratio. This ensures that the coordinate system is always the same, no matter the display size, which is important to ensure that components appear and interact consistently across devices.

I/O Pinball also adapts to a mobile or desktop browser. On a mobile browser, users can tap the launch button to begin play, as well as tap the left and right sides of the screen to control the corresponding flippers. On a desktop browser, users can use the keyboard to launch the ball and control the flippers.

## Codebase architecture

The pinball codebase follows a layered architecture, with each feature in its own folder. The game logic is also separated from the visual components in this project. This ensures that we could easily update visual elements independently of the game logic and vice versa.

The theme of pinball varies depending on which character a user selects before beginning the game. Theming is controlled with the `CharacterThemeCubit` class. Depending on the character selection, the ball color, background, and other elements are updated.

<DashImage figure src="images/1I0xzMeuSQHI_vB0x28IucQ.webp" />

```dart
/// {@template character_theme}
/// Base class for creating character themes.
///
/// Character specific game components should have a getter specified here to
/// load their corresponding assets for the game.
/// {@endtemplate}
abstract class CharacterTheme extends Equatable {
  /// {@macro character_theme}
  const CharacterTheme();

/// Name of character.
  String get name;

/// Asset for the ball.
  AssetGenImage get ball;

/// Asset for the background.
  AssetGenImage get background;

/// Icon asset.
  AssetGenImage get icon;

/// Icon asset for the leaderboard.
  AssetGenImage get leaderboardIcon;

/// Asset for the the idle character animation.
  AssetGenImage get animation;

@override
  List<Object> get props => [
        name,
        ball,
        background,
        icon,
        leaderboardIcon,
        animation,
      ];
}
```

I/O Pinball game state is handled with [`flame_bloc`](https://pub.dev/packages/flame_bloc), a package that bridges blocs with Flame components. For example, we use `flame_bloc` to keep track of the number of rounds left to play, any bonuses achieved through the game, as well as the current game score. In addition, there is a widget at the top of the widget tree that contains logic for the loading page, including instructions for how to play the game. We also follow the [behavior pattern](https://en.wikipedia.org/wiki/Behavioral_pattern) to encapsulate and isolate certain elements of a game feature based on its components. For example, the bumpers play a sound when hit by the ball, so we implemented the `BumperNoiseBehavior` class to handle this.

```dart
class BumperNoiseBehavior extends ContactBehavior {
  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    readProvider<PinballPlayer>().play(PinballAudio.bumper);
  }
}
```

The codebase also contains comprehensive unit, widget, and golden tests. At times, testing the game posed a few challenges due to the fact that single components could have multiple responsibilities, which made them hard to test in isolation. As a result, we ended up defining patterns to better isolate and test components. We also incorporated improvements into the [`flame_test`](https://pub.dev/packages/flame_test) package.

## Component sandbox

This project relies heavily on Flame components to bring the pinball experience to life. The codebase comes with a component sandbox, which is similar to a [UI component gallery](https://gallery.flutter.dev/#/). This is a helpful tool when developing games because it allows you to develop the game components in isolation and ensure that they look and behave as expected before integrating them into the game.

<DashImage figure src="images/1zAjKICKgCTiEiiMTou9MJQ.gif" />

## What’s next

See if you can get a high score in [I/O Pinball](https://pinball.flutter.dev/)! The code is open source in [this GitHub repo](https://github.com/flutter/pinball). Keep an eye on the leaderboard and be sure to share your score on social media!
