---
title: Layouts in Flutter
short-title: Layout
description: Learn how Flutter's layout mechanism works and how to build a layout.
diff2html: true
---

{% assign api = site.api | append: '/flutter' -%}
{% capture code -%} {{site.repo.this}}/tree/{{site.branch}}/src/_includes/code {%- endcapture -%}
{% capture examples -%} {{site.repo.this}}/tree/{{site.branch}}/examples {%- endcapture -%}
{% capture demo -%} {{site.repo.gallery}}/tree/{{site.branch}}/lib/demos {%- endcapture -%}

<?code-excerpt path-base=""?>

<style>dl, dd { margin-bottom: 0; }</style>

{{site.alert.secondary}}
## What you'll learn

* Widgets are classes used to build UIs.
* Widgets are used for both layout and UI elements.
* Compose simple widgets to build complex widgets.
{{site.alert.end}}

This guide explains how Flutter lays out applications on screen.

## Flutter's building blocks

Flutter calls the building blocks it uses to create its screen layouts _widgets_.
Widgets include both visible UI components and invisible components
that arrange, constrain, and align the visible widgets.

Visible widgets include images, icons, and text.
Invisible widgets include rows, columns, lists, and grids.

After covering basic layout widgets, you will create a Flutter app that
places a single widget on the screen.

All layout widgets have at least one property.
This property notes how many components the layout widget contains.
Some layout widgets can only contain one component.
Those use the `child` property.
Some layout widgets can contain one or more components.
Those use the `children` property.

| **Property** |                **Widget**               |
|:------------:|:---------------------------------------:|
| `child`      | `Center`, `Container`                   |
| `children`   | `Row`,  `Column`,  `ListView`,  `Stack` |
{:.table .table-striped}

To create a layout, you compose widgets to build more complex widgets.

For example, the following screenshot shows three icons with a label
under each one.

<div class="row mb-4">
  <div class="col-12 text-center">
    <img src='/assets/images/docs/ui/layout/lakes-icons.png' class="border mt-1 mb-1 mw-100" alt="Sample layout">
    <img src='/assets/images/docs/ui/layout/lakes-icons-visual.png' class="border mt-1 mb-1 mw-100" alt="Sample layout with visual debugging">
  </div>
</div>

The second screenshot displays the visual layout, showing a row of
3 columns where each column contains an icon and a label.

{{site.alert.note}}
  Most of the screenshots in this tutorial are displayed with
  `debugPaintSizeEnabled` set to true so you can see the visual layout.
  For more information, see
  [Debugging layout issues visually][], a section in
  [Using the Flutter inspector][].
{{site.alert.end}}

Here's a diagram of the widget tree for this UI.

<img src='/assets/images/docs/ui/layout/sample-flutter-layout.png' class="mw-100" alt="Node tree">
{:.text-center}

Most of this should look as you might expect, but you might be wondering
about the containers (shown in pink). [`Container`][] is a widget class
that allows you to customize its child widget. Use a `Container` when
you want to add padding, margins, borders, or background color,
to name some of its capabilities.

In this example, each [`Text`][] widget is placed in a `Container`
to add margins. The entire [`Row`][] is also placed in a
`Container` to add padding around the row.

The rest of the UI in this example is controlled by properties.
Set an [`Icon`][]'s color using its `color` property.
Use the `Text.style` property to set the font, its color, weight, and so on.
Columns and rows have properties that allow you to specify how their
children are aligned vertically or horizontally, and how much space
the children should occupy.

<hr>

## Common layout widgets

Flutter has a rich library of layout widgets.
This section lists a few of those most in common use.

This should get you up and running as soon as possible,
rather than overwhelm you with a complete list.

The following widgets fall into two categories: standard widgets
from the [widgets library][], and specialized widgets from the
[Material library][]. Any app can use the widgets library but
only Material apps can use the Material Components library.

### Standard widgets

