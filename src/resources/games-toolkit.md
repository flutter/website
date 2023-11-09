---
title: Casual Games Toolkit
description: Free & open source multiplatform 2D game development in Flutter
---

The Flutter Casual Games Toolkit pulls together new and existing resources
so you can accelerate development of games on mobile platforms.

This page outlines where you can find these available resources.

## Why Flutter for games?

The Flutter framework can create performant apps for six target platforms
from the desktop to mobile devices to the web.

The benefits of cross-platform development and performance make Flutter
a great choice for games.

Video games fall into two categories: hobbyist games and casual games.
You may be familiar with both types of games,
though you might not have thought about them in quite this way.

_Hobbyist games_ cover games for those who dedicate time to the playing of games
with complex interfaces, rules, and controllers.
These players are also known as core, hardcore, or professional gamers.
These include arcade-style games: shooters, racing games, and so on.
These types of games could use the [Flame game engine][] built using Flutter.

_Casual games_ cover games meant for a mass market with simple rules
and gameplay.
This includes board games, card games, puzzles, and strategy games.
These games respond to simple user input,
like tapping on a card or entering a number or letter.
These games are well suited for Flutter.

## What's included in the toolkit

The Casual Games Toolkit provides the following free resources:

* A repository that includes the following game templates:
  * A [basic game][basic-template]
  * A [card-based game][card-template]
  * An [endless runner game][runner-template]
* All templates include the following prebuilt features:
  * Main menu
  * Sound and music
  * Ads
  * In-app purchases
  * Achievements and leaderboards
  * Crashlytics support
* The [Build your own game in Flutter][game-video] video that explains
  how to use the basic template.
* The source code for a [finished tic tac toe game][],
  built using the [basic game template][basic-template].
  This game has been released on [Android][and-tic-tac] and [iOS][ios-tic-tac].
* A link to a [Flame Discord][game-discord] channel.
  If you have a Discord account, use this [direct link][discord-direct].

These game templates make certain choices to accelerate development.
They include specific packages, like `provider`, `google_mobile_ads`,
`in_app_purchase`, `audioplayers`, `crashlytics`, and `games_services`.
If you prefer other packages, you can change the code to use them.

The game templates assume that
**you'll want to earn money for your mobile game**.
The templates integrate both ads and in-app purchase packages
into the templates. They're all ready to be configured.

As explained on the [Games][] page,
you can leverage up to $900 in offers when you integrate Google services,
such as [Cloud, Firebase][], and [Ads][], into your game.

