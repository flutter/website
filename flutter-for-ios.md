---
layout: page
title: Flutter for iOS Developers
permalink: /flutter-for-ios/
---

# This document is a work in progress
We're working on this document right now. Please do not rely on its completeness
and accuracy until it's finished and it's shown in the sidebar as a link.

---

This document is meant for iOS developers looking to apply their
existing iOS knowledge to build mobile apps with Flutter. If you understand
the fundamentals of the iOS framework then you can use this document as a
jump start to Flutter development.

Your iOS knowledge and skill set are highly valuable when building with
Flutter, because Flutter relies on the mobile operating system for numerous
capabilities and configurations. Flutter is a new way to build UIs for mobile,
but it has a plugin system to communicate with iOS (and Android) for non-UI
tasks. If you're an expert in iOS development, you don't have to relearn everything
to use Flutter.

This document can be used as a cookbook by jumping around and finding questions
that are most relevant to your needs.

* TOC Placeholder
{:toc}

# Navigation

## How do I navigate between pages?

In iOS, to travel between view controllers, you can use a
`UINavigationController` that manages the stack of view controllers to
display.

Flutter has a relatively similar implementation, using a `Navigator` and
`Routes`. A `Route` is an abstraction for a “screen” or “page” of an app, and
a `Navigator` is a [widget](https://flutter.io/technical-
overview/#everythings-a-widget) that manages routes. A route roughly maps to a
`UIViewController`. The navigator works in a similar way to the iOS
`UINavigationController`, in that it can `push()` and `pop()` routes depending
on whether you want to navigate to, or back from, a view.

Unlike iOS, you will need to pass in a `Map` of names of routes to the top
level `App` instance to declare all of your routes:

<!-- skip -->
{% prettify dart %}
void main() {
  runApp(new MaterialApp(
    home: new MyAppHome(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => new MyPage(title: 'page A'),
      '/b': (BuildContext context) => new MyPage(title: 'page B'),
      '/c': (BuildContext context) => new MyPage(title: 'page C'),
    },
  ));
}
{% endprettify %}
 
You can then navigate to a route by getting hold of the `Navigator` and
`push`ing one of the named routes.

<!-- skip -->
{% prettify dart %}
Navigator.of(context).pushNamed('/b');
{% endprettify %}

The `Navigator` class which handles all routing in Flutter can be used to get
a result back from a route that you have pushed on the stack. This can be done
by `await`ing on the `Future` returned by `push()`. For example, if you were
to start a ‘location’ route which lets the user select their location, you
could do:

<!-- skip -->
{% prettify dart %}
Map coordinates = await Navigator.of(context).pushNamed('/location');
{% endprettify %}

And then, inside your ‘location’ route, once the user has selected their
location you can `pop()` the stack with the result:

<!-- skip -->
{% prettify dart %}
Navigator.of(context).pop({"lat":43.821757,"long":-79.226392});
{% endprettify %}

## Navigating to other apps

In iOS, in order to send the user to another application, you would use a
specific URL scheme. For the system level apps, there are specific schemes you
would use. In order to implement this functionality in Flutter, you would need
to create a native platform integration, or use an existing
[plugin](#plugins), such as
[`url_launcher`](https://pub.dartlang.org/packages/url_launcher).