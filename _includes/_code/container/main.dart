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
          decoration: new BoxDecoration(
            backgroundColor: Colors.black26,
          ),
          child: new Column(
            children: [
              new Row(
                children: [
                  new Expanded(
                    child: new Container(
                      decoration: new BoxDecoration(
                        border:
                            new Border.all(width: 10.0, color: Colors.black38),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(8.0)),
                      ),
                      margin: const EdgeInsets.all(4.0),
                      child: new Image.asset('images/pic1.jpg'),
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      decoration: new BoxDecoration(
                        border:
                            new Border.all(width: 10.0, color: Colors.black38),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(8.0)),
                      ),
                      margin: const EdgeInsets.all(4.0),
                      child: new Image.asset('images/pic2.jpg'),
                    ),
                  ),
                ],
              ),
              new Row(
                children: [
                  new Expanded(
                    child: new Container(
                      decoration: new BoxDecoration(
                        border:
                            new Border.all(width: 10.0, color: Colors.black38),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(8.0)),
                      ),
                      margin: const EdgeInsets.all(4.0),
                      child: new Image.asset('images/pic3.jpg'),
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      decoration: new BoxDecoration(
                        border:
                            new Border.all(width: 10.0, color: Colors.black38),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(8.0)),
                      ),
                      margin: const EdgeInsets.all(4.0),
                      child: new Image.asset('images/pic4.jpg'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Row({Key key,
//   MainAxisAlignment mainAxisAlignment: MainAxisAlignment.start,
//   MainAxisSize mainAxisSize: MainAxisSize.max,
//   CrossAxisAlignment crossAxisAlignment: CrossAxisAlignment.center,
//   TextBaseline textBaseline,
//   List<Widget> children: const [] })
