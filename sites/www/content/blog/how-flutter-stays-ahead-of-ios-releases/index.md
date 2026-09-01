---
title: "How Flutter stays ahead of iOS releases"
description: >-
  Learn how the Flutter team navigates WWDC, beta releases,
  and proactive engineering to deliver Day 0 iOS support.
publishDate: 2026-08-25
author:
  - craiglabenz
  - louisehsu
image: images/banner
category: deep-dive
layout: blog
---

<DashImage figure src="images/banner.jpg" alt="Dash watching WWDC 2026" caption="Dash watching WWDC 2026"/>

As a Flutter developer, your relationship with each of Flutter's six primary
supported platforms can vary (to say nothing of the extended universe platforms,
like webOS). For the platform running the phone in your pocket,
you might tune in to release events and get excited about each announcement.
For other platforms,
you might only cross your fingers and hope that annual changes won't disrupt
your ability to run `flutter build [platform]` and release your app.
Luckily, no matter who you are,
you benefit from a band of platform-focused developers on the Flutter team
whose job is to make sense of each announcement and deprecation so you don't have
to.

Each platform-specific sub-team's workflow is tailored to how that platform
evolves and, in Apple's case, that tends to orbit a single week in June
when the eyes of the tech world turn to Cupertino, California.

## Apple's flagship event, WWDC

Every June, Apple hosts an event called WWDC to preview how their software will
evolve in the coming year.
This is typically separate from hardware announcements,
which trickle out during the rest of the year.
At WWDC, Apple's many operating systems (iOS, macOS, watchOS, and more)
are the main characters.

If you've ever tuned in to WWDC,
then you know its general post-COVID format: first, the keynote,
then, the "Platform State of the Union",
and lastly, a massive release of topical videos.
In 2026, WWDC included over 145 technical sessions helping Apple's community
of developers understand what to expect—an incredible resource, to be sure,
but also far too much content to manually sift through.

You already know where this is going.
We don't even have to write the following sentence for you to know it's true,
but we will anyway:

_In 2026, the Flutter team began using AI to categorize each technical session._

Beginning this year,
a small piece of Dart code first extracted transcripts from each video.
Then, Gemini ranked and categorized each session based on the following rubric:

1.  Importance to Flutter contributors (inside and outside of Google)
1.  Area of impact
1.  Recommended actions

Instead of having to watch 145 (admittedly very high quality) technical
sessions, by sundown on the day the videos were released,
we had a Gemini-produced triage document with early signal on every session.
For example, our system recognized that we could largely ignore a SwiftData
session because Flutter handles persistence differently.
Separately, it flagged a "Modernize your UIKit app" talk as critical [1]
for the Flutter Engine team because it described mandatory changes
to the `UIScene` [2] lifecycle API.

> [1] To see everything important for Flutter,
we do physically pop some popcorn and watch each session that Gemini flags
in this way.  
> [2] More on the `UIScene` API later!

By sun-up the next morning,
Flutter's iOS team was officially in its crunch period.
Three months separate WWDC in June from the eventual stable releases in
September, so it's a race against the clock filled with sprints and bug bashes
to ensure timely compliance.
It's a lot of work, but the Flutter team is committed to always delivering Day 0
support for every major iOS release. To follow our progress on supporting iOS
27, [check out its project on GitHub][github-project].

That system of Dart code and Gemini workflows processes all of WWDC,
which accounts for the vast majority of changes from Apple.
However, "vast majority" and "entirety" are different things;
and sometimes, a critical breaking change comes from something as innocuous
as a minor patch's release notes.

## The beta releases heard 'round the Flutter team

The year was 2024 and the iOS 18.2 developer beta had just arrived
with a slew of updates around, amongst other things,
gesture and pointer event handling.
Days later, we received an alarming bug report:
after clicking on a widget above a webview,
no ensuing gestures or clicks to the underlying webview would trigger `onClick`
events.

This wasn't just bad. No, this was a Code Red, five alarm fire—because ads
depend on webviews, and depriving developers of even a single dollar of revenue
is absolutely a non-starter.

The root cause of the bug was originally opaque,
but in time-honored, tech-debugging tradition,
a member of the team thought to try _turning it off and back on again_,
so to speak.
We discovered that swapping out one of the gesture recognizers
in the webview stack on every click solved the problem.
No one was terribly happy with the solution,
but it was a solution, and an invisible one to end-users at that.

Fast forward to August 2025 and the iOS 26 beta,
and seemingly unrelated changes clashed with our gesture recognizer toggling
trick which caused a more serious regression where Flutter's touch
and gesture blocking system completely failed.
With no other options, we reverted the previous workaround…
_and were immediately reacquainted with the unresponsive webview bug_.

