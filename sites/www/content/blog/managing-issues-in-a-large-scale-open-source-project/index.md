---
title: "Managing issues in a large-scale open source project"
description: "How the Flutter team addresses its issue backlog"
publishDate: 2020-07-17
author: kf6gpe
image: images/0E-lTv57-czvPhZre.webp
category: engineering
layout: blog
---

We’re honored by the amount of positive feedback we get from folks using Flutter. As one of the largest active repositories on GitHub, we have a relatively unique challenge and we thought you might find it interesting to learn our philosophy and approach to how we’re dealing with issues at this scale, what changes we’re making to deal with the project growth, and some helpful tips for filing issues to maximize their value.

Sometimes developers attempt to use the total number of public logged issues as a measure of the overall quality of the project. We think this number is poorly correlated with project health, and want to explain why, counter to expectation, a larger number of issues can be a signal of a high-quality, popular project.

Lastly, we want to use this blog post to share some concrete changes we’ve made in recent months: more active scrubbing of our backlog, accomplishing (and holding to) zero-bug-bounce for unassigned issues, and a new prioritization scheme that better aligns with how we believe our customers think about priorities.

## How Flutter uses GitHub

It’s common in today’s software development world for teams to keep a backlog of issues submitted both by team members and users: this backlog is the sum total of bugs, feature requests, and technical debt facing the team. Flutter is no different: we use GitHub as our backlog. If it’s a bug, an idea for a new feature, or something in between, it’s filed as an issue in our issue database [on GitHub](https://github.com/flutter/flutter/issues).

Each of these issues starts with you, or one of Flutter’s contributors. Contributors and users file issues about Flutter or Flutter’s API documentation in the [flutter/flutter issue tracker](https://github.com/flutter/flutter/issues), and issues about Flutter’s website ([flutter.dev](https://flutter.dev)) in the [flutter/website issue tracker](https://github.com/flutter/website/issues).

There are three special considerations about how we manage issues on GitHub, which contributes to a large overall number:

1. The issue repository is completely open. The core engineering and product teams, along with the entire Flutter community, files all feature enhancements, bugs, and potential future work into the open repository.

1. We don’t aggressively close issues, even if we don’t plan to work on them in the immediate future; we want to keep the total backlog of possible work open, so that any future contributor can work on a feature they’re interested in and see the discussion that’s already transpired.

1. We use one repository for *all* issues except for those involving the developer toolchain and website. Issues with Android, iOS, Windows, web, macOS, and Linux; framework and engine; API documentation and plugins, are all logged in the same [flutter/flutter](https://github.com/flutter/flutter) repository.

## Flutter’s triage process

The [flutter/flutter](https://github.com/flutter/flutter) issues are triaged by a member of the team: perhaps a volunteer, or one of the folks at [Nevercode](https://blog.codemagic.io/flutter-and-codemagic-join-forces-on-github/) who have been helping us with triage, or by a Google employee (or an employee of another company). In triage, we assign as many labels to the issue as we can.

Some labels direct the issue for secondary triage. For example, the [engine](https://github.com/flutter/flutter/labels/engine) label directs the issue to the engine team for secondary triage. Other labels indicate additional attributes, such as whether the issue is a feature request or a possible enhancement to increase the team’s velocity (as I write this, there are [over 500 issues with that label](https://github.com/flutter/flutter/labels/team)).

Between primary and secondary triage, we also assign a priority label for issues filed against the code base or API documentation. Similar to other bug trackers, we use a ranked priority scheme, with priorities ranging from P0 to P6:

* The [P0](https://github.com/flutter/flutter/labels/P0) label indicates top-priority issues such as build breaks or severe performance regressions that must be addressed immediately.

* The [P1](https://github.com/flutter/flutter/labels/P1) label indicates that the issue requires timely attention, such as breakage in a major feature used by the majority of our users, or an issue blocking a strategic partner. We aim to fix or remediate P1 bugs within the current milestone.

* The [P2](https://github.com/flutter/flutter/labels/P2) label indicates major features or issues that affect a significant subset of our users. Like P1 issues, we aim to fix or remediate these within the current milestone.

* The [P3](https://github.com/flutter/flutter/labels/P3) label indicates an issue currently on our timeline for an upcoming release that is at the top of our work list. Many issues we are actively working on bear this label, and most should have a milestone indicating when we think they’ll land.

* The [P4](https://github.com/flutter/flutter/labels/P4) label indicates issues that we agree are important to work on, but not at the top of the work list. This is the default level for bugs.

* The [P5](https://github.com/flutter/flutter/labels/P5) label indicates issues we think are valid but not critical. This is the default level for new feature requests.

* The [P6](https://github.com/flutter/flutter/labels/P6) label indicates valid issues that are unlikely to ever be worked on, but kept open in the event that a contributor might want to tackle it.

This schema is relatively new, replacing our three-axis system of committed milestones, `customer:` and `severe:` labels. In the process of establishing it, we auto-prioritized a large number of issues based on committed milestones and other labels.

## Measuring quality by bug count

Because Flutter uses GitHub as a fully open issue tracker, with both bugs and feature requests, there’s no direct correlation between issue counts and product quality. Other open source projects, such as [Chromium](https://bugs.chromium.org/p/chromium/issues/list) and [TensorFlow](https://github.com/tensorflow/tensorflow/issues), also developed fully in the open, have large issue counts as well. If anything, the large number of issues suggests that the project is active and vibrant as users engage in the product finding both bugs and things they’d like to improve.

It’s difficult to make apples-to-apples comparisons, though. Some projects proactively close open issues they’re not going to address; others keep their issue database in secret, and others use different projects for different kinds of issues. As already noted, we track feature enhancements and bugs in the same repository; we also use one repository across tools, Android, iOS, first-party plugins, and so forth.

A better metric to gauge the health of an open-source project is to look at the number of issues closed vs. the number of issues currently open. As of this writing (early July 2020), we have 7,757 issues open and 32,485 issues closed. The rate of closure has increased over the last year, although has flattened somewhat in recent months:

<DashImage figure src="images/0E-lTv57-czvPhZre.webp" />


The dip in December is due to the holiday season; many contributors at Google and elsewhere take a vacation in that month. Regardless, the year-over-year average is 1314 issues closed, and if you look at the six-month average, you see that it’s considerably higher, at 1604 issues closed every month.

## Understanding our open issues

To get a better understanding of the kinds of issues we face, the Flutter leads recently took a random sample of 1,200 open issues and retriaged them. In the process, we learned the following:

* 32% of the issues filed came from core contributors on the project. Many of these are future work items, such as features, ways to improve the product, or improvements to our team’s tooling and infrastructure that would increase our own developer velocity.

* The average Flutter contributor filed 7.4 bugs, while the average user of Flutter who had filed any bugs had filed 1.2 bugs.

* Of the issues we examined, some 25% were either support requests, clearly unactionable, or otherwise no longer valid (i.e., subsequent work fixed the issue or new product directions made the concern of the issue obsolete), which we were able to close.

We’re continuing to work with Nevercode on grooming our backlog, both with recently filed issues and older issues. They have been very helpful in several ways:

* They actively create reproducible code for issues, helping other engineers look for ways to fix bona fide bugs in Flutter.

* They deduplicate bugs, closing duplicates after crosslinking them.

* They close non-reproducible bugs, as well as requests for support (which should be directed to one of the channels listed at [https://www.flutter.dev/community](https://www.flutter.dev/community)).

* They request additional information for unclear issues, closing those that are unactionable.

* As time permits, they help us cull our backlog of old issues, answering the same questions: Is it still an issue? Does it have a reproducible case? Is it a duplicate?

Together, we’ve learned some interesting things about the issues people file: Over the last two months, fully 55% of the issues filed don’t meet our criteria — they’re either requests for support or don’t have reproducible cases.

For older issues, the Nevercode team has found that fewer issues were invalid or duplicated, likely explained by survivorship bias (issues that survive previous triages are likely not invalid or duplicate issues). Nonetheless, in their sample, 18% of the issues were invalid (either support requests or unactionable), and another 15% were duplicates. The lion’s share — up to 50% — reflects issues that have been subsequently addressed, suggesting that we can do a better job closing old issues as we add functionality and fix bugs.

## Issue prioritization

As of this writing (early July 2020), here’s the breakdown of P0-P2 issues:

<DashImage figure src="images/0aO0bWR8VrmusQNRi.webp" />


This chart shows a healthy number of issues that we’re actually working on with urgency. As you’d expect from a popular open-source project, there are a *lot* of other pieces of feedback in our issue database: here’s the breakdown of P3-P6 issues:

<DashImage figure src="images/0shcSGNkownGkrpoM.webp" />


The team is actively working on many of the P3 issues, as well as the higher-priority P0-P2 issues.

We still have a historical backlog of triaged unprioritized issues. Of these, we believe that most will likely fall into the P5 or P6 category, because as part of Nevercode’s triage efforts, they’ve escalated those that deserve immediate attention.

Just because an issue makes it to secondary triage does not mean that the core engineering team has bandwidth to work on it. In secondary triage, we look at several things to determine what to do with an issue, including:

* What other work have we committed to?

* How severe an issue is this?

* How many people does it affect?

* Is this issue for a specific customer?

* How does working on this issue affect our roadmap and architecture?

For details on how we accomplish this, you can see our previous blog post on the topic, [“Issues, Bugs, and Backlogs](https://medium.com/flutter/https-medium-com-flutter-issues-bugs-and-backlogs-5fb3adab5e25)”.

## How you can help

The Flutter issue database on GitHub isn’t just the team’s issue database, it’s the issue database for our entire community, so we all need to play a part in its health. Here are some things we can all do to help keep a check on the quality of issues in the database:

* Don’t file an issue for support requests. Support requests should be raised in one of the channels we describe at [https://flutter.dev/community](https://flutter.dev/community). We actively close requests for support raised on GitHub.

* File issues in the appropriate database: Flutter bugs, API documentation bugs, and feature requests in the [flutter/flutter issue tracker](https://github.com/flutter/flutter/issues), and feedback about the Flutter website or codelabs in the [flutter/website issue tracker](https://github.com/flutter/website/issues).

* When filing an issue, search to see if one already exists for the issue you’re having. If so, upvote it and comment if appropriate. The development team uses upvotes as a measure of interest when ranking issues for future work.

* Cross-linking is good! Feel free to crosslink related issues, either when filing new issues or when upvoting an issue you’ve encountered. Like upvoting, the team uses crosslinks in their investigations, and there’s a good chance that you see a relationship that others have missed.

* Make sure that your bug contains everything the team needs to reproduce it. A minimally reproducible case is crucial for the team to be able to quickly get to the root of a bug. Explaining why a feature is important makes it more likely that the team will prioritize the work quickly.

* Consider helping the triage effort. See a bug you have time to reproduce? Try reproducing it on the latest stable and master, and let us know if it’s still a problem. See a related issue? Crosslink it. Want to write some code? Submit a PR with a unit test exhibiting the issue, or better yet, a unit test with a fix for the issue. We welcome help on managing issues, so if you’d like to help, see our [contributing guide](https://github.com/flutter/flutter/blob/master/CONTRIBUTING.md) for detailed information on how you can join us in the triage process.

Speaking for those working on Flutter, we’re in awe of the support you continue to give us in our vision to build ways to bring beautiful, performant applications to your users. Thanks so much for all that you do!