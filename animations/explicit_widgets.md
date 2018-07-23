---
layout: page
title: "Flutter explicit animations"
permalink: /animations/explicit_widgets.html
---

* TOC Placeholder
{:toc}



Explicit animations allow you to specify precise custom animations. They're a bit more complicated than implicit and transition animations since they require you to build the animation objects, set their properties, and then apply those to the object that you want to animate.

## Creating an explicit animation

To create an explicit animation, you need to create an `AnimationController` to control the animation. Once you’ve created a controller, you can use it to build other animations. For example, you can create a ForwardAnimation then modify some of the parameters to create a ReverseAnimation that mirrors the original animation but runs in reverse. Similarly, you can create a CurvedAnimation whose value is adjusted by a curve and then reverse it. The steps below describe the basic tasks used to create an explicit animation.

<!-- 1. Declare your `StatefulWidget` class.
2. Declare the `State` class with the appropriate ticker (`SingleTickerProviderStateMixin` or `TickerProviderStateMixin`).
3. Declare an instance of `Animation<T>` and `AnimationController`.
4. Define optional and required parameters such as `vsync` and `duration`.
5. Specify the animation such as `CurvedAnimation`
6. Add the appropriate action in the `listener` callback such as `setState`.
7. Start the animation.
8. Define the `BuildContext` to return the animation.
9. Dispose and stop the animation. -->


<!-- 1. Declare your <code>StatefulWidget</code> class.  
2. Declare the <code>State</code> class with the appropriate ticker: <code>SingleTickerProviderStateMixin</code> or <code>TickerProviderStateMixin</code>.  
3. Declare an instance of <code>Animation<T\></code> and <code>AnimationController</code>.  
4. Define optional and required parameters such as <code>vsync</code> and <code>duration</code>.  
5. Specify the animation such as <code>CurvedAnimation</code>.  
6. Add the appropriate action in the <code>listener</code> callback such as <code>setState</code>.  
7. Start the animation.  
8. Define the <code>BuildContext</code> to return the animation.  
9. Dispose and stop the animation.   -->


<div>
<table class="table" width="100%">
  <col width="35%">
  <col width="65%">
	<tbody>
    <tr>
      <td><img src="images/explicit.png" alt="Explicit animation widgets"></td>
      <td>
      1. Declare your <code>StatefulWidget</code> class.<br>
      2. Declare the <code>State</code> class with the appropriate ticker: <code>SingleTickerProviderStateMixin</code> or <code>TickerProviderStateMixin</code>.<br>
      3. Declare an instance of <code>Animation&lt;T&gt;</code> and <code>AnimationController</code>.<br>
      4. Define optional and required parameters such as <code>vsync</code> and <code>duration</code>.<br>
      5. Specify the animation such as <code>CurvedAnimation</code>. <br>
      6. Add the appropriate action in the <code>listener</code> callback such as <code>setState</code>. <br>
      7. Start the animation.  <br>
      8. Define the <code>BuildContext</code> to return the animation. <br>
      9. Dispose and stop the animation. <br>
      </td>
    </tr>
   </tbody>
  </table>
</div>

<!-- To reuse existing Flutter SDK implicit and transition widgets, see [Implicit animations](/animations/implicit_widgets.html) and [Transition animations](/animations/transition_widgets.html). -->

## Explicit animation examples

[Tutorial: Animations in Flutter](/tutorials/animation/)— < revise the tutorial and transfer it to an example here -
This example shows you how to build an explicit animation using Flutter concepts, classes, and methods—and it walks you through 5 animation examples that build on each other to make a complex animation. The example also shows how to use the `AnimationWidget` and the `AnimatedBuilder`.
> This tutorial needs to be revised to remove the concept descriptions that are described on the Concepts web page to keep definitions together—so that information isn't repeated or contradicted on multiple web pages. For example, the AnimationController and Tween are defined on three separate web pages.
> The objective of the tutorial s/b revised to state: 1. How to use Flutter animation classes to add an explicit animation to a widget 2. When to use the `AnimatedWidget` and when to use the `AnimatedBuilder`. (perhaps make the second part a separate tutorial?)


The code for the `animationexample` example is shown below. The `animationexample` widget extends the `AnimatedWidget` class and already includes the listeners, tickers, and other elements that define the animation.  
<!-- skip -->
{% prettify dart %}
```Dart
import 'package:flutter/material.dart';

add the code for the explicit widget

```
{% endprettify %}



## Explicit animations widgets

The Flutter SDK includes the following explicit animation widgets. This is a sample of the many explicit widgets that are included in the Flutter SDK.