* [`Container`](#container): Adds padding, margins, borders,
  background color, or other decorations to a widget.
* [`GridView`](#gridview): Lays widgets out as a scrollable grid.
* [`ListView`](#listview): Lays widgets out as a scrollable list.
* [`Stack`](#stack): Overlaps a widget on top of another.

#### Container

Many layouts make liberal use of [`Container`][]s to separate
widgets using padding, or to add borders or margins.
You can change the device's background by placing the
entire layout into a `Container` and changing its background
color or image.

<div class="row">
<div class="col-lg-6" markdown="1">
  <h4 class="no_toc">Summary (Container)</h4>

  * Add padding, margins, borders
  * Change background color or image
  * Contains a single child widget, but that child can be a Row,
    Column, or even the root of a widget tree
</div>
<div class="col-lg-6 text-center">
  <img src='/assets/images/docs/ui/layout/margin-padding-border.png' class="mb-4 mw-100"
      width="230px"
      alt="Diagram showing: margin, border, padding, and content">
</div>
</div>

##### Examples (Container)
{:.no_toc}

This layout consists of a column with two rows, each containing
2 images. A [`Container`][] is used to change the background color
of the column to a lighter grey.

<div class="row">
<div class="col-lg-7">
  <?code-excerpt "layout/container/lib/main.dart (column)" replace="/\bContainer/[!$&!]/g;"?>
  {% prettify dart context="html" %}
  Widget _buildImageColumn() {
    return [!Container!](
      decoration: const BoxDecoration(
        color: Colors.black26,
      ),
      child: Column(
        children: [
          _buildImageRow(1),
          _buildImageRow(3),
        ],
      ),
    );
  }
  {% endprettify %}
</div>
<div class="col-lg-5 text-center">
  <img src='/assets/images/docs/ui/layout/container.png' class="mb-4 mw-100" width="230px"
      alt="Screenshot showing 2 rows, each containing 2 images">
</div>
</div>

A `Container` is also used to add a rounded border and margins
to each image:

<?code-excerpt "layout/container/lib/main.dart (row)" replace="/\bContainer/[!$&!]/g;"?>
```dart
Widget _buildDecoratedImage(int imageIndex) => Expanded(
      child: [!Container!](
        decoration: BoxDecoration(
          border: Border.all(width: 10, color: Colors.black38),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4),
        child: Image.asset('images/pic$imageIndex.jpg'),
      ),
    );

Widget _buildImageRow(int imageIndex) => Row(
      children: [
        _buildDecoratedImage(imageIndex),
        _buildDecoratedImage(imageIndex + 1),
      ],
    );
```

You can find more `Container` examples in the [tutorial][]
and the Flutter Gallery ([running app][], [repo][]).

**App source:** [container]({{examples}}/layout/container)

#### GridView

Use [`GridView`][] to lay widgets out as a two-dimensional
list. `GridView` provides two pre-fabricated lists,
or you can build your own custom grid. When a `GridView`
detects that its contents are too long to fit the render box,
it automatically scrolls.

##### Summary (GridView)
{:.no_toc}

* Lays widgets out in a grid
* Detects when the column content exceeds the render box
  and then adds scrolling
* Build your own custom grid, or use one of the provided grids:
  * `GridView.count` allows you to specify the number of columns
  * `GridView.extent` allows you to specify the maximum pixel
    width of a tile

  {% comment %}
  * Use `MediaQuery.of(context).orientation` to create a grid
    that changes its layout depending on whether the device
    is in landscape or portrait mode.
  {% endcomment %}

{{site.alert.note}}
  When displaying a two-dimensional list where it's important which
  row and column a cell occupies (for example,
  it's the entry in the "calorie" column for the "avocado" row), use
  [`Table`][] or [`DataTable`][].
{{site.alert.end}}

##### Examples (GridView)
{:.no_toc}

<div class="row">
<div class="col-lg-6" markdown="1">
  <img src='/assets/images/docs/ui/layout/gridview-extent.png' class="mw-100" alt="A 3-column grid of photos">
  {:.text-center}

  Uses `GridView.extent` to create a grid with tiles a maximum
  150 pixels wide.

  **App source:** [grid_and_list]({{examples}}/layout/grid_and_list)
</div>
<div class="col-lg-6" markdown="1">
  <img src='/assets/images/docs/ui/layout/gridview-count-flutter-gallery.png' class="mw-100"
      alt="A 2 column grid with footers">
  {:.text-center}

  Uses `GridView.count` to create a grid that's 2 tiles
  wide in portrait mode, and 3 tiles wide in landscape mode.
  The titles are created by setting the `footer` property for
  each [`GridTile`][].

  **Dart code:** [grid_list_demo.dart]({{demo}}/material/grid_list_demo.dart)
  from the [Flutter Gallery][repo]
</div>
</div>

<?code-excerpt "layout/grid_and_list/lib/main.dart (grid)" replace="/\GridView/[!$&!]/g;"?>
```dart
Widget _buildGrid() => [!GridView!].extent(
    maxCrossAxisExtent: 150,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridTileList(30));

// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// The List.generate() constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
List<Container> _buildGridTileList(int count) => List.generate(
    count, (i) => Container(child: Image.asset('images/pic$i.jpg')));
```

#### ListView

[`ListView`][], a column-like widget, automatically
provides scrolling when its content is too long for
its render box.

##### Summary (ListView)
{:.no_toc}

* A specialized [`Column`][] for organizing a list of boxes
* Can be laid out horizontally or vertically
* Detects when its content won't fit and provides scrolling
* Less configurable than `Column`, but easier to use and
  supports scrolling

##### Examples (ListView)
{:.no_toc}

<div class="row">
<div class="col-lg-6" markdown="1">
  <img src='/assets/images/docs/ui/layout/listview.png' class="border mw-100"
      alt="ListView containing movie theaters and restaurants">
  {:.text-center}

  Uses `ListView` to display a list of businesses using
  `ListTile`s. A `Divider` separates the theaters from
  the restaurants.

  **App source:** [grid_and_list]({{examples}}/layout/grid_and_list)
</div>
<div class="col-lg-6" markdown="1">
  <img src='/assets/images/docs/ui/layout/listview-flutter-gallery.png' class="border mw-100"
      alt="ListView containing shades of blue">
  {:.text-center}

  Uses `ListView` to display the [`Colors`][] from
  the [Material Design palette][]
  for a particular color family.

  **Dart code:** [colors_demo.dart]({{demo}}/reference/colors_demo.dart) from the
  [Flutter Gallery][repo]
</div>
</div>

<?code-excerpt "layout/grid_and_list/lib/main.dart (list)" replace="/\ListView/[!$&!]/g;"?>
```dart
Widget _buildList() {
  return [!ListView!](
    children: [
      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
      _tile('United Artists Stonestown Twin', '501 Buckingham Way',
          Icons.theaters),
      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
      const Divider(),
      _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
      _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
      _tile('La Ciccia', '291 30th St', Icons.restaurant),
    ],
  );
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}
```

#### Stack

Use [`Stack`][] to arrange widgets on top of a base
widget&mdash;often an image. The widgets can completely
or partially overlap the base widget.

##### Summary (Stack)
{:.no_toc}

* Use for widgets that overlap another widget
* The first widget in the list of children is the base widget;
  subsequent children are overlaid on top of that base widget
* A `Stack`'s content can't scroll
* You can choose to clip children that exceed the render box

##### Examples (Stack)
{:.no_toc}

<div class="row">
<div class="col-lg-7" markdown="1">
  <img src='/assets/images/docs/ui/layout/stack.png' class="mw-100" width="200px" alt="Circular avatar image with a label">
  {:.text-center}

  Uses `Stack` to overlay a `Container`
  (that displays its `Text` on a translucent
  black background) on top of a `CircleAvatar`.
  The `Stack` offsets the text using the `alignment` property and
  `Alignment`s.

  **App source:** [card_and_stack]({{examples}}/layout/card_and_stack)
</div>
<div class="col-lg-5" markdown="1">
  <img src='/assets/images/docs/ui/layout/stack-flutter-gallery.png' class="mw-100" alt="An image with a icon overlaid on top">
  {:.text-center}

  Uses `Stack` to overlay an icon on top of an image.

  **Dart code:** [bottom_navigation_demo.dart]({{demo}}/material/bottom_navigation_demo.dart)
  from the [Flutter Gallery][repo]
</div>
</div>

<?code-excerpt "layout/card_and_stack/lib/main.dart (Stack)" replace="/\bStack/[!$&!]/g;"?>
```dart
Widget _buildStack() {
  return [!Stack!](
    alignment: const Alignment(0.6, 0.6),
    children: [
      const CircleAvatar(
        backgroundImage: AssetImage('images/pic.jpg'),
        radius: 100,
      ),
      Container(
        decoration: const BoxDecoration(
          color: Colors.black45,
        ),
        child: const Text(
          'Mia B',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
```

### Material widgets

* [`Card`](#card): Organizes related info into a box with
  rounded corners and a drop shadow.
* [`ListTile`](#listtile): Organizes up to 3 lines of text,
  and optional leading and trailing icons, into a row.

#### Card

A [`Card`][], from the [Material library][],
contains related nuggets of information and can
be composed from almost any widget, but is often used with
[`ListTile`][]. `Card` has a single child,
but its child can be a column, row, list, grid,
or other widget that supports multiple children.
By default, a `Card` shrinks its size to 0 by 0 pixels.
You can use [`SizedBox`][] to constrain the size of a card.

In Flutter, a `Card` features slightly rounded corners
and a drop shadow, giving it a 3D effect.
Changing a `Card`'s `elevation` property allows you to control
the drop shadow effect. Setting the elevation to 24,
for example, visually lifts the `Card` further from the
surface and causes the shadow to become more dispersed.
For a list of supported elevation values, see [Elevation][] in the
[Material guidelines][Material Design].
Specifying an unsupported value disables the drop shadow entirely.

##### Summary (Card)
{:.no_toc}

* Implements a [Material card][]
* Used for presenting related nuggets of information
* Accepts a single child, but that child can be a `Row`,
  `Column`, or other widget that holds a list of children
* Displayed with rounded corners and a drop shadow
* A `Card`'s content can't scroll
* From the [Material library][]

##### Examples (Card)
{:.no_toc}

<div class="row">
<div class="col-lg-6" markdown="1">
  <img src='/assets/images/docs/ui/layout/card.png' class="mw-100" alt="Card containing 3 ListTiles">
  {:.text-center}

  A `Card` containing 3 ListTiles and sized by wrapping
  it with a `SizedBox`. A `Divider` separates the first
  and second `ListTiles`.

  **App source:** [card_and_stack]({{examples}}/layout/card_and_stack)
</div>
<div class="col-lg-6" markdown="1">
  <img src='/assets/images/docs/ui/layout/card-flutter-gallery.png' class="mw-100"
      alt="Card containing an image, text and buttons">
  {:.text-center}

  A `Card` containing an image and text.

  **Dart code:** [cards_demo.dart]({{demo}}/material/cards_demo.dart)
  from the [Flutter Gallery][repo]
</div>
</div>

<?code-excerpt "layout/card_and_stack/lib/main.dart (Card)" replace="/\bCard/[!$&!]/g;"?>
```dart
Widget _buildCard() {
  return SizedBox(
    height: 210,
    child: [!Card!](
      child: Column(
        children: [
          ListTile(
            title: const Text(
              '1625 Main Street',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('My City, CA 99984'),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              '(408) 555-1212',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.contact_phone,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: const Text('costa@example.com'),
            leading: Icon(
              Icons.contact_mail,
              color: Colors.blue[500],
            ),
          ),
        ],
      ),
    ),
  );
}
```
<hr>

#### ListTile

Use [`ListTile`][], a specialized row widget from the
[Material library][], for an easy way to create a row
containing up to 3 lines of text and optional leading
and trailing icons. `ListTile` is most commonly used in
[`Card`][] or [`ListView`][], but can be used elsewhere.

##### Summary (ListTile)
{:.no_toc}

* A specialized row that contains up to 3 lines of text and
  optional icons
* Less configurable than `Row`, but easier to use
* From the [Material library][]

##### Examples (ListTile)
{:.no_toc}

<div class="row">
<div class="col-lg-6" markdown="1">
  <img src='/assets/images/docs/ui/layout/card.png' class="mw-100" alt="Card containing 3 ListTiles">
  {:.text-center}

  A `Card` containing 3 `ListTile`s.

  **App source:** [card_and_stack]({{examples}}/layout/card_and_stack)
</div>
<div class="col-lg-6" markdown="1">
  <img src='/assets/images/docs/ui/layout/listtile-flutter-gallery.png' class="border mw-100" height="200px"
      alt="4 ListTiles, each containing a leading avatar">
  {:.text-center}

  Uses `ListTile` with leading widgets.<br>
  **Dart code:** [list_demo.dart]({{demo}}/material/list_demo.dart)
  from the [Flutter Gallery][repo]
</div>
</div>

### To learn more about layout widgets

To learn about other available widgets,
check out the [Widget catalog][],
or search the [API reference docs][].

The widget pages in the API docs often suggest
similar widgets that might better suit your needs.

<hr>

## Constraints

To fully understand Flutter's layout system, you need
to learn how Flutter positions and sizes
the components in a layout. For more information,
see [Understanding constraints][].

## The one widget app: Hello Dash!

How do you lay out a single widget on an app written in Flutter?
This section shows you how to create and display a simple widget.
It also shows the entire code for a simple Hello World app.

In Flutter, it takes only a few steps to put text, an icon,
or an image on the screen.

### 1. Add a layout widget

Choose from a variety of [layout widgets][] based
on how you want to align or constrain the visible widget,
as these characteristics are typically passed on to the
contained widget.

This guide uses the [`Center`][] widget.
It centers its content both horizontally and vertically on the screen.

### 2. Add a visible widget

Add a [`Text`][] widget.

<?code-excerpt "layout/base/lib/main.dart (text)" replace="/child: //g"?>
```dart
Text('Hello World'),
```

Create an [`Image`][] widget.

<?code-excerpt "layout/lakes/step5/lib/main.dart (Image-asset)" remove="/width|height|return/" replace="/;/,/g"?>
```dart
  image,
  fit: BoxFit.cover,
),
```

Create an [`Icon`][] widget.

<?code-excerpt "layout/lakes/step5/lib/main.dart (Icon)" remove="return "?>
```dart
Icon(
  Icons.star,
  color: Colors.red[500],
),
```

### 3. Add the visible widget to the layout widget

<?code-excerpt path-base="layout/base"?>

For this guide, make the `Text` a child of the `Center` widget.

<?code-excerpt "lib/main.dart (centered-text)" replace="/body: //g"?>
```dart
const Center(
  child: Text('Hello World'),
),
```

### 4. Add the layout widget to the page

A Flutter app is itself a widget. Most widgets have a [`build()`][] method.
If you instantiate and return a widget in the app's `build()` method,
the app then displays the widget.

This exact layout depends on the design system you use: Material, Cupertino,
or your own custom solution.

#### Material apps

For a `Material` app, you can use a [`Scaffold`][] widget;
it provides a default banner, background color,
and has API for adding drawers, snack bars, and bottom sheets.
Then you can add the `Center` widget directly to the `body`
property for the home page.

<?code-excerpt path-base="layout/base"?>
<?code-excerpt "lib/main.dart (MyApp)" title?>
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Flutter layout demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
```

{{site.alert.note}}
  The [Material library][] implements widgets that follow [Material
  Design][] principles. When designing your UI, you can exclusively use
  widgets from the standard [widgets library][], or you can use
  widgets from the Material library. You can mix widgets from both
  libraries, you can customize existing widgets,
  or you can build your own set of custom widgets.
{{site.alert.end}}

#### Cupertino apps

To create a `Cupertino` app, use `CupertinoApp` and [`CupertinoPageScaffold`][] widgets.

Unlike `Material`, it doesn't provide a default banner or background color.
You need to set these yourself.

* To set default colors, pass in a configured [`CupertinoThemeData`][]
  to your app's `theme` property.
* To add an iOS-styled navigation bar to the top of your app, add a
  [`CupertinoNavigationBar`][] widget to the `navigationBar`
  property of your scaffold.
  You can use the colors that [`CupertinoColors`][] provides to
  configure your widgets to match iOS design.

* To layout the body of your app, set the `child` property of your scaffold
  with the desired widget as its value, like `Center` or `Column`.

To learn what other UI components you can add, check out the
[Cupertino library][].

<?code-excerpt "lib/cupertino.dart (MyApp)" title?>
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter layout demo',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemGrey,
          middle: Text('Flutter layout demo'),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hello World'),
            ],
          ),
        ),
      ),
    );
  }
}
```

{{site.alert.note}}
  The [Cupertino library][] implements widgets that follow
  [Apple's Human Interface Guidelines for iOS][].
  When designing your UI, you can use
  widgets from the standard [widgets library][], or the Cupertino library.
  You can mix widgets from both libraries, you can customize existing widgets,
  or you can build your own set of custom widgets.
{{site.alert.end}}

[`CupertinoColors`]: {{api}}/cupertino/CupertinoColors-class.html
[`CupertinoThemeData`]: {{api}}/cupertino/CupertinoThemeData-class.html
[`CupertinoNavigationBar`]: {{api}}/cupertino/CupertinoNavigationBar-class.html
[Apple's Human Interface Guidelines for iOS]: {{site.apple-dev}}/design/human-interface-guidelines/designing-for-ios

#### Non-Material apps

For a non-Material app, you can add the `Center` widget to the app's
`build()` method:

<?code-excerpt path-base="layout/non_material"?>
<?code-excerpt "lib/main.dart (MyApp)" title?>
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
        child: Text(
          'Hello World',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
```

By default a non-Material app doesn't include an `AppBar`, title,
or background color. If you want these features in a non-Material app,
you have to build them yourself. This app changes the background
color to white and the text to dark grey to mimic a Material app.

<div class="row">
<div class="col-md-6" markdown="1">
  That's it! When you run the app, you should see _Hello World_.

  App source code:
  - [Material app]({{examples}}/layout/base)
  - [Non-Material app]({{examples}}/layout/non_material)
</div>
<div class="col-md-6">
  {% include docs/app-figure.md img-class="site-mobile-screenshot border w-75"
      image="ui/layout/hello-world.png" alt="Hello World" %}
</div>
</div>

## Videos

The following videos, part of the
[Flutter in Focus][] series,
explain `Stateless` and `Stateful` widgets.

<iframe width="560" height="315" src="{{site.youtube-site}}/embed/wE7khGHVkYY?rel=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> <iframe width="560" height="315" src="{{site.youtube-site}}/embed/AqCMFXEmf3w?rel=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
[Flutter in Focus playlist]({{site.youtube-site}}/watch?v=wgTBLj7rMPM&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2)

---

Each episode of the
[Widget of the Week series]({{site.youtube-site}}/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)
focuses on a widget. Several of them includes layout widgets.

<iframe width="560" height="315" src="{{site.youtube-site}}/embed/b_sQ9bMltGU?rel=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
[Flutter Widget of the Week playlist]({{site.youtube-site}}/watch?v=yI-8QHpGIP4&index=5&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)

## Other resources

The following resources might help when writing layout code.

* [Layout tutorial][]
: Learn how to build a layout.

* [Widget catalog][]
: Describes many of the widgets available in Flutter.

* [HTML/CSS Analogs in Flutter][]
: For those familiar with web programming,
  this page maps HTML/CSS functionality to Flutter features.

* Flutter Gallery [running app][], [repo][]
: Demo app showcasing many Material Design widgets and other
  Flutter features.

* [API reference docs][]
: Reference documentation for all of the Flutter libraries.

* [Adding assets and images][]
: Explains how to add images and other assets to your app's package.

* [Zero to One with Flutter][]
: One person's experience writing his first Flutter app.

[Cupertino library]: {{api}}/cupertino/cupertino-library.html
[`CupertinoPageScaffold`]: {{api}}/cupertino/CupertinoPageScaffold-class.html
[Adding assets and images]: {{site.url}}/ui/assets/assets-and-images
[API reference docs]: {{api}}
[`build()`]: {{api}}/widgets/StatelessWidget/build.html
[`Card`]: {{api}}/material/Card-class.html
[`Center`]: {{api}}/widgets/Center-class.html
[`Column`]: {{api}}/widgets/Column-class.html
[Common layout widgets]: #common-layout-widgets
[`Colors`]: {{api}}/material/Colors-class.html
[`Container`]: {{api}}/widgets/Container-class.html
[`CrossAxisAlignment`]: {{api}}/rendering/CrossAxisAlignment.html
[`DataTable`]: {{api}}/material/DataTable-class.html
[Elevation]: {{site.material}}/styles/elevation
[`Expanded`]: {{api}}/widgets/Expanded-class.html
[Flutter in Focus]: {{site.youtube-site}}/watch?v=wgTBLj7rMPM&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2
[`GridView`]: {{api}}/widgets/GridView-class.html
[`GridTile`]: {{api}}/material/GridTile-class.html
[HTML/CSS Analogs in Flutter]: {{site.url}}/get-started/flutter-for/web-devs
[`Icon`]: {{api}}/material/Icons-class.html
[`Image`]: {{api}}/widgets/Image-class.html
[Layout tutorial]: {{site.url}}/ui/layout/tutorial
[layout widgets]: {{site.url}}/ui/widgets/layout
[`ListTile`]: {{api}}/material/ListTile-class.html
[`ListView`]: {{api}}/widgets/ListView-class.html
[`MainAxisAlignment`]: {{api}}/rendering/MainAxisAlignment.html
[Material card]: {{site.material}}/components/cards
[Material Design]: {{site.material}}/styles
[Material Design palette]: {{site.material2}}/design/color/the-color-system.html#tools-for-picking-colors
[Material library]: {{api}}/material/material-library.html
[pubspec file]: {{examples}}/layout/pavlova/pubspec.yaml
[`pubspec.yaml` file]: {{examples}}/layout/row_column/pubspec.yaml
[repo]: {{site.repo.gallery}}/tree/main
[`Row`]: {{api}}/widgets/Row-class.html
[running app]: {{site.gallery}}
[`Scaffold`]: {{api}}/material/Scaffold-class.html
[`SizedBox`]: {{api}}/widgets/SizedBox-class.html
[`Stack`]: {{api}}/widgets/Stack-class.html
[`Table`]: {{api}}/widgets/Table-class.html
[`Text`]: {{api}}/widgets/Text-class.html
[tutorial]: {{site.url}}/ui/layout/tutorial
[widgets library]: {{api}}/widgets/widgets-library.html
[Widget catalog]: {{site.url}}/ui/widgets
[Debugging layout issues visually]: {{site.url}}/tools/devtools/inspector#debugging-layout-issues-visually
[Understanding constraints]: {{site.url}}/ui/layout/constraints
[Using the Flutter inspector]: {{site.url}}/tools/devtools/inspector
[Widget of the Week series]: {{site.youtube-site}}/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG
[Zero to One with Flutter]: {{site.medium}}/@mravn/zero-to-one-with-flutter-43b13fd7b354
