---
title: Casual Games Toolkit
description: >-
  Learn about free & open source multiplatform 2D game development in Flutter.
showBreadcrumbs: false
---

The Flutter Casual Games Toolkit pulls together new and existing resources
so you can accelerate development of games on mobile platforms.

This page outlines where you can find these available resources.

## Why Flutter for games?

The Flutter framework can create performant apps for six target platforms
from the desktop to mobile devices to the web.

With Flutter's benefits of cross-platform development, performance, and
open source licensing, it makes a great choice for games.

Casual games fall into two categories: turn-based games
and real-time games.
You might be familiar with both types of games,
though perhaps you didn't think about them in quite this way.

_Turn-based games_ cover games meant for a mass market with
simple rules and gameplay.
This includes board games, card games, puzzles, and strategy games.
These games respond to simple user input,
like tapping on a card or entering a number or letter.
These games are well suited for Flutter.

_Real-time games_ cover games with a series of actions that
require real-time responses.
These include endless runner games, racing games, and so on.
You might want to create a game with advanced features like collision detection,
camera views, game loops, and the like.
These types of games could use an open source game engine like the
[Flame game engine][] built using Flutter.

## What's included in the toolkit

The Casual Games Toolkit provides the following free resources.

* A repository that includes three game templates that provide
  a starting point for building a casual game.

  1. A [base game template][basic-template]
     that includes the basics for:

     * Main menu
     * Navigation
     * Settings
     * Level selection
     * Player progress
     * Play session management
     * Sound
     * Themes

  1. A [card game template][card-template]
     that includes everything in the base template plus:

     * Drag and drop
     * Game state management
     * Multiplayer integration hooks

  1. An [endless runner template][runner-template] created in partnership
     with the open source game engine, Flame. It implements:

     * A FlameGame base template
     * Player steering
     * Collision detection
     * Parallax effects
     * Spawning
     * Different visual effects

  1. A sample game built on top of the endless runner template,
     called SuperDash. You can play the game on iOS, Android,
     or [web][], [view the open source code repo][], or
     [read how the game was created in 6 weeks][].

* Developer guides for integrating needed services.
* A link to a [Flame Discord][game-discord] channel.
  If you have a Discord account, use this [direct link][discord-direct].

The included game templates and cookbook recipes make certain choices
to accelerate development.
They include specific packages, like `provider`, `google_mobile_ads`,
`in_app_purchase`, `audioplayers`, `crashlytics`, and `games_services`.
If you prefer other packages, you can change the code to use them.

The Flutter team understands that monetization might be a future consideration.
Cookbook recipes for advertising and in-app purchases have been added.

As explained on the [Games][] page,
you can leverage up to $900 in offers when you integrate Google services,
such as [Cloud, Firebase][], and [Ads][], into your game.

