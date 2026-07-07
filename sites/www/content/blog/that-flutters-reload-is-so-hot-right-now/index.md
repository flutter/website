---
title: "Flutter’s hot reload is so hot right now."
description: "Testing how Flutter’s hot reload scales up."
publishDate: 2018-03-13
author: swavkulinski
image: images/17BKoEbJbiH08LxyMIpQdew.png
category: tutorial
layout: blog
---

<DashImage figure src="images/17BKoEbJbiH08LxyMIpQdew.png" />


When it comes to discussing hot reload there is really no chance to avoid a Zoolander meme so please forgive me the title.

One of the most popular features of Flutter framework is its **hot reload**. It allows reloading the code on the running app without losing the state, massively reducing development time. What is really important is that Flutter’s hot reload isn’t a feature which was added to the framework, like **Instant Run** in AndroidStudio. Flutter was designed this way from day one and it just leverages the power of its architecture. Flutter is fairly young but mobile companies already try to tackle full-scale development. I have noticed this by observing the shift in questions asked on [https://gitter.im/flutter/flutter](https://gitter.im/flutter/flutter) and on meetups. The initial wave of questions :
> How does it draw?
Why does it use Dart?
How it differs from other frameworks?

start to fade away and give more more time questions rooted in large-scale development.
> How does it scale?
What does CI support look like?
How automated testing looks like?

During last Flutter meetup [@Skillsmatter](http://twitter.com/Skillsmatter) one of the developers asked a quite serious question:
> *Will hot reload slow down as the project gets bigger? How much?*

My own projects in Flutter have never got bigger than a couple of dozens of classes and a handful of screens. My hot reload always stays steady at 650 ms, hence my curiosity.

## So where is the breaking point?

This is why I have decided to create a dummy project to take hot reload for a spin and push the envelope. I’ve built a simple code generator written in — no surprise here — **Dart**. Dart has a bunch of tricks under its belt which come in very handy when generating code. Dart is completely insensitive to **trailing commas**. This simplifies the code generation algorithm massively. You no longer need to branch your logic when processing the last element in the list.

## The Sample

My first attempt was quite simplistic.

1) The generator will create a specific number of stateless widgets
2) The generator will create a layout which nests them. 
3) I will manually modify generated .dart file and observe hot reload time

Below is an example of one of the generated stateless widget class.

```dart
class GeneratedWidget0 extends StatelessWidget {
 
  final Widget child;
  
  GeneratedWidget0({this.child});
  
  Widget build(BuildContext context) {
    return new Center(
      child: new DecoratedBox(
        decoration: new BoxDecoration(border: new Border(
          top: const BorderSide(color: Colors.blue,width: 0.5,style: BorderStyle.solid),
          bottom: const BorderSide(color: Colors.blue,width: 0.5,style: BorderStyle.solid),
          left: const BorderSide(color: Colors.blue,width: 0.5,style: BorderStyle.solid),
          right: const BorderSide(color: Colors.blue,width: 0.5,style: BorderStyle.solid),
        )),
         child: new Padding( 
          padding: new EdgeInsets.all(1.1),
          child: child,
         )
      ) 
    );
  }
}
```

The generated layout looks like this:

```dart
import ‘package:flutter/material.dart’;
 
  class MainLayout extends StatelessWidget {
 
@override
  Widget build(BuildContext context) {
    return new Material( child: new GeneratedWidget4 (
      child: new GeneratedWidget3 (
        child: new GeneratedWidget2 (
          child: new GeneratedWidget1 (
            child: new GeneratedWidget0 (
              child: new GeneratedWidget0 (
                child: new Text(‘test with 5 items’,style: Theme.of(context).textTheme.body1,),
              ),
            ),
          ),
        ),
      ),
    );
}

```

## The Test

I’ve started gently with 20 widgets. As I was expecting no reload could jump over 600ms. So I’ve pushed the throttle a bit with 80 widgets. Still no change.
I have decided to go nuts and hit it with 1000 nested widgets.

The result was interesting. Compiler hit me with an error:

```
error: line 265 pos 8: stack overflow while parsing
```


