---
title: Align widgets in Flutter
short-title: Align widgets
description: Learn how position widgets in relation to each other.
diff2html: true
---

{% assign api = site.api | append: '/flutter' -%}
{% capture code -%} {{site.repo.this}}/tree/{{site.branch}}/src/_includes/code {%- endcapture -%}
{% capture examples -%} {{site.repo.this}}/tree/{{site.branch}}/examples {%- endcapture -%}
{% capture demo -%} {{site.repo.gallery}}/tree/{{site.branch}}/lib/demos {%- endcapture -%}

## Orient multiple widgets

<?code-excerpt path-base=""?>

One of the most common layout patterns is to arrange
widgets vertically or horizontally. You can use a
`Row` widget to arrange widgets horizontally,
and a `Column` widget to arrange widgets vertically.

{{site.alert.secondary}}

## What you'll learn

* What layout patterns are the most common.
* What widgets contain multiple child widgets.
* How widgets can be nested in a layout.
* How widgets can be positioned.
{{site.alert.end}}

To create a row or column in Flutter, you add a list of children
widgets to a [`Row`][] or [`Column`][] widget. In turn,
each child can itself be a row or column, and so on.
The following example shows how it is possible to nest rows or
columns inside of rows or columns.

This layout is organized as a `Row`. The row contains two children:
a column on the left, and an image on the right:

<img src='/assets/images/docs/ui/layout/pavlova-diagram.png' class="mw-100"
    alt="Screenshot with callouts showing the row containing two children">

The left column's widget tree nests rows and columns.

<img src='/assets/images/docs/ui/layout/pavlova-left-column-diagram.png' class="mw-100"
    alt="Diagram showing a left column broken down to its sub-rows and sub-columns">

You'll implement some of Pavlova's layout code in
[Nesting rows and columns](#nesting-rows-and-columns).

{{site.alert.note}}
  `Row` and `Column` are basic primitive widgets for horizontal
  and vertical layouts&mdash;these low-level widgets allow for maximum
  customization. Flutter also offers specialized, higher level widgets
  that might be sufficient for your needs. For example,
  instead of `Row` you might prefer [`ListTile`][],
  an easy-to-use widget with properties for leading and trailing icons,
  and up to 3 lines of text.  Instead of Column, you might prefer
  [`ListView`][], a column-like layout that automatically scrolls
  if its content is too long to fit the available space.
  For more information, see [Common layout widgets][].
{{site.alert.end}}

### Aligning widgets

You control how a row or column aligns its children using the
`mainAxisAlignment` and `crossAxisAlignment` properties.
For a row, the main axis runs horizontally and the cross axis runs
vertically. For a column, the main axis runs vertically and the cross
axis runs horizontally.

<div class="mb-2 text-center">
  <img src='/assets/images/docs/ui/layout/row-diagram.png' class="mb-2 mw-100"
      alt="Diagram showing the main axis and cross axis for a row">
  <img src='/assets/images/docs/ui/layout/column-diagram.png' class="mb-2 mr-2 ml-2 mw-100"
      alt="Diagram showing the main axis and cross axis for a column">
</div>

The [`MainAxisAlignment`][] and [`CrossAxisAlignment`][]
enums offer a variety of constants for controlling alignment.

{{site.alert.note}}
  When you add images to your project,
  you need to update the `pubspec.yaml` file to access
  them&mdash;this example uses `Image.asset` to display
  the images.  For more information, see this example's
  [`pubspec.yaml` file][] or [Adding assets and images][].
  You don't need to do this if you're referencing online
  images using `Image.network`.
{{site.alert.end}}

In the following example, each of the 3 images is 100 pixels wide.
The render box (in this case, the entire screen)
is more than 300 pixels wide, so setting the main axis
alignment to `spaceEvenly` divides the free horizontal
space evenly between, before, and after each image.

<div class="row">
<div class="col-lg-8">
  <?code-excerpt "layout/row_column/lib/main.dart (Row)" replace="/Row/[!$&!]/g"?>
  {% prettify dart context="html" %}
  [!Row!](
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Image.asset('images/pic1.jpg'),
      Image.asset('images/pic2.jpg'),
      Image.asset('images/pic3.jpg'),
    ],
  );
  {% endprettify %}
</div>
<div class="col-lg-4" markdown="1">
  <img src='/assets/images/docs/ui/layout/row-spaceevenly-visual.png' class="mw-100" alt="Row with 3 evenly spaced images">

  **App source:** [row_column]({{examples}}/layout/row_column)
