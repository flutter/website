---
title: "API design tip for complex Flutter Widgets"
description: "Asking a widget to be something vs. do something"
publishDate: 2019-03-14
author: amir_h
category: tutorial
layout: blog
---

When writing widgets that manage non-trivial state, it sometimes becomes a struggle to maintain a clean API. I think that, in many cases, this is because one hits the expressiveness boundaries of constructor-based APIs. We’ve been dealing with such cases in the core Flutter team and, while this is not a super complex problem, I find that being unaware of these boundaries can be painful. Naming the problem and taking these limits into account has been useful for me, so I want to share these lessons.

I’ll start with an example: let’s say we are building a WebView widget that shows embedded web content . For simplicity, let’s start with a minimal API surface. We want to be able to load a specific URL and specify whether JavaScript is enabled. We want the API to feel “Fluttery”, so we create a widget with constructor parameters for these 2 controls. What a simple API! Every Flutter developer will feel at home right away! Want to load the YouTube homepage? Just build the widget:

`WebView(url: 'https://youtube.com', javascriptEnabled: true)`

You now want to disable JavaScript? just rebuild the widget:

`WebView(url: 'https://youtube.com', javascriptEnabled: false)`

Wait, let’s say that before we rebuilt the WebView with `javascriptEnabled=false`, the user clicked a link and the WebView navigated to a different URL. Before the rebuild, the WebView was on https://flutter.dev. What should the widget do when it’s rebuilt with `(url: 'https://youtube.com', javascriptEnabled: false)`? Should it return to https://youtube.com? Should it stay in the same page? None of these options are ideal as different apps might want a different thing to happen at different times. The app must be able to express which of the 2 possibilities should happen.

(Another interesting thought exercise: how would you design a widget-parameters-based API for refreshing the current page?)

## Be something or do something?

An application uses a widget’s API for asking it to do things.

We can, in a hand-wavy way, categorize the things an application asks a widget to do into 2 categories:

**Be something**, or **do something** (sometimes referred to as *level triggers* and *edge triggers*, respectively).

When an app tells a widget to have a certain color or, for example, when it tells the WebView widget to have JavaScript enabled, I think of it as a request to “be something”. For example, be a widget with a red background color. For “be something” requests there’s a special contract between the app and the widget: a “be something” request applies to the widget until the next time the app makes a different “be something” request for the same parameter. Back to the color example, the widget cannot change its color property internally, or through any mechanism other than the app’s next “be something” request. So after the app asks the widget to be red, the app knows the widget is red (*) until it asks it to be another color.

“Be something” requests model nicely as widget parameters, building a widget with a set of parameters is how the app asks it to be something. After building a `Container(color: red)` widget, the app knows that the container is red as long as the app doesn’t rebuild the container with a different parameter. There is no point in making the same “be something” request again, as the widget is already guaranteed to be the widget that complies to the previous request.

**Do something** requests are requests that don’t require the widget to keep the guarantees described above. Asking a WebView widget to show a specific URL can be nicely modeled as a “do something” request. It is ok if the user navigates to a different page, and the current URL is no longer the last URL the app requested the WebView to show. The app makes no assumption that just because it asked the WebView to show a specific URL, it is still showing it.

“Do something” requests don’t model well as widget parameters, that is because the widget cannot control when and how it is being rebuilt, it cannot “rebuild itself” with a new URL whenever the user clicks a link.

So how do we make an API for “do something” requests? So far, I find what works best is making imperative calls. For the URL example, this means having a controller for the WebView and making a `webViewController.loadUrl(..)` call. That’s right, not everything has to be controlled through widget parameters, and it’s no sin to use controllers (in fact, Flutter uses some controllers in the framework, such as [PageController](https://docs.flutter.io/flutter/widgets/PageController-class.html), and the WebViewController in the [webview_flutter](https://pub.dartlang.org/packages/webview_flutter) plugin).

**There’s a trade-off decision to be made**

Keep in mind that it is possible to achieve the same functionality of a “do something” API with a “be something” API. For example, for the WebView URL case we can extract the management of the “current location” property out of the widget: when a user clicks a link, the widget invokes an event handler which rebuilds the widget with the new location, basically leaving the “current location” state management to the app. For the “loadUrl” case, managing the “current location” state is pretty complex (imagine a web page with multiple iframes, each with a different scroll position. A user clicks a link in one of these iframes; the new state that the app needs to pass to the WebView is far from trivial and difficult to maintain), so we chose to make it a “do something” API.

## But I just want to show one specific URL

Continuing with the WebView URL example, for the simple (and common) case in which the app just wants to show a single page, with no links (maybe a license page), it might be nice to avoid requiring the developer to manage a controller instance.

In webview_flutter we’ve included an `initialUrl` widget parameter for this purpose. The first time the widget is built initialUrl is loaded. Later changes to this value are ignored when rebuilding the widget.

While this is nice for simple use cases, it can confuse developers who try to later change the initialUrl value. (See this [GitHub issue](https://github.com/flutter/flutter/issues/21566) for an idea on how confusing this can be.)

When evaluating whether to add an `initialFoo` parameter, keep in mind that while these are handy for some simple use-cases, they can be confusing for developers.

That’s my tidbit for today, I found that separating these different kinds of requests to a widget (“be something” vs “do something”) helps when designing APIs for complex widgets (like a WebView or a Map). I hope that this helps you as well!

*This is not exactly correct, e.g when considering implicit animation widgets like [AnimatedOpacity](https://docs.flutter.io/flutter/widgets/AnimatedOpacity-class.html), the app does not know that the widget is at opacity ‘1.0’ after rebuilding the widget, but it can still be considered as a “be something” request: be the widget that animates opacity to 1.0 (whether that animation was complete already or is still running).*