By trial and error, I’ve concluded that it takes roughly about 250 unique nested widgets to get this error. This wasn’t a result I was looking for. I wanted to see how hot reload slows down, not where compiler tells me that I am insane.

I had to find the way to pass the limit nested widgets without breaking the parser.

I modified the generator to create a number of packages, each one with a generated file like the one above, but all with distinct names. Then I added a generator for a **router** which registered each package as the navigator’s target. This way I was sure I’d used all my classes.

Below you can see the router for 5 packages.

```dart

import ‘package:flutter/material.dart’;
import ‘package_0/generated_widget.dart’;
import ‘package_1/generated_widget.dart’;
import ‘package_2/generated_widget.dart’;
import ‘package_3/generated_widget.dart’;
import ‘package_4/generated_widget.dart’;

class Router extends StatelessWidget {
  
  @override build(BuildContext context) {
  
    return new MaterialApp(
      title: ‘Flutter Demo’,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes : {
        ‘/’ : (context) => new Package0MainLayout(onTapHandler:()=>Navigator.of(context).pushNamed(‘/route_1’)),
        ‘/route_1’ : (context) => new Package1MainLayout(onTapHandler:()=>Navigator.of(context).pushNamed(‘/route_2’)),
        ‘/route_2’ : (context) => new Package2MainLayout(onTapHandler:()=>Navigator.of(context).pushNamed(‘/route_3’)),
        ‘/route_3’ : (context) => new Package3MainLayout(onTapHandler:()=>Navigator.of(context).pushNamed(‘/route_4’)),
        ‘/route_4’ : (context) => new Package4MainLayout(onTapHandler:()=>Navigator.of(context).pushNamed(‘/’)),
      },
    );
  }
}

```

Now I was able to pack more classes into more layouts without hitting the “magic 250 nested widgets wall”. I was out of the woods with the parser problem and able to continue my tests.

**80 widgets x 1 package — *one class modified*** — 650 ms.
**80 widgets x 5 packages — *5 classes modified*** — 650 ms.

However this one returned with a warning

```
Some program elements were changed during reload but did not run when the view was reassembled;
you may need to restart the app (by pressing “R”) for the changes to have an effect.
 • Package4MainLayout.build (lib/package_4/generated_widget.dart:10)
 • Package3MainLayout.build (lib/package_3/generated_widget.dart:10)
 • Package2MainLayout.build (lib/package_2/generated_widget.dart:10)

```


then I added 75 more packages and the result was a Dart VM timeout error:

```
TimeoutException: Request to Dart VM Service timed out
…
Application finished.

```


I restarted Flutter and continued from 80 x 80. Then I pressed reload and noticed

```
Reloaded 82 of 644 libraries in 1,209ms.
```


OK. So **it depends on how many classes we modify**, not on the size of the project itself. Flutter reloaded 80 widgets in 80 packages in slightly more than 1.2 seconds. I’ve realised that the reason why I was receiving same 650 ms result was one of the Dart’s and Flutter’s strongest side — **immutability**. Dart and Flutter reuse most of the old object when creating new state. Only parts which are inevitably modified are replaced.

Smart, this means if we stick to one place in the code during development we will get 650 ms every time. My thoughts went straight to Uncle Bob’s lessons. This tool is perfect for TDD.

It was time for a pedal to the metal. **80 widgets x 250 packages** — if you are developing an application which has 250 unique layouts /screens— please stop it now. Be considerate of user’s time, and your own!

The result of this craziness was:

```
Reloaded 252 of 984 libraries in 3,219ms.
```


I must say, Flutter’s hot reload is really impressive. For day to day use it won’t jump above its usual time as long as we do nice and small incremental changes. Size of the project doesn’t matter that much.

Before I go I want to share with you my generator. Please have fun with it. I know it doesn’t look pretty but it does the job. If you have ideas about how to test other parts of the Flutter framework make a pull request or fork it!

<GitHubEmbed repo="swavkulinski/flutter-stress-test" title="flutter-stress-test - This started as a question from one of the Flutter meet-ups." image="images/0BUpIm2yR_KoNcT82.jpg" />