<div>
<table class="table" width="100%">
  <col width="25%">
  <col width="70%">
	<thead>
		<tr>
			<th>Explicit widget</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
    <tr>
			<td><a href="https://docs.flutter.io/flutter/material/BottomSheet-class.html">BottomSheet</a> </td>
			<td>This widget is a material design bottom sheet. There are two kinds of bottom sheets in material design:  <br>      
      <b>Persistent</b>—A persistent bottom sheet shows information that supplements the primary content of the app. A persistent bottom sheet remains visible even when the user interacts with other parts of the app.  <br>
      <b>Modal</b>—A modal bottom sheet is an alternative to a menu or a dialog and prevents the user from interacting with the rest of the app.  <br>
<!-- <span style="padding-left: 20px; display:block">
</span> -->  
			Flutter SDK libary: <a href="https://docs.flutter.io/flutter/material/material-library.html">material</a>
      </td>
		</tr>
    <tr>
			<td><a href="https://docs.flutter.io/flutter/material/ExpansionTile-class.html">ExpansionTile</a> </td>
			<td>This widget is a single-line <a href="https://docs.flutter.io/flutter/material/ListTile-class.html">ListTile</a> with a trailing button that expands or collapses the tile to reveal or hide the children.<br>
			Flutter SDK libary: <a href="https://docs.flutter.io/flutter/material/material-library.html">material</a>
      </td>
		</tr>
    <tr>
      <td><a href="https://docs.flutter.io/flutter/material/PopupMenuButton-class.html">PopupMenuButton</a> </td>
      <td>This widget displays a menu when pressed and calls <code>onSelected</code> when the menu is dismissed because an item was selected. The value passed to <code>onSelected</code> is the value of the selected menu item. <br>
      	Flutter SDK libary: <a href="https://docs.flutter.io/flutter/material/material-library.html">material</a>
      </td>
    </tr>
    <tr>
      <td><a href="https://docs.flutter.io/flutter/material/ProgressIndicator-class.html">ProgressIndicator</a> </td>
      <td>This widget is a base class for Material Design progress indicators.<br>
      Flutter SDK libary: <a href="https://docs.flutter.io/flutter/material/material-library.html">material</a>
      </td>
    </tr>
    <tr>
      <td><a href="https://docs.flutter.io/flutter/material/RefreshIndicator-class.html">RefreshIndicator</a> </td>
      <td>This widget supports the Material <em>swipe to refresh</em> idiom.<br>
      Flutter SDK libary: <a href="https://docs.flutter.io/flutter/material/material-library.html">material</a>
      </td>
    </tr>
    <tr>
      <td><a href="https://docs.flutter.io/flutter/material/Scaffold-class.html">Scaffold</a> </td>
      <td>This widget implements the basic Material Design visual layout structure and provides APIs for showing drawers, snack bars, and bottom sheets.<br>
      Flutter SDK libary: <a href="https://docs.flutter.io/flutter/material/material-library.html">material</a>
      </td>
    </tr>
    <tr>
      <td><a href="https://docs.flutter.io/flutter/material/SnackBar-class.html">SnackBar</a> </td>
      <td>This widget is a lightweight message with an optional action which briefly displays at the bottom of the screen. To display a snack bar, call <code>Scaffold.of(context).showSnackBar()</code>, passing an instance of <code>SnackBar</code> that describes the message.<br>
      Flutter SDK libary: <a href="https://docs.flutter.io/flutter/material/material-library.html">material</a>
      </td>
    </tr>
    <tr>
      <td><a href="https://docs.flutter.io/flutter/material/TabBar-class.html">TabBar</a> </td>
      <td>This widget is a Material Design widget that displays a horizontal row of tabs.<br>
      Flutter SDK libary: <a href="https://docs.flutter.io/flutter/material/material-library.html">material</a>
      </td>
    </tr>
    <tr>
      <td><a href="https://docs.flutter.io/flutter/material/TextField-class.html">TextField</a> </td>
      <td>This widget is a Material Design text field that lets a user enter text, either with the hardware keyboard or with an onscreen keyboard. <br>
      Flutter SDK libary: <a href="https://docs.flutter.io/flutter/material/material-library.html">material</a>
      </td>
    </tr>
    <tr>
      <td><a href="https://docs.flutter.io/flutter/material/ExpansionTile-class.html">ExpansionTile</a> </td>
      <td>This widget is a single-line <a href="https://docs.flutter.io/flutter/material/ListTile-class.html">ListTile</a> with with a trailing button that expands or collapses the tile to reveal or hide the children. <br>
      Flutter SDK libary: <a href="https://docs.flutter.io/flutter/material/material-library.html">material</a>
      </td>
    </tr>
	</tbody>
</table>
