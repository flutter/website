---
title: Flutter Documentation
description: The landing page for Flutter documentation.
---

<ul class="cards">
{% for card in site.data.docs_cards %}
	<li class="cards__item">
	    <div class="card">
		    <h3 class="catalog-category-title"><a class="action-link" href="{{card.url}}">{{card.name}}</a></h3>
		    <p>{{card.description}}</p>
		    <div class="card-action">
		        <a class="action-link" href="{{card.url}}">VISIT</a>
		    </div>
		</div>
	</li>
{% endfor %}
</ul>

&nbsp;


## New to Flutter?

Once you've gone through [Get Started](/get-started/install),
including [Write Your First Flutter App,](/get-started/codelab)
here are some next steps.

* [Flutter for Android Developers](/get-started/flutter-for/android-devs)<br>
  Review these tips if you have Android experience.

* [Flutter for iOS Developers](/get-started/flutter-for/ios-devs)<br>
  Review these tips if you have iOS experience.

* [Flutter for Web Devs](/get-started/flutter-for/web-devs)<br>
  Review these HTML -> Flutter analogs if you have web experience.

* [Flutter for React Native Devs](/get-started/flutter-for/react-native-devs)<br>
  Review these tips if you have React Native experience.

* [Flutter for Xamarin.Forms Devs](/get-started/flutter-for/xamarin-forms-devs)<br>
  Review these tips if you have Xamarin Forms experience.

* [Building Layouts in Flutter](/development/ui/layout)<br>
  Learn how to create layouts in Flutter, where everything is
  a widget.

* [Adding Interactivity to Your Flutter App](/development/ui/interactive)<br>
  Learn how to add a stateful widget to your app.

* [A Tour of the Flutter Widget Framework](/widgets-intro)<br>
  Learn more about Flutter's react-style framework.

&nbsp;


## Want to skill up?

Once you’ve mastered the basics, try these pages.

* [Cookbook](/cookbook)<br>
  A (growing) collection of recipes that address common Flutter
  use cases.

* [Sample App Catalog](/catalog/samples)<br>
  Simple apps that demonstrate how to implement features and widgets.

* [Adding Assets and Images in Flutter](/development/ui/assets-and-images)<br>
  How to add resources to a Flutter app.

* [Animations in Flutter](/development/ui/animations)<br>
  How to create standard, hero, or staggered animations, to
  name a few animations styles that Flutter supports.

* [Routing and Navigation](/cookbook/navigation/navigation-basics)<br>
  How to create and navigate to a new screen (called a
  _route_ in Flutter).

* [Internationalization](/tutorials/internationalization)<br>
  Go global! How to internationalize your Flutter app.

* [Effective Dart](https://www.dartlang.org/guides/language/effective-dart)<br>
  Guides on how to write better Dart code.

&nbsp;


## Specialized topics

Dive deeper into topics that interest you.

* [Flutter Widget Inspector](/development/tools/inspector)<br>
  How to use the widget inspector, a powerful tool that allows
  you to explore widget trees, disable the "DEBUG"
  banner, display the performance overlay, and much more.

* [Custom Fonts](/cookbook/design/fonts)<br>
  How to add new fonts to your app.

* [Text Input](/cookbook/forms/text-input)<br>
  How to set up basic text input.

* [Debugging Flutter Apps](/debugging)<br>
  Tools and tips for debugging your app.


&nbsp;


This is not a complete list. Please use the left navigation,
or the search field to find other topics.
