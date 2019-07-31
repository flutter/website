---
title: "Codelab: widgets and Flutter's UI"
description: "A codelab that teaches basic Flutter layout concepts through DartPad2 code examples."
toc: true
--- 

#### What's the point? 

* Widgets are classes, properties, and values that build Flutter's UI.  

#### Requirements
{:.no_toc}
* You should have an understanding of [Flutter](https://www.flutter.dev). 
* You shoudl have an understanding of [Dart](https://www.dart.dev) or some exposure to object-oriented programming.

#### System requirements
{:.no_toc}
* You should have a PC (Microsoft, Mac, or Linux) with Google Chrome installed.

{{site.alert.important}}
  This codelab features embedded code examples that are based on an experimental code editor called DartPad2. DartPad2 is being developed and tested with Google Chrome. Some of the features in this codelab may not function on other browsers.
{{site.alert.end}}

## Widget class

In Flutter, widgets are immutable objects that perform specifc functions. As you progress through this codelab, you learn that widgets build everything in Flutter. 

#### Code example
{:.no_toc}

Check out **Dart**. The code contains various widgets that complete specific tasks.

* `MyWidget` displays a silver box. 
* `BlueBox` displays a blue square.
* `BuildContext` enables parent-child relationships between widgets.
* `Container` enables widget customization. 
* `Row` is a class and parent widget to `BlueBox`.
* `BlueBox` is a child widget to `Row`.
* `StatelessWidget` indicates that the UI is built from fixed data.

More information on parent-child relationships between widgets is available at [Layouts in Flutter](https://flutter.dev/docs/development/ui/layout). 

1. Run the code.

{% comment %}
  Gist: https://gist.github.com/579d215abcbea78d192fcdeeb6cccde1
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=579d215abcbea78d192fcdeeb6cccde1&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br> 

The code displays three blue squares in a grey, rectangular box. 

## Row class and Column class

`Row` and `Column` are classes that contain widgets. When `Row` and `Column` contain widgets, the widgets become "children," and `Row` and `Column` become "parents." Moreover, when `Row` and `Column` contain widgets, `Row` and `Column` lay out their children. `Row` lays out its children horizontally. `Column` lays out its children vertically. 

{{site.alert.note}}
  In Flutter, left-to-right and right-to-left languages are supported.  
{{site.alert.end}}

#### Code example: Row
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
*Check out Dart.*

In the code, `Row` contains three children, all `BlueBox` widgets. 

In this code example, the code displays three blue squares horizontally.

***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/26c8fb02c58c4120917b073ec6253953
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=26c8fb02c58c4120917b073ec6253953&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe> 
<br>
#### Code example: Column
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
*Check out Dart.*

In the code, `Column` contains three child widgets, all `BlueBox` widgets. 

In this code example, the code displays three blue squares vertically.

***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/db96dc75c3283227bc849ba31d213783
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=db96dc75c3283227bc849ba31d213783&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## mainAxisSize property

`Row` and `Column` occupy different main axes. `Row`\'s main axis horizontal. `Column`\'s main axis is vertical. `mainAxisSize` is a property that determines how much space `Row` and `Column` can occupy on their main axes. `mainAxisSize` has two `MainAxisSize` enums: 

* `MainAxisSize.max`
<br/>
Increases the amount of space `Row` and `Column` can occupy on their main axes. 
* `MainAxisSize.min` 
<br/>
Decreases the amount of space `Row` and `Column` can occupy on their main axes.  

#### Code example: MainAxisSize.max
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
*Check out Dart.*

`Row` contains three `BlueBox` widgets. Notice how `mainAxisSize` is set to `MainAxisSize.max`. 

When `mainAxisSize` is set to `MainAxisSize.max`, `Row` and `Column` occupy all of the space on their main axes. As a result, `Row` and `Column` may have extra space on their main axes.

In this code example, the code displays three blue sqaures, and notice how the grey, rectangular box has extra space. 

***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/def3c5c3c68459b5bb4bdfed58f5d024
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=def3c5c3c68459b5bb4bdfed58f5d024&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
#### Code example: MainAxisSize.min
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
*Check out Dart.*

`Row` contains three `BlueBox` widgets. Notice how `mainAxisSize` is set to `MainAxisSize.min`. 

When `mainAxisSize` is set to `MainAxisSize.min`, `Row` and `Column` only occupy enough space for their children. As a result, `Row` and `Column` don't have any extra space on their main axes.

In this code example, the code displays three blue squares, and notice how the grey, rectangular box doesn't have extra space. 

***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/def3c5c3c68459b5bb4bdfed58f5d024
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=d852e4f07d6c87600fe8e0f186c7a31b&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br> 
## mainAxisAlignment property

When `mainAxisSize` is set to `MainAxisSize.max`, `Row` and `Column` may have extra space on their main axes. `mainAxisAlignment` is a property that determines how `Row` and `Column` can position their children horizontally in extra space. `mainAxisAlignment` has six `MainAxisAlignment` enums: 

* `MainAxisAligment.start`<br>
  Positions children near the beginning of the main axis. (Left for `Row`, top for `Column`)
* `MainAxisAlignment.end`<br>
  Positions children near the end of the main axis. (Right for `Row`, bottom for `Column`)
* `MainAxisAlignment.center`<br>
  Positions children at the middle of the main axis.
* `MainAxisAlignment.spaceBetween`<br>
  Divides the extra space evenly between children.
* `MainAxisAlignment.spaceEvenly`<br>
  Divides the extra space evenly between children, but also creates an even amount of space before and after the first and last child.
* `MainAxisAlignment.spaceAround`<br>
  Similar to `MainAxisAlignment.spaceEvenly`, but reduces 50% of the extra space before the first child and after the last child. 

#### Code example
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.* 

  `Row` contains three `BlueBox` widgets. Notice how `mainAxisAlignment` is set to `MainAxisAlignment.start`.

  In this code example, the code displays three blue squares on the left side of the grey, rectangular box. 

***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/cb8abed13f90a6a0c7a0ada6f15a09c9
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=cb8abed13f90a6a0c7a0ada6f15a09c9&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

Before moving to the next section, try resetting `mainAxisAlignment` to one of the other `MainAxisAlignment` enums. 

## crossAxisAlignment property

Similar to the `mainAxisAlignment` property, `crossAxisAlignment` is a property that determines how `Row` and `Column` can position their children in extra space. However, the `crossAxisAlignment` property determines how children should be positioned in vertical space. As a result, most of the `crossAxisAlignment` property's `CrossAxisAlignment` enums only function inside of `Row`. The `crossAxisAlignment` property has five `CrossAxisAlignment` enums:

* `CrossAxisAlignment.start`<br>
  Positions children near the top of the cross axis. (`Row`)
* `CrossAxisAlignment.end`<br>
  Positions children near the bottom of the cross axis. (`Row`)
* `CrossAxisAlignment.center`<br>
  Positions children at the middle of the cross axis. (`Row`)
* `CrossAxisAlignment.stretch`<br>
  Stretches children to across the cross axis. (Top to bottom for `Row`, left to right for `Column`)
* `CrossAxisAlignment.baseline`<br>
  Aligns children according to their character baselines. (`Text` class)

{{site.alert.tip}}
  `CrossAxisAlignment.baseline` aligns `Text` classes along their character baselines, but requires the `textBaseline` property. In the following code example, if you reset `crossAxisAlignment` to `CrossAxisAlignment.baseline`, the code displays an error message. `CrossAxisAlignment.baseline` is covered in the [Text class](#text-class) section. 
{{site.alert.end}}

#### Code example 
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.* 

`Row` contains two `BlueBox` widgets and one `BiggerBlueBox` widget. Notice how `crossAxisAlignment` is set to `CrossAxisAlignment.center`.

In this code example, the code displays two squares and one rectangle at the middle of the grey, rectangular box. 

***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/70a6eb88f13019eec349a57bc4fd5fe0
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=70a6eb88f13019eec349a57bc4fd5fe0&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

Before moving to the next section, try resetting `crossAxisAlignment` to one of the other `CrossAxisAlignment` enums. 

## Flexible class

`mainAxisAlignment` and `crossAxisAlignment` are properties that determine how `Row` and `Column` can position widgets in extra space. When `Row` and `Column` lay out widgets, widgets of fixed sizes are laid out first. Widgets of fixed sizes are considered "inflexible" because they can't resize themselves after `Row` and `Column` lay them out. `Flexible` is a class that wraps around a widget, takes the widget as its child, and then resizes the widget. 

When the `Flexible` class wraps around a widget, the widget is considered "flexible" because the widget can resize itself. `Row` and `Column` lay out flexible widgets after inflexible widgets. Flexible widgets resize themselves according to their `flex` and `fit` properties, which determine how much of the extra space each flexible widget receives.

* `flex`
<br>
  Compares itself against other `flex` properties and their corresponding `flex` values before determining what fraction of the extra space each flexible child receives.

* `fit` 
<br>
  Determines whether a flexible child fills all of their extra space. 

#### Code example: flex property
{:.no_toc}
{{site.alert.secondary}}
  *Check out Dart.* 

  `Row` contains one `BlueBox` widget (inflexible) and two `Flexible` classes. Notice how both `Flexible` classes wrap around `BlueBox` widgets, which become flexible widgets. Also, notice that both `Flexible` classes contain `flex` properties with corresponding `flex` values of 1. 

  When `flex` properties compare themselves against one another, they add up their `flex` values, and the sum of the `flex` values determines what fraction of the extra space each flexible widget receives. 
  
  In this code example, the sum of both `flex` values is 2, so each flexible widget receives half of the extra space. 

  ***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/82e4dd24028034ae03ba0ddc71bf59e5
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=82e4dd24028034ae03ba0ddc71bf59e5&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
#### Code example: fit property
{:.no_toc}  
{{site.alert.secondary}}
  *Check out Dart*
  `Row` contains three `Flexible` classes, which all wrap around `BlueBox` widgets. Notice that all three `Flexible` classes contain `flex` properties with different corresponding `flex` values. Also notice that all three `Flexible` classes contain `fit` properties, which 

`fit` has two `fit` values: 

* `FlexFit.loose`
<br>
  Enables flexible children to occupy as much of or as little of the extra space.
* `FlexFit.tight`
<br>
  Forces flexible children to occupy all of the extra space. 

Check out **Dart**. In the code, `Row` contains three `Flexible` classes. Notice that all three `Flexible` classes wrap around `BlueBox` widgets. Also notice that all three `BlueBox` widgets have `flex` properties with different `flex` values.

***Run the code.***  
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=ba0f40356d1023066d960f6de2be1a4b&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The code displays three blue squares, but notice how the silver box contains extra space. 

In this code example, the `Flexible` classes contain `fit` properties set to `FlexFit.loose`. 

. Notice how the silver box contains extra space. `Flexible` classes contain `flex` and `fit` properties, and `fit` properties determine whether `Flexible` classes receieve all of the extra space according to their `flex` values. Notice the display message that suggests resetting the `fit` properties to `FlexFit.tight`. 

1. In the code, replace `FlexFit.loose` with `FlexFit.tight` for each of the three `fit` properties. 
2. Run the code. 

The code displays three blue squares, and now the silver box doesn't contain extra space.

## Expanded class

Similar to the `Flexible` class, `Expanded` is a class that can wrap around a widget, take the widget as its child, and then resize the widget. However, the `Expanded` class doesn't utilize `fit` and `flex` properties to resize its child. Insetad, the `Expanded` class forces its child to fill extra space. 

#### Code example
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.* 

`Row` contains two `BlueBox` widgets and one `Expanded` class. Notice how the `Expanded` class wraps around another `BlueBox` widget. 

In this code example, the code displays three blue squares, and the middle square fills all of the extra space inside the grey, rectangular box.  

***Run the code.*** 
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=77021d2ed15f9ece850de15e73c47526&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>

## SizedBox class

Similar to the `Flexible` and `Expanded` classes, `SizedBox` is a class that can wrap around a widget, take the widget as its child, and then resize the widget. However, the `SizedBox` class also can create space between widgets. Instead of utilizing `flex` and `fit` properties, the `SizedBox` class utilizes `height` and `width` properties.

#### Code example: SizedBox with a child
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.* 

`Row` contains two `BlueBox` widgets and one `SizedBox` class. Notice how the `SizedBox` class wraps around another `BlueBox` widget and contains a `width` property equal to 100. 

In this code example, try adding a height property equal to 100 inside the `SizedBox` class. 

***Run the code.*** 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/6582851e85b57180ff5321f814fabb81
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=6582851e85b57180ff5321f814fabb81&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The `SizedBox` class resizes the middle blue square from 50 X 50 pixels to 100 X 100 pixels. 

#### Code example: SizedBox without a child
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.* 

`Row` contains three `BlueBox` widgets and one `SizedBox` class. Notice how the `SizedBox` class separates the first and second `BlueBox` widgets. Also, notice how the `SizedBox` class doesn't wrap around a widget and only contains a `width` property. 

When the `SizedBox` class creates space between widgets, the `SizedBox` class doesn't take a child widget. Also, when `Row` contains a `SizedBox` class, the `SizedBox` class only utilizes a `width` property. Likewise, when `Column` contains a `SizedBox` class, the `SizedBox` class only utilizes a `height` property.

In this code example, try adding another `SizedBox` class between the second and third `BlueBox` widgets. Then add a `width` property equal to 25 inside the the `SizedBox` class.

***Run the code.*** 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/19ead147ab5c7668d7d32e1cfed90097
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=19ead147ab5c7668d7d32e1cfed90097&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The `SizedBox` classes create different amounts of space between all three blue squares, one that has a width of 50 pixels and another that has a width of 25 pixels. 

## Spacer class

Similar to the `SizedBox` class, `Spacer` is a class that creates space between widgets. However, the `Spacer` class can't take child widgets and doesn't create space at exact dimensions. Instead, the `Spacer` class creates space according to its `flex` property and corresponding `flex` value.

#### Code example
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.* 

`Row` contains three `BlueBox` widgets and one `Spacer` class that contains a `flex` property equal to 1. Notice how the `Spacer` class separates the first and second `BlueBox` widgets. 

In this codelab, try adding another `Spacer` class between the second and third `BlueBox` widgets. Then add another `flex` property equal to 1 inside the `Spacer` class. 

***Run the code.*** 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/bfc367aefde35e02ea5283efdbf58e60
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=bfc367aefde35e02ea5283efdbf58e60&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The `Spacer` classes create equal amounts of space between all three blue squares. 
## Text class

`Text` is a class that displays a string of text. The text class can display text at various font sizes and in different fonts and colors. 

#### Code example
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.*

  `Row` contains three `Text` classes, which all display "Hey!" in the same font, but at various font sizes and in different colors. Notice how `Row` also contains the `crossAxisAlignment` property and the `textBaseline` property. 

  Earlier in this codelab, you learn about the `crossAxisAlignment` property and its `CrossAxisAlignment` enum `CrossAxisAlignment.baseline`. When `Row` and `Column` contain `Text` classes, the `crossAxisAlignment` property set to `CrossAxisAlignment.baseline` can align the `Text` classes along their character baselines. However, the `crossAxisAlignment` property requires the `textBaseline` property set to `TextBaseline.alphabetic`. 

  In this code example, try resetting the `crossAxisAlignment` property to `CrossAxisAlignment.baseline`.  

***Run the code***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/0ff109090b99ef1873d9fad501b2bc86
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=0ff109090b99ef1873d9fad501b2bc86&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The code displays "Hey! Hey! Hey!" along their character baselines.
## Icon class

`Icon` is a class that displays glyphs. Flutter is preloaded with multiple icon packages for Android and iOS applications. 

#### Code example
{:.no_toc}
{{site.alert.secondary}}
  *Check out Dart.* 

  `Row` contains three `Icon` classes, which all display widget icons in the same size. Notice how the first and second `Icon` classes contain `color` properties.

  In this code example, try adding a `color` property set to `Colors.amber` inside the third `Icon` class.   

  ***Run the code***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/01688fca8c13f85d93078054af2e858b
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=01688fca8c13f85d93078054af2e858b&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The code displays three widget icons in blue, red, and amber.
## Image class 

`Image` is a class that links to and displays an image. Unlike the widgets previously covered in this codelab, the `Image` class references its data, which is stored remotely.

#### Code example
{:.no_toc}
{{site.alert.secondary}}
  *Check out Dart* 

  `Row` contains an `Image` class. Notice how the `Image` class references its image. The `Image` class initiates that it's linking to an image with `.Network` followed by parentheses. Then, inside the parentheses, the `Image` class links to its image.

  In this code example, the code displays an image that's stored remotely on [GitHub](https://github.com/flutter/website/tree/master/examples/layout/sizing/images).

  ***Run the code.*** 
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=b6f3084800bd139cdb522b8858bb58b7&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
## Test yourself 
### Part 1
### Part 2
### Part 3
## Conclusion 
