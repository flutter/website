---
layout: page
title: "Using Themes to share colors and font styles"
permalink: /cookbook/design/themes/
---

In order to share colors and font styles throughout our app, we can take 
advantage of themes. There are two ways to define themes: App-wide or using 
`Theme` Widgets that define the colors and font styles for a particular part of 
our application. 

After we define a Theme, we can use it within our own Widgets. In addition, the 
Material Widgets provided by Flutter will use our Theme to set the background 
colors and and font styles for AppBars, Buttons, Checkboxes, and more.    

## Creating an app theme

In order to share a Theme containing colors and font styles across our entire 
app, we can provide [`ThemeData`](https://docs.flutter.io/flutter/material/ThemeData-class.html)
to the `MaterialApp` constructor.

If no `theme` is provided, Flutter will create a fallback theme under the hood.

```dart
new MaterialApp(
  title: title,
  theme: new ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],
    accentColor: Colors.cyan[600],
    fontFamily: 'Merriweather',
  ),
);
```

Please see the [ThemeData](https://docs.flutter.io/flutter/material/ThemeData-class.html)
documentation to see all of the colors and fonts you can define.

## Themes for part of an application

If we want to override the app-wide theme in part of our application, we can 
wrap a section of our app in a `Theme` Widget. 

```dart
new Theme(
  data: new ThemeData(
    accentColor: Colors.yellow,
  ),
  child: new FloatingActionButton(
    onPressed: () {},
    child: new Icon(Icons.add),
  ),
);
```

## Using a Theme

Now that we've defined a theme, we can use it within our Widget `build` methods
by using the `Theme.of(context)` function!

`Theme.of(context)` will look up the Widget tree and return the nearest `Theme` 
in the tree. If we have a stand-alone `Theme` defined above our Widget, it 
returns that. If not, it returns the App theme.
 
```dart
new Container(
  padding: new EdgeInsets.all(12.0),
  decoration: new BoxDecoration(
    color: Theme.of(context).accentColor,
    borderRadius: new BorderRadius.circular(8.0),
  ),
  child: new Text(
    'Hi Friends!',
    style: Theme.of(context).textTheme.title,
  ),
);
```   

## Complete Example

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Custom Themes';

    return new MaterialApp(
      title: title,
      theme: new ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Merriweather',
      ),
      home: new MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Container(
          padding: new EdgeInsets.all(12.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: new BorderRadius.circular(8.0),
          ),
          child: new Text(
            'Hi Friends!',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
      floatingActionButton: new Theme(
        data: new ThemeData(
          accentColor: Colors.yellow,
        ),
        child: new Theme(
          data: new ThemeData(
            accentColor: Colors.yellow,
          ),
          child: new FloatingActionButton(
            onPressed: null,
            child: new Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
```