Investigations into the anomaly from Flutter's end proved fruitless,
so we had to simplify things.
The team created a test project in pure Swift.
With no Flutter, no Dart, just a standard UIKit parent view,
a native gesture recognizer, and a standalone webview,
we saw the same faulty behavior.

This was a huge win!
With a clean reproduction,
we sent our bug report and a recommended fix to Apple,
who wasted little time identifying and patching the issue.
By iOS 26.4, webview clicks were back to behaving how you would expect,
whether or not the project used Flutter.

### Multiple fixes from multiple directions

Complementing this happy ending was the fact that, at the same time,
the Flutter team was busy
[migrating all of our Dart code off of a separate "UI thread" and back on to the main "platform thread"][platform-thread-migration]
(as Flutter calls them).
This meant that Dart code could synchronously talk to platform code,
like Swift and Objective-C for iOS,
which opened the door to other modernizations,
such as introducing a synchronous system for hit testing.
These refactors further improved gesture behavior on iOS
by removing microtask delays and other sources of chaos.

Combined, these changes delivered major stability improvements
for both Flutter apps running on iOS _and_ native iOS apps.

## Sometimes we're even proactive, too

WWDC announcements and bug reports are definitionally reactive maneuvers,
but sometimes the Flutter team is actually ahead of the game.
In the spring of 2025, Apple released iOS 18.4,
which produced the following warning in Flutter apps:

> CLIENT OF UIKIT REQUIRES UPDATE: This process does not adopt UIScene
> lifecycle. This will become an assert in a future version.

"A future version" is ambiguous,
but the Flutter team wasn't about to procrastinate with your apps,
so we dove in ahead of schedule.
Unfortunately, the implied change would prove to be a big one.

To understand why,
one must consider how much the mobile landscape has changed
since Flutter's inception in 2014.
Once upon a time, Flutter was iOS and Android only,
filled those screens completely, and enjoyed stable window sizes.
Now, in 2026, Flutter runs on other platforms, can have multiple windows,
is embedded into non-Flutter apps,
and can have its geometry folded in half at a moment's notice.
These changes complicated once simple questions like "How big is the window?",
"Is the app backgrounded?", and also complicated the adoption of `UIScene`!

Then, in 2025's WWDC,
an individual technical session included the following all-important sentence:

> In the release following iOS 26, any `UIKit` app built with the latest SDK
> will be required to use the `UIScene` life cycle, otherwise it will not
> launch.

_Thank goodness our intake and our (then manual) triage process flagged that
session!_

We spent Q3 of 2025 designing and implementing,
and were ultimately already beta testing our `UIScene` implementation by Q4.
An experimental flag unlocked it for adventurous Flutter developers,
and we owe a huge thank you to everyone who kicked the tires
because you collectively helped us find critical edge cases,
timing issues, and other quirks.

By January of 2026,
we shifted our focus to helping the ecosystem update iOS plugins,
as their adoption was also required for app health.
After migrating every plugin we directly maintain,
we began filing issues against community plugins.
Thankfully, plugin authors from around the world were highly responsive
and we enjoyed a tremendous amount of buy-in and team spirit in getting
everything updated!

### Shipping the feature

Full support for Apple's `UIScene` API landed in Flutter's 3.41 stable release
in February of 2026.
And if you've never heard of `UIScene` and basically don't know what we're
talking about—good!
Our definition of success was that most Flutter developers would run
`flutter upgrade`, resume writing Dart code, and never have to think about this.
(Some advanced users, like those with add-to-app scenarios,
did have a short-but-manual migration guide to follow.)

This proactive work paid _huge_ dividends,
because Apple turned that warning into an assert in the iOS 27 beta
just as they said they would.
But, thanks to our early efforts,
Flutter was ready for iOS 27 months before it was even announced.

## We sweat in the desert; you get sweet desserts

The Flutter team's goal remains the same as ever:
to figure out the annoying parts of app development
so you can focus on the fun parts: building features, making users happy,
and shipping great releases.
Whether it's iOS, Android, or any of the other many platforms where Flutter
apps run, we want your build targets to remain just another implementation
detail en route to creating great experiences that delight your users.

For more information on Flutter,
check out [the video version of this blog post][video-version],
our [docs][], [YouTube channel][], or find us on socials.
Until then, we can't wait to see what you build!

[docs]: https://docs.flutter.dev
[platform-thread-migration]: https://www.youtube.com/watch?v=miW7vCmQwnw
[video-version]: https://www.youtube.com/watch?v=vFYxYjepaK8
[YouTube channel]: https://youtube.com/flutterdev
[github-project]: https://github.com/orgs/flutter/projects/212/views/1?sliceBy%5Bvalue%5D=27
