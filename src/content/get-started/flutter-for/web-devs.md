---
title: Flutter for web developers
description: >-
  Learn how to apply Web developer knowledge when building Flutter apps.
---

<?code-excerpt path-base="get-started/flutter-for/web_devs"?>

This page is for users who are familiar with the HTML
and CSS syntax for arranging components of an application's UI.
It maps HTML/CSS code snippets to their Flutter/Dart code equivalents.

Flutter is a framework for building cross-platform applications
that uses the Dart programming language.
To understand some differences between programming with Dart
and programming with Javascript, 
see [Learning Dart as a JavaScript Developer][].

One of the fundamental differences between
designing a web layout and a Flutter layout,
is learning how constraints work,
and how widgets are sized and positioned.
To learn more, see [Understanding constraints][].

The examples assume:

* The HTML document starts with `<!DOCTYPE html>`, and the CSS box model
  for all HTML elements is set to [`border-box`][],
  for consistency with the Flutter model.

  ```css
  {
      box-sizing: border-box;
  }
  ```
* In Flutter, the default styling of the 'Lorem ipsum' text
  is defined by the `bold24Roboto` variable as follows,
  to keep the syntax simple:

  <?code-excerpt "lib/main.dart (text-style)"?>
  ```dart
  TextStyle bold24Roboto = const TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  ```

:::secondary
How is react-style, or _declarative_, programming different from the
traditional imperative style?
For a comparison, see [Introduction to declarative UI][].
:::

## Performing basic layout operations

The following examples show how to perform the most common UI layout tasks.

### Styling and aligning text

Font style, size, and other text attributes that CSS
handles with the font and color properties are individual
properties of a [`TextStyle`][] child of a [`Text`][] widget.

For text-align property in CSS that is used for aligning text,
there is a textAlign property of a [`Text`][] widget.

In both HTML and Flutter, child elements or widgets
are anchored at the top left, by default.

```css highlightLines=9
<div class="grey-box">
  Lorem ipsum
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Georgia;
}
```

```dart highlightLines=8-13
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: const Text(
    'Lorem ipsum',
    style: TextStyle(
      fontFamily: 'Georgia',
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  ),
);
```

### Setting background color

In Flutter, you set the background color using the `color` property
or the `decoration` property of a [`Container`][].
However, you cannot supply both, since it would potentially
result in the decoration drawing over the background color.
The `color` property should be preferred
when the background is a simple color.
For other cases, such as gradients or images,
use the `decoration` property.

The CSS examples use the hex color equivalents to the Material color palette.

```css highlightLines=6
<div class="grey-box">
  Lorem ipsum
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
}
```

```dart highlightLines=5
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Text(
    'Lorem ipsum',
    style: bold24Roboto,
  ),
);
```

```dart highlightLines=5-7
final container = Container(
  // grey box
  width: 320,
  height: 240,
  decoration: BoxDecoration(
    color: Colors.grey[300],
  ),
  child: Text(
    'Lorem ipsum',
    style: bold24Roboto,
  ),
);
```

### Centering components

A [`Center`][] widget centers its child both horizontally
and vertically.

To accomplish a similar effect in CSS, the parent element uses either a flex
or table-cell display behavior. The examples on this page show the flex
behavior.

```css highlightLines=10-12
<div class="grey-box">
  Lorem ipsum
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
```

```dart highlightLines=6-7
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Text(
      'Lorem ipsum',
      style: bold24Roboto,
    ),
  ),
);
```

### Setting container width

To specify the width of a [`Container`][]
widget, use its `width` property.
This is a fixed width, unlike the CSS max-width property
that adjusts the container width up to a maximum value.
To mimic that effect in Flutter,
use the `constraints` property of the Container.
Create a new [`BoxConstraints`][] widget with a `minWidth` or `maxWidth`.

For nested Containers, if the parent's width is less than the child's width,
the child Container sizes itself to match the parent.

```css highlightLines=9,20-21
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    width: 100%;
    max-width: 240px;
}
```

```dart highlightLines=3,9
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      width: 240, // max-width is 240
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);
```

## Manipulating position and size

The following examples show how to perform more complex operations
on widget position, size, and background.

### Setting absolute position

By default, widgets are positioned relative to their parent.

To specify an absolute position for a widget as x-y coordinates,
nest it in a [`Positioned`][] widget that is,
in turn, nested in a [`Stack`][] widget.

```css highlightLines=8,18-20
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    position: relative;
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    position: absolute;
    top: 24px;
    left: 24px;
}
```

