---
title: "Material and Cupertino decoupling are here"
description: >-
  Why moving Material and Cupertino out of core Flutter accelerates
  fixes and development of new features.
publishDate: 2026-09-02
author: craiglabenz
image: images/xxx
socialImage: images/xxx
category: news
layout: blog
---

Flutter has always been a "batteries included" framework with great tooling,
design systems, animations, and more. But, batteries don't last forever,
so it's very important to be able to replace them when needed.
Back in 2017 when Flutter was approaching viability, the decision to
elevate Material and Cupertino was broadly considered the right decision.
Fast forward into the 2020s as that perspective shifted,
and the Material and Cupertino batteries started to feel more soldered-on
than just included. For years, improving this system was a top request from
Flutter developers. And now, in 2026, a long process to grant this developer wish
is finally coming to fruition.

## What we're doing

Starting months ago and landing in August 2026, this effort froze
contributions to the Material and Cupertino libraries within the
Flutter framework and released exact replicas on `pub.dev` as the
1.0.0<sup><a href="#footnote">1</a></sup>
versions of  [`pkg:material_ui`](https://pub.dev/packages/material_ui)
and [`pkg:cupertino_ui`](https://pub.dev/packages/cupertion_ui).
(Those external libraries are not frozen and are ready for contributions!)
Then, at a future date, this effort will complete with deprecation
and eventual removal of the Material and Cupertino libraries from the
Flutter framework itself.


The reasons for pausing other work to complete this maneuver are manyfold,
but several are described below.

### Reducing friction when updating Flutter

For years, upgrading Flutter for security patches and other fixes
necessarily included any Material or Cupertino UI updates.
Needless to say, this was a *major* source of developer friction
that kept many teams on older Flutter releases. It also meant that
when teams did finally kick off an upgrade, the task could consume
multiple weeks of developer effort and bottleneck entire repositories
while teams addressed UI changes.

Now that the Material and Cupertino libraries are migrated out of the
core framework, we expect that updating Flutter will return to the
simple task it should have always been—complicated only when underlying
platform changes necessitate a Flutter developer's attention.

### Accelerating Material and Cupertino progress

Flutter releases a new stable version every 3 months, which is a pretty fast
pace for a project of its scope. However, fast as it is, it still means that
the worst case scenario (landing code one minute after the stable release cutoff)
can introduce a 16 week delay until that change sees the light of a stable release.
That is… not good.

Broken out into their own packages, `pkg:material_ui` and `pkg:cupertino_ui`
can now be released on their own weekly schedules. This enables simpler CI
workflows and is easier to contribute to, especially for those unfamiliar
with Flutter’s internals.

For these reasons, we expect Material and Cupertino to accelerate development
progress and keep better pace with both Google’s and Apple's design language updates.
For example, work is already underway on official implementations of
Liquid Glass and Material 3 Expressive. We are working with our community
of package authors to ensure Flutter's implementations of these libraries
have the best possible quality and compatibility.

### Strengthening the base widgets

One of the unintended consequences of elevating the Material and Cupertino
libraries in the Flutter framework was that it proved too tempting to build
foundational functionality *in those design libraries*. Both were technically
built on top of the plain `widgets` library, but the `widgets` library itself
was full of holes and gaps in basic UI concepts.

To rectify this, a portion of the decoupling effort will fill those gaps
in the `widgets` library to offer a stronger foundation on top of which
developers can build other design languages. The Flutter ecosystem already
supports many design languages, including `macos_ui`, `fluent_ui`,
`yaru`, `arna`, `chicago`, `VSP`, `shadcn`, and others. In the fullness of time,
we hope to simplify this task by augmenting Flutter's core widgets
with more helpful building blocks.

## What we're **not** doing

The `material_ui` and `cupertino_ui` packages on pub.dev will continue
to receive the same attention from the Flutter team itself and,
as of August 13th 2026, are open for contributions from *all*
Flutter developers. While the Flutter team's resources are limited
and we occasionally have to make hard choices and deprioritize certain initiatives;
**this is not that**. The Flutter team remains committed to maintaining
excellent offerings for Material and Cupertino so that your Flutter apps
look modern and idiomatic across all the platforms you target.

## Looking forward

All projects that live to see their twelfth year have technical debt.
The goal is not to avoid such debt entirely, but to identify it
and set aside the time and energy to pay it down. For the Flutter team,
solving the aforementioned problems has long been on our wish list
and we're excited to finally deliver smoother upgrades,
faster innovation, and a stronger core widgets library to all of our developers.

To get started, if your apps use `flutter/material.dart` or
`flutter/cupertino.dart`, use `dart fix` to add the new
standalone libraries to your `pubspec.yaml` file at version 1.0.0
and replace your imports to use the new packages. Our expectation
is that this will be a drop-in maneuver, but
please [file an issue](https://github.com/flutter/flutter/issues/new)
if you encounter any trouble.

If you're a UI developer with expertise in Material or Cupertino,
consider contributing to the standalone libraries! As always,
we recommend either finding an issue that interests you or
filing a feature request for work you would like to complete.

Until next time, Happy Fluttering!

<a id="footnote">1</a>: To streamline your migration, we intentionally chose
version `1.0.0` to mark the standalone version which perfectly matches
each library's in-framework state. Moving forward, the libraries will
evolve using semantic versioning.
