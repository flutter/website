---
title: Building layouts
short-title: Tutorial
description: Learn how to build a layout.
diff2html: true
---

{% assign api = '{{site.api}}/flutter' -%}
{% capture examples -%} {{site.repo.this}}/tree/{{site.branch}}/null_safety_examples {%- endcapture -%}
{% assign rawExFile = 'https://raw.githubusercontent.com/flutter/website/master/null_safety_examples' -%}
{% capture demo -%} {{site.repo.flutter}}/tree/{{site.branch}}/null_safety_examples/flutter_gallery/lib/demo {%- endcapture -%}

<style>dl, dd { margin-bottom: 0; }</style>

{{site.alert.secondary}}
  <h4 class="no_toc">What you’ll learn</h4>

  * How Flutter's layout mechanism works.
  * How to lay out widgets vertically and horizontally.
  * How to build a Flutter layout.
{{site.alert.end}}

This is a guide to building layouts in Flutter.
You'll build the layout for the following app:

{% include app-figure.md img-class="site-mobile-screenshot border"
    image="ui/layout/lakes.jpg" caption="The finished app" %}

This guide then takes a step back to explain Flutter's
approach to layout, and shows how to place a single widget
on the screen. After a discussion of how to lay widgets
out horizontally and vertically, some of the most common
layout widgets are covered.

