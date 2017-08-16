---
layout: page
title: Routing and navigation

permalink: /routing-and-navigation/
---

Most apps have more than one screen or view, and
want to smoothly transition a user from screen to
screen. Flutter's _routing_ and _navigation_ features
help you manage naming and transitioning between
screens in your app.

* Placeholder for TOC
{:toc}

## Core concepts

There are two core concepts and classes for managing
multiple screens: [Route][routedoc] and
[Navigator][navigatordoc]. A _Route_ is an abstraction
for a "screen" or "page" of an app,
and a _Navigator_ is a widget that manages routes.
A Navigator can _push_ and _pop_ routes to help
a user move from screen to screen.

To get started, we recommend reading the
[API docs for Navigator][navigatordoc].
There you will learn about the different
kinds of routes, naming routes, route
transitions, and more.

## Examples

The [stocks example][stocks] has a simple example of how to
declare named routes for a [MaterialApp][materialappdoc].

The [Navigator API docs][navigatordoc] contain a few examples of
pushing and popping a route, named routes, routes that return
a value, and more.

[routedoc]: https://docs.flutter.io/flutter/widgets/Route-class.html
[navigatordoc]: https://docs.flutter.io/flutter/widgets/Navigator-class.html
[stocks]: https://github.com/flutter/flutter/blob/master/examples/stocks/lib/main.dart#L122
[materialappdoc]: https://docs.flutter.io/flutter/material/MaterialApp-class.html