```dart highlightLines=6-7,10-11
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Stack(
    children: [
      Positioned(
        // red box
        left: 24,
        top: 24,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red[400],
          ),
          child: Text(
            'Lorem ipsum',
            style: bold24Roboto,
          ),
        ),
      ),
    ],
  ),
);
```

### Rotating components

To rotate a widget, nest it in a [`Transform`][] widget.
Use the `Transform` widget's `alignment` and `origin` properties
to specify the transform origin (fulcrum) in relative and absolute terms,
respectively.

For a simple 2D rotation, in which the widget is rotated on the Z axis,
create a new [`Matrix4`][] identity object
and use its `rotateZ()` method to specify the rotation factor
using radians (degrees × π / 180).

```css highlightLines=20
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    transform: rotate(15deg);
}
```

```dart highlightLines=7-10,
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateZ(15 * 3.1415927 / 180),
      child: Container(
        // red box
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        child: Text(
          'Lorem ipsum',
          style: bold24Roboto,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ),
);
```

### Scaling components

To scale a widget up or down, nest it in a [`Transform`][] widget.
Use the Transform widget's `alignment` and `origin` properties
to specify the transform origin (fulcrum) in relative or absolute terms,
respectively.

For a simple scaling operation along the x-axis,
create a new [`Matrix4`][] identity object
and use its `scale()` method to specify the scaling factor.

When you scale a parent widget,
its child widgets are scaled accordingly.

```css highlightLines=20
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    transform: scale(1.5);
}
```

```dart highlightLines=7-10
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..scale(1.5),
      child: Container(
        // red box
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        child: Text(
          'Lorem ipsum',
          style: bold24Roboto,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ),
);
```

### Applying a linear gradient

To apply a linear gradient to a widget's background,
nest it in a [`Container`][] widget.
Then use the `Container` widget's `decoration` property to create a
[`BoxDecoration`][] object, and use `BoxDecoration`'s `gradient`
property to transform the background fill.

The gradient "angle" is based on the Alignment (x, y) values:

* If the beginning and ending x values are equal,
  the gradient is vertical (0° | 180°).
* If the beginning and ending y values are equal,
  the gradient is horizontal (90° | 270°).

#### Vertical gradient

```css highlightLines=19
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    padding: 16px;
    color: #ffffff;
    background: linear-gradient(180deg, #ef5350, rgba(0, 0, 0, 0) 80%);
}
```

```dart highlightLines=9-18
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.0, 0.6),
          colors: <Color>[
            Color(0xffef5350),
            Color(0x00ef5350),
          ],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);
```

#### Horizontal gradient

```css highlightLines=19
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    padding: 16px;
    color: #ffffff;
    background: linear-gradient(90deg, #ef5350, rgba(0, 0, 0, 0) 80%);
}
```

```dart highlightLines=10-19
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(0.6, 0.0),
          colors: <Color>[
            Color(0xffef5350),
            Color(0x00ef5350),
          ],
        ),
      ),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);
```

## Manipulating shapes

The following examples show how to make and customize shapes.

### Rounding corners

To round the corners of a rectangular shape,
use the `borderRadius` property of a [`BoxDecoration`][] object.
Create a new [`BorderRadius`][]
object that specifies the radius for rounding each corner.

```css highlightLines=20
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    border-radius: 8px;
}
```

```dart highlightLines=12-14
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red circle
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);
```

### Adding box shadows

In CSS you can specify shadow offset and blur in shorthand,
using the box-shadow property. This example shows two box shadows,
with properties:

* `xOffset: 0px, yOffset: 2px, blur: 4px, color: black @80% alpha`
* `xOffset: 0px, yOffset: 06x, blur: 20px, color: black @50% alpha`

In Flutter, each property and value is specified separately.
Use the `boxShadow` property of `BoxDecoration` to create a list of
[`BoxShadow`][] widgets. You can define one or multiple
`BoxShadow` widgets, which can be stacked
to customize the shadow depth, color, and so on.

```css highlightLines=20-21
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.8),
              0 6px 20px rgba(0, 0, 0, 0.5);
}
```

```dart highlightLines=15-26
final container = Container(
  // grey box
  width: 320,
  height: 240,
  margin: const EdgeInsets.only(bottom: 16),
  decoration: BoxDecoration(
    color: Colors.grey[300],
  ),
  child: Center(
    child: Container(
      // red box
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[400],
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0xcc000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
          BoxShadow(
            color: Color(0x80000000),
            offset: Offset(0, 6),
            blurRadius: 20,
          ),
        ],
      ),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);
```

### Making circles and ellipses

Making a circle in CSS requires a workaround of applying a
border-radius of 50% to all four sides of a rectangle,
though there are [basic shapes][].