</div>
</div>

Columns work the same way as rows. The following example shows a column
of 3 images, each is 100 pixels high. The height of the render box
(in this case, the entire screen) is more than 300 pixels, so
setting the main axis alignment to `spaceEvenly` divides the free vertical
space evenly between, above, and below each image.

<div class="row">
<div class="col-lg-8" markdown="1">
  <?code-excerpt "layout/row_column/lib/main.dart (Column)" replace="/Column/[!$&!]/g"?>
  {% prettify dart context="html" %}
  [!Column!](
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Image.asset('images/pic1.jpg'),
      Image.asset('images/pic2.jpg'),
      Image.asset('images/pic3.jpg'),
    ],
  );
  {% endprettify %}

  **App source:** [row_column]({{examples}}/layout/row_column)
</div>
<div class="col-lg-4 text-center">
  <img src='/assets/images/docs/ui/layout/column-visual.png' class="mb-4" height="250px"
      alt="Column showing 3 images spaced evenly">
</div>
</div>

### Sizing widgets

When a layout is too large to fit a device, a yellow
and black striped pattern appears along the affected edge.
Here is an [example][sizing] of a row that is too wide:

<img src='/assets/images/docs/ui/layout/layout-too-large.png' class="mw-100" alt="Overly-wide row">
{:.text-center}

Widgets can be sized to fit within a row or column by using the
[`Expanded`][] widget. To fix the previous example where the
row of images is too wide for its render box,
wrap each image with an `Expanded` widget.

<div class="row">
<div class="col-lg-8">
  <?code-excerpt "layout/sizing/lib/main.dart (expanded-images)" replace="/Expanded/[!$&!]/g"?>
  {% prettify dart context="html" %}
  Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      [!Expanded!](
        child: Image.asset('images/pic1.jpg'),
      ),
      [!Expanded!](
        child: Image.asset('images/pic2.jpg'),
      ),
      [!Expanded!](
        child: Image.asset('images/pic3.jpg'),
      ),
    ],
  );
  {% endprettify %}
</div>
<div class="col-lg-4" markdown="1">
  <img src='/assets/images/docs/ui/layout/row-expanded-2-visual.png' class="mw-100"
      alt="Row of 3 images that are too wide, but each is constrained to take only 1/3 of the space">

  **App source:** [sizing]({{examples}}/layout/sizing)
</div>
</div>

Perhaps you want a widget to occupy twice as much space as its
siblings. For this, use the `Expanded` widget `flex` property,
an integer that determines the flex factor for a widget.
The default flex factor is 1. The following code sets
the flex factor of the middle image to 2:

<div class="row">
<div class="col-lg-8">
  <?code-excerpt "layout/sizing/lib/main.dart (expanded-images-with-flex)" replace="/flex.*/[!$&!]/g"?>
  {% prettify dart context="html" %}
  Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Image.asset('images/pic1.jpg'),
      ),
      Expanded(
        [!flex: 2,!]
        child: Image.asset('images/pic2.jpg'),
      ),
      Expanded(
        child: Image.asset('images/pic3.jpg'),
      ),
    ],
  );
  {% endprettify %}
</div>
<div class="col-lg-4" markdown="1">
  <img src='/assets/images/docs/ui/layout/row-expanded-visual.png' class="mw-100"
      alt="Row of 3 images with the middle image twice as wide as the others">

  **App source:** [sizing]({{examples}}/layout/sizing)
</div>
</div>

[sizing]: {{examples}}/layout/sizing

### Packing widgets

By default, a row or column occupies as much space along its main axis
as possible, but if you want to pack the children closely together,
set its `mainAxisSize` to `MainAxisSize.min`. The following example
uses this property to pack the star icons together.

<div class="row">
<div class="col-lg-8">
  <?code-excerpt "layout/pavlova/lib/main.dart (stars)" replace="/mainAxisSize.*/[!$&!]/g; /\w+ \w+ = //g; /;//g"?>
  {% prettify dart context="html" %}
  Row(
    [!mainAxisSize: MainAxisSize.min,!]
    children: [
      Icon(Icons.star, color: Colors.green[500]),
      Icon(Icons.star, color: Colors.green[500]),
      Icon(Icons.star, color: Colors.green[500]),
      const Icon(Icons.star, color: Colors.black),
      const Icon(Icons.star, color: Colors.black),
    ],
  )
  {% endprettify %}
