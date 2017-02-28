import 'package:flutter/material.dart';
// Uncomment lines 3 and 6 to view the visual layout at runtime.
//import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  //debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

IconData icon = Icons.star;

class FavoriteWidget extends StatefulWidget {
  /**
  new Icon(
  icon,
  color: Colors.red[500],
  ),
  new Text('41'),
      */
  
}


//class MyApp extends StatefulWidget {
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'Oeschinen Lake Campground',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  'Kandersteg, Switzerland',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          new FavoriteWidget(),
        ],
      ),
    ); // end of "Widget titleSection"

    Column buildButtonColumn(IconData icon, String label) {
      List<Widget> widgets = new List(2);
      Color color = Theme.of(context).primaryColor;

      widgets[0] = new Icon(icon, color: color);
      widgets[1] = new Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: new Text(
          label,
          style: new TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      );

      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets,
      );
    } // end of "Column buildButtonColumn"

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );

    IconData swapIcon(IconData currentIcon) {
      return currentIcon == Icons.star ? Icons.star_border : Icons.star;
    }

    return new GestureDetector(
        onTap: () {
          icon = swapIcon(icon);
        },
        child: new MaterialApp(
          title: 'Flutter Demo',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new Scaffold(
            appBar: new AppBar(
              title: new Text('Top Lakes'),
            ),
            body: new Column(
              children: [
                new Image.asset(
                  'images/lake.jpg',
                  width: 600.0,
                  height: 240.0,
                  fit: ImageFit.cover,
                ),
                titleSection,
                buttonSection,
                textSection,
              ],
            ),
          ),
        ) // end of "new MaterialApp()"
        ); // end of "return new GestureDetector()"
  } // end of "Widget build()"
} // end "class MyApp extends StatelessWidget"
