---
title: "How to embed a Flutter application in a Website using DartPad"
description: "Have you ever wanted to embed your mobile application into a website? This is now easy to do with Flutter."
publishDate: 2020-03-23
author: josealba
image: images/0u979IALi6tiDee8O.png
category: tutorial
layout: blog
---

*About the author: Jose recently graduated from university and now works on [Material](https://material.io), a design system that helps teams build high-quality digital experiences. Jose’s team maintains the Flutter [material library](https://api.flutter.dev/flutter/material/material-library.html).*

Have you ever wanted to embed your mobile application into a website? This is now easy to do with Flutter.

Flutter is a framework that lets you create native applications for iOS and Android and, most recently, for the web! This means that you can now develop a website using Flutter. [DartPad,](https://dartpad.dev/) the open source tool that lets you run Dart in any modern browser, has also been extended to support Flutter applications. You can now make a simple application on the web and share it with others, instead of hosting the Flutter application somewhere and then embedding it into a web page.

This feature is useful and powerful, as you can imagine. Users can simultaneously see both the code and running application. Here are a list of steps you can follow to embed your Flutter application. There are two ways to create a DartPad instance using GitHub:

1. Using a Gist file

1. Using a GitHub repo

## Using a Gist file

1. To get started, open [DartPad](https://dartpad.dev/) and create the application you want to share with others. The code you write here represents the main.dart file in a Flutter application. You can also use an editor to do this but be aware that DartPad does have some limitations. For example, you are limited to one Dart file, a default pubspec, and you can’t import non-Dart libraries or plugins..

This article uses the following code:

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Applcation Embedded in Website'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'The Gist URL to this website is:',
              textAlign: TextAlign.center,
            ),
            Text(
              'https://gist.github.com/JoseAlba/a205e21aa0d0a64fe7c977107ce22cbf \n',
              textAlign: TextAlign.center,
            ),
            Text(
              'The Dartpad URL to this website is:',
              textAlign: TextAlign.center,
            ),
            Text(
              'https://dartpad.dev/a205e21aa0d0a64fe7c977107ce22cbf \n',
              textAlign: TextAlign.center,
            ),
            Text(
              'The iFrame code is:',
              textAlign: TextAlign.center,
            ),
            Text(
              '<iframe src="https://dartpad.dev/embed-flutter.html?id=a205e21aa0d0a64fe7c977107ce22cbf"></iframe> \n',
              textAlign: TextAlign.center,
            ),
            Text(
              'This Flutter application might be within an iFrame within a Medium post. \n',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

```

Note that importing ‘package:flutter/material.dart’ tells DartPad that this is a Flutter app.

Once your Flutter application builds in DartPad, copy this code and paste it into a [new gist file](https://gist.github.com/) on GitHub. This gist can be either public or private. A gist is a git repository for simple purposes like sharing code. The file name of your gist must be main.dart . For reference, see my [main.dart gist](https://gist.github.com/JoseAlba/a205e21aa0d0a64fe7c977107ce22cbf) file. If you are having problems, see the [DartPad Sharing Guide](https://github.com/dart-lang/dart-pad/wiki/Sharing-Guide).

[https://gist.github.com/JoseAlba/a205e21aa0d0a64fe7c977107ce22cbf](https://gist.github.com/JoseAlba/a205e21aa0d0a64fe7c977107ce22cbf)

You can test if you did this correctly by checking if your gist is available on DartPad. To do this, replace everything before the gistID with “dartpat.dev/”. For example, to view “[https://gist.github.com/JoseAlba/a205e21aa0d0a64fe7c977107ce22cbf](https://gist.github.com/JoseAlba/a205e21aa0d0a64fe7c977107ce22cbf)” in DartPad, use the URL, “[https://dartpad.dev/a205e21aa0d0a64fe7c977107ce22cbf](https://dartpad.dev/a205e21aa0d0a64fe7c977107ce22cbf)”

<DashImage figure src="images/0u979IALi6tiDee8O.png" />


To embed your Flutter application, prefix the gist ID with “[https://dartpad.dev/embed-flutter.html?id=](https://dartpad.dev/embed-flutter.html?id=a205e21aa0d0a64fe7c977107ce22cbf)”. For example, to view “[https://gist.github.com/JoseAlba/a205e21aa0d0a64fe7c977107ce22cbf](https://gist.github.com/JoseAlba/a205e21aa0d0a64fe7c977107ce22cbf) “in an HTML iframe, use “[https://dartpad.dev/embed-flutter.html?id=a205e21aa0d0a64fe7c977107ce22cbf](https://dartpad.dev/embed-flutter.html?id=a205e21aa0d0a64fe7c977107ce22cbf)” . You can learn more details about embedding DartPad code into a website in the [DartPad Embedding Guide](https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide). I recommend you visit this page since it also explains the query parameters. The following example uses an &lt;iframe&gt; element:

```
<div style=”position:relative;padding-top:56.25%;”>
<iframe src=’https://dartpad.dev/embed-flutter.html?id=d&theme=dark&run=true&split=50' style=”position:absolute;top:0;left:0;width:100%;height:100%;”>.       </iframe>
</div>
```


This code created the screenshot below:

<DashImage figure src="images/0botL1tnoYh9nbjgw.png" />


## Using a GitHub repo

To get started, you need to create a repository. Within this repository there are a few files that you can have.

* dartpad_metadata.yaml (MANDATORY)

* hint.txt (OPTIONAL)

* main.dart (MANDATORY)

* solution.dart (OPTIONAL)

* test.dart (OPTIONAL)

If you want to have only one Dart file, all you need are the dartpad_metadata.yaml and main.dart files, but you have the freedom to use other Dart files, too. In my case, I wanted to create the main.dart file without having the runApp() method within it, so I use test.dart to run the application. My repo consists of 3 files:

* [dartpad_metadata.yaml](https://github.com/JoseAlba/flutter_code/blob/master/lib/dartpad/dartpad_metadata.yaml)

* [main.dart](https://github.com/JoseAlba/flutter_code/blob/master/lib/dartpad/main.dart)

* [test.dart](https://github.com/JoseAlba/flutter_code/blob/master/lib/dartpad/test.dart)

Note that test.dart doesn’t require any imports. This is because DartPad sees main.dart and test.dart as one single file. So, if I import the Material package within main.dart, it will be seen in test.dart once the DartPad instance is loaded up.

To load this folder into DartPad you need to know the following:

* gh_owner: Owner of the GitHub account.

* gh_repo: Name of the repo within the above account.

* gh_path: Path to a dartpad_metadata.yaml file within the repo.

* gh_ref: (optional) Branch to use when loading the file. Defaults to master.

In my case:

* gh_owner: JoseAlba

* gh_repo: flutter_code

* gh_path: lib/dartpad

* The gh_ref is not needed since I am using the master branch

This means if I want to load:

[https://github.com/JoseAlba/flutter_code/blob/master/lib/dartpad/main.dart](https://github.com/JoseAlba/flutter_code/blob/master/lib/dartpad/main.dart)

The DartPad URL would be:

[dartpad.dev/embed-flutter.html?gh_owner=JoseAlba&gh_repo=flutter_code&gh_path=lib/dartpad](http://dartpad.dev/embed-flutter.html?gh_owner=JoseAlba&gh_repo=flutter_code&gh_path=lib/dartpad)

1. To embed a flutter application into an iframe, specify the following:

```
<div style=”position:relative;padding-top:56.25%;”>

<iframe src=’https://dartpad.dev/embed-flutter.html?gh_owner=JoseAlba&gh_repo=flutter_code&gh_path=lib/dartpad&theme=dark&run=true&split=50' style=”position:absolute;top:0;left:0;width:100%;height:100%;”></iframe>

</div>
```


## In Conclusion

DartPad is a powerful tool that helps you test, share, and embed your code into web pages. If you want to learn more. see the [DartPad wiki](https://github.com/dart-lang/dart-pad/wiki).

*To learn more about Jose, visit his pages on [GitHub](https://github.com/JoseAlba), [LinkedIn](https://www.linkedin.com/in/josealba1996/), [YouTube](https://www.youtube.com/channel/UCOdKA_On0oPe1tz02z1QfxA?view_as=subscriber), and [Instagram](https://www.instagram.com/jose.alba/).*