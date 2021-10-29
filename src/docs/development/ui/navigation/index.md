---
title: Navigation and routing
description: Articles and cookbook recipes that address screen navigation.
---

Flutter has an imperative routing mechanism, the `Navigator` widget,
and a more idomatic declarative routing mechanism (which is similar to
build methods as used with widgets), the `Router` widget.

The two systems can be used together (indeed, the declarative system
is built using the imperative system).

Typically, small applications are served well by just using the
`Navigator` API, via the `MaterialApp` constructor's
[`MaterialApp.routes`][] property.

To learn about `Navigator` and its imperative API, see the
[Navigation recipes][] in the [Flutter cookbook][], and the
[`Navigator`][] API docs.

More elaborate applications are usually better served by the `Router`
API, via the [`MaterialApp.router`] constructor. This requires some
more up-front work to describe how to parse deep links for your
application and how to map the application state to the set of active
pages, but is more expressive on the long run.

To learn about `Router` and the declarative approach, see [Learning
Flutter’s new navigation and routing system][], and the [`Router`][]
API docs.

[Flutter cookbook]: /docs/cookbook
[Learning Flutter’s new navigation and routing system]: {{site.flutter-medium}}/learning-flutters-new-navigation-and-routing-system-7c9068155ade
[Navigation recipes]: /docs/cookbook/navigation
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`Router`]: {{site.api}}/flutter/widgets/Router-class.html
[`MaterialApp.routes`]: {{site.api}}/flutter/material/MaterialApp/routes.html
[`MaterialApp.router`]: {{site.api}}/flutter/material/MaterialApp/MaterialApp.router.html
