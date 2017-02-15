import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  //debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

Widget buildGrid() {
  return new GridView.count(
    crossAxisCount: 2,
    padding: const EdgeInsets.all(8.0),
    mainAxisSpacing: 8.0,
    crossAxisSpacing: 8.0,
    children: [
      new Container(
        decoration: new BoxDecoration(
          border: new Border.all(width: 10.0, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
        ),
        child: new GridTile(
          child: new Image.asset('images/pic1.jpg'),
        ),
      ),
      new Container(
        decoration: new BoxDecoration(
          border: new Border.all(width: 10.0, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
        ),
        child: new GridTile(
          child: new Image.asset('images/pic2.jpg'),
        ),
      ),
      new Container(
        decoration: new BoxDecoration(
          border: new Border.all(width: 10.0, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
        ),
        child: new GridTile(
          child: new Image.asset('images/pic3.jpg'),
        ),
      ),
      new Container(
        decoration: new BoxDecoration(
          border: new Border.all(width: 10.0, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
        ),
        child: new GridTile(
          child: new Image.asset('images/pic4.jpg'),
        ),
      ),
    ],
  );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 5, // Removing drop shadow cast by the AppBar.
        title: new Text(config.title),
      ),
      body: new Center(
        child: new Container(
          decoration: new BoxDecoration(backgroundColor: Colors.black26),
          child: buildGrid(),
        ),
      ),
    );
  }
}

// GridView.count({Key key,
//   Axis scrollDirection: Axis.vertical,
//   bool reverse: false,
//   ScrollController controller,
//   bool primary: false,
//   ScrollPhysics physics,
//   bool shrinkWrap: false,
//   EdgeInsets padding,
//   @required int crossAxisCount,
//   double mainAxisSpacing: 0.0,
//   double crossAxisSpacing: 0.0,
//   double childAspectRatio: 1.0,
//   List<Widget> children: const [] })

// GridView.extent({Key key,
//   Axis scrollDirection: Axis.vertical,
//   bool reverse: false,
//   ScrollController controller,
//   bool primary: false,
//   ScrollPhysics physics,
//   bool shrinkWrap: false,
//   EdgeInsets padding,
//   @required double maxCrossAxisExtent,
//   double mainAxisSpacing: 0.0,
//   double crossAxisSpacing: 0.0,
//   double childAspectRatio: 1.0,
//   List<Widget> children: const [] })

/**
    Widget buildGrid(Orientation orientation) {
    return new GridView.count(
    crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
    padding: const EdgeInsets.all(4.0),
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
    children: _buildGridTileList(29));
    }
 */