If you want a "big picture" understanding of the layout mechanism,
start with [Flutter's approach to layout][].

## Step 0: Create the app base code

Make sure to [set up][] your environment,
then do the following:

 1. [Create a basic "Hello World" Flutter app][hello-world].
 2. Change the app bar title and the app title as follows:

    <?code-excerpt "../null_safety_examples/layout/base/lib/{main_starter,main}.dart"?>
    ```diff
    --- ../null_safety_examples/layout/base/lib/main_starter.dart
    +++ ../null_safety_examples/layout/base/lib/main.dart
    @@ -10,10 +10,10 @@
       @override
       Widget build(BuildContext context) {
         return MaterialApp(
    -      title: 'Welcome to Flutter',
    +      title: 'Flutter layout demo',
           home: Scaffold(
             appBar: AppBar(
    -          title: Text('Welcome to Flutter'),
    +          title: Text('Flutter layout demo'),
             ),
             body: Center(
               child: Text('Hello World'),
    ```

## Step 1: Diagram the layout

The first step is to break the layout down to its basic elements:

* Identify the rows and columns.
* Does the layout include a grid?
* Are there overlapping elements?
* Does the UI need tabs?
* Notice areas that require alignment, padding, or borders.

First, identify the larger elements. In this example,
four elements are arranged into a column: an image, two rows, and a block of text.  

{% include app-figure.md img-class="site-mobile-screenshot border"
    image="ui/layout/lakes-column-elts.png" caption="Column elements (circled in red)" %}

Next, diagram each row. The first row, called the Title
section, has 3 children: a column of text, a star icon,
and a number. Its first child, the column, contains 2 lines of text.
That first column takes a lot of space, so it must be wrapped in an
Expanded widget.

{% include app-figure.md image="ui/layout/title-section-parts.png" alt="Title section" %}

The second row, called the Button section, also has
3 children: each child is a column that contains an icon and text.

{% include app-figure.md image="ui/layout/button-section-diagram.png" alt="Button section" %}

Once the layout has been diagrammed, it's easiest to
take a bottom-up approach to implementing it.
To minimize the visual confusion of deeply nested layout code,
place some of the implementation in variables and functions.

## Step 2: Implement the title row

<?code-excerpt path-base="../null_safety_examples/layout/lakes/step2"?>

First, you'll build the left column in the title section.
Add the following code at the top of the `build()`
method of the `MyApp` class:

<?code-excerpt "lib/main.dart (titleSection)" title?>
```dart
Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      Text('41'),
    ],
  ),
);
```

{:.numbered-code-notes}
 1. Putting a `Column` inside an `Expanded` widget stretches
    the column to use all remaining free space in the row.
    Setting the `crossAxisAlignment` property to
    `CrossAxisAlignment.start` positions the column at
    the start of the row.
 2. Putting the first row of text inside a `Container`
    enables you to add padding. The second child in the
    `Column`, also text, displays as grey.
 3. The last two items in the title row are a star icon,
    painted red, and the text "41". The entire row is in
    a `Container` and padded along each edge by 32 pixels.
    Add the title section to the app body like this:

<?code-excerpt path-base="../null_safety_examples/layout/lakes"?>
<?code-excerpt "{../base,step2}/lib/main.dart" from="return MaterialApp"?>
```diff
--- ../base/lib/main.dart
+++ step2/lib/main.dart
@@ -12,11 +46,13 @@
     return MaterialApp(
       title: 'Flutter layout demo',
       home: Scaffold(
         appBar: AppBar(
           title: Text('Flutter layout demo'),
         ),
-        body: Center(
-          child: Text('Hello World'),
+        body: Column(
+          children: [
+            titleSection,
+          ],
         ),
       ),
     );
```

{{site.alert.tip}}
  * When pasting code into your app, indentation can
    become skewed. You can fix this in your Flutter editor
    using the [automatic reformatting support][].
  * For a faster development experience,
    try Flutter's [hot reload][] feature.
  * If you have problems, compare your code to [`lib/main.dart`][].
{{site.alert.end}}

## Step 3: Implement the button row

<?code-excerpt path-base="../null_safety_examples/layout/lakes/step3"?>

The button section contains 3 columns that use the same
layout&mdash;an icon over a row of text.
The columns in this row are evenly spaced,
and the text and icons are painted with the primary color.

Since the code for building each column is almost identical,
create a private helper method named `buildButtonColumn()`,
which takes a color, an `Icon` and `Text`,
and returns a column with its widgets painted in the given color.

<?code-excerpt "lib/main.dart (_buildButtonColumn)" title?>
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ···
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
```

The function adds the icon directly to the column.
The text is inside a `Container` with a top-only margin,
separating the text from the icon.

Build the row containing these columns by calling the
function and passing the color, `Icon`, and text specific
to that column. Align the columns along the main axis
using `MainAxisAlignment.spaceEvenly` to arrange the
free space evenly before, between, and after each column.
Add the following code just below the
`titleSection` declaration inside the `build()` method:

<?code-excerpt "lib/main.dart (buttonSection)" title?>
```dart
Color color = Theme.of(context).primaryColor;

Widget buttonSection = Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(color, Icons.call, 'CALL'),
      _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
      _buildButtonColumn(color, Icons.share, 'SHARE'),
    ],
  ),
);
```

Add the button section to the body:

<?code-excerpt path-base="../null_safety_examples/layout/lakes"?>
<?code-excerpt "{step2,step3}/lib/main.dart" from="return MaterialApp" to="}"?>
```diff
--- step2/lib/main.dart
+++ step3/lib/main.dart
@@ -46,3 +59,3 @@
     return MaterialApp(
       title: 'Flutter layout demo',
       home: Scaffold(
@@ -52,8 +65,9 @@
         body: Column(
           children: [
             titleSection,
+            buttonSection,
           ],
         ),
       ),
     );
   }
```

## Step 4: Implement the text section

<?code-excerpt path-base="../null_safety_examples/layout/lakes/step4"?>

Define the text section as a variable. Put the text
in a `Container` and add padding along each edge.
Add the following code just below the `buttonSection`
declaration:

<?code-excerpt "lib/main.dart (textSection)" title?>
```dart
Widget textSection = Container(
  padding: const EdgeInsets.all(32),
  child: Text(
    'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
    softWrap: true,
  ),
);
```

By setting `softwrap` to true, text lines will fill the column width before
wrapping at a word boundary.

Add the text section to the body:

<?code-excerpt path-base="../null_safety_examples/layout/lakes"?>
<?code-excerpt "{step3,step4}/lib/main.dart" from="return MaterialApp"?>
```diff
--- step3/lib/main.dart
+++ step4/lib/main.dart
@@ -59,3 +72,3 @@
     return MaterialApp(
       title: 'Flutter layout demo',
       home: Scaffold(
@@ -66,6 +79,7 @@
           children: [
             titleSection,
             buttonSection,
+            textSection,
           ],
         ),
       ),
