---
layout: page
title: Flutter Documentation
permalink: /docs/
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

* [Write Your First Flutter App](/tutorials/get-started/)  
  A walkthrough on creating a Flutter app that generates names for startup companies.

* [Flutter for Android Developers](/flutter-for-android/)  
  Tips for Android developers.

* [HTML/CSS patterns](/web-analogs/)  
  Tips for web developers showing how HTML and CSS syntax maps to Flutter widgets.

* [Building Layouts in Flutter](/tutorials/layout/)  
  Walkthrough showing how to create layouts in Flutter, where everything is a widget.

* [Add Interactivity to Your Flutter App](/tutorials/interactivity/)  
  Walkthrough showing how to add a stateful widget to your app.

* [A Tour of the Flutter Widget Framework](/widgets-intro/)  
  A short, conceptual tour through the Flutter framework.

&nbsp;


## Want to skill up?

You’ve mastered the basics and want to add to your skills.

* [Cookbook](/cookbook/)  
  A (growing) collection of recipes that address common Flutter use cases.

* [Sample App Catalog](/samples/)  
  Simple apps that show how to implement features and widgets.

* [Adding Assets and Images in Flutter](/assets-and-images/)  
  How to add resources to a Flutter app.

* [Animations in Flutter](/animations/)  
  Flutter supports different types of animations. Learn how to create standard,
  hero, or staggered animations, to name a few.

* [Routing and Navigation](/routing-and-navigation/)  
  How to create and navigate to new pages.
  
* [Internationalization](/tutorials/internationalization/)  
  Go global! How to internationalize your Flutter app.

* [Effective Dart](https://www.dartlang.org/guides/language/effective-dart)  
  Guides on how to write better Dart code.

&nbsp;


## Specialized topics

* [Custom fonts](/custom-fonts/)  
  How to add new fonts to your app.

* [Text input](/text-input/)  
  How to set up basic text input.

* [Debugging Flutter Apps](/debugging/)  
  Tools and tips for debugging your app.
  
* [Flutter Widget Inspector](/inspector/)  
  The Flutter Inspector, a tool available in the Flutter plugin for your IDE.

&nbsp;


This is not a complete list. Please use the left navigation, or the search 
field to find other topics.
