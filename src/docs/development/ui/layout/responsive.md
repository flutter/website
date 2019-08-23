---
title: Creating responsive apps
short-title: Responsive
---

{% comment %}
  TODO: Once published, remove this page on the GitHub wiki:
  (https://github.com/flutter/flutter/wiki/Creating-Responsive-Apps)
  and forward to this page.
{% endcomment %}

A responsive app lays out its UI according to the
size and shape of the screen or window.
This is especially necessary when the same app
can run on a variety of devices, from a watch, phone,
tablet, to a laptop or desktop computer. When the user
resizes the window on a laptop or desktop,
or changes the orientation of the phone or tablet,
the app should respond by rearranging the UI accordingly.

Flutter allows you to create apps that self-adapt
to the device's screen size and orientation.

There are two basic approaches to creating Flutter
apps with responsive design:

**Use the [`LayoutBuilder`][] class**
: From its [`builder`][] property, you get a
  [`BoxConstraints`][] object.
  Examine the constraint's properties to decide what to
  display. For example, if your [`maxWidth`][] is greater than
  your width breakpoint, return a [`Scaffold`][] object with a
  row that has a list on the left. If it's narrower,
  return a [`Scaffold`][] object with a drawer containing that
  list. You can also adjust your display based on the
  device's height, the aspect ratio, or some other property.
  When the constraints change (for example,
  the user rotates the phone, or puts your app into a tile UI
  in Nougat), the build function runs.

**Use the [`MediaQuery.of()`][] method in your build functions**
: This gives you the size, orientation, etc, of your current app.
  This is more useful if you want to make decisions based on the
  complete context rather than on just the size of your particular
  widget. Again, if you use this, then your build function automatically
  runs if the user somehow changes the app's size.

Other useful widgets for creating a responsive UI:

* [`AspectRatio`][]
* [`CustomSingleChildLayout`][]
* [`CustomMultiChildLayout`][]
* [`FittedBox`][]
* [`LayoutBuilder`][]
* [`MediaQuery`][]
* [`MediaQueryData`][]
* [`OrientationBuilder`][]

For more information, here are a few resources,
including contributions from the Flutter community:

* [MediaQuery (Flutter Widget of the Week video)](https://www.youtube.com/watch?v=A3WrA4zAaPw)
* [Developing for Multiple Screen Sizes and Orientations in
  Flutter]({{site.medium}}/flutter-community/developing-for-multiple-screen-sizes-and-orientations-in-flutter-fragments-in-flutter-a4c51b849434)
  by Deven Joshi
* [Build Responsive UIs in
  Flutter](https://medium.com/flutter-community/build-responsive-uis-in-flutter-fd450bd59158)
  by Raouf Rahiche
* [Making Cross-platform Flutter Landing Page
  Responsive]({{site.medium}}/flutter-community/making-cross-platform-flutter-landing-page-responsive-7fffe0655970)
  by Priyanka Tyagi
* [How to make flutter app responsive according to different screen
  size?](https://stackoverflow.com/questions/49704497/how-to-make-flutter-app-responsive-according-to-different-screen-size),
  a question on StackOverflow

[`AspectRatio`]: {{site.api}}/flutter/widgets/AspectRatio-class.html
[`BoxConstraints`]: {{site.api}}/flutter/rendering/BoxConstraints-class.html
[`CustomMultiChildLayout`]: {{site.api}}/flutter/widgets/CustomMultiChildLayout-class.html
[`CustomSingleChildLayout`]: {{site.api}}/flutter/widgets/CustomSingleChildLayout-class.html
[`FittedBox`]: {{site.api}}/flutter/widgets/FittedBox-class.html
[`LayoutBuilder`]: {{site.api}}/flutter/widgets/LayoutBuilder-class.html
[`MediaQuery`]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[`MediaQuery.of()`]: {{site.api}}/flutter/widgets/MediaQuery/of.html
[`MediaQueryData`]: {{site.api}}/flutter/widgets/MediaQueryData-class.html
[`OrientationBuilder`]: {{site.api}}/flutter/widgets/OrientationBuilder-class.html
[`Scaffold`]: {{site.api}}/flutter/material/Scaffold-class.html

[`builder`]: {{site.api}}/flutter/widgets/LayoutBuilder/builder.html
[`maxWidth`]: {{site.api}}/flutter/rendering/BoxConstraints/maxWidth.html