While this approach is supported
with the `borderRadius` property of [`BoxDecoration`][],
Flutter provides a `shape` property
with [`BoxShape` enum][] for this purpose.

```css highlightLines=20-23
<div class="grey-box">
  <div class="red-circle">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-circle {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    text-align: center;
    width: 160px;
    height: 160px;
    border-radius: 50%;
}
```

```dart highlightLines=11,14-15,19
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red circle
      decoration: BoxDecoration(
        color: Colors.red[400],
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(16),
      width: 160,
      height: 160,
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
        textAlign: TextAlign.center,
      ),
    ),
  ),
);
```

## Manipulating text

The following examples show how to specify fonts and other
text attributes. They also show how to transform text strings,
customize spacing, and create excerpts.

### Adjusting text spacing

In CSS, you specify the amount of white space
between each letter or word by giving a length value
for the letter-spacing and word-spacing properties, respectively.
The amount of space can be in px, pt, cm, em, etc.

In Flutter, you specify white space as logical pixels
(negative values are allowed)
for the `letterSpacing` and `wordSpacing` properties
of a [`TextStyle`][] child of a `Text` widget.

```css highlightLines=20
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    letter-spacing: 4px;
}
```

```dart highlightLines=19
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      child: const Text(
        'Lorem ipsum',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w900,
          letterSpacing: 4,
        ),
      ),
    ),
  ),
);
```

### Making inline formatting changes

A [`Text`][] widget lets you display text
with some formatting characteristics.
To display text that uses multiple styles
(in this example, a single word with emphasis),
use a [`RichText`][] widget instead.
Its `text` property can specify one or more
[`TextSpan`][] objects that can be individually styled.

In the following example, "Lorem" is in a `TextSpan`
with the default (inherited) text styling,
and "ipsum" is in a separate `TextSpan` with custom styling.

```css highlightLines=3,11,21-4
<div class="grey-box">
  <div class="red-box">
    Lorem <em>ipsum</em>
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
}
.red-box em {
    font: 300 48px Roboto;
    font-style: italic;
}
```

```dart highlightLines=13-28
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      padding: const EdgeInsets.all(16),
      child: RichText(
        text: TextSpan(
          style: bold24Roboto,
          children: const <TextSpan>[
            TextSpan(text: 'Lorem '),
            TextSpan(
              text: 'ipsum',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                fontSize: 48,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);
```

### Creating text excerpts

An excerpt displays the initial line(s) of text in a paragraph,
and handles the overflow text, often using an ellipsis.

In Flutter, use the `maxLines` property of a [`Text`][] widget
to specify the number of lines to include in the excerpt,
and the `overflow` property for handling overflow text.

```css highlightLines=20-23
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum dolor sit amet, consec etur
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    overflow: hidden;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
}
```

```dart highlightLines=16-17
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      padding: const EdgeInsets.all(16),
      child: Text(
        'Lorem ipsum dolor sit amet, consec etur',
        style: bold24Roboto,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ),
  ),
);
```


[basic shapes]: https://developer.mozilla.org/en-US/docs/Web/CSS/basic-shape
[`border-box`]: https://css-tricks.com/box-sizing/
[`BorderRadius`]: {{site.api}}/flutter/painting/BorderRadius-class.html
[`BoxDecoration`]: {{site.api}}/flutter/painting/BoxDecoration-class.html
[`BoxConstraints`]: {{site.api}}/flutter/rendering/BoxConstraints-class.html
[`BoxShape` enum]: {{site.api}}/flutter/painting/BoxShape.html
[`BoxShadow`]: {{site.api}}/flutter/painting/BoxShadow-class.html
[`Center`]: {{site.api}}/flutter/widgets/Center-class.html
[`Container`]: {{site.api}}/flutter/widgets/Container-class.html
[Introduction to declarative UI]: /get-started/flutter-for/declarative
[Learning Dart as a JavaScript Developer]: {{site.dart-site}}/guides/language/coming-from/js-to-dart
[`Matrix4`]: {{site.api}}/flutter/vector_math_64/Matrix4-class.html
[`Positioned`]: {{site.api}}/flutter/widgets/Positioned-class.html
[`RichText`]: {{site.api}}/flutter/widgets/RichText-class.html
[`Stack`]: {{site.api}}/flutter/widgets/Stack-class.html
[`Text`]: {{site.api}}/flutter/widgets/Text-class.html
[`TextSpan`]: {{site.api}}/flutter/painting/TextSpan-class.html
[`TextStyle`]: {{site.api}}/flutter/painting/TextStyle-class.html
[`Transform`]: {{site.api}}/flutter/widgets/Transform-class.html
[Understanding constraints]: /ui/layout/constraints

