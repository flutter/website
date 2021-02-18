```run-dartpad:theme-light:mode-flutter:split-60:width-100%:height-532px:ga_id-fade_in_starter_code:null_safety-true
{$ begin main.dart $}
import 'package:flutter/material.dart';

const owl_url = 'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

class FadeInDemo extends StatefulWidget {
  _FadeInDemoState createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Image.network(owl_url),
      TextButton(
        child: Text(
          'Show details',
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () => null,
      ),
      Container(
        child: Column(
          children: <Widget>[
            Text('Type: Owl'),
            Text('Age: 39'),
            Text('Employment: None'),
          ],
        ),
      )
    ]);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FadeInDemo(),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MyApp(),
  );
}
{$ end main.dart $}
```
