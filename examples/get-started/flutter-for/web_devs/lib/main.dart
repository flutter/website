import 'package:flutter/material.dart';

// #docregion TextStyle
TextStyle bold24Roboto = const TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
// #enddocregion TextStyle

class MyWidget extends StatelessWidget {
  MyWidget({super.key});

  // #docregion Container
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: const Text(
      'Lorem ipsum',
      style: /*[[highlight]]*/ TextStyle(
        fontFamily: 'Georgia',
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      /*[[/highlight]]*/
      /*[[highlight]]*/ textAlign: TextAlign.center, /*[[/highlight]]*/
    ),
  );
// #enddocregion Container

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class Container2 extends StatelessWidget {
  Container2({super.key});

  // #docregion Container2
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    /*[[highlight]]*/ color: Colors.grey[300],
    /*[[/highlight]]*/
    child: Text(
      'Lorem ipsum',
      style: bold24Roboto,
    ),
  );
// #enddocregion Container2

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class Container3 extends StatelessWidget {
  Container3({super.key});

  // #docregion Container3
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    /*[[highlight]]*/ decoration: BoxDecoration(
      color: Colors.grey[300],
    ),
    /*[[/highlight]]*/
    child: Text(
      'Lorem ipsum',
      style: bold24Roboto,
    ),
  );
// #enddocregion Container3

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class CenterWidget extends StatelessWidget {
  CenterWidget({super.key});

  // #docregion Center
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: /*[[highlight]]*/ Center(
      child: /*[[/highlight]]*/ Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  );
  // #enddocregion Center

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class Nested extends StatelessWidget {
  Nested({super.key});

  // #docregion Nested
  final container = Container(
    // grey box
    /*[[highlight]]*/ width: 320,
    /*[[/highlight]]*/
    height: 240,
    color: Colors.grey[300],
    child: Center(
      child: Container(
        // red box
        /*[[highlight]]*/ width: 240,
        /*[[/highlight]]*/ // max-width is 240
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        child: Text(
          'Lorem ipsum',
          style: bold24Roboto,
        ),
      ),
    ),
  );
  // #enddocregion Nested

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class Absolute extends StatelessWidget {
  Absolute({super.key});

  // #docregion Absolute
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    /*[[highlight]]*/ child: Stack(
      children: /*[[/highlight]]*/ [
        Positioned(
          // red box
          /*[[highlight]]*/ left: 24,
          top: 24,
          /*[[/highlight]]*/
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[400],
            ),
            child: Text(
              'Lorem ipsum',
              style: bold24Roboto,
            ),
          ),
        ),
      ],
    ),
  );
  // #enddocregion Absolute

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class Rotating extends StatelessWidget {
  Rotating({super.key});

  // #docregion Rotating
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: Center(
      child: /*[[highlight]]*/ Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateZ(15 * 3.1415927 / 180),
        child: /*[[/highlight]]*/ Container(
          // red box
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red[400],
          ),
          child: Text(
            'Lorem ipsum',
            style: bold24Roboto,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
  // #enddocregion Rotating

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class Scaling extends StatelessWidget {
  Scaling({super.key});

  // #docregion Scaling
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: Center(
      child: /*[[highlight]]*/ Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(1.5),
        child: /*[[/highlight]]*/ Container(
          // red box
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red[400],
          ),
          child: Text(
            'Lorem ipsum',
            style: bold24Roboto,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
  // #enddocregion Scaling

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class Gradient extends StatelessWidget {
  Gradient({super.key});

  // #docregion Gradient
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: Center(
      child: Container(
        // red box
        /*[[highlight]]*/ decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0.0, 0.6),
            colors: <Color>[
              Color(0xffef5350),
              Color(0x00ef5350),
            ],
          ),
        ),
        /*[[/highlight]]*/
        padding: const EdgeInsets.all(16),
        child: Text(
          'Lorem ipsum',
          style: bold24Roboto,
        ),
      ),
    ),
  );
  // #enddocregion Gradient

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class HorizontalGradient extends StatelessWidget {
  HorizontalGradient({super.key});

  // #docregion HorizontalGradient
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: Center(
      child: Container(
        // red box
        padding: const EdgeInsets.all(16),
        /*[[highlight]]*/ decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(0.6, 0.0),
            colors: <Color>[
              Color(0xffef5350),
              Color(0x00ef5350),
            ],
          ),
        ),
        /*[[/highlight]]*/
        child: Text(
          'Lorem ipsum',
          style: bold24Roboto,
        ),
      ),
    ),
  );
  // #enddocregion HorizontalGradient

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class RoundCorners extends StatelessWidget {
  RoundCorners({super.key});

  // #docregion RoundCorners
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: Center(
      child: Container(
        // red circle
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[400],
          /*[[highlight]]*/ borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ), /*[[/highlight]]*/
        ),
        child: Text(
          'Lorem ipsum',
          style: bold24Roboto,
        ),
      ),
    ),
  );
  // #enddocregion RoundCorners

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class BoxShadowExample extends StatelessWidget {
  BoxShadowExample({super.key});

  // #docregion BoxShadow
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.grey[300],
    ),
    child: Center(
      child: Container(
        // red box
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[400],
          /*[[highlight]]*/ boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0xcc000000),
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
            BoxShadow(
              color: Color(0x80000000),
              offset: Offset(0, 6),
              blurRadius: 20,
            ),
          ], /*[[/highlight]]*/
        ),
        child: Text(
          'Lorem ipsum',
          style: bold24Roboto,
        ),
      ),
    ),
  );
  // #enddocregion BoxShadow

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class CircleExample extends StatelessWidget {
  CircleExample({super.key});

  // #docregion Circle
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: Center(
      child: Container(
        // red circle
        decoration: BoxDecoration(
          color: Colors.red[400],
          /*[[highlight]]*/ shape: BoxShape.circle, /*[[/highlight]]*/
        ),
        padding: const EdgeInsets.all(16),
        /*[[highlight]]*/ width: 160,
        height: 160,
        /*[[/highlight]]*/
        child: Text(
          'Lorem ipsum',
          style: bold24Roboto,
          /*[[highlight]]*/ textAlign: TextAlign.center, /*[[/highlight]]*/
        ),
      ),
    ),
  );
  // #enddocregion Circle

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class TextSpacingExample extends StatelessWidget {
  TextSpacingExample({super.key});

  // #docregion TextSpacing
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: Center(
      child: Container(
        // red box
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        child: const Text(
          'Lorem ipsum',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            /*[[highlight]]*/ letterSpacing: 4, /*[[/highlight]]*/
          ),
        ),
      ),
    ),
  );
  // #enddocregion TextSpacing

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class InlineFormattingExample extends StatelessWidget {
  InlineFormattingExample({super.key});

  // #docregion InlineFormatting
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: Center(
      child: Container(
        // red box
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        padding: const EdgeInsets.all(16),
        child: /*[[highlight]]*/ RichText(
          text: TextSpan(
            style: bold24Roboto,
            children: const <TextSpan>[
              TextSpan(text: 'Lorem '),
              TextSpan(
                text: 'ipsum',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  fontSize: 48,
                ),
              ),
            ],
          ),
        ), /*[[/highlight]]*/
      ),
    ),
  );
  // #enddocregion InlineFormatting

  @override
  Widget build(BuildContext context) {
    return container;
  }
}

class TextExcerptsExample extends StatelessWidget {
  TextExcerptsExample({super.key});

  // #docregion TextExcerpt
  final container = Container(
    // grey box
    width: 320,
    height: 240,
    color: Colors.grey[300],
    child: Center(
      child: Container(
        // red box
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          'Lorem ipsum dolor sit amet, consec etur',
          style: bold24Roboto,
          /*[[highlight]]*/ overflow: TextOverflow.ellipsis,
          maxLines: 1, /*[[/highlight]]*/
        ),
      ),
    ),
  );
  // #enddocregion TextExcerpt

  @override
  Widget build(BuildContext context) {
    return container;
  }
}
