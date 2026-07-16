---
title: "How It’s Made: I/O FLIP"
description: "AI-generated text and images add some fun to this card game built with Flutter, Firebase, and Google Cloud"
publishDate: 2023-05-18
author: verygoodopensource
image: images/1nGcHw9zmkDT1oGhYwuZMqA.jpeg
category: story
layout: blog
---

<DashImage figure src="images/1nGcHw9zmkDT1oGhYwuZMqA.jpeg" />


## How It’s Made: I/O FLIP

### AI-generated text and images add some fun to this card game built with Flutter, Firebase, and Google Cloud

[I/O FLIP](https://flip.withgoogle.com) is an AI-designed card game powered by Google and built in Flutter. It unites a handful of Google products and techniques. This includes [Flutter](https://flutter.dev/), [Firebase](https://firebase.google.com/), generative AI tools, Dreambooth on Muse, [PaLM API](https://developers.googleblog.com/2023/03/announcing-palm-api-and-makersuite.html), and [MakerSuite](https://developers.googleblog.com/2023/03/announcing-palm-api-and-makersuite.html). Players can play multiple matches and share cards from their game to social media.

To play the game, visit [https://flip.withgoogle.com](https://flip.withgoogle.com). To start and to generate your deck, answer a few prompts. To make your hand and join a match, select three cards. You’ll use these cards to play your opponent for three rounds in which the highest card wins the round. The fun doesn’t have to end when the match does. Keep playing matches to increase your win streak and try to make the leaderboard!

Let’s dig into the technical details of we used Flutter and Firebase to build I/O FLIP.

## A card game created with Flutter

The I/O FLIP user interface, animations, hologram effects, and backend, were all built with Flutter and Dart.

To start, we leveraged the [Flutter Casual Games Toolkit](https://docs.flutter.dev/resources/games-toolkit). We used the out-of-the-box audio functionality, game lifecycle, and app navigation with [go_router](https://pub.dev/packages/go_router) as a foundation. From there, we built out the game logic and UI. I/O FLIP is a [responsive web app](https://docs.flutter.dev/ui/layout/adaptive-responsive). It resizes its UI based on the players’ screen. The app also handles input based on the device the player uses. It receives touch input when accessed on a mobile device or tablet and mouse input on desktop.

Playing cards are a key element of I/O FLIP. Thousands of cards could end up in a player’s deck. Each card displays a Google mascot, element, and power value. The elements come into play when they go up against each other. For example, when someone plays a fire card and their opponent plays a water card, the water card receives a penalty of 10 points. We also used records, a [new feature of Dart 3](https://medium.com/dartlang/dart-3-alpha-f1458fb9d232), to render a frame based on the card element.

```dart
…
 (String, SvgPicture) _mapSuitNameToAssets() {
    switch (suitName) {
      case 'fire':
        if (isRare) {
          return (
            Assets.images.cardFrames.holos.cardFire.keyName,
            Assets.images.suits.card.fire.svg(),
          );
        }
        return (
          Assets.images.cardFrames.cardFire.keyName,
          Assets.images.suits.card.fire.svg(),
        );
…
```


### Cards created with AI-generated images and descriptions

<DashImage figure src="images/1-8FtGtAwiERpc5_ctA0GKg.webp" alt="Example I/O FLIP cards" caption="Example I/O FLIP cards" />


Each card in I/O FLIP is unique because it contains an AI-generated image and description. At the beginning of the game, players answer two prompts. These prompts help populate a deck of 12 cards that feature images and descriptions that AI models pre-generated.

Google team used two technologies to pre-generate the images: [Muse](https://muse-model.github.io/), a Transformer text-to-image model, and [DreamBooth](https://dreambooth.github.io/). DreamBooth enables synthesizing a subject in diverse scenes, poses, views, and lighting conditions. Each card contains one of four Google mascots: [Dash](https://docs.flutter.dev/dash), Sparky, [Android](https://source.android.com/docs/setup/about/brands#robot-android), or Dino, and a location. The mascot also has an item that designates their team. The “team type” prompt at the beginning of the game seed the creation of this item. For example, selecting “wizard” may result in a character with a wizard hat, magic wand, or something else wizardly!

The Google team used the [PaLM API](https://developers.googleblog.com/2023/03/announcing-palm-api-and-makersuite.html) to pre-generate card descriptions. The PaLM API accesses Google’s large language models. The prompts at the beginning of the game included the team type and power type for their team. Let’s say you selected team “Wizard” and power “Magnetism”. When your cards generate, one card’s description includes context to the generated image including the character’s special powers. For example, “Dash the Wizard lives in a castle with his pet dragon. He loves to cast spells and make people laugh.”

Flutter composes the cards via the `GameCard` widget. This widget receives the card’s data: name, description, image, and power. Once it creates the card, it applies a border to depict the card’s suit element. If a card is a special card, Flutter applies a foil shader effect.

To learn more about how the Generative AI aspects of the game were created, check out [this Google Developer blog post](https://www.google.com/url?q=https://developers.googleblog.com/2023/05/how-its-made-io-flip-adds-twist-to.html&sa=D&source=docs&ust=1684366112610573&usg=AOvVaw1fj9CV5BxCPvxUEGfcZF39).

### Shaders add foil effect to special cards

<DashImage figure src="images/1oMUDkIUdJaEb6tX1jdQjKg.gif" alt="I/O FLIP uses a fragment shader to render the holo effect on a card" caption="I/O FLIP uses a fragment shader to render the holo effect on a card" />


Flutter supports [fragment shaders](https://docs.flutter.dev/ui/advanced/shaders). To generate these per-pixel visual effects, Flutter runs the OpenGL Shading Language (GLSL) on the device’s GPU. Trading card collectors might remember the feeling of opening a pack to find a special edition card with a shiny, holographic foil. I/O FLIP includes special foil cards, too. They are valued at 100 points. Regular cards have a point values ranging from 10 to 99. We used custom shaders to render the foil effect.

We implemented the foil shader in the `foil.frag` file. The effect uses the following constants:

* `STRENGTH`. This mixes the original pixel color with the color of the foil effect. This ranges from 0.0 for no effect to 1.0 for full effect.

* `SATURATION`. This sets the intensity of a color. This ranges from 0.0 for grayscale, or absence of color, to 1.0 for full color or absence of black.

* `LIGHTNESS`. This ranges from 0.0 for full black to 1.0 for full white.

The shader also receives input through [uniforms](https://docs.flutter.dev/ui/advanced/shaders#uniforms), in this case `resolution` and `offset`. The uniform `sampler2d` called `tSource` represents the card image to which the shader is applied. The final result is a card with a foil effect.

```dart
vec4 rainbowEffect(vec2 uv) {
    vec4 srcColor = texture(tSource, uv);
    float hue = uv.x / (1.75 + abs(offset.x)) + offset.x / 3.0;
    float lightness = LIGHTNESS + 0.25 * (0.5 + offset.y * (0.5 - uv.y));
    hue = fract(hue);

    float c = (1.0 - abs(2.0 * lightness - 1.0)) * SATURATION;
    float x = c * (1.0 - abs(mod(hue / (1.0 / 6.0), 2.0) - 1.0));
    float m = LIGHTNESS - c / 2.0;

    vec3 rainbowPrime;

    if (hue < 1.0 / 6.0) {
        rainbowPrime = vec3(c, x, 0.0);
    } else if (hue < 1.0 / 3.0) {
        rainbowPrime = vec3(x, c, 0.0);
    } else if (hue < 0.5) {
        rainbowPrime = vec3(0.0, c, x);
    } else if (hue < 2.0 / 3.0) {
        rainbowPrime = vec3(0.0, x, c);
    } else if (hue < 5.0 / 6.0) {
        rainbowPrime = vec3(x, 0.0, c);
    } else {
        rainbowPrime = vec3(c, 0.0, x);
    }

    vec3 rainbow = rainbowPrime + m;
    return mix(srcColor, vec4(rainbow, srcColor.a), STRENGTH);
}
```


## Firebase enables game hosting and sharing to social media

All of the gameplay communication happens in real time via [Firebase’s Cloud Firestore](https://firebase.google.com/docs/firestore). Firebase Storage hosts the card assets that generate players’ card decks. We also use Cloud Firestore to track the “Highest Win Streak” on the leaderboard. When a leaderboard adds new leader, the [`firedart`](https://pub.dev/packages/firedart) package adds it to Firestore.

### Dart Frog enables sharing code between the backend and frontend

I/O FLIP needed a backend to prevent cheating. This server-authoritative game logic prevent malicious clients from sending fabricated requests. Dart Frog keeps the game logic, such as the winner of each round, on the backend. It also shares this code between the Flutter frontend and the Firestore backend. Sharing code has a few benefits. It allows us to share logic. For example, if one player wins a round, the game can display a win animation without needing to query Firebase every time. Sharing code also sped development, since the team could write backend and frontend code in the same language: Dart. We deployed the I/O FLIP Dart Frog server to [Cloud Run](https://cloud.google.com/run). This means the server code runs in Google Cloud and can autoscale, so the app can handle many players at once.

```dart
FutureOr<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    final cardsRepository = context.read<CardsRepository>();
    final promptRepository = context.read<PromptRepository>();

    final body = await context.request.json() as Map<String, dynamic>;
    final prompt = Prompt.fromJson(body);

    if (!await promptRepository.isValidPrompt(prompt)) {
      return Response(statusCode: HttpStatus.badRequest);
    }

    final characterClass = prompt.characterClass;
    if (characterClass == null) {
      return Response(statusCode: HttpStatus.badRequest);
    }

    final characterPower = prompt.power;
    if (characterPower == null) {
      return Response(statusCode: HttpStatus.badRequest);
    }

    final cards = await cardsRepository.generateCards(
      characterClass: characterClass,
      characterPower: characterPower,
    );
    return Response.json(
      body: {'cards': cards.map((e) => e.toJson()).toList()},
    );
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}
```


Dart Frog also facilitates sharing on social media. When selecting cards, a player can share an individual card to Twitter or Facebook. When you submit your score to the leaderboard, you can share your hand to Twitter or Facebook. Once the user clicks **Share**, Dart Frog generates a pre-populated post. This post contains text and a link to a webpage with your corresponding hand or card and a button for visitors to play I/O FLIP themselves!

## What’s next

I/O FLIP showcases how to combine Flutter and Firebase, along with Google generative AI tools and techniques, in a fun game that people around the world can play.

[Play a game](https://flip.withgoogle.com) and show us your hand, or dig into the [open source code](https://github.com/flutter/io_flip)!