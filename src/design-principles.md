---
layout: page
title: Flutter's Development Philosophy

permalink: /design-principles/
---

* TOC Placeholder
{:toc}

Introduction
------------

Flutter is written based on some core principles that were mostly
intuited from past experiences with other platforms such as the Web
and Android, some of which are summarised below.

This document is most useful if you want to contribute to Flutter, as
then we hope you will also follow these philosophies. Please also read
our
[style guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
for more specific guidelines regarding writing Dart code for Flutter.


Code review and checking in code
--------------------------------

Every PR must be code-reviewed before check-in, including things like
rolling a dependency. Getting a review means that a regular Flutter
contributor (someone with commit access) has written a comment saying
"LGTM" on your PR, and you have addressed all their feedback. ("LGTM"
means "Looks Good To Me".)

Code review serves many critical purposes. There's the obvious
purpose: catching errors. Even the most experienced engineers
frequently make errors that are caught by code review. But there are
also many other benefits of code reviews:

 * It spreads knowledge among the team. Since every line of code will
   have been read by two people, it's more likely that once you move
   on, someone else will understand the code.

 * It keeps you honest. Knowing that someone will be reading your
   code, you are less tempted to cut corners and more motivated to
   write code you are proud of.

 * It exposes you to different modes of thinking. Your code reviewer
   has probably not thought about the problem in the same way you
   have, and so may have a fresh perspective and may find you a better
   way to solve the problem.

We recommend you consider
[these suggestions](https://testing.googleblog.com/2017/06/code-health-too-many-comments-on-your.html)
for addressing code review comments on your PR.

If you're working on a big patch, don't hesitate to get reviews early,
before you're ready to check code in. Also, don't hesitate to ask for
multiple people to review your code, and don't hesitate to provide unsolicited
comments on other people's PRs. The more reviews the better.

Reviewers should carefully read the code and make sure they understand
it. A reviewer should check the code for both high level concerns,
such as whether the code's structure makes sense, as well as
readability and adherence to the [Flutter style guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo).
Use [these best practices](https://mtlynch.io/human-code-reviews-1/)
when reviewing code and providing comments.

Reviewers should not give an LGTM unless the patch has tests that verify
all the affected code, or unless a test would make no sense. If you
review a patch, you are sharing the responsibility for the patch with
its author. You should only give an LGTM if you would feel confident
answering questions about the code.

A reviewer may in some circumstances consider the code satisfactory
without having fully reviewed or understood it. If a reviewer has not
fully reviewed the code, they admit to this by saying "RSLGTM" rather
than just "LGTM". If you feel your code needs a real review, please
find someone to actually review it. ("RSLGTM" means "Rubber Stamp
Looks Good To Me".) If you mark a patch as RSLGTM, you are still
sharing the responsibility for the patch with its author. Reviewing a
patch as RSLGTM should be a rare event.

If you really need to check something in in a hurry, for example
because everything is broken and you can fix it, then pick someone on
the team who you want to have review the code, and then mark the PR as
"TBR" with their name. ("TBR" means "To Be Reviewed".) This is only to
be used in emergencies. (Nobody being around to review your 50,000
line patch at midnight on December 31st is not an emergency!) If
someone marks a patch as TBR and gives your name as the reviewer, you
should review the patch as soon as possible. If a reviewer finds
problems with a patch marked TBR, the issues should be fixed as soon
as possible.

Wait for Cirrus to give the green light before merging a PR. Cirrus
runs a bunch of precommit checks (see the tests for the
[framework](https://github.com/flutter/flutter/blob/master/dev/bots/test.dart),
the [engine](https://github.com/flutter/engine/blob/master/ci/build.sh),
and the website).
These checks include checks on comments, so make sure you wait for the
green light even if your patch is _obviously_ fine!

For the engine repository, Travis
does not actually _build_ the engine, so you should make sure to do
that locally first too before checking anything in.

Make sure all the trees and dashboards are green before checking in:
the [infra waterfall](https://build.chromium.org/p/client.flutter/waterfall),
our [Cirrus dashboard](https://cirrus-ci.com/github/flutter/flutter/master),
our [test dashboard](https://flutter-dashboard.appspot.com/build.html), and
our [benchmarks dashboard](https://flutter-dashboard.appspot.com/benchmarks.html) (Google-only, sorry).

**If the trees or dashboards are showing any regressions, only fixes
that improve the situation are allowed to go in.**


Handling breaking changes
-------------------------

We're attempting to stablize the APIs for the
[packages in the SDK](https://github.com/flutter/flutter/tree/master/packages).
To make a change that will require developers to change their code:

 1. File an issue or create a pull request with the `prod: API break`
    label.

 2. Send an e-mail to <mailto:flutter-announce@googlegroups.com> to socialize
    your proposed change. The purpose of this e-mail is to see if you can
    get consensus around your change. **You are not telling people that
    the change will happen, you are asking them for permission.**
    The e-mail should include the following:

    - A subject line that clearly summarises the proposed change and sounds like it
      matters (so that people can spot these e-mails among the noise). Prefix
      the subject line with `[Breaking Change]`.

    - A summary of each change you propose.

    - A brief justification for the change.

    - A link to the issue you filed in step 1, and any PRs you may have already
      posted relating to this change.

    - Clear mechanical steps for porting the code from the old form to the new
      form, if possible. If not possible, clear steps for figuring out how to
      port the code.

    - A sincere offer to help port code, which includes the preferred venue for
      contacting the person who made the change.

    - A request that people notify you if this change will be a problem,
      perhaps by discussing the change in the issue tracker on on the pull request.

 3. **If folks agree that the benefits of changing the API outweigh the stablity
    costs**, you can proceed with the normal code review process for making
    changes. You should leave some time between steps 2 and 3 (at a bare minimum
    24 hours during the work week so that people in all time zones have had a
    chance to see it, but ideally a week or so).

 4. If you landed a breaking change, add a bullet point to the top section of
    the [Changelog page on the wiki](https://github.com/flutter/flutter/wiki/Changelog),
    describing your change and
    linking to your e-mail in [the mailing list archives](https://groups.google.com/forum/#!forum/flutter-dev).
    To figure out the correct version heading for the changelog run
    `git fetch upstream && flutter --version`. For example, if it says
    "Flutter 0.0.23-pre.10" in the output your changelog entry should be under
    heading "Changes since 0.0.22".

Where possible, even "breaking" changes should be made in a backwards-compatible way,
for example by introducing a new class and marking the old class `@deprecated`. When
doing this, include a description of how to transition in the deprecation notice, for
example:

<!-- skip -->
```dart
@Deprecated('FooInterface has been deprecated because ...; it is recommended that you transition to the new FooDelegate.')
class FooInterface {
  /// ...
}
```

If you use `@deprecated`, make sure to remember to actually remove the feature a few
weeks later (after the next beta release), do not just leave it forever!


#### Google-only responsibilities

If you work for Google, you have the added responsibility of updating Google's
internal copy of Flutter and fixing any broken call-sites reasonably quickly
after merging the upstream change.

Lazy programming
----------------

Write what you need and no more, but when you write it, do it right.

Avoid implementing features you don't need. You can't design a feature
without knowing what the constraints are. Implementing features "for
completeness" results in unused code that is expensive to maintain,
learn about, document, test, etc.

When you do implement a feature, implement it the right way. Avoid
workarounds. Workarounds merely kick the problem further down the
road, but at a higher cost: someone will have to relearn the problem,
figure out the workaround and how to dismantle it (and all the places
that now use it), _and_ implement the feature. It's much better to
take longer to fix a problem properly, than to be the one who fixes
everything quickly but in a way that will require cleaning up later.

You may hear team members say "embrace the [yak
shave](http://www.catb.org/jargon/html/Y/yak-shaving.html)!". This is
an encouragement to take on the larger effort necessary to perform a
proper fix for a problem rather than just applying a band-aid.


Tests
-----

**Write Tests, Find Bugs**

When you fix a bug, first write a test that fails, then fix the bug
and verify the test passes.

When you implement a new feature, write tests for it.


Documentation
-------------

When working on Flutter, if you find yourself asking a question about
our systems, please place whatever answer you subsequently discover
into the documentation in the same place where you first looked for
the answer.

We try to avoid reliance on "oral tradition". It should be possible
for anyone to begin contributing without having had to learn all the
secrets from existing team members. To that end, all processes should
be documented (typically on the wikis), code should be self-explanatory
or commented, and conventions should be written down, e.g. in our style
guide.

There is one exception: it's better to _not_ document something in our API
docs than to document it poorly. This is because if you don't document it,
it still appears on our list of things to document. Feel free to remove
documentation that violates our
[style guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo),
so as to make it reappear on the list.


API design
----------

We have learned various lessons over the years.

* There should be no objects that represent live state that reflect
  some state from another source, since they are expensive to maintain.
  (The Web's `HTMLCollection` object is an example of such an object.)
  In other words, **keep only one source of truth**, and **don't replicate
  live state**.

* Property getters should be efficient (e.g. just returning a cached
  value, or an O(1) table lookup). If an operation is inefficient, it
  should be a method instead. e.g. `document.getForms()`, not
  `document.forms` (it walks the entire tree).

  - Asynchronous expensive operations can be represented by futures.
    A method can start the work and return a future; a getter can return 
    a future corresponding to already-running work. A getter should not
    kick-off the work and return the future, since getters appear idempotent
    and side-effect free.

* There should be no APIs that require synchronously completing an
  expensive operation (e.g. computing a full app layout outside of the
  layout phase). Expensive work should be asynchronous.

* We use a layered framework design, where each layer addresses a
  narrowly scoped problem and is then used by the next layer to solve
  a bigger problem. This is true both at a high level (widgets relies
  on rendering relies on painting) and at the level of individual
  classes and methods (e.g. in the rendering library, having one class
  for clipping and one class for opacity rather than one class that
  does both at the same time).

  - Convenience APIs belong at the layer above the one they are
    simplifying.

  - Having dedicated APIs for performance reasons is fine. If one
    specific operation, say clipping a rounded rectangle, is expensive
    using the generic API but could be implemented more efficiently
    using a dedicated API, then a dedicated API is fine.

* APIs that encourage bad practices should not exist. e.g., no
  `document.write()`, `innerHTML`, `insertAdjacentHTML()`, etc.

  - String manipulation to generate data or code that will subsequently
    be interpreted or parsed is a bad practice as it leads to code
    injection vulnerabilities.

  - If an operation is expensive, that expense should be represented
    in the API (e.g. by returning a `Future` or a `Stream`).  Avoid
    providing APIs that hide the expense of tasks.

* Convenience APIs that wrap some aspect of a service from one environment
  for exposure in another environment (for example, exposing an Android API
  in Dart), should expose/wrap the complete API, so that there's no cognitive cliff
  when interacting with that service (where you are fine using the exposed
  API up to a point, but beyond that have to learn all about the underlying
  service).

* APIs that wrap underlying services but prevent the underlying API from
  being directly accessed (e.g. how `dart:ui` exposes Skia) should carefully
  expose only the best parts of the underlying API. This may require refactoring
  features so that they are more usable. It may mean avoiding exposing
  convenience features that abstract over expensive operations unless there's a
  distinct performance gain from doing so. A smaller API surface is easier
  to understand.

  - This is why `dart:ui` doesn't expose `Path.fromSVG()`: we checked, and it
    is just as fast to do that work directly in Dart, so there is no benefit
    to exposing it. That way, we avoid the costs (bigger API surfaces are more
    expensive to maintain, document, and test, and put a compatibility burden
    on the underlying API).


Bugs
----

Only assign a bug to yourself when you are actively working on it. If
you're not working on it, leave it unassigned. Don't assign bugs to
people unless you know they are going to work on it. If you find
yourself with bugs assigned that you are not going to be working on in
the very near future, unassign the bug so that other people feel
empowered to work on them.

You may hear team members refer to "licking the cookie". Assigning a
bug to yourself, or otherwise indicating that you will work on it,
tells others on the team to not fix it. If you then don't work on it
straight away, you are acting like someone who has taken a cookie,
licked it to unappetising to other people, and then not eaten it right
away. By extension, "unlicking the cookie" means indicating to the
rest of the team that you are not actually going to work on the bug
right away after all, e.g. by unassigning the bug from yourself.

File bugs for anything that you come across that needs doing. When you
implement something but know it's not complete, file bugs for what you
haven't done. That way, we can keep track of what still needs doing.


Regressions
-----------

If a check-in has caused a regression on the trunk, roll back the
check-in (even if it isn't yours) unless doing so would take longer
than fixing the bug. When the trunk is broken, it slows down everyone
else on the project.

If things are broken, the priority of everyone on the team should be
helping the team fix the problem. Someone should own the issue, and
they can delegate responsibilities to others on the team. Once the
problem is resolved, write a
[post-mortem](https://github.com/flutter/flutter/wiki/Postmortems).
Postmortems are about documenting what went wrong and how to avoid the
problem (and the entire class of problems like it) from recurring in
the future. Postmortems are emphatically _not_ about assigning blame.

There is no shame in making mistakes.


Questions
---------

It's always ok to ask questions. Our systems are large, nobody will be
an expert in all the systems.


Conflict resolution
-------------------

When multiple contributors disagree on the direction for a particular
patch or the general direction of the project, the conflict should be
resolved by communication. The people who disagree should get together,
try to understand each other's points of view, and work to find a design
that addresses everyone's concerns.

This is usually sufficient to resolve issues. If you cannot come to an
agreement, ask for the advice of a more senior member of the team.

Be wary of agreement by attrition, where one person argues a point repeatedly
until other participants give up in the interests of moving on. This is
not conflict resolution, as it does not address everyone's concerns. Be wary
of agreement by compromise, where two good competing solutions are merged
into one mediocre solution. A conflict is addressed when the participants
agree that the final solution is _better_ than all the conflicting proposals.
Sometimes the solution is more work than either of the proposals. Please
see the comments above where we introduce the phrase "embrace the yak shave".


Code of conduct
---------------

This section is the last section in this document because it should be
the most obvious. However, it is also the most important.

We expect Flutter's contributors to act professionally and respectfully, and
we expect our social spaces to be safe and dignified environments.

Specifically:

* Respect people, their identities, their culture, and their work.
* Be kind. Be courteous. Be welcoming.
* Listen. Consider and acknowledge people's points before responding.

Should you experience anything that makes you feel unwelcome in Flutter's
community, please contact someone on the team, for instance
[Ian](mailto:ian@hixie.ch) or [Tim](mailto:timsneath@google.com). We will
not tolerate harrasment from anyone in Flutter's community, even outside
of Flutter's public communication channels.
