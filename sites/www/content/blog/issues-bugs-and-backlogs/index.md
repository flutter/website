---
title: "Issues, Bugs, and Backlogs"
description: >-
  Managing feedback in a large open source project like Flutter
publishDate: 2019-11-25
author: kf6gpe
image: images/1D_MCtnl2h_spFgoORikDcA.webp
category: engineering
layout: blog
---

The growth of Flutter as a community-driven open source project is an ongoing source of delight to us here at Google. Whether measured in [popularity on GitHub](https://twitter.com/timsneath/status/1189594253690691584), number of [projects created](https://www.reddit.com/r/FlutterDev/comments/dsnzbq/githubs_2019_octoverse_report_is_out_flutter_is/), or [skills growth](https://adtmag.com/articles/2019/03/29/linkedin-skills.aspx), 2019 has been a defining year for the project, and we’re ever thankful to you all for your support and contributions to make Flutter the project it is. We build Flutter with you and for you, and we hope that comes across in everything we do.

As we’ve grown, the number of issues we need to track grows, too! We use issues on GitHub in a variety of ways: not just to report bugs, but any unit of work pertaining to the project. Anyone can submit an issue, and these issues fall into a number of categories:

* Feature requests: things a user or a contributor wish that Flutter could do, or do better.

* Support issues: questions from users as to how Flutter works or how to do things. While these are better asked on Stack Overflow, many point to ways that we could improve our documentation, too.

* Bona fide defects: things that don’t work as they should. This includes serious issues like crashes and performance regressions, but also those pesky fit-and-finish bugs that are common in any large software system.

* Untriaged items that haven’t been examined and labeled.

Thus, our issues aren’t just a collection of defects; they’re our backlog. Anything we think of that we may want to work on should be represented as an issue, appropriately labeled, so that as we plan our goals and milestones we have a place from which to start.

Some projects use the number of open bugs as a proxy for gauging release quality, and classify bugs as either defects or issues. [Flutter doesn’t do this; we choose to track bugs and issues the same way, in GitHub, keeping everything in the open](https://github.com/flutter/flutter/wiki/Issue-hygiene#issue-philosophy). As a result, there will always be far more things that we *could* be working on than we actually *are* working on. This is true for many healthy open-source projects; one need only look at others that have been around for a while such as [Tensorflow](https://github.com/tensorflow/tensorflow/issues), [Chrome](https://bugs.chromium.org/p/chromium/issues/list), [Dart](https://github.com/dart-lang/sdk/issues), [Go](https://github.com/golang/go/issues), or [VSCode](https://github.com/Microsoft/vscode/issues).

Nonetheless, we want to be sure that our incoming issues are well-labeled and do the necessary gardening work so that our issue database is an accurate reflection of our product status. To this end, we’ve engaged with the community: there are a number of volunteers helping us with our front-line triage, and we’re [pleased to announce that we’ve partnered with Nevercode](https://blog.codemagic.io/flutter-and-codemagic-join-forces-on-github/), the providers of [Codemagic](https://codemagic.io/), a leading CI/CD system for Flutter, to help us with our front-line triage as well.

## The Lifecycle of an Issue

We welcome new issue submissions! Our issue triage process is described in [Guidelines for triage](https://github.com/flutter/flutter/wiki/Triage). Here’s how it works in practice:

An issue starts with you: a user of Flutter, or an open-source contributor. Once you file it (hopefully with a reproducible case if it’s a bug, or a clear outline of what you’re proposing and why, if it’s a feature request), it goes to *front-line triage*.

In front-line triage, a community participant — perhaps a volunteer, perhaps someone at Nevercode, or an engineer working on Flutter — examines the issue you’ve filed, and asks several questions:

* Is it clearly defined?

* If a bug, does it have a reproducible case and enough to go on?

* If a feature enhancement, do we understand enough about what you’re asking for so that we can gauge its contribution to the platform?

* Does it duplicate a previously filed issue?

As we do this, our front-line triage applies as many labels to the issue as we can. We use these labels in lots of ways, such as to establish relative priority, determine how to route an issue to a particular team, and whether to include the issue in an upcoming milestone. We use both GitHub queries and some custom tools to mine the issues for signals as to what the community is looking for and why.

From there, it goes to *secondary triage*, where an assigned team looks at the issue, and asks questions such as how the issue fits with the current work that they’re doing, and when they can schedule the work for completion. Again, more labels may be added or changed, as the labels provide us with the best possible snapshots as to the work we want to do and who can do the work.

Eventually, an engineer offers to work on the issue. Unlike many software projects, we generally don’t assign issues to contributors: whether a contributor works for Google or not, contributors offer to tackle issues, rather than get assigned issues from the backlog. By letting developers offer, we distribute load-balancing down to individual contributors; each contributor self-assigns only the issues they’re actively working on, and gives milestones to those issues so that we know when they’ll land on the master branch. Leads may ask particular people to work on issues, of course, but most of the time it’s just that: a request for help, not an ultimatum or an assignment.

Once an issue has been completed to our satisfaction, it is closed. Often this includes a link to the pull request addressing the issue, but there are other reasons we close issues, including:

* Is this a request for support? We direct the reporter to a support channel such as the [flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com) mailing list, the [r/FlutterDev](https://reddit.com/r/flutterdev) Reddit, our Discord communities ([user chat](https://discordapp.com/invite/N7Yshp4), [community chat](https://github.com/flutter/flutter/wiki/Chat) used primarily by contributors), or [Stack Overflow](https://stackoverflow.com/tags/flutter).

* Is this a duplicate issue? Before closing, we link to the original issue, which also updates the original issue.

* Does the issue have enough information to reproduce, and have we been able to reproduce it? If not, odds are that we can’t do anything and will close the issue.

## Our Progress Thus Far

As you can imagine, as our popularity has grown, so has the number of opened and closed issues for [github.com/flutter/flutter](https://github.com/flutter/flutter) (this contains all issues except those for the web site, which are logged at [github.com/flutter/website](https://github.com/flutter/website)):

<DashImage figure src="images/1D_MCtnl2h_spFgoORikDcA.webp" alt="Closed vs. open bugs for month-ends since Jan-2018" caption="Closed vs. open bugs for month-ends since Jan-2018" />

Equally exciting is the number of issues *not* bearing a label corresponding to one of our secondary triage teams, such as [framework](https://github.com/flutter/flutter/labels/framework), [engine](https://github.com/flutter/flutter/labels/engine), or [plugin](https://github.com/flutter/flutter/labels/plugin):

<DashImage figure src="images/19ZXPKWTBT01b_6zsFtundg.webp" alt="Issues not labeled for secondary triage, Mar-2019-present" caption="Issues not labeled for secondary triage, Mar-2019-present" />

You can clearly see where we started to engage Nevercode in our triage process, first in early September, with great progress by mid-September as they got up to speed.

This emphasis on triage reflects our goal: not to have zero *open* issues, but to have zero *unlabeled* issues to provide adequate signals from our community, so that we can best prioritize our work. As Flutter continues to grow in popularity, we expect to see continued growth in the number of open issues that require triage, many of which will be requests for new features from the community. We’ll continue to use labels to help us determine which are bugs that require immediate attention, which are bugs we can defer to our next beta or stable release, and which are new feature requests.

## How You Can Help

You can help keep our issue database clean and tidy with actionable issues. When filing an issue, please consider the following :

* Don’t use GitHub for support. As part of our issue triage, we’re now closing requests for support that come up in GitHub, redirecting folks to better channels. In those channels you’ll likely find someone able to answer your question, and the questions and answers are easier for other users to find as well.

* Help with reproducible cases: if it’s your own issue, make sure you have one. Even if it’s not your issue, we’ll gladly take reproducible cases from you, too! Writing reproducible cases for bugs is a great way to start learning how to use Flutter with real-world examples.

* Update and upvote issues that are important to you.

* Contribute test cases to the Flutter repository. This is another way to get your feet wet using Flutter and join the community. It also helps us prevent regressions: while all new code is accompanied by test cases, we strive to increase our test coverage as a matter of good practice. If you’re interested in contributing in this way, you can take a look at issues with the [a: tests](https://github.com/flutter/flutter/labels/a%3A%20tests) label.

* Consider helping us triage issues that others have filed.

We’re deeply appreciative of the support and trust you’ve given us in investing your time and application ideas with Flutter. We welcome community involvement, whether it be filing a bug or feature you’d like to see addressed, or creating a pull request to make Flutter the platform you want to work with. Thank you!
