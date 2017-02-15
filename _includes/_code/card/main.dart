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
        child: new SizedBox(
          height: 210.0,
          child: new Card(
            child: new Column(
              children: [
                new ListItem(
                  title: new Text('1625 Main Street',
                      style: new TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: new Text('My City, CA 99984'),
                  leading: new Icon(
                    Icons.restaurant_menu,
                    color: Colors.blue[500],
                  ),
                ),
                new Divider(),
                new ListItem(
                  title: new Text('(408) 555-1212',
                      style: new TextStyle(fontWeight: FontWeight.w500)),
                  leading: new Icon(
                    Icons.contact_phone,
                    color: Colors.blue[500],
                  ),
                ),
                new ListItem(
                  title: new Text('costa@example.com'),
                  leading: new Icon(
                    Icons.contact_mail,
                    color: Colors.blue[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