:::important
You must connect your Firebase and GCP accounts to use credits for
Firebase services and verify your business email during sign up to earn
an additional $100 on top of the normal $300 credit.
For the Ads offer, [check your region's eligibility][].
:::

## Get started

Are you ready? To get started:

1. If you haven't done so, [install Flutter][].
1. [Clone the games repo][game-repo].
1. Review the `README` file for the first type of game you want to create.

   * [basic game][basic-template-readme]
   * [card game][card-template-readme]
   * [runner game][runner-template-readme]

1. [Join the Flame community on Discord][game-discord]
   (use the [direct link][discord-direct] if you already
   have a Discord account).
1. Review the codelabs and cookbook recipes.

   * Build a [multiplayer game][multiplayer-recipe] with Cloud Firestore.
   * Build a [word puzzle][] with Flutter.
   * Make your games more engaging
     with [leaderboards and achievements][leaderboard-recipe].
   * Monetize your games with [in-game ads][ads-recipe]
     and [in-app purchases][iap-recipe].
   * Add user authentication flow to your game with
     [Firebase Authentication][firebase-auth].
   * Collect analytics about crashes and errors inside your game
     with [Firebase Crashlytics][firebase-crashlytics].

1. Set up accounts on AdMob, Firebase, and Cloud, as needed.
1. Write your game!
1. Deploy to both the Google Play and Apple stores.

[word puzzle]: {{site.codelabs}}/codelabs/flutter-word-puzzle

## Example games

For Google I/O 2022, both the Flutter team
and Very Good Ventures created new games.

* VGV created the [I/O Pinball game][pinball-game] using the Flame engine.
  To learn about this game,
  check out [I/O Pinball Powered by Flutter and Firebase][] on Medium
  and [play the game][pinball-game] in your browser.

* The Flutter team created [I/O Flip][flip-game], a virtual [CCG].
  To learn more about I/O Flip,
  check out [How It's Made: I/O FLIP adds a twist to a classic card game with generative AI][flip-blog]
  on the Google Developers blog and [play the game][flip-game] in your browser.

## Other resources

Once you feel ready to go beyond these games templates,
investigate other resources that our community recommended.

<table class="table table-striped">
<tr>
<th>Feature</th>
<th>Resources</th>
</tr>

<tr>
<td>Animation and sprites</td>
<td>

<Icon id="book_5" title="Cookbook recipe"></Icon> [Special effects][]<br>
<Icon id="handyman" title="Desktop tool"></Icon> [Spriter Pro][]<br>
<Icon id="package_2" title="Flutter package"></Icon> [rive][]<br>
<Icon id="package_2" title="Flutter package"></Icon> [spritewidget][]

</td>
</tr>

<tr>
<td>App review</td>
<td>

<Icon id="package_2" title="Flutter package"></Icon> [app_review][]

</td>
</tr>

<tr>
<td>Audio</td>
<td>

<Icon id="package_2" title="Flutter package"></Icon> [audioplayers][]<br>
<Icon id="package_2" title="Flutter package"></Icon> [flutter_soloud][]<br>

</td>
</tr>

<tr>
<td>Authentication</td>
<td>

<Icon id="science" title="Codelab"></Icon> [User Authentication using Firebase][firebase-auth]

</td>
</tr>

<tr>
<td>Cloud services</td>
<td>

<Icon id="science" title="Codelab"></Icon> [Add Firebase to your Flutter game][]

</td>
</tr>

<tr>
<td>Debugging</td>
<td>

<Icon id="quick_reference_all" title="Guide"></Icon> [Firebase Crashlytics overview][firebase-crashlytics]<br>
<Icon id="package_2" title="Flutter package"></Icon> [firebase_crashlytics][]

</td>
</tr>

<tr>
<td>Drivers</td>
<td>

<Icon id="package_2" title="Flutter package"></Icon> [win32_gamepad][]

</td>
</tr>

<tr>
<td>Game assets<br>and asset tools</td>
<td>

<Icon id="photo_album" title="Game assets"></Icon> [CraftPix][]<br>
<Icon id="photo_album" title="Game assets"></Icon> [Game Developer Studio][]<br>
<Icon id="handyman" title="Desktop tool"></Icon> [GIMP][]

</td>
</tr>

<tr>
<td>Game engines</td>
<td>

<Icon id="package_2" title="Flutter package"></Icon> [Flame][flame-pkg]<br>
<Icon id="package_2" title="Flutter package"></Icon> [Bonfire][bonfire-pkg]<br>
<Icon id="package_2" title="Flutter package"></Icon> [forge2d][]

</td>
</tr>

<tr>
<td>Game features</td>
<td>

<Icon id="book_5" title="Cookbook recipe"></Icon> [Add achievements and leaderboards to your game][leaderboard-recipe]<br>
<Icon id="book_5" title="Cookbook recipe"></Icon> [Add multiplayer support to your game][multiplayer-recipe]

</td>
</tr>

<tr>
<td>Game services integration</td>
<td>

<Icon id="package_2" title="Flutter package"></Icon> [games_services][game-svc-pkg]

</td>
</tr>

<tr>
<td>Level editor</td>
<td>

<Icon id="handyman" title="Desktop tool"></Icon> [Tiled][]

</td>
</tr>

<tr>
<td>Monetization</td>
<td>

<Icon id="book_5" title="Cookbook recipe"></Icon> [Add advertising to your Flutter game][ads-recipe]<br>
<Icon id="science" title="Codelab"></Icon> [Add AdMob ads to a Flutter app][]<br>
<Icon id="science" title="Codelab"></Icon> [Add in-app purchases to your Flutter app][iap-recipe]<br>
<Icon id="science" title="Codelab"></Icon> [Gaming UX and Revenue Optimizations for Apps][] (PDF)<br>

</td>
</tr>

<tr>
<td>Persistence</td>
<td>

<Icon id="package_2" title="Flutter package"></Icon> [shared_preferences][]<br>
<Icon id="package_2" title="Flutter package"></Icon> [sqflite][]<br>
<Icon id="package_2" title="Flutter package"></Icon> [cbl_flutter][] (Couchbase Lite)<br>

</td>
</tr>

<tr>
<td>Special effects</td>
<td>

<Icon id="api" title="API documentation"></Icon> [Paint API][]<br>
<Icon id="book_5" title="Cookbook recipe"></Icon> [Special effects][]

</td>
</tr>

<tr>
<td>User Experience</td>
<td>

<Icon id="quick_reference_all" title="Guide"></Icon> [Best practices for optimizing Flutter web loading speed][]

</td>
</tr>
</table>

[Ads]: https://ads.google.com/intl/en_us/home/flutter/#!/
[Air Hockey]: https://play.google.com/store/apps/details?id=com.ignacemaes.airhockey
[CCG]: https://en.wikipedia.org/wiki/Collectible_card_game
[Cloud, Firebase]: https://cloud.google.com/free
[Flame game engine]: https://flame-engine.org/
[Games]: {{site.main-url}}/games
[I/O Pinball Powered by Flutter and Firebase]: {{site.medium}}/flutter/di-o-pinball-powered-by-flutter-and-firebase-d22423f3f5d
[install Flutter]: /get-started
[Tomb Toad]: https://play.google.com/store/apps/details?id=com.crescentmoongames.tombtoad
[basic-template-readme]: {{site.repo.games}}/blob/main/templates/basic/README.md
[basic-template]: {{site.repo.games}}/tree/main/templates/basic
[card-template-readme]: {{site.repo.games}}/blob/main/templates/card/README.md
[card-template]: {{site.repo.games}}/tree/main/templates/card
[check your region's eligibility]: https://www.google.com/intl/en/ads/coupons/terms/flutter/
[discord-direct]: https://discord.com/login?redirect_to=%2Fchannels%2F509714518008528896%2F788415774938103829
[firebase_crashlytics]: {{site.pub}}/packages/firebase_crashlytics
[flame-pkg]: {{site.pub}}/packages/flame
[flip-blog]: {{site.google-blog}}/2023/05/how-its-made-io-flip-adds-twist-to.html
[flip-game]: https://flip.withgoogle.com/#/
[game-discord]: https://discord.gg/qUyQFVbV45
[game-repo]: {{site.repo.games}}
[pinball-game]: https://pinball.flutter.dev/#/
[runner-template-readme]: {{site.repo.games}}/blob/main/templates/endless_runner/README.md
[runner-template]: {{site.repo.games}}/tree/main/templates/endless_runner

[Add AdMob ads to a Flutter app]: {{site.codelabs}}/codelabs/admob-ads-in-flutter
[firebase-crashlytics]: {{site.firebase}}/docs/crashlytics/get-started?platform=flutter
[ads-recipe]: /cookbook/plugins/google-mobile-ads
[iap-recipe]: {{site.codelabs}}/codelabs/flutter-in-app-purchases#0
[leaderboard-recipe]: /cookbook/games/achievements-leaderboard
[multiplayer-recipe]: /cookbook/games/firestore-multiplayer
[firebase-auth]: {{site.firebase}}/codelabs/firebase-auth-in-flutter-apps#0
[bonfire-pkg]: {{site.pub}}/packages/bonfire
[CraftPix]: https://craftpix.net
[Add Firebase to your Flutter game]: {{site.firebase}}/docs/flutter/setup
[GIMP]: https://www.gimp.org
[Game Developer Studio]: https://www.gamedeveloperstudio.com
[Gaming UX and Revenue Optimizations for Apps]: {{site.main-url}}/go/games-revenue
[Paint API]: {{site.api}}/flutter/dart-ui/Paint-class.html
[Special effects]: /cookbook/effects
[Spriter Pro]: https://store.steampowered.com/app/332360/Spriter_Pro/
[app_review]: {{site.pub-pkg}}/app_review
[audioplayers]: {{site.pub-pkg}}/audioplayers
[cbl_flutter]: {{site.pub-pkg}}/cbl_flutter
[firebase_crashlytics]: {{site.pub-pkg}}/firebase_crashlytics
[forge2d]: {{site.pub-pkg}}/forge2d
[game-svc-pkg]: {{site.pub-pkg}}/games_services
[rive]: {{site.pub-pkg}}/rive
[shared_preferences]: {{site.pub-pkg}}/shared_preferences
[spritewidget]: {{site.pub-pkg}}/spritewidget
[sqflite]: {{site.pub-pkg}}/sqflite
[win32_gamepad]: {{site.pub-pkg}}/win32_gamepad
[read how the game was created in 6 weeks]: {{site.flutter-blog}}/how-we-built-the-new-super-dash-demo-in-flutter-and-flame-in-just-six-weeks-9c7aa2a5ad31
[view the open source code repo]: {{site.github}}/flutter/super_dash
[web]: https://superdash.flutter.dev/
[Tiled]: https://www.mapeditor.org/
[flutter_soloud]: {{site.pub-pkg}}/flutter_soloud
[Best practices for optimizing Flutter web loading speed]: {{site.flutter-blog}}/best-practices-for-optimizing-flutter-web-loading-speed-7cc0df14ce5c

## Other resources

Check out the following videos:

* [Building multiplatform games with Flutter][gdc-talk], a talk
  given at the [Game Developer Conference (GDC)][] 2024.
* [How to build a physics-based game with Flutter and Flame's Forge2D][forge2d-video],
  from Google I/O 2024.

[Game Developer Conference (GDC)]: https://gdconf.com/
[forge2d-video]: {{site.youtube-site}}/watch?v=nsnQJrYHHNQ
[gdc-talk]: {{site.youtube-site}}/watch?v=7mG_sW40tsw
