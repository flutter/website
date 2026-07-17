---
title: "The Power of WebViews in Flutter"
description: >-
  Do you want to write an app that can display a web page without
  having to open your mobile device’s browser?
publishDate: 2019-01-31
author: efortuna
image: images/1aMgCX1bmq6hRNgmsDDVOXQ.gif
category: tutorial
layout: blog
---

Do you want to write an app that can display a web page without having to open your mobile device’s browser? Or maybe you already have a secure payment flow implemented on your website and don’t want to reimplement payment functionality in your mobile app — money can be tricky business and you don’t want to end up accidentally sending half of the payment to the Save the [Kraken](https://en.wikipedia.org/wiki/Kraken) Fund. Oh, that’s just me? Well anyway, the Flutter team has created a [really cool plugin](https://pub.dartlang.org/packages/webview_flutter) that allows you to incorporate WebViews into your Flutter app to make all of this functionality possible.

I meant the functionality of showing websites in Flutter apps… not rehabilitating krakens.

## Flutter WebViews are just like any other widget

Incorporating the WebView plugin into your app is extremely simple. It’s just a widget like any other: `WebView(initialUrl: 'https://flutter.io')`. You can also optionally enable or disable JavaScript in your WebView with the `javascriptMode` parameter. By default, JavaScript in your WebView is disabled, so to enable it you’d construct a WebView like so:

```dart
WebView(
  initialUrl: 'https://flutter.io',
  javascriptMode: JavascriptMode.unrestricted,
)
```

Pretty much all the information you want to know about your WebView and also the ability to control your WebView happens through the…wait for it… WebViewController. This controller is returned in a callback when the WebView is fully built:

```dart
WebViewController _controller;
WebView(
  initialUrl: 'https://flutter.io',
  onWebViewCreated: (WebViewController webViewController) {
    _controller = webViewController;
  },
);

//...later on, probably in response to some event:
_controller.loadUrl('http://dartlang.org/');
```

The WebViewController is your ticket to modifying the WebView programmatically from Flutter or accessing properties like the current URL being displayed. To see how all this works in practice, I wrote a simple Wikipedia-browsing app that allows you to bookmark pages for later, so that the completionist in you will never forget about that last fascinating Wikipedia article the next time you find yourself falling down a [Wiki rabbit hole](https://en.wikipedia.org/wiki/Wiki_rabbit_hole).

<DashImage figure src="images/1aMgCX1bmq6hRNgmsDDVOXQ.gif" alt="A Wikipedia-exploring app written in Flutter using WebViews. You can favorite pages and save them for later viewing" caption="A Wikipedia-exploring app written in Flutter using WebViews. You can favorite pages and save them for later viewing" />

The complete code for this Wiki-rabbit-hole-browser can be found at this [GitHub repository](https://github.com/efortuna/wiki_browser).

```dart
class WikipediaExplorer extends StatefulWidget {
  @override
  _WikipediaExplorerState createState() => _WikipediaExplorerState();
}

class _WikipediaExplorerState extends State<WikipediaExplorer> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Explorer'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          NavigationControls(_controller.future),
          Menu(_controller.future, () => _favorites),
        ],
      ),
      body: WebView(
        initialUrl: 'https://en.wikipedia.org/wiki/Kraken',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      floatingActionButton: _bookmarkButton(),
    );
  }

  _bookmarkButton() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              var url = await controller.data.currentUrl();
              _favorites.add(url);
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Saved $url for later reading.')),
              );
            },
            child: Icon(Icons.favorite),
          );
        }
        return Container();
      },
    );
  }
}
```

WebView is just like any other widget in Flutter and can be composed with other widgets layering on top of it. Note that the favorite button is just a regular `FloatingActionButton` that is hovering on top of the WebView, complete with the shadow effect you would expect with the button. Also, when the drop down menu from the app bar is open, it partially covers the WebView just like with any other widget underneath the menu.

If you look at the code, you may notice I use the `Completer` class and `FutureBuilder` frequently in this sample. Declaring the `_controller` instance variable as a Completer is like setting a placeholder for the WebViewController. We can check if we have the working WebViewController by calling _controller.isCompleted (meaning, it is completed when we have the valid WebViewController) or [using a FutureBuilder with _controller.future](https://github.com/efortuna/wiki_browser/blob/master/lib/main.dart#L40). Using a FutureBuilder allows us to build new UI components like the FloatingActionButton for adding favorites only after we have a working WebViewController (otherwise the program would have no way of getting [`currentUrl`](https://pub.dartlang.org/documentation/webview_flutter/latest/webview_flutter/WebViewController/currentUrl.html) when saving a favorite page).

Two other features about WebViews can be a little complex, so let’s take a closer look at them in the following two sections.

## WebViews can capture specific gestures, too

Since WebViews are Flutter widgets, they can participate in Flutter’s gesture disambiguation protocol ([aka the Gesture Arena](https://flutter.io/gestures/#gesture-disambiguation)). By default, a WebView only responds to a gesture if no other widget claimed it. But you can make the WebView proactively claim a gesture by specifying `gestureRecognizers`.

If your WebView is inside another widget that responds to gestures, for example a ListView, you might want to specify how your app responds to gestures. If the user drags their finger across the screen, should you scroll the ListView or the WebView? If you want both widgets to be scrollable, the WebView widget can “capture” the drag gesture so that it scrolls when the user drags the WebView, but scrolls the ListView otherwise. You can specify which gestures get passed on to the WebView widget with the `gestureRecognizers` parameter. The parameter takes a Set of all the GestureRecognizers that you want to capture. Don’t be scared off by that Factory object, either — it’s basically just a glorified builder method. To capture the vertical scroll event, I can write this:

```dart
WebView(
  initialUrl: someUrl,
  gestureRecognizers: Set()
    ..add(Factory<VerticalDragGestureRecognizer>(
      () => VerticalDragGestureRecognizer())),
)
```

Or, written another way:

```dart
var verticalGestures = Factory<VerticalDragGestureRecognizer>(
  () => VerticalDragGestureRecognizer());
var gestureSet = Set.from([verticalGestures]);
return WebView(
  initialUrl: someUrl,
  gestureRecognizers: gestureSet,
);
```

If you watch the [Boring Flutter Development Show](https://www.youtube.com/playlist?list=PLOU2XLYxmsIK0r_D-zWcmJ1plIcDNnRkK) at all, you may have seen us develop the Kraken News, I mean the *Hacker* News Reader App.

<DashImage figure src="images/1jqWObs72aipeAj8-1PmlZw.gif" alt="latest version of the Hacker News app that we’ve been developing on our YouTube show" caption="latest version of the Hacker News app that we’ve been developing on our YouTube show" />

To show gesture capturing in the context of an app, I modified the Hacker News app to show part of the webpage as a “preview.” This allows the user to scroll through the linked page vertically to determine if they want to open it in a separate page for more in-depth reading.

<DashImage figure src="images/1XpAN7M4hnhe5OvJL3L22gw.gif" alt="Hacker News Reader app with WebView previews of the links. The WebViews capture the vertical drag gesture to enable scrolling of the previews." caption="Hacker News Reader app with WebView previews of the links. The WebViews capture the vertical drag gesture to enable scrolling of the previews." />

The code for this Hacker News reader app can be found at [this GitHub repo](https://github.com/efortuna/hn_app/blob/master/lib/main.dart). (perhaps show code for `_buildItem` here).

However, if the WebView is inside a widget that only captures gestures you don’t care about, no gesture detector is needed. For example, a PageController only responds to horizontal drag gestures, and you just want the WebView to be able to scroll vertically, you can write the code like this:

```dart
PageView(children: [
  WebView(initialUrl: urlOne),
  WebView(initialUrl: urlTwo),
  WebView(initialUrl: urlThree),
]));
```

<DashImage figure src="images/1t_QQZf2S8t-i1IIDs4_Xcw.gif" alt="WebViews in a PageView. The PageView controls the horizontal swiping and the WebViews can scroll vertically with no extra work on your part." caption="WebViews in a PageView. The PageView controls the horizontal swiping and the WebViews can scroll vertically with no extra work on your part." />

## Your WebViews might need a key parameter

You’ve probably seen those ubiquitous optional key parameters sprinkled on just about every Widget constructor in the Flutter codebase. Keys are needed if you have multiple stateful widgets of the same type that are removed, added, or reordered in your app. As it turns out, WebView is a stateful widget (the state including the current page and browser history). Therefore, if you have multiple WebViews in your app, you may need to add a key parameter.

An example of this situation is actually in the Hacker News app! Here’s what happens if we switch tabs and our WebViews don’t have keys:

<DashImage figure src="images/1W_1b-8uIxDeFKplKkxtY0g.gif" alt="This is what happens if you don’t use keys in a stateful app. When we change to the “New Stories” tab the wrong web preview page displays." caption="This is what happens if you don’t use keys in a stateful app. When we change to the “New Stories” tab the wrong web preview page displays." />

As you can see, when we switch tabs, the “Interview with Alan Kay” tile is expanded, but the webview still shows the BBC page about Virgin Galactic! This is fixed by putting a key at the *topmost* collection widget (in this case the `ExpansionTile`):

<DashImage figure src="images/1fdVsrNAivMi-VLPXWMW8gg.gif" alt="Whew! Using keys fixes the problem by showing a different WebView (and the corresponding correct website) for each item in the reader app" caption="Whew! Using keys fixes the problem by showing a different WebView (and the corresponding correct website) for each item in the reader app" />

The super abbreviated explanation of why keys solve this is that when Flutter switches the list of stories to display, it sees that each set of stories is made of a ListView with ExpansionTile items. Flutter has a fast comparison algorithm to avoid unnecessarily redrawing the screen that checks the widget type and key. Without a key, because the widget types of each list are the same, the stateless items (like link titles) all get updated, but stateful components, (like the expanded state of ExpansionTile and the website’s URL), they fail to get redrawn. Adding a key fixes this issue. For a more thorough explanation, check out this video on keys:

<YoutubeEmbed id="kn0EOS-ZiIc" title="When to Use Keys - Flutter Widgets 101 Ep. 4" fullwidth="true"/>

Similarly, if you use WebViews in the context of a [Hero](https://flutter.io/docs/development/ui/animations/hero-animations) widget, you’ll want to use a global key so that Flutter knows the two WebViews are actually the same and doesn’t try to re-render the second.

## A few remaining things to bear in mind:

The WebView plugin is currently in Developer Preview while we finish adding polish. This means that if you want to run the webview plugin on iOS, you also need to add the following line inside the `<dict>` in your `ios/Runner/Info.plist`:

`<key>io.flutter.embedded_views_preview</key><string>yes</string>` [as described in this GitHub issue](https://github.com/flutter/flutter/issues/19030#issuecomment-437534853).

There is another community-based WebView plugin though it doesn’t have all of the functionality of the above plugin by the Flutter team. It is simply displays a webpage in a native view, and is not integrated with the rest of the Flutter widget tree. Therefore that version does not allow you to compose WebViews with arbitrary other Flutter widgets. Using the [webview_flutter plugin](https://pub.dartlang.org/packages/webview_flutter) described in this article avoids this problem.

That’s all folks! Go forth and add WebViews to your Flutter apps. And give those krakens some love too.
