---
title: State management
description: How to structure an app to manage the state of the data flowing through it.
next:
  title: Start thinking declaratively
  path: /data-and-backend/state-mgmt/declarative
---

:::note
If you have written a mobile app using Flutter
and wonder why your app's state is lost
on a restart, check out [Restore state on Android][]
or [Restore state on iOS][].
:::

[Restore state on Android]: /platform-integration/android/restore-state-android
[Restore state on iOS]: /platform-integration/ios/restore-state-ios

_If you are already familiar with state management in reactive apps,
you can skip this section, though you might want to review the
[list of different approaches][]._

<img src='/assets/images/docs/development/data-and-backend/state-mgmt/state-management-explainer.webp' width="100%" alt="A short animated gif that shows the workings of a simple declarative state management system. This is explained in full in one of the following pages. Here it's just a decoration.">

{% comment %}
Source of the above animation tracked internally as b/122314402
{% endcomment %}

As you explore Flutter,
there comes a time when you need to share application
state between screens, across your app.
There are many approaches you can take,
and many questions to think about.

In the following pages,
you will learn the basics of dealing with state in Flutter apps.

[list of different approaches]: /data-and-backend/state-mgmt/options
