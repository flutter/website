---
layout: page
title: Design Principles
sidebar: home_sidebar
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
means "Looks Good To Me".) If you review a patch, you are sharing the
responsibility for the patch with its author.

Reviewers should not give an LGTM unless the patch has tests that
verify all the affected code, or unless a test would make no sense.

A reviewer may in some circumstances consider the code satisfactory
without having fully reviewed or understood it. If a reviewer has not
fully reviewed the code, they must admit to this by saying "RSLGTM"
rather than just "LGTM". If you feel your code needs a real review,
please find someone to actually review it. ("RSLGTM" means "Rubber
Stamp Looks Good To Me".) If you mark a patch as RSLGTM, you are still
sharing the responsibility for the patch with its author.

If you really need to check something in in a hurry, for example
because everything is broken and you can fix it, then pick someone on
the team who you want to have review the code, and then mark the PR as
"TBR" with their name. ("TBR" means "To Be Reviewed".) This is only to
be used in emergencies. Nobody being around to review your 50,000 line
patch at midnight on December 31st is not an emergency.

Run the tests before checking code in. Travis does this for you, so
wait for Travis to give the green light before merging a PR. The only
time it is ok to skip this step is if the tests are already failing,
and your fix is intended to improve matters, and you're going to watch
the results once you've checked it in (in which case the bots are
essentially doing the same job as Travis would have on your PR).

Make sure all the trees and dashboards are green before checking in:
the [infra waterfall](https://build.chromium.org/p/client.flutter/waterfall),
our [travis dashboard](https://travis-ci.org/flutter/flutter/builds),
our [test dashboard](https://flutter-dashboard.appspot.com/build.html) (Google-only, sorry),
our [status dashboard](https://flutter-dashboard.appspot.com/status.html) (Google-only, sorry), and
our [benchmarks dashboard](https://flutter-dashboard.appspot.com/benchmarks.html) (Google-only, sorry).

**If the trees or dashboards are showing any regressions, only fixes
that improve the situation are allowed to go in**.


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

You may hear team members say "embrace the yak shave!". This is an
encouragement to take on the larger effort necessary to perform a
proper fix for a problem rather than just applying a band-aid.


Tests
-----

When you fix a bug, first write a test that fails, then fix the bug
and verify the test passes.

When you implement a new feature, write tests for it.


Documentation
-------------

If you have a question about our systems, then when you find the
answer, put it into the documentation in the same place where you
first looked for the answer.

It's better to not document something than to document it poorly
(because if you don't document it, it still appears on our list of
things to document). Feel free to remove documentation that violates
our
[style guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo),
so as to make it reappear on the list.


API design
----------

* There should be no objects that represent live state that reflects
  some other state, since they are expensive to maintain. e.g. no
  `HTMLCollection`.

* Property getters should be efficient (e.g. just returning a cached
  value, or an O(1) table lookup). If an operation is inefficient it
  should be a method instead. e.g. `document.getForms()`, not
  `document.forms`.

* There should be no APIs that require synchronously completing an
  expensive operation (e.g. computing a full app layout outside of the
  layout phase).

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

* If we expose some aspect of a mojo service, we should expose/wrap
  all of it, so that there's no cognitive cliff when interacting with
  that service (where you are fine using the exposed API up to a
  point, but beyond that have to learn all about the underlying
  service).

Bugs
----

Only assign a bug to yourself when you are actively working on it. If
you're not working on it, leave it unassigned. Don't assign bugs to
people unless you know they are going to work on it.

You may hear team members refer to "licking the cookie". Assigning a
bug to yourself, or otherwise indicating that you will work on it,
tells others on the team to not fix it. If you then don't work on it
straight away, you are acting like someone who has taken a cookie,
licked it to unappetising to other people, and then not eaten it right
away. By extension, "unlicking the cookie" means indicating to the
rest of the team that you are not actually going to work on the bug
right away after all.

File bugs for anything that you come across that needs doing. When you
implement something but know it's not complete, file bugs for what you
haven't done. That way, we can keep track of what still needs doing.

Regressions
-----------

If a check-in has caused a regression on the trunk, roll back the
check-in (even if it isn't yours) unless doing so would take longer
than fixing the bug. When the trunk is broken, it slows down everyone
else on the project.

If things are broken, your priority should be helping the team fix the
problem. Someone should own the issue, and they can delegate
responsibilities to others on the team. Once the problem is resolved,
write a
[post-mortem](https://github.com/flutter/flutter/wiki/Postmortems).

There is no shame in making mistakes.

Questions
---------

It's always ok to ask questions. Our systems are large, nobody will be
an expert in all the systems.
