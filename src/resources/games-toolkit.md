---
title: Casual Games Toolkit
description: Learn more about creating app-like games in Flutter.
---

The Flutter Casual Games Toolkit, announced at Google I/O 2022,
pulls together new and existing resources that enable you to
speed up development of casual games on mobile.

This page outlines what resources are available and
where you can find them.

## How Flutter can help

In the beginning, four engineers had a vision of
developing a framework for creating performant mobile apps
written as a single application.
What later became Flutter has grown in many ways,
but has always focused on writing apps.

Games fall into roughly two categories: video games
and app-like games. You are likely familiar with both
types of games, though you might not have thought
about them in quite this way.

_Video games_ include arcade-style games: shooters,
racing games, and so on.
Video games are generally action-based and use a
continual input device, like a joystick.

_App-like_ games include casual games such as board games,
card games, puzzles, and strategy games.
App-like games tend to respond to user input,
like tapping on a card or entering a number or letter.

Because these games _are_ app-like, they are
especially well suited for Flutter.

When we say _casual games_, we are primarily
referring to app-like games in this context.

## What's included

The Casual Games Toolkit provides the following free resources:

* A [game template app][game-template], available in Flutter's
  [samples repo][], includes the following prebuilt features:
  * Main menu
  * Sound & music
  * Ads
  * In-app purchases
  * Achievements and leader boards
  * Crashlytics support
* A video, [Build your own game in Flutter][game-video],
  explaining how to use the template
* Source code for a [finished tic tac toe game][],
  built using the [game template][game-template],
  and released [on Android][] and [iOS][]
* A link to a [Flutter Games Discord][game-discord] channel
  (use the [direct link][direct-discord] if you already
  have a Discord account)

[finished tic tac toe game]: {{site.github}}/filiph/tictactoe
[game-discord]: https://discord.gg/WY5NwwjBQz
[iOS]: https://apps.apple.com/us/app/tic-tac-toe-puzzle-game/id1611729977 
[on Android]: https://play.google.com/store/apps/details?id=dev.flutter.tictactoe
[samples repo]: {{site.github}}/flutter/samples

The game template is opinionated (it pretty
much has to be), so it uses specific packages,
like `provider`, `google_mobile_ads`, `in_app_purchase`,
`audioplayers`, `crashlytics`, and `games_services`.
Feel free to change the code
to use other packages, if you prefer.

And, yes, the game template assumes that **you'll
want to earn money for your mobile game**,
so the ads and in-app purchase packages are already
integrated with the template and ready to be configured.

