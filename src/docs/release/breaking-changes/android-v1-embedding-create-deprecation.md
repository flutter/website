---
title: Android v1 embedding app and plugin creation deprecation
description: Gradual deprecation of the Android v1 embedding.
---

## Summary

The `flutter create` templates for apps and plugins
no longer create Android wrapping based on the
v1 Android embedding as part of our gradual
Android v1 embedding deprecation process described in our
[Android Migration Summary][].

Application projects using the v1 Android embedding
are encouraged to migrate following the steps described in
[Upgrading pre 1.12 Android projects][].

Plugins targeting the v1 Android embedding are encouraged
to migrate following the instructions in
[Supporting the new Android plugins APIs][].

[Android Migration Summary]: /go/android-migration-summary
[Upgrading pre 1.12 Android projects]: /go/android-project-migration
[Supporting the new Android plugins APIs]: /docs/development/packages-and-plugins/plugin-api-migration

## Context

In Flutter version 1.12, we launched a v2 set of
Android APIs based on the [`io.flutter.embedding`][]
package in order to enable the [add-to-app][] workflow
on Android.

Over time, we gradually deprecated the older
v1 Android embeddings based on the
[`io.flutter.app`][] package.

As of Q2 2020, only 26% of applications used the v1 embeddings.

Since the v2 embeddings were strongly established over
the 7 months since the launch of Flutter v1.12,
we disabled the creation of new app and plugin
projects using the v1 embeddings.

[add-to-app]: /docs/development/add-to-app
[`io.flutter.embedding`]: https://cs.opensource.google/flutter/engine/+/master:shell/platform/android/io/flutter/embedding/
[`io.flutter.app`]: https://cs.opensource.google/flutter/engine/+/master:shell/platform/android/io/flutter/app/.

## Description of change

The `flutter config` command no longer has a
togglable `enable-android-embedding-v2`
flag (which defaulted to true since v1.12).
All projects created with `flutter create`
and `flutter create -t plugin` exclusively use the
Android v2 embedding.

Existing v1 applications continue to work.

Existing v1 applications consuming plugins now receive
a warning prompt to migrate to v2 embedding.

Existing v1 applications consuming a plugin that targets
only the v2 embedding won't build and must migrate.
This has been the case since v1.12. However,
the likelihood of encountering this increases as
plugin developers create and publish v2 only plugins.

Existing v2 applications continue to work with or without
plugins.

Existing v2 applications consuming plugins that only
target the v1 embedding continue to receive a warning prompt.
The likelihood of encountering this decreases
as plugin developers create and publish v2 plugins.

## Migration guide

See the [migration guide][].

[migration guide]: /go/android-project-migration

## Timeline

Landed in version: 1.20.0-8.0<br>
In stable release: 1.22