```

## Step 5: Implement the image section

Three of the four column elements are now complete,
leaving only the image. Add the image file to the example:

* Create an `images` directory at the top of the project.
* Add [`lake.jpg`][].

{{site.alert.info}}
  Note that `wget` doesn't work for saving this binary file.
  The original image is [available online][] under a
  Creative Commons license, but it's large and slow to fetch.
{{site.alert.end}}

* Update the `pubspec.yaml` file to include an `assets` tag.
  This makes the image available to your code.

  <?code-excerpt "{step4,step5}/pubspec.yaml"?>
  ```diff
  --- step4/pubspec.yaml
  +++ step5/pubspec.yaml
  @@ -17,3 +17,5 @@

   flutter:
     uses-material-design: true
  +  assets:
  +    - images/lake.jpg
  ```
{{site.alert.tip}}
  * Note that `pubspec.yaml` is case sensitive,
    so write `assets:` and the image URL
    as shown above.
  * The pubspec file is also sensitive to white
    space, so use proper indentation.
{{site.alert.end}}

Now you can reference the image from your code:

<?code-excerpt "{step4,step5}/lib/main.dart"?>
```diff
--- step4/lib/main.dart
+++ step5/lib/main.dart
@@ -77,6 +77,12 @@
         ),
         body: Column(
           children: [
+            Image.asset(
+              'images/lake.jpg',
+              width: 600,
+              height: 240,
+              fit: BoxFit.cover,
+            ),
             titleSection,
             buttonSection,
             textSection,
```

`BoxFit.cover` tells the framework that the image should
be as small as possible but cover its entire render box.

## Step 6: Final touch

In this final step, arrange all of the elements in a
`ListView`, rather than a `Column`, because a
`ListView` supports app body scrolling when the app is run
on a small device.

<?code-excerpt "{step5,step6}/lib/main.dart" diff-u="6" from="return MaterialApp"?>
```diff
--- step5/lib/main.dart
+++ step6/lib/main.dart
@@ -72,13 +77,13 @@
     return MaterialApp(
       title: 'Flutter layout demo',
       home: Scaffold(
         appBar: AppBar(
           title: Text('Flutter layout demo'),
         ),
-        body: Column(
+        body: ListView(
           children: [
             Image.asset(
               'images/lake.jpg',
               width: 600,
               height: 240,
               fit: BoxFit.cover,
```

**Dart code:** [`main.dart`][]<br>
**Image:** [images][]<br>
**Pubspec:** [`pubspec.yaml`][]<br>

That's it! When you hot reload the app,
you should see the same app layout as
the screenshot at the top of this page.

You can add interactivity to this layout by following
[Adding Interactivity to Your Flutter App][].


[Adding Interactivity to Your Flutter App]: /docs/development/ui/interactive
[automatic reformatting support]: /docs/development/tools/formatting
[available online]: https://images.unsplash.com/photo-1471115853179-bb1d604434e0?dpr=1&amp;auto=format&amp;fit=crop&amp;w=767&amp;h=583&amp;q=80&amp;cs=tinysrgb&amp;crop=
[Flutter's approach to layout]: /docs/development/ui/layout
[hello-world]: /docs/get-started/codelab#step-1-create-the-starter-flutter-app
[images]: {{examples}}/layout/lakes/step6/images
[`lake.jpg`]: {{rawExFile}}/layout/lakes/step5/images/lake.jpg
[`lib/main.dart`]: {{examples}}/layout/lakes/step2/lib/main.dart
[hot reload]: /docs/development/tools/hot-reload
[`main.dart`]: {{examples}}/layout/lakes/step6/lib/main.dart
[`pubspec.yaml`]: {{examples}}/layout/lakes/step6/pubspec.yaml
[set up]: /docs/get-started/install