As explained on the [Games][] page,
you can also take advantage of up to $900
in offers when you integrate Google services,
such as [Cloud, Firebase][], and [Ads][],
into your game.
(Terms and conditions apply: You must connect your
Firebase and GCP accounts to use credits for
Firebase services and verify your business
email during sign up to earn an additional $100
on top of the normal $300 credit. For the Ads offer,
[check your region's eligibility][].

[Ads]: https://ads.google.com/intl/en_us/home/flutter/#!/
[check your region's eligibility]: https://www.google.com/intl/en/ads/coupons/terms/flutter/
[Cloud, Firebase]: https://cloud.google.com/free
[Games]: {{site.main-url}}/games

## Get started

Are you ready? To get started:

1. [Watch the Quick Start video][game-video]
1. [Clone the games template repo][game-template]
1. [Join the Flutter Games community on Discord][game-discord]
   (use the [direct link][direct-discord] if you already
   have a Discord account).
1. Set up accounts on AdMob, Firebase, and Cloud, as needed
1. Write your game!
1. Deploy to both the Google and Apple stores

[direct-discord]: https://discord.com/login?redirect_to=%2Fchannels%2F420324994703163402%2F964110538986651658
[game-discord]: https://discord.com/invite/WY5NwwjBQz
[game-template]: {{site.github}}/flutter/samples/tree/master/game_template
[game-video]: {{site.youtube-site}}/watch?v=zGgeBNiRy-8&t=3s

## Video games

Perhaps you want to write a video-style game?
The game template is still valuable for
the high-level structure of such games.

For video games, you might want to look into the
[Flame package][flame-package],
join the [Flame community on Discord][flame-discord],
and play with the [Flame demo app on DartPad][flame-demo].

In fact, the people at Very Good Ventures wrote a
[Pinball game][pinball-game] for Google I/O 2022 using the Flame engine.
For more information, check out
[I/O Pinball Powered by Flutter and Firebase][],
a free article on Medium and [play the game][pinball-game].

{% comment %}
Some examples of successful mobile videogames
built with Flutter and Flame include 
[Tomb Toad][] and [Air Hockey][].
{% endcomment %}

[Air Hockey]: https://play.google.com/store/apps/details?id=com.ignacemaes.airhockey
[flame-demo]: https://dartpad.dev/?id=3e52ca7b51ba15f989ad880b8b3314a2
[flame-discord]: https://discord.gg/5unKpdQD78
[flame-package]: {{site.pub}}/packages/flame
[I/O Pinball Powered by Flutter and Firebase]: {{site.medium}}/flutter/di-o-pinball-powered-by-flutter-and-firebase-d22423f3f5d
[pinball-game]: https://pinball.flutter.dev/#/
[Tomb Toad]: https://play.google.com/store/apps/details?id=com.crescentmoongames.tombtoad

## Other resources

Once you feel ready to go beyond the games template,
you might want to investigate other resources
recommended by the community.
Bolded items in the following table are used in the games template:

<table class="table table-striped" markdown="1">
<tr markdown="1">
  <th>Feature
  </th>
  <th>Resources
  </th>
</tr>
<tr>
  <td>Animations & sprites
  </td>
  <td><a href="{{site.url}}/cookbook/effects">Special effects recipes (including animations)</a><br>
      <a href="{{site.pub-pkg}}/rive">rive</a> package<br>
      <a href="https://store.steampowered.com/app/332360/Spriter_Pro/">Spriter Pro</a> tool<br>
      <a href="{{site.pub-pkg}}/spritewidget">spriteWidget</a> package
  </td>
</tr>
<tr>
  <td>App review
  </td>
  <td><a href="{{site.pub-pkg}}/app_review">app_review</a> package
  </td>
</tr>
<tr>
  <td>Audio
  </td>
  <td><b><a href="{{site.pub-pkg}}/audioplayers">audioplayers</a> package</b>
  </td>
</tr>
<tr>
  <td>Firebase
  </td>
  <td><a href="https://firebase.google.com/docs/flutter/setup">Flutter Firebase getting started guide</a> NEWLY UPDATED<br>
      <b><a href="{{site.pub-pkg}}/firebase_crashlytics">firebase_crashlytics</a>
      package (tracks crashes of your app)</b>
  </td>
</tr>
<tr>
  <td>Game engines
  </td>
  <td><a href="https://docs.flame-engine.org">Flame</a> engine<br>
      <a href="https://bonfire-engine.github.io/#/">Bonfire</a> engine<br>
      <a href="{{site.pub-pkg}}/forge2d">forge2d</a> package
  </td>
</tr>
<tr>
  <td>Games services
  </td>
  <td><b><a href="{{site.pub-pkg}}/games_services">games_services</a> package</b>
  </td>
</tr>
<tr>
  <td>Images and icons
  </td>
  <td><a href="https://craftpix.net/">CraftPix</a> (free and purchasable assets)<br>
      <a href="https://www.gamedeveloperstudio.com/">Game Developer Studio</a> (purchasable asset packs)<br>
      <a href="https://www.gimp.org/">GIMP</a> (a free image editor to create your own assets)
  </td>
</tr>
<tr>
  <td>Persistence
  </td>
  <td><b><a href="{{site.pub-pkg}}/shared_preferences">shared_preferences</a> package</b><br>
      <a href="{{site.pub-pkg}}/sqflite">sqflite</a> package<br>
      Couchbase Lite, <a href="{{site.pub-pkg}}/cbl_flutter">cbl_flutter</a> package
  </td>
</tr>
<tr>
  <td>Special effects
  </td>
  <td><a href="{{site.api}}/flutter/dart-ui/Paint-class.html">Paint API docs</a><br>
      <a href="{{site.url}}/cookbook/effects">Special effects recipes</a>
  </td>
</tr>
<tr>
  <td>Win 32
  </td>
  <td><a href="{{site.pub-pkg}}/win32_gamepad">win32_gamepad</a>
      package (supports win32 gamepad)
  </td>
</tr>
</table>
