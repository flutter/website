---
title: "Flutter’s Material and Cupertino code freeze"
description: >-
  We’ve been hard at work preparing to
  decouple Material and Cupertino from the Framework,
  and now our first major milestone has arrived!
publishDate: 2026-04-07
author: justinmc
image: images/1JN1_t6kPRkgGFVJyetZE0w.webp
category: announcement
layout: blog
---

<DashImage figure src="images/1JN1_t6kPRkgGFVJyetZE0w.webp" alt="Material and Cupertino libraries are frozen and will be moved from the Flutter framework to new packages" caption="Material and Cupertino libraries are frozen and will be moved from the Flutter framework to new packages" />

## Flutter’s Material and Cupertino code freeze

We’ve been hard at work preparing to decouple Material and Cupertino from the Framework, and now our first major milestone has arrived! As of April 7th, all contributions to the Material and Cupertino libraries in flutter/flutter are frozen. Our next milestone will be the re-release of these libraries as the [`material_ui`](https://pub.dev/packages/material_ui) and [`cupertino_ui`](https://pub.dev/packages/cupertino_ui) packages on pub.dev.

This means that, after the code freeze, no more changes will be allowed to the Material and Cupertino libraries inside of flutter/flutter. Further development on these libraries will resume in the [flutter/packages](https://github.com/flutter/packages) repository once the new packages are released.

**If you write Flutter apps or plugins, but don’t contribute to Material or Cupertino itself, you can stop reading now. This won’t affect you… yet.**

After the 3.44 stable release, the new packages will be published and developers will eventually need to migrate. The old Material and Cupertino code will be deprecated in the stable release *after* 3.44 and deleted some time after that. Of course, when the time comes, we’ll follow up with detailed instructions about this migration.

For those who actively contribute to these libraries or are otherwise invested in their development, here are some things you should know:

## What if you have PRs in flight?

Despite the code freeze, we want development on Material and Cupertino to continue with minimal interruption! Any open PRs that touch Material or Cupertino should remain open, and reviewers will continue reviewing and giving feedback as usual. Once the new packages are published, we will provide instructions on how to port these kinds of PRs to flutter/packages. Eventually, your change will go out as a part of a new `material_ui` or `cupertino_ui` release.

## How about new and existing issues related to Material and Cupertino?

Issues that relate to Material or Cupertino will remain in flutter/flutter as always. This unified issue tracker approach is the same pattern that we follow for other packages in the flutter/packages repo and a few other repositories.

## Why freeze the code now?

The moment that we release the 1.0.0 versions of the `material_ui` and `cupertino_ui` packages, we think it’s important to have a seamless migration process for every Flutter developer who is ready to migrate, regardless of which release channel they’re coming from. This means that we need to keep the risk of breaking changes to an absolute minimum between the Material and Cupertino libraries in flutter/flutter and in flutter/packages. We can achieve this by freezing the code one stable release cycle ahead and copying that frozen code to the new packages.

The first step in the migration process for Flutter developers is to perform a normal SDK migration to v3.44 or above on any channel. Once there, we know that they have a copy of Material and Cupertino that is frozen. Even if they upgrade their SDK again, that Material and Cupertino code will not change (until it’s deprecated and deleted in the long term). What’s more, we know that the frozen Material and Cupertino code is identical to the code in the 1.0.0 `material_ui` and `cupertino_ui` packages, or as close to identical as possible. From there, the developer can migrate from the Material and Cupertino code inside their copy of the SDK onto the `material_ui` and `cupertino_ui` packages with minimal friction.

<DashImage figure src="images/1NkrFO7smrNSo2NofNp0EVA.webp" />

## How we got here

It’s been a long journey to this point with *many* contributions and feedback from across the community. A few months ago when I realized that we had test dependencies that would get in the way of decoupling, I posted an [issue](https://github.com/flutter/flutter/issues/177028) and figured I was in for a lot of migration work. Instead, contributors from across the community immediately jumped in to help migrate hundreds of tests. The support we received from first-time contributors to veterans was critical to getting us ready for decoupling. THANK YOU!

## What’s next?

After the code freeze, we’ll begin preparing for migration to the new `material_ui` and `cupertino_ui` packages. This includes tasks like porting the code over, implementing CI/CD, testing, and setting up docs infrastructure to make sure we can keep the same high quality developer experience that you expect from Flutter.

As the new packages near readiness, we’ll publish more information about how to migrate successfully, so keep an eye out. Also, if you see anything that you think we’ve missed, please jump in with an issue or a PR. We couldn’t have gotten this far without help from the amazing Flutter community, and we can’t wait to see where we’ll go from here.
