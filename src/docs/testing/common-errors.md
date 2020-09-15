---
title: Common Flutter Errors
description: How to recognize and resolve common Flutter Framework errors.
---

## Introduction

This page explains several frequently-encountered Flutter Framework errors and gives suggestions on how to resolve them. This is a living document with more errors we’d like to add in future revisions, and we welcome contributions from all Flutter users. Feel free to open an issue or submit a pull request to make this page more useful to you and the Flutter community. 


### List of Errors

* [A RenderFlex overflowed…](#a-renderflex-overflowed)
* [RenderBox was not laid out](#renderbox-was-not-laid-out)
* [Vertical viewport was given unbounded height](#vertical-viewport-was-given-unbounded-height)
* [Incorrect use of ParentData widget](#incorrect-use-of-parentdata-widget)
* [‘An InputDecorator...cannot have an unbounded width’](#an-inputdecoratorcannot-have-an-unbounded-width)
* [setState called during build](#setstate-called-during-build)



## ‘A RenderFlex overflowed…’


### What does the error look like?

RenderFlex overflow is one of the most frequent Flutter Framework errors we’ve seen, and you probably have run into it already. When it happens, you’ll see yellow & black stripes indicating the area of overflow in the app UI in addition to the error message in the debug console: 

<!-- ![alt_text](images/image1.png "image_tooltip") -->


```
The following assertion was thrown during layout:
A RenderFlex overflowed by 1146 pixels on the right.

The relevant error-causing widget was
    Row 							lib/errors/renderflex_overflow_column.dart:23
The overflowing RenderFlex has an orientation of Axis.horizontal.
The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and black striped pattern. This is usually caused by the contents being too big for the RenderFlex.

Consider applying a flex factor (e.g. using an Expanded widget) to force the children of the RenderFlex to fit within the available space instead of being sized to their natural size.
This is considered an error condition because it indicates that there is content that cannot be seen. If the content is legitimately bigger than the available space, consider clipping it with a ClipRect widget before putting it in the flex, or using a scrollable container rather than a Flex, like a ListView.

The specific RenderFlex in question is: RenderFlex#c3a70 relayoutBoundary=up1 OVERFLOWING
```



### How might you run into this error?

The error often occurs when a Column or Row has a child widget that is not constrained in its size. Let’s take a look at a common scenario in the code below:


```dart
Widget build(BuildContext context) {
  return Container(
    child: Row(
      children: [
        Icon(Icons.message),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title", style: Theme.of(context).textTheme.headline4),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed"
                " do eiusmod tempor incididunt ut labore et dolore magna "
                "aliqua. Ut enim ad minim veniam, quis nostrud "
                "exercitation ullamco laboris nisi ut aliquip ex ea "
                "commodo consequat."),
          ],
        ),
      ],
    ),
  );
}
```


In the above example, the Column will try to be wider than the space the Row (its parent) can allocate to it, causing an overflow error.  Why does the Column try to do that? To understand this layout behavior, we need to remember how Flutter Framework does layout:

<!-- TODO: Fix the blockquote style -->
>"To perform layout, Flutter walks the render tree in a depth-first traversal and **passes down size constraints** from parent to child… Children respond by **passing up a size** to their parent object within the constraints the parent established."  – [Flutter architectural overview](/docs/resources/architectural-overview#layout-and-rendering)

In this case, the Row widget doesn’t constrain the size of its children, nor does the Column widget. Lacking constraints from its parent widget, the second Text widget tries to be as wide as all the characters it needs to display. The self-determined width of the Text widget then gets adopted by the Column which clashes with the maximum amount of horizontal space its parent the Row widget can provide.  


### How to fix it?

Well, we need to make sure the Column won’t attempt to be wider than it can be. To achieve this, we need to constrain its width. One way to do it is to wrap the Column in an Expanded widget:


```dart
child: Row(
  children: [
    Icon(Icons.message),
    Expanded(
      child: Column(
        // code omitted
      ),
    ),
  ]
)
```


Another way is to wrap the Column in a Flexible widget and specify a flex factor. In fact, the Expanded widget is equivalent to the Flexible widget with a flex factor of 1.0, as [its source code](https://github.com/flutter/flutter/blob/127e67902e8bbb0dcbfb3351b8fd00f7cbdf0178/packages/flutter/lib/src/widgets/basic.dart#L4677-L4686) shows. To further understand how to use the Flex widget in Flutter layouts, please check out [this Widget of the Week video](https://youtu.be/CI7x0mAZiY0) on the Flexible widget.

### Further readings:



*   [Flexible (Flutter Widget of the Week)](https://youtu.be/CI7x0mAZiY0)
*   [How to debug layout issues with the Flutter Inspector](https://medium.com/flutter/how-to-debug-layout-issues-with-the-flutter-inspector-87460a7b9db#738b)
*   [Understanding constraints](/docs/development/ui/layout/constraints)


## ‘RenderBox was not laid out’


### What does the error look like?

The message shown by the error looks like this: 

<!-- ![alt_text](images/image2.png "image_tooltip") -->


```
RenderBox was not laid out: RenderViewport#5a477 NEEDS-LAYOUT NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
'package:flutter/src/rendering/box.dart':
Failed assertion: line 1785 pos 12: 'hasSize'
The relevant error-causing widget was
    ListView 					lib/errors/unbounde...
```



### How might you run into this error?

While this error is pretty common, it’s often a side effect of a primary error occurring earlier in the rendering pipeline. Usually, the issue is related to violation of box constraints and needs to be solved by providing more information to Flutter about how you’d like to constrain the widgets in question. You can learn more about how constraints work in Flutter on [this page](/docs/development/ui/layout/constraints). 

In this doc, we describe two primary errors that can lead to the ‘RenderBox was not laid out’ error:



*   [‘Vertical viewport was given unbounded height’](#vertical-viewport-was-given-unbounded-height)
* [‘An InputDecorator...cannot have an unbounded width’](#an-inputdecoratorcannot-have-an-unbounded-width)


## ‘Vertical viewport was given unbounded height’


### What does the error look like?

The message shown by the error looks like this: 

<!-- ![alt_text](images/image3.png "image_tooltip") -->



```
The following assertion was thrown during performResize():
Vertical viewport was given unbounded height.

Viewports expand in the scrolling direction to fill their container. In this case, a vertical viewport was given an unlimited amount of vertical space in which to expand. This situation typically happens when a scrollable widget is nested inside another scrollable widget.

If this widget is always nested in a scrollable widget there is no need to use a viewport because there will always be enough vertical space for the children. In this case, consider using a Column instead. Otherwise, consider using the "shrinkWrap" property (or a ShrinkWrappingViewport) to size the height of the viewport to the sum of the heights of its children.

The relevant error-causing widget was
    ListView 						lib/errors/unbounded...
```



### How might you run into this error?

The error is often caused when a ListView (or other kinds of scrollable widgets such as GridView) is placed inside a Column. A ListView takes all the vertical space available to it, unless it’s constrained by its parent widget. However, a Column doesn’t impose any constraint on it’s children’s height by default. The combination of the two behaviors lead to the failure of determining the size of the ListView. 


```dart
Widget build(BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        Text('Header'),
        ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
            ),
            ListTile(
              leading: Icon(Icons.subway),
              title: Text('Subway'),
            ),
          ],
        ),
      ],
    ),
  );
}
```



### How to fix it?

To fix this error, you need to specify how tall you’d like the ListView to be. If you’d like to have the ListView be as tall as the remaining space in the Column, you can wrap it using an Expanded widget (see the example below). Otherwise, you can specify an absolute height using SizedBox or a relative height using a Flexible widget.


```dart
Widget build(BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        Text('Header'),
        Expanded(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Map'),
              ),
              ListTile(
                leading: Icon(Icons.subway),
                title: Text('Subway'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
```



### Further readings:



*   [How to debug layout issues with the Flutter Inspector](https://medium.com/flutter/how-to-debug-layout-issues-with-the-flutter-inspector-87460a7b9db#1de2)
*   [Understanding constraints](/docs/development/ui/layout/constraints)


## ‘An InputDecorator...cannot have an unbounded width’


### What does the error look like?

The message shown by the error looks like this: 

<!-- ![alt_text](images/image4.png "image_tooltip") -->

```
The following assertion was thrown during performLayout():
An InputDecorator, which is typically created by a TextField, cannot have an unbounded width.
This happens when the parent widget does not provide a finite width constraint. For example, if the InputDecorator is contained by a Row, then its width must be constrained. An Expanded widget or a SizedBox can be used to constrain the width of the InputDecorator or the TextField that contains it.
```



### How might you run into the error?

This error would occur, when you put a TextFormField or a TextField in a Row without constraining the width of the TextField.


```dart
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title:
            Text('Unbounded Width of the TextField'),
      ),
      body: Row(
        children: [
          TextField(),
        ],
      ),
    ),
  );
}
```



### How to fix it?

As suggested by the error message, you can fix this error by constrain the TextField using an Expanded widget (see the example below) or a SizedBox widget. 


```dart
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Unbounded Width of the TextField'),
        ),
        body: Row(
          children: [
            Expanded(
                child: TextFormField()
            ),
          ],
        ),
      ),
    );
  }
```



## ‘Incorrect use of ParentData widget’


### What does the error look like?

The message shown by the error looks like this: 

<!-- ![alt_text](images/image5.png "image_tooltip") -->



```
The following assertion was thrown while looking for parent data.:
Incorrect use of ParentDataWidget.

The following ParentDataWidgets are providing parent data to the same RenderObject:
- Expanded(flex: 1) (typically placed directly inside a Flex widget)
- LayoutId-[<_ScaffoldSlot.body>](id: _ScaffoldSlot.body) (typically placed directly inside a CustomMultiChildLayout widget)
However, a RenderObject can only receive parent data from at most one ParentDataWidget.

Usually, this indicates that at least one of the offending ParentDataWidgets listed above is not placed directly inside a compatible ancestor widget.
```



### How might you run into the error?

While Flutter’s widgets are generally flexible in how they get composed together in a UI, a small subset of those widgets expect specific parent widgets. When this expectation can’t be satisfied in your widget tree, you’re likely to see this error. 

Here is an _incomplete_ list of widgets that expect specific parent widgets within the Flutter Framework. Feel free to submit a PR to add more of such widgets. 

| Widget                            | Expected parent widget(s) |
| :-------------------------------- | ------------------------: |
| Flexible                          |      Row, Column, or Flex |
| Expanded (a specialized Flexible) |      Row, Column, or Flex |
| Positioned                        |                     Stack |
| Flexible                          |      Row, Column, or Flex |
| TableCell                         |                     Table |



### How to fix it?

The fix should be obvious once you know what parent widget is missing. 


## ‘setState called during build’


### What does the error look like?

<!-- ![alt_text](images/image6.png "image_tooltip") -->

```
The following assertion was thrown building DialogPage(dirty, dependencies: [_InheritedTheme, _LocalizationsScope-[GlobalKey#59a8e]], state: _DialogPageState#f121e):
setState() or markNeedsBuild() called during build.

This Overlay widget cannot be marked as needing to build because the framework is already in the process of building widgets.  A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
The widget on which setState() or markNeedsBuild() was called was: Overlay-[LabeledGlobalKey<OverlayState>#783d6]
```

### How might you run into the error?

In general, this error occurs when the `setState` method is called within the build method. 

A common scenario where this error would occur is when attempting to trigger a Dialog from within the build method. This scenario is often motivated by the requirement of showing some information to the user immediately upon their entry to a new page.  

Below is a snippet that seems to be a common culprit of this error:


```dart
Widget build(BuildContext context) {

  // Don't do this. 
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert Dialog"),
        );
      });

  return Center(
    child: Column(
      children: <Widget>[
        Text('Show Material Dialog'),
      ],
    ),
  );
}
```


You can’t see the call to `setState` here, but it’s being used as part of `showDialog`, which is why this error is coming up. The build method is never the right place to call `showDialog`. The `build` method could be called by the framework for every frame, e.g., during an animation. 

### How to fix it?

One way to avoid this error is to use the Navigator API to trigger the dialog as a route. In the example below, there are two pages. The second page has a dialog to be displayed upon entry. When the user requests the second page from clicking on a button on the first page, the Navigator would push two routes in a row – one for the second page and another for the dialog.  


```dart
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
            // Immediately show a dialog upon loading the second screen.
            Navigator.push(
              context,
              PageRouteBuilder(
                barrierDismissible: true,
                opaque: false,
                pageBuilder: (_, anim1, anim2) => MyDialog(),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

## References

*   [How to debug layout issues with the Flutter Inspector](https://medium.com/flutter/how-to-debug-layout-issues-with-the-flutter-inspector-87460a7b9db)
*   [Understanding constraints](/docs/development/ui/layout/constraints)
*   [Dealing with box constraints](/docs/development/ui/layout/box-constraints)
*   [Flutter architectural overview](/docs/resources/architectural-overview#layout-and-rendering)