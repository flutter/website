---
title: "Working title"
description: "A codelab that uses DartPad2 to teach Flutter layout concepts."
toc: true
--- 
{{site.alert.secondary}}
  <h4 class="no_toc">Introduction</h4>
  * To learn about Flutter and its core layout concepts. 
  * To gain experience writing code in Dart.  
  * To understand how Flutter builds its UI. 
{{site.alert.end}}

#### Requirements
{:.no_toc}
* An understanding of [Flutter](https://www.flutter.dev) 
* An understanding of [Dart](https://www.dart.dev) or some exposure to object-oriented programming

#### System requirements
{:.no_toc}
* A PC (Microsoft, Mac, or Linux) with Google Chrome installed

{{site.alert.important}}
  This codelab features embedded code examples that are based on an experimental code editor. The code editor is being developed and tested with Google Chrome. Some of the features in this codelab may not function on other browsers.
{{site.alert.end}}

## Widget class

Widgets are immutable objects that build specific parts of a UI.

As you progress through this codelab, you learn that everything in Fluter is a widget: from the UI to the code.  

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

## Row and Column classes

`Row` and `Column` are classes that house widgets. When `Row` and `Column` house widgets, the widgets become children, thus `Row` and `Column` become parents. 

When `Row` or `Column` houses children, the children are laid out. `Row` lays out its children horizontally, and `Column` lays out its children vertically. 

{{site.alert.note}}
  In Flutter, left-to-right and right-to-left languages are supported.  
{{site.alert.end}}

#### Code example: Row
{:.no_toc}

Check out **Dart**. In the code, `Row` houses three children, all `BlueBox` widgets. 

1. Run the code.    

{% comment %}
  Gist: https://gist.github.com/26c8fb02c58c4120917b073ec6253953
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=26c8fb02c58c4120917b073ec6253953&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe> 
<br>

The code displays three blue squares horizontally.

#### Code example: Column
{:.no_toc}

Check out **Dart**. `Column` houses three children, all `BlueBox` widgets. 

1. Run the code. 

{% comment %}
  Gist: https://gist.github.com/db96dc75c3283227bc849ba31d213783
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=db96dc75c3283227bc849ba31d213783&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>

The code displays three blue squares vertically.

## mainAxisSize property

`Row` and `Column` rest on their main axes. `Row`'s main axis horizontal, and `Column`'s main axis is vertical. 

`mainAxisSize` is a property that determines how much space a `Row` and `Column` can occupy on their main axes. 

`mainAxisSize` has two `MainAxisSize` enums: 

* `MainAxisSize.max`
<br/>
Increases the amount of space `Row` and `Column` can occupy on their main axes. 
* `MainAxisSize.min` 
<br/>
Decreases the amount of space `Row` and `Column` can occupy on their main axes.  

#### Code example 
{:.no_toc}

Check out **Dart**. `Row` houses three `BlueBox` widgets. Notice how `mainAxisSize` is set to `MainAxisSize.max`. 

1. Run the code. 

{% comment %}
  Gist: https://gist.github.com/def3c5c3c68459b5bb4bdfed58f5d024
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=def3c5c3c68459b5bb4bdfed58f5d024&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>

The code displays three blue sqaures. But notice how the grey, rectangular box has extra space.  

When `mainAxisSize` is set to `MainAxisSize.max`, `Row` or `Column` occupies all of the space on its main axis. As a result, `Row` or `Column`'s main axis may have extra space. But, when `mainAxisSize` is set to `MainAxisSize.min`, `Row` or `Column` occupies the same amount of space that its children occupy.  

In this code example, `Row` occupies more than the space that its children occupy. Try resetting `mainAxisSize` to `MainAxisSize.min`. 

1. In the code, replace `MainAxisSize.max` with `MainAxisSize.min`.
2. Run the code. 

The code displays three blue squares. And notice how the grey, rectangular box doesn't have extra space. 

## mainAxisAlignment property

When `mainAxisSize` is set to `MainAxisSize.max`, `Row` or `Column`'s main axis may have extra space. 

`mainAxisAlignment` is a property that determines how `Row` and `Column` can position their children horizontally in that extra space. 

`mainAxisAlignment` has six `MainAxisAlignment` enums: 

* `MainAxisAligment.start`<br>
  Positions children near the beginning of the extra space.
* `MainAxisAligment.end`<br>
  Positions children near the end of the extra space.
* `MainAxisAligment.center`<br>
  Positions children at the center of the extra space.
* `MainAxisAligment.spaceBetween`<br>
  Divides the extra space evenly between children.
* `MainAxisAligment.spaceEvenly`<br>
  Divides the extra space evenly between children, but also creates an even amount of space before and after the first and last child.
* `MainAxisAligment.spaceAround`<br>
  Similar to `MainAxisAlignment.spaceEvenly`, but reduces 50% of the extra space before the first child and after the last child. 

#### Code example
{:.no_toc}

Check out **Dart**. `Row` houses three `BlueBox` widgets. Notice how `mainAxisAlignment` is set to `MainAxisAlignment.start`. 

1. Run the code.

{% comment %}
  Gist: https://gist.github.com/cb8abed13f90a6a0c7a0ada6f15a09c9
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=cb8abed13f90a6a0c7a0ada6f15a09c9&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The code displays three blue squares horizontally. But, before moving to the next section, try resetting `mainAxisAlignment` to one of the other `MainAxisAlignment` enums. 

## crossAxisAlignment property

Similar to `mainAxisAlignment`, `crossAxisAlignment` is a property that determines how `Row` and `Column` can position their children in extra space. However, `crossAxisAlignment` determines how `Row` and `Column` can position their children vertically.

`crossAxisAlignment` has five `CrossAxisAlignment` enums: 

* `CrossAxisAlignment.start`<br>
  Positions children at the top of `Row` and `Column`’s vertical space.
* `CrossAxisAlignment.end`<br>
  Positions children at the bottom of `Row` and `Column`’s vertical space.
* `CrossAxisAlignment.center`<br>
  Positions children at the middle of `Row` and `Column`’s vertical space.
* `CrossAxisAlignment.stretch`<br>
  Stretches children to fill all of `Row` and `Column`’s vertical space. 
* `CrossAxisAlignment.baseline`<br>
  Aligns children inside of `Row` and `Column` by their baselines.

#### Code example 
{:.no_toc}

Check out **Dart**. `Row` houses two `BlueBox` widgets and one `BiggerBlueBox` widget. Notice how `crossAxisAlignment` is set to `CrossAxisAlignment.center`.

1. Run the code. 

{% comment %}
  Gist: https://gist.github.com/70a6eb88f13019eec349a57bc4fd5fe0
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=70a6eb88f13019eec349a57bc4fd5fe0&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The code displays two blue squares and one blue rectangle vertically. But, before moving to the next section, try resetting `crossAxisAlignment` to one of the other `CrossAxisAlignment` enums. 

{{site.alert.tip}}
  When you reset  `crossAxisAlignment` to `CrossAxisAlignment.baseline`, the code displays an error message. `crossAxisAlignment: CrossAxisAlignment.baseline` requires `textBaseline`, a property that aligns `Text` classes, not by their overall bounds, but by their baselines. `CrossAxisalignment.baseline` is covered in [Text](#text). 
{{site.alert.end}}

## Flexible class

`crossAxisAlignment` and `mainAxisAlignment` are properties that determine how `Row` and `Column` can position their children in extra space. In the previous code examples, `Row` and `Column` house children of fixed sizes. Children of fixed sizes are considered "inflexible" because `Row` and `Column` determine their sizes. `Flexible` is a class that wraps around a widget and then makes the widget its child. When `Flexible` classes make widgets their children, the children are considered "flexible" because they determine their own sizes.

When `Row` or `Column` lays out its children, `Row` or `Column` lays out its inflexible children first. If `Row` or `Column`'s main axis has extra space, `Row` or `Column` divides that extra space among its flexible children. `Flexible` determines how that extra space is divided among `Row` or `Column`'s flexible children.

`Flexible` has two properties that help determine how extra space is divided among flexible children. 

* `flex`
<br>
  Compares flexible children against one another and then determines how much of the extra space each flexible child receieves.
* `fit` 
<br>
  Determines whether a flexible child receives all of the extra space. 

#### Code example (flex property)
{:.no_toc}

Check out **Dart**. In the code, `Row` contains one `BlueBox` widget and two `Flexible` classes. Notice how both `Flexible` classes wrap around `BlueBox` widgets and make the `BlueBox` widgets their children. Also notice how both `Flexible` classes contain `flex` properties with different `flex` values.

1. Run the code.

<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=82e4dd24028034ae03ba0ddc71bf59e5&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The code displays three blue squares, but notice how two of the squares are displayed at different sizes. 

In a `Row` or `Column`, when `Flexible` classes wrap around widgets, the `Flexible` classes assign the widgets `flex` properties with `flex` values. The `flex` properties then compare themselves against one another according to their `flex` values divided by the total number of `flex` values. 

In this code example, one flexible `BlueBox` widget contains a `flex` property of 1, and the other flexible `BlueBox` widget contains a `flex` property of 2. The total number `flex` values is 3, so one flexible `BlueBox` widget receieves one third of the extra space while the other flexible `BlueBox` widget receives two-thirds of the extra space.

#### Code example (fit property)
{:.no_toc}  

`fit` has two `fit` values: 

* `FlexFit.loose`
<br>
  Enables flexible children to occupy as much of or as little of the extra space.
* `FlexFit.tight`
<br>
  Forces flexible children to occupy all of the extra space. 

Check out **Dart**. In the code, `Row` contains three `Flexible` classes. Notice that all three `Flexible` classes wrap around `BlueBox` widgets. Also notice that all three `BlueBox` widgets have `flex` properties with different `flex` values.

1. Run the code.  

<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=ba0f40356d1023066d960f6de2be1a4b&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The code displays three blue squares, but notice how the silver box contains extra space. 

In this code example, the `Flexible` classes contain `fit` properties set to `FlexFit.loose`. 

. Notice how the silver box contains extra space. `Flexible` classes contain `flex` and `fit` properties, and `fit` properties determine whether `Flexible` classes receieve all of the extra space according to their `flex` values. Notice the display message that suggests resetting the `fit` properties to `FlexFit.tight`. 

1. In the code, replace `FlexFit.loose` with `FlexFit.tight` for each of the three `fit` properties. 
2. Run the code. 

The code displays three blue squares, and now the silver box doesn't contain extra space.

## Expanded class

Similar to the `Flexible` class, `Expanded` is a class that wraps around a widget and then makes the widget its child. The difference is that the `Expanded` class doesn't require a `flex` or `fit` property.

#### Code example
{:.no_toc}

Check out **Dart**. In the code, `Row` contains three `BlueBox` widgets. 

1. Run the code. 

<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=77021d2ed15f9ece850de15e73c47526&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>

The code displays three blue squares. Notice that the silver box contains extra space. Try wrapping the second `BlueBox` in an `Expanded` class, so the middle, blue square fills the extra space.

1.  

## SizedBox class

Similar to the `Expanded` and `Flexible` classes, `SizedBox` is a class that can wrap around a widget and then make the widget its child. The difference is that the `SizedBox` class doesn't require a child widget.

#### Code example: SizedBox with a child
{:.no_toc}

When `SizedBox` wraps around a widget, it makes the widget its child and then resizes the widget to an exact dimension. `SizedBox` resizes widgets with `width` and `height` properties. 

Check out **Dart**. In the code, `Row` contains two `BlueBox` widgets and one `SizedBox` class. Notice that `SizedBox` wraps around a `BlueBox` widget and contains a `width` property of 100.

1. Run the code. 

{% comment %}
  Gist: https://gist.github.com/datafoya/6582851e85b57180ff5321f814fabb81
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=6582851e85b57180ff5321f814fabb81&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>

The code displays three blue squares. Notice how `SizedBox` increases the middle, blue square's width from 50 to 100. Try adding a `height` property to `SizedBox`.  

1. In the code, create a new line under `width: 100`.
2. On the new line, enter `height: 100`. 
3. Run the code. 

The code displays three blue squares, and now the middle square has a width and height of 100.

#### Code example: SizedBox without a child
{:.no_toc}

`SizedBox` doesn't require a child widget. When `SizedBox` doesn't wrap around a widget, `SizedBox` creates space between widgets. 

Check out **Dart**. In the code, `Row` contains three `BlueBox` eidgets and one `SizedBox` class. Notice how the `SizedBox` separates the first and second `BlueBox` widgets. Also notice that `SizedBox` contains a `width` property of 100.

1. Run the code. 

{% comment %}
  Gist: https://gist.github.com/datafoya/19ead147ab5c7668d7d32e1cfed90097
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=19ead147ab5c7668d7d32e1cfed90097&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The code displays three blue squares, and `SizedBox` creates a gap between the first and middle squares. Try adding another `SizedBox` class to `Row`. 

1. In the code, create a new line between the second and third `BlueBox` widgets. 
2. On the new line, enter `SizedBox()`.
2. Inside of the parentheses, enter `width: 25`. 
3. Run the code. 

The code displays three blue squares, but now the squares have gaps between them, one with a width of 50 and another with a width of 25. 

## Spacer class

Similar to `SizedBox`, `Spacer` is a class that creates space between widgets. The difference is that `Spacer` requires a `flex` property instead of `width` and `height` properties.

#### Code example
{:.no_toc}

Check out **Dart**. In the code, `Row` contains three `BlueBox` widgets and one `Spacer` class. Notice how `Spacer` separates the first and second `BlueBox` widgets. 

1. Run the code. 

{% comment %}
  Gist: https://gist.github.com/datafoya/bfc367aefde35e02ea5283efdbf58e60
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=bfc367aefde35e02ea5283efdbf58e60&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The code displays three blue squares, and `Spacer` creates a gap between the first and middle squares. Notice how the gap takes up all of the extra space inside the silver box. Try adding another `Spacer` class to `Row`. 

1. In the code, create a new line between the second and third `BlueBox` widgets. 
2. On the new line, enter `Spacer()`. 
3. Inside of the parentheses, enter `flex: 2`. 
4. Run the code. 

The code displays three blue squares, but now the squares have gaps between them. 

## Text class

`Text` is a class that displays a single line of text. `Text` classes can display lines of text in different fonts, styles, and colors. 

#### Code example
{:.no_toc}

Check out **Dart**. In the code, `Row` contains three `Text` classes. Also, notice that `Row` contains two properties: `crossAxisalignment` and `textBaseline`. 

1. Run the code. 

{% comment %}
  Gist: https://gist.github.com/datafoya/0ff109090b99ef1873d9fad501b2bc86
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=0ff109090b99ef1873d9fad501b2bc86&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
<br>
The code displays "Hey! Hey! Hey!" at three different font sizes and in Arial and black. Notice how "Hey! Hey! Hey!" is displayed at the center of the silver box. Try resetting `crossAxisAlignment` to `CrossAxisAlignment.baseline`. 

1. In the code, replace `CrossAxisAlignment.center` with `CrossAxisAlignment.baseline`.
2. Run the code. 

The code now displays all three `Text` classes on the same baseline. 

## Icon class
 
Icon is a class that displays glyphs and symbols.

#### Code example
{:.no_toc}

Check out **Dart**. In the code, `Row` contains three `Icon` classes.

1. Run the code.

{% comment %}
  Gist: https://gist.github.com/datafoya/01688fca8c13f85d93078054af2e858b
{% endcomment %}
<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=01688fca8c13f85d93078054af2e858b&fw=true" width="100%" height="400px"></iframe>
<br>

The code displays a yellow sun, a white cloud, and a snowflake. Try adding a color property to `Icons.ac_unit`. 

1. In the code, create a new line under `size:50`.
2. On the new line, enter `color: Colors.blue`. 
3. Run the code. 

The code displays all three icons, but now the snowflake is blue. 

## Image class 

`Image` is a class that displays images. Unlike the widgets previously covered in this codelab, the `Image` class references data that's stored in another location.  

#### Code example
{:.no_toc}

Check out **Dart**. In the code, `Row` contains three `Expanded` classes. Notice how the `Expanded` classes wrap around the `Image` classes. Also notice how the `Image` classes reference their images, which are stored on GitGub.com. 

1. Run the code.  

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=b6f3084800bd139cdb522b8858bb58b7&fw=true" width="100%" height="400px"></iframe>
<br>

The code displays three images. 

## Test yourself 
### Part 1
### Part 2
### Part 3
## Conclusion 
