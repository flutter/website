---
title: "Enums with Extensions Dart"
description: "About the author: Jose recently graduated from university and now works on Material, a design system that helps teams build high-quality…"
publishDate: 2020-07-17
author: JoseAlba
image: images/1j9632GFfT3IT7sfeiHUZtw.png
category: spotlight
layout: blog
---

## Enums with Extensions in Dart

How to write cleaner code using extension methods in Dart

<DashImage figure src="images/1j9632GFfT3IT7sfeiHUZtw.png" alt="Example of Dart code using an extension method" caption="Example of Dart code using an extension method" />


Dart has recently released support for extension methods, which means that you can now use this awesome feature. This article describes one example of how I use extension methods in my Flutter code.

I’ve always used enums in my Flutter code, but integrating enums and extension methods has made developing in Flutter easier and the code cleaner to read.

Let’s say you make an enumeration and your text is dependent on your enum. Previously, I would have used a switch statement within the `Widget` by using [IIFE](https://en.wikipedia.org/wiki/Immediately_invoked_function_expression) ([medium post](https://medium.com/dartlang/3-cool-dart-patterns-6d8d9d3d8fb8)). An *immediately invoked function expression* lets you invoke an anonymous method, which is a useful Dart pattern. But using this pattern might lead to spaghetti code, as shown in the example below. Also, if you need to add the same text elsewhere, you would have to copy the entire code snippet instead of just making a function call.

```
Text((){

  switch (selectedColor) {

    case SelectedColor.PrimaryColor:

      return 'This is the Primary Color';

    case SelectedColor.SecondaryColor:

      return 'This is the Secondary Color';

    default:

      return 'SelectedScheme Title is null';

  }

}()),

Text((){

  switch (selectedColor) {

    case SelectedColor.PrimaryColor:

      return 'This is the Primary Color';

    case SelectedColor.SecondaryColor:

      return 'This is the Secondary Color';

    default:

      return 'SelectedScheme Title is null';

  }

}()),
```


Also, what happens if you need to change the text color based on the enum? You would need to use another IIFE to get the `PrimaryColor` or `SecondaryColor`.

Instead, you can extend your enum and create a method within that extension so you don’t have to use an IIFE . That way when you invoke your method in your code, it looks cleaner but still gives you the same result. This is an important technique that Java developers are familiar with, and is an expected capability of enums.

```
enum SelectedColor {

  primaryColor,

  secondaryColor,

}

extension SelectedColorExtension on SelectedColor {

  String get name => describeEnum(this);

  String get displayTitle {

    switch (this) {

      case SelectedColor.PrimaryColor:

        return 'This is the Primary Color';

      case SelectedColor.SecondaryColor:

        return 'This is the Secondary Color';

      default:

        return 'SelectedScheme Title is null';

    }

  }

}
```


The `describeEnum()` function, which is defined in the Flutter foundation library, strips off the enum class name from `enumEntry.toString()`. I provide the code below in the event that you want to use it outside of Flutter development, for other Dart projects:

```
String describeEnum(Object enumEntry) {

  final String description = enumEntry.toString();

  final int indexOfDot = description.indexOf('.');

  assert(indexOfDot != -1 && indexOfDot < description.length - 1);

  return description.substring(indexOfDot + 1);

}
```


To play around with the example mentioned above try this Pen.

<iframe src="https://codepen.io/JoseAlba/embed/zYvLPBM" width="800" height="600" frameborder="0" allowfullscreen></iframe>


In the full example, which you can see in CodePen above, the enum is extended with four methods: `displayTitle()`, `displayColorChangeText()`, `color()`, and `getRandomSelectedColor()`. When calling the `displayTitle()` method within the Flutter code you can see that the code is modularized, making it cleaner, as compared to the IIFE. Additionally, if you ever decide to add another enum variable within your enumeration it’s easier to update since all of the code is within the extension. This is seen when the `color()` method was called to change the text color. If I wanted to do this with the IIFE the code would get complicated quickly. It’s also easier to add methods in the future by using extensions; you can see this when the `color()` method was invoked in the CodePen.

The [Flutter Gallery](https://gallery.flutter.dev/#/) uses enums with extensions when [handling category demos](https://github.com/flutter/gallery/blob/74d9d92883c6ca10742c44df309f065289cf2f55/lib/data/demos.dart#L53-L75). The Gallery uses enums to categorize the demo code and uses extensions methods when they want to convert their enumeration into text for the application.

## Closing remarks

[Extension methods](https://dart.dev/guides/language/extension-methods) are a powerful tool provided by Dart. By using enums and extension methods together, you can have cleaner, more scalable code.

Learn more about the useful dart patterns in[ 3 Cool Dart Patterns for everyday programming in Flutter.](https://medium.com/dartlang/3-cool-dart-patterns-6d8d9d3d8fb8)

*About the author: Jose recently graduated from university and now works on [Material](https://material.io), a design system that helps teams build high-quality digital experiences. Jose’s team maintains the Flutter [material library](https://api.flutter.dev/flutter/material/material-library.html).*

*To learn more about Jose, visit his pages on [GitHub](https://github.com/JoseAlba), [LinkedIn](https://www.linkedin.com/in/josealba1996/), [YouTube](https://www.youtube.com/channel/UCOdKA_On0oPe1tz02z1QfxA?view_as=subscriber), and [Instagram](https://www.instagram.com/jose.alba/).*