</div>
<div class="col-lg-4" markdown="1">
  <img src='/assets/images/docs/ui/layout/packed.png' class="border mw-100"
      alt="Row of 5 stars, packed together in the middle of the row">

  **App source:** [pavlova]({{examples}}/layout/pavlova)
</div>
</div>

### Nesting rows and columns

The layout framework allows you to nest rows and columns
inside of rows and columns as deeply as you need.
Let's look at the code for the outlined
section of the following layout:

<img src='/assets/images/docs/ui/layout/pavlova-large-annotated.png' class="border mw-100"
    alt="Screenshot of the pavlova app, with the ratings and icon rows outlined in red">
{:.text-center}

The outlined section is implemented as two rows. The ratings row contains
five stars and the number of reviews. The icons row contains three
columns of icons and text.

The widget tree for the ratings row:

<img src='/assets/images/docs/ui/layout/widget-tree-pavlova-rating-row.png' class="mw-100" alt="Ratings row widget tree">
{:.text-center}

The `ratings` variable creates a row containing a smaller row
of 5 star icons, and text:

<?code-excerpt "layout/pavlova/lib/main.dart (ratings)" replace="/ratings/[!$&!]/g"?>
```dart
final stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    const Icon(Icons.star, color: Colors.black),
    const Icon(Icons.star, color: Colors.black),
  ],
);

final [!ratings!] = Container(
  padding: const EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      stars,
      const Text(
        '170 Reviews',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: 20,
        ),
      ),
    ],
  ),
);
```

{{site.alert.tip}}
  To minimize the visual confusion that can result from
  heavily nested layout code, implement pieces of the UI
  in variables and functions.
{{site.alert.end}}

The icons row, below the ratings row, contains 3 columns;
each column contains an icon and two lines of text,
as you can see in its widget tree:

<img src='/assets/images/docs/ui/layout/widget-tree-pavlova-icon-row.png' class="mw-100" alt="Icon widget tree">
{:.text-center}

The `iconList` variable defines the icons row:

<?code-excerpt "layout/pavlova/lib/main.dart (iconList)" replace="/iconList/[!$&!]/g"?>
```dart
const descTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

// DefaultTextStyle.merge() allows you to create a default text
// style that is inherited by its child and all subsequent children.
final [!iconList!] = DefaultTextStyle.merge(
  style: descTextStyle,
  child: Container(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.kitchen, color: Colors.green[500]),
            const Text('PREP:'),
            const Text('25 min'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.timer, color: Colors.green[500]),
            const Text('COOK:'),
            const Text('1 hr'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.restaurant, color: Colors.green[500]),
            const Text('FEEDS:'),
            const Text('4-6'),
          ],
        ),
      ],
    ),
  ),
);
```

The `leftColumn` variable contains the ratings and icons rows,
as well as the title and text that describes the Pavlova:

<?code-excerpt "layout/pavlova/lib/main.dart (leftColumn)" replace="/leftColumn/[!$&!]/g"?>
```dart
final [!leftColumn!] = Container(
  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
  child: Column(
    children: [
      titleText,
      subTitle,
      ratings,
      iconList,
    ],
  ),
);
```

The left column is placed in a `SizedBox` to constrain its width.
Finally, the UI is constructed with the entire row (containing the
left column and the image) inside a `Card`.

The [Pavlova image][] is from [Pixabay][].
You can embed an image from the net using `Image.network()` but,
for this example, the image is saved to an images directory in the project,
added to the [pubspec file][], and accessed using `Images.asset()`.
For more information, see [Adding assets and images][].

<?code-excerpt "layout/pavlova/lib/main.dart (body)"?>
```dart
body: Center(
  child: Container(
    margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
    height: 600,
    child: Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 440,
            child: leftColumn,
          ),
          mainImage,
        ],
      ),
    ),
  ),
),
```

{{site.alert.tip}}
  The Pavlova example runs best horizontally on a wide device,
  such as a tablet.  If you are running this example in the iOS simulator,
  you can select a different device using the **Hardware > Device** menu.
  For this example, we recommend the iPad Pro.
  You can change its orientation to landscape mode using
  **Hardware > Rotate**. You can also change the size of the
  simulator window (without changing the number of logical pixels)
  using **Window > Scale**.
{{site.alert.end}}

**App source:** [pavlova]({{examples}}/layout/pavlova)

[Pavlova image]: https://pixabay.com/en/photos/pavlova
[Pixabay]: https://pixabay.com/en/photos/pavlova

<hr>