{{ site.alert.important }}
**Terms and conditions apply.**
You must connect your Firebase and GCP accounts to use credits for
Firebase services and verify your business email during sign up to earn
an additional $100 on top of the normal $300 credit.
For the Ads offer, [check your region's eligibility][].
{{ site.alert.end }}

## Get started

Are you ready? To get started:

1. [Watch the Quick Start video][game-video]
1. [Clone the games repo][game-repo].
1. Review the `README` file for the first type of game you want to create.

   * [basic game][basic-template-readme]
   * [card game][card-template-readme]
   * [runner game][runner-template-readme]

1. [Join the Flame community on Discord][game-discord]
   (use the [direct link][discord-direct] if you already
   have a Discord account).
1. Set up accounts on AdMob, Firebase, and Cloud, as needed
1. Write your game!
1. Deploy to both the Google and Apple stores

## Advanced game development

Perhaps you want to write a hobbyist video game?
The game template still provides value for
the advanced interface and structure of such games.

For hobbyist games, check out the
[Flame package][flame-package] and join the
[Flame community on Discord][discord-flame].

## Example games

For Google I/O 2022, both the Flutter team and Very Good Ventures created new
games.

* VGV created the [I/O Pinball game][pinball-game] using the Flame engine.
  To learn about this game,
  check out [I/O Pinball Powered by Flutter and Firebase][] on Medium
  and [play the game][pinball-game] in your browser.

* The Flutter team created [I/O Flip][flip-game], a virtual [CCG].
  To learn more about I/O Flip,
  check out [How It’s Made: I/O FLIP adds a twist to a classic card game with generative AI][flip-blog]
  on the Google Developers blog and [play the game][flip-game] in your browser.

{% comment %}
Some examples of successful mobile videogames
built with Flutter and Flame include
[Tomb Toad][] and [Air Hockey][].
{% endcomment %}

## Other resources

Once you feel ready to go beyond these games templates,
investigate other resources that our community recommended.

{% assign pkg-icon = '<span class="material-symbols-outlined">package_2</span>' %}
{% assign doc-icon = '<span class="material-symbols-outlined">quick_reference_all</span>' %}
{% assign codelab = '<span class="material-symbols-outlined">science</span>' %}
{% assign engine = '<span class="material-symbols-outlined">manufacturing</span>' %}
{% assign tool-icon = '<span class="material-symbols-outlined">handyman</span>' %}
{% assign recipe-icon = '<span class="material-symbols-outlined">book_5</span>' %}
{% assign assets-icon = '<span class="material-symbols-outlined">photo_album</span>' %}
{% assign api-icon = '<span class="material-symbols-outlined">api</span>' %}

{{ site.alert.secondary }}
{{pkg-icon}} Flutter package<br>
&nbsp;&nbsp;Packages included in the templates in **bold**<br>
{{api-icon}} API documentation<br>
{{codelab}} Codelab <br>
{{recipe-icon}} Cookbook recipe<br>
{{tool-icon}} Desktop application<br>
{{assets-icon}} Game assets<br>
{{engine}} Game engine<br>
{{doc-icon}} Guide<br>
{{ site.alert.end }}

<table class="table table-striped" markdown="1">
<tr>
<th>Feature</th>
<th>Resources</th>
</tr>

<tr>
<td>Animation and sprites</td>
<td markdown="1">

{{recipe-icon}} [Special effects][]<br>
{{tool-icon}} [Spriter Pro][]<br>
{{pkg-icon}} [rive][]<br>
{{pkg-icon}} [spriteWidget][]

</td>
</tr>

<tr>
<td>App review</td>
<td markdown="1">

{{pkg-icon}} [app_review][]

</td>
</tr>

<tr>
<td>Audio</td>
<td markdown="1">

{{pkg-icon}} **[audioplayers][]**

</td>
</tr>

<tr>
<td>Authentication</td>
<td markdown="1">

{{codelab}} [User Authentication using Firebase][]

</td>
</tr>

<tr>
<td>Cloud services</td>
<td markdown="1">

{{codelab}} [Add Firebase to your Flutter game][]

</td>
</tr>

<tr>
<td>Debugging</td>
<td markdown="1">

{{doc-icon}} [Firebase Crashlytics overview][]<br>
{{pkg-icon}} **[firebase_crashlytics][]**

</td>
</tr>

<tr>
<td>Drivers</td>
<td markdown="1">

{{pkg-icon}} [win32_gamepad][]

</td>
</tr>

<tr>
<td>Game assets and asset tools</td>
<td markdown="1">

{{assets-icon}} [CraftPix][]<br>
{{assets-icon}} [Game Developer Studio][]<br>
{{tool-icon}} [GIMP][]

</td>
</tr>

<tr>
<td>Game engines</td>
<td markdown="1">

{{engine}} [Flame][]<br>
{{engine}} [Bonfire][]<br>
{{pkg-icon}} [forge2d][]

</td>
</tr>

<tr>
<td>Game features</td>
<td markdown="1">

{{recipe-icon}} [Add achievements and leaderboards to your mobile game][]<br>
{{recipe-icon}} [Add multiplayer support to your mobile game][]

</td>
</tr>

<tr>
<td>Games services</td>
<td markdown="1">

{{pkg-icon}} **[games_services][]**

</td>
</tr>

<tr>
<td>Legacy code</td>
<td markdown="1">

{{codelab}} [Use the Foreign Function Interface in a Flutter plugin][]

</td>
</tr>

<tr>
<td>Monetization</td>
<td markdown="1">

{{recipe-icon}} [Add advertising to your Flutter game][]<br>
{{codelab}} [Add AdMob ads to a Flutter app][]<br>
{{codelab}} [Add in-app purchases to your Flutter app][]

</td>
</tr>

<tr>
<td>Persistence</td>
<td markdown="1">

{{pkg-icon}} **[shared_preferences][]**<br>
{{pkg-icon}} [sqflite][]<br>
{{pkg-icon}} [cbl_flutter][]<br>

</td>
</tr>

<tr>
<td>Special effects</td>
<td markdown="1">

{{api-icon}} [Paint API][]<br>
{{recipe-icon}} [Special effects][]

</td>
</tr>

<tr>
<td>User Experience</td>
<td markdown="1">

{{codelab}} [Build next generation UIs in Flutter][]

</td>
</tr>
</table>

[Ads]: https://ads.google.com/intl/en_us/home/flutter/#!/
[Air Hockey]: https://play.google.com/store/apps/details?id=com.ignacemaes.airhockey
[Cloud, Firebase]: https://cloud.google.com/free
[Flame game engine]: https://flame-engine.org/
[Games]: {{site.main-url}}/games
[I/O Pinball Powered by Flutter and Firebase]: {{site.medium}}/flutter/di-o-pinball-powered-by-flutter-and-firebase-d22423f3f5d
[Tomb Toad]: https://play.google.com/store/apps/details?id=com.crescentmoongames.tombtoad
[and-tic-tac]: https://play.google.com/store/apps/details?id=dev.flutter.tictactoe
[basic-template-readme]: {{site.github}}/flutter/samples/tree/main/templates/basic/README.md
[basic-template]: {{site.github}}/flutter/games/tree/main/templates/basic
[card-template-readme]: {{site.github}}/flutter/samples/tree/main/templates/card/README.md
[card-template]: {{site.github}}/flutter/games/tree/main/templates/card
[check your region's eligibility]: https://www.google.com/intl/en/ads/coupons/terms/flutter/
[discord-direct]: https://discord.com/login?redirect_to=%2Fchannels%2F509714518008528896%2F788415774938103829
[discord-flame]: https://discord.gg/5unKpdQD78
[finished tic tac toe game]: {{site.github}}/filiph/tictactoe
[firebase_crashlytics]: {{site.pub}}/packages/firebase_crashlytics
[flame-demo]: https://dartpad.dev/?id=3e52ca7b51ba15f989ad880b8b3314a2
[flame-package]: {{site.pub}}/packages/flame
[game-discord]: https://discord.gg/qUyQFVbV45
[game-repo]: {{site.github}}/flutter/games
[game-video]: {{site.youtube-site}}/watch?v=zGgeBNiRy-8&t=3s
[ios-tic-tac]: https://apps.apple.com/us/app/tic-tac-toe-puzzle-game/id1611729977
[pinball-game]: https://pinball.flutter.dev/#/
[runner-template-readme]: {{site.github}}/flutter/samples/tree/main/templates/endless_runner/README.md
[runner-template]: {{site.github}}/flutter/games/tree/main/templates/endless_runner
[samples repo]: {{site.github}}/flutter/games
[flip-game]: https://flip.withgoogle.com/#/
[CCG]: https://en.wikipedia.org/wiki/Collectible_card_game
[flip-blog]: {site.google-blog}/2023/05/how-its-made-io-flip-adds-twist-to.html

[Add AdMob ads to a Flutter app]: {{site.codelabs}}/codelabs/admob-ads-in-flutter
[Building a game with Flutter and Flame]: {{site.codelabs}}/codelabs/flutter-flame-game
[Build next generation UIs in Flutter]: {{site.codelabs}}/codelabs/flutter-next-gen-uis
[Firebase Crashlytics overview]: {{site.flutterfire}}/docs/crashlytics/overview/
[Add advertising to your Flutter game]: /cookbook/plugins/google-mobile-ads
[Add in-app purchases to your Flutter app]: {{site.codelabs}}/codelabs/flutter-in-app-purchases#0
[Add achievements and leaderboards to your mobile game]: /cookbook/games/achievements-leaderboard
[Add multiplayer support to your mobile game]: /cookbook/games/firestore-multiplayer
[User Authentication using Firebase]: {{site.firebase}}/codelabs/firebase-auth-in-flutter-apps#0
[Use the Foreign Function Interface in a Flutter plugin]: {{site.codelabs}}/codelabs/flutter-ffigen
[Bonfire]: https://bonfire-engine.github.io
[CraftPix]: https://craftpix.net
[Flame]: https://docs.flame-engine.org
[Add Firebase to your Flutter game]: {{site.firebase}}/docs/flutter/setup
[GIMP]: https://www.gimp.org
[Game Developer Studio]: https://www.gamedeveloperstudio.com
[Paint API]: {{site.api}}/flutter/dart-ui/Paint-class.html
[Special effects]: {{site.url}}/cookbook/effects
[Spriter Pro]: https://store.steampowered.com/app/332360/Spriter_Pro/
[app_review]: {{site.pub-pkg}}/app_review
[audioplayers]: {{site.pub-pkg}}/audioplayers
[cbl_flutter]: Couchbase Lite, {{site.pub-pkg}}/cbl_flutter
[firebase_crashlytics]: {{site.pub-pkg}}/firebase_crashlytics
[forge2d]: {{site.pub-pkg}}/forge2d
[games_services]: {{site.pub-pkg}}/games_services
[rive]: {{site.pub-pkg}}/rive
[shared_preferences]: {{site.pub-pkg}}/shared_preferences
[spriteWidget]: {{site.pub-pkg}}/spritewidget
[sqflite]: {{site.pub-pkg}}/sqflite
[win32_gamepad]: {{site.pub-pkg}}/win32_gamepad
