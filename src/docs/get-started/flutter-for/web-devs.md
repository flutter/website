---
title: Flutter for web developers
description: Learn how to apply Web developer knowledge when building Flutter apps.
css-old: [two_column.css]
---

This page is for users who are familiar with the HTML and CSS syntax for
arranging components of an application's UI. It maps HTML/CSS code snippets to
their Flutter/Dart code equivalents.

The examples assume:

* The HTML document starts with `<!DOCTYPE html>`, and the CSS box model
  for all HTML elements is set to
  [`border-box`](https://css-tricks.com/box-sizing/),
  for consistency with the Flutter model.
  ```css
  {
    box-sizing: border-box;
  }
  ```
* In Flutter, the default styling of the "Lorem ipsum" text is defined by the
  `bold24Roboto` variable as follows, to keep the syntax simple:
  ```dart
  TextStyle bold24Roboto = TextStyle(
    color: Colors.white,
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
  );
  ```

{{site.alert.secondary}}
How is react-style, or _declarative_, programming different than the
traditional imperative style?
For a comparison, see [Introduction to declarative
UI](/docs/get-started/flutter-for/declarative).
{{site.alert.end}}

## Performing basic layout operations

The following examples show how to perform the most common UI layout tasks.

### Styling and aligning text

Font style, size, and other text attributes that CSS handles with the font and
color properties are individual properties of a
[TextStyle](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
child of a
[Text](https://docs.flutter.io/flutter/widgets/Text-class.html) widget.

In both HTML and Flutter, child elements or widgets are anchored at
the top left, by default.

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
    Lorem ipsum
</div>

.greybox {
      background-color: #e0e0e0; /* grey 300 */
      width: 320px;
      height: 240px;
[[highlight]]      font: 900 24px Georgia;[[/highlight]]
    }
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
  var container = Container( // grey box
    child: Text(
      "Lorem ipsum",
      style: [[highlight]]TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w900,
        fontFamily: "Georgia",
      ),[[/highlight]]
    ),
    width: 320.0,
    height: 240.0,
    color: Colors.grey[300],
  );
{% endprettify %}
</div>

### Setting background color

In Flutter, you set the background color using a
[Container](https://docs.flutter.io/flutter/widgets/Container-class.html)’s
`decoration` property.

The CSS examples use the hex color equivalents to the Material color palette.
<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  Lorem ipsum
</div>

.greybox {
[[highlight]]      background-color: #e0e0e0;[[/highlight]]  /* grey 300 */
      width: 320px;
      height: 240px;
      font: 900 24px Roboto;
    }
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
  var container = Container( // grey box
    child: Text(
      "Lorem ipsum",
      style: bold24Roboto,
    ),
    width: 320.0,
    height: 240.0,
[[highlight]]    color: Colors.grey[300],[[/highlight]]
  );
{% endprettify %}
</div>

### Centering components

A [Center](https://docs.flutter.io/flutter/widgets/Center-class.html) widget
centers its child both horizontally and vertically.

To accomplish a similar effect in CSS, the parent element uses either a flex
or table-cell display behavior. The examples on this page show the flex
behavior.

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  Lorem ipsum
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
[[highlight]]  display: flex;
  align-items: center;
  justify-content: center; [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
  child: [[highlight]] Center(
    child: [[/highlight]] Text(
      "Lorem ipsum",
      style: bold24Roboto,
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### Setting container width

To specify the width of a
[Container](https://docs.flutter.io/flutter/widgets/Container-class.html)
widget, use its `width` property. This is a fixed width, unlike the
CSS max-width property that adjusts the container width up to a maximum value.
To mimic that effect in Flutter, use the `constraints` property of the
Container. Create a new
[BoxConstraints](https://docs.flutter.io/flutter/rendering/BoxConstraints-class.html)
widget with a `minWidth` or `maxWidth`.

For nested Containers, if the parent’s width is less than the child’s width,
the child Container sizes itself to match the parent.

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
[[highlight]]  width: 320px; [[/highlight]]
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  width: 100%;
  max-width: 240px; [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
  child: Center(
    child: Container( // red box
      child: Text(
        "Lorem ipsum",
        style: bold24Roboto,
      ),
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      padding: EdgeInsets.all(16.0),
[[highlight]]      width: 240.0, [[/highlight]]//max-width is 240.0
    ),
  ),
[[highlight]]  width: 320.0, [[/highlight]]
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

## Manipulating position and size

The following examples show how to perform more complex operations on widget
position, size, and background.

### Setting absolute position

By default, widgets are positioned relative to their parent.

To specify an absolute position for a widget as x-y coordinates, nest it in a
[Positioned](https://docs.flutter.io/flutter/widgets/Positioned-class.html)
widget that is, in turn, nested in a
[Stack](https://docs.flutter.io/flutter/widgets/Stack-class.html) widget.
<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
[[highlight]]  position: relative; [[/highlight]]
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  position: absolute;
  top: 24px;
  left: 24px; [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
[[highlight]]  child: Stack(
    children: [
      Positioned( // red box
        child: [[/highlight]] Container(
          child: Text(
            "Lorem ipsum",
            style: bold24Roboto,
          ),
          decoration: BoxDecoration(
            color: Colors.red[400],
          ),
          padding: EdgeInsets.all(16.0),
        ),
[[highlight]]        left: 24.0,
        top: 24.0,
      ),
    ],
  ), [[/highlight]]
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### Rotating components

To rotate a widget, nest it in a
[Transform](https://docs.flutter.io/flutter/widgets/Transform-class.html)
widget. Use the Transform widget’s `alignment` and `origin` properties to
specify the transform origin (fulcrum) in relative and absolute terms,
respectively.

For a simple 2D rotation, the widget is rotated on the Z axis using radians.
(degrees × π / 180)
<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  transform: rotate(15deg); [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = Container( // gray box
  child: Center(
    child: [[highlight]] Transform(
      child: [[/highlight]] Container( // red box
        child: Text(
          "Lorem ipsum",
          style: bold24Roboto,
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        padding: EdgeInsets.all(16.0),
      ),
[[highlight]]      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateZ(15 * 3.1415927 / 180),
    ), [[/highlight]]
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### Scaling components

To scale a widget up or down, nest it in a
[Transform](https://docs.flutter.io/flutter/widgets/Transform-class.html)
widget. Use the Transform widget’s `alignment` and `origin`
properties to specify the transform origin (fulcrum) in relative or
absolute terms, respectively.

For a simple scaling operation along the x-axis, create a new
[Matrix4](https://docs.flutter.io/flutter/vector_math_64/Matrix4-class.html)
identity object and use its scale() method to specify the scaling factor.

When you scale a parent widget, its child widgets are scaled accordingly.
<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  transform: scale(1.5); [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = Container( // gray box
  child: Center(
    child: [[highlight]] Transform(
      child: [[/highlight]] Container( // red box
        child: Text(
          "Lorem ipsum",
          style: bold24Roboto,
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        padding: EdgeInsets.all(16.0),
      ),
[[highlight]]      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..scale(1.5),
     ), [[/highlight]]
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### Applying a linear gradient

To apply a linear gradient to a widget's background, nest it in a
[Container](https://docs.flutter.io/flutter/widgets/Container-class.html)
widget.  Then use the Container widget’s `decoration` property to create a
[BoxDecoration](https://docs.flutter.io/flutter/painting/BoxDecoration-class.html)
object, and use BoxDecoration's `gradient` property to transform the
background
fill.

The gradient “angle” is based on the Alignment (x, y) values:

* If the beginning and ending x values are equal, the gradient is vertical
(0° | 180°).
* If the beginning and ending y values are equal, the gradient is horizontal
(90° | 270°).

#### Vertical Gradient

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  padding: 16px;
  color: #ffffff;
[[highlight]]  background: linear-gradient(180deg, #ef5350, rgba(0, 0, 0, 0) 80%); [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
  child: Center(
    child: Container( // red box
      child: Text(
        "Lorem ipsum",
        style: bold24Roboto,
      ),
[[highlight]]      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.0, -1.0),
          end: const Alignment(0.0, 0.6),
          colors: <Color>[
            const Color(0xffef5350),
            const Color(0x00ef5350)
          ],
        ),
      ), [[/highlight]]
      padding: EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

#### Horizontal gradient
<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  padding: 16px;
  color: #ffffff;
[[highlight]]  background: linear-gradient(90deg, #ef5350, rgba(0, 0, 0, 0) 80%); [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
  child: Center(
    child: Container( // red box
      child: Text(
        "Lorem ipsum",
        style: bold24Roboto,
      ),
[[highlight]]      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1.0, 0.0),
          end: const Alignment(0.6, 0.0),
          colors: <Color>[
            const Color(0xffef5350),
            const Color(0x00ef5350)
          ],
        ),
      ), [[/highlight]]
      padding: EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

## Manipulating shapes

The following examples show how to make and customize shapes.

### Rounding corners

To round the corners of a rectangular shape, use the `borderRadius` property
of a
[BoxDecoration](https://docs.flutter.io/flutter/painting/BoxDecoration-class.html)
object. Create a new
[BorderRadius](https://docs.flutter.io/flutter/painting/BorderRadius-class.html)
object that specifies the radii for rounding each corner.
<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* gray 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  border-radius: 8px; [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
  child: Center(
    child: Container( // red circle
      child: Text(
        "Lorem ipsum",
        style: bold24Roboto,
      ),
      decoration: BoxDecoration(
        color: Colors.red[400],
[[highlight]]        borderRadius: BorderRadius.all(
          const Radius.circular(8.0),
        ), [[/highlight]]
      ),
      padding: EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### Adding box shadows

In CSS you can specify shadow offset and blur in shorthand,
using the box-shadow property. This example shows two box shadows,
with properties:

*  `xOffset: 0px, yOffset: 2px, blur: 4px, color: black @80% alpha`
*  `xOffset: 0px, yOffset: 06x, blur: 20px, color: black @50% alpha`

In Flutter, each property and value is specified separately.
Use the `boxShadow` property of BoxDecoration to create a list of
[BoxShadow](https://docs.flutter.io/flutter/painting/BoxShadow-class.html)
widgets. You can define one or multiple BoxShadow widgets, which can be stacked
to customize the shadow depth, color, etc.

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.8),
              0 6px 20px rgba(0, 0, 0, 0.5);[[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
  child: Center(
    child: Container( // red box
      child: Text(
        "Lorem ipsum",
        style: bold24Roboto,
      ),
      decoration: BoxDecoration(
        color: Colors.red[400],
[[highlight]]        boxShadow: <BoxShadow>[
          BoxShadow (
            color: const Color(0xcc000000),
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0,
          ),
          BoxShadow (
            color: const Color(0x80000000),
            offset: Offset(0.0, 6.0),
            blurRadius: 20.0,
          ),
        ], [[/highlight]]
      ),
      padding: EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  decoration: BoxDecoration(
    color: Colors.grey[300],
  ),
  margin: EdgeInsets.only(bottom: 16.0),
);
{% endprettify %}
</div>

### Making circles and ellipses

Making a circle in CSS requires a workaround of applying a border-radius of
50% to all four sides of a rectangle, though there are
[basic shapes](https://developer.mozilla.org/en-US/docs/Web/CSS/basic-shape).

While this approach is supported with the `borderRadius` property of
[BoxDecoration](https://docs.flutter.io/flutter/painting/BoxDecoration-class.html),
Flutter provides a `shape` property with
[BoxShape enum](https://docs.flutter.io/flutter/painting/BoxShape-class.html)
for this purpose.

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redcircle">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* gray 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redcircle {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  text-align: center;
  width: 160px;
  height: 160px;
  border-radius: 50%; [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
  child: Center(
    child: Container( // red circle
      child: Text(
        "Lorem ipsum",
        style: bold24Roboto,
[[highlight]]        textAlign: TextAlign.center, [[/highlight]]
      ),
      decoration: BoxDecoration(
        color: Colors.red[400],
[[highlight]]        shape: BoxShape.circle, [[/highlight]]
      ),
      padding: EdgeInsets.all(16.0),
[[highlight]]      width: 160.0,
      height: 160.0, [[/highlight]]
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

## Manipulating text

The following examples show how to specify fonts and other text attributes. They
also show how to transform text strings, customize spacing, and create excerpts.


### Adjusting text spacing

In CSS you specify the amount of white space between each letter or word by
giving a length value for the letter-spacing and word-spacing properties,
respectively. The amount of space can be in px, pt, cm, em, etc.

In Flutter, you specify white space as logical pixels
(negative values are allowed)
for the `letterSpacing` and `wordSpacing` properties of a
[TextStyle](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
child of a Text widget.

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  letter-spacing: 4px; [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
  child: Center(
    child: Container( // red box
      child: Text(
        "Lorem ipsum",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
[[highlight]]          letterSpacing: 4.0, [[/highlight]]
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      padding: EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### Making inline formatting changes

A [Text](https://docs.flutter.io/flutter/widgets/Text-class.html) widget lets
you display text with the same formatting characteristics. To
display text that uses multiple styles (in this example, a single word with
emphasis), use a
[RichText](https://docs.flutter.io/flutter/widgets/RichText-class.html)
widget instead. Its `text` property can specify one or more
[TextSpan](https://docs.flutter.io/flutter/painting/TextSpan-class.html) widgets
that can be individually styled.

In the following example, "Lorem" is in a TextSpan widget with the default
(inherited) text styling, and "ipsum" is in a separate TextSpan with custom
styling.


<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
[[highlight]]    Lorem <em>ipsum</em> [[/highlight]]
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
[[highlight]]  font: 900 24px Roboto; [[/highlight]]
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
}
[[highlight]] .redbox em {
  font: 300 48px Roboto;
  font-style: italic;
} [[/highlight]]
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
  child: Center(
    child: Container( // red box
      child: [[highlight]] RichText(
        text: TextSpan(
          style: bold24Roboto,
          children: <TextSpan>[
            TextSpan(text: "Lorem "),
            TextSpan(
              text: "ipsum",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                fontSize: 48.0,
              ),
            ),
          ],
        ),
      ), [[/highlight]]
      decoration: BoxDecoration(
        backgroundColor: Colors.red[400],
      ),
      padding: EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### Creating text excerpts

An excerpt displays the initial line(s) of text in a paragraph, and handles the
overflow text, often using an ellipsis. In HTML/CSS an excerpt can be no longer
than one line. Truncating after multiple lines requires some JavaScript code.

In Flutter, use the `maxLines` property of a
[Text](https://docs.flutter.io/flutter/widgets/Text-class.html)
widget to specify the number of lines to include in the excerpt, and the
`overflow` property for handling overflow text.

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum dolor sit amet, consec etur
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap; [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = Container( // grey box
  child: Center(
    child: Container( // red box
      child: Text(
        "Lorem ipsum dolor sit amet, consec etur",
        style: bold24Roboto,
[[highlight]]        overflow: TextOverflow.ellipsis,
        maxLines: 1, [[/highlight]]
      ),
      decoration: BoxDecoration(
        backgroundColor: Colors.red[400],
      ),
      padding: EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>
<div class="end-examples"></div>
