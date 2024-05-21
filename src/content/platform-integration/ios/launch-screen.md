---
title: Adding a launch screen to your iOS app
short-title: Launch screen
description: Learn how to add a launch screen to your iOS app.
toc: false
---

{% comment %}
Consider introducing an image here similar to the android splash-screen one:
https://github.com/flutter/website/issues/8357
{% endcomment -%}

[Launch screens][] provide a simple initial experience while your iOS app loads.
They set the stage for your application, while allowing time for the app engine
to load and your app to initialize.

[Launch screens]: {{site.apple-dev}}/design/human-interface-guidelines/launching#Launch-screens

All apps submitted to the Apple App Store
[must provide a launch screen][apple-requirement]
with an Xcode storyboard.

## Customize the launch screen

The default Flutter template includes an Xcode
storyboard named `LaunchScreen.storyboard`
that can be customized with your own assets.
By default, the storyboard displays a blank image,
but you can change this. To do so,
open the Flutter app's Xcode project
by typing `open ios/Runner.xcworkspace`
from the root of your app directory.
Then select `Runner/Assets.xcassets`
from the Project Navigator and
drop in the desired images to the `LaunchImage` image set.

Apple provides detailed guidance for launch screens as
part of the [Human Interface Guidelines][].

[apple-requirement]: {{site.apple-dev}}/documentation/xcode/specifying-your-apps-launch-screen
[Human Interface Guidelines]: {{site.apple-dev}}/design/human-interface-guidelines/patterns/launching#launch-screens
