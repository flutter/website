---
title: "Improving perceived performance with image placeholders, precaching, and disabled navigation…"
description: "Perceived performance is how fast an application feels to the user. This article covers three strategies that you can use in your…"
publishDate: 2020-05-26
author: perclasson
image: images/1Pp2MNotBJdSHDcW3Fhz19A.gif
category: tutorial
layout: blog
---

## Improving perceived performance with image placeholders, precaching, and disabled navigation transitions

Perceived performance is how fast an application feels to the user. This article covers three strategies that you can use in your application to improve perceived performance: image placeholders, precaching images, and disabling navigation transitions.

## Image placeholders to prevent content from jumping around

When a user is waiting for images to load, and then they eventually show up, the layout can shift around. By leaving space in the layout for image placeholders, you can avoid this shifting to ensure a better user experience.

See the following GIF for an example of how it can look without using any placeholders:

<DashImage figure src="images/1Pp2MNotBJdSHDcW3Fhz19A.gif" alt="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=images_jumping_around/lib&theme=dark)" caption="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=images_jumping_around/lib&theme=dark)" />


If you already have a placeholder image cached and loaded in your application you can use the [`FadeInImage`](https://api.flutter.dev/flutter/widgets/FadeInImage-class.html) widget to show placeholders. If you want to use a widget instead of an image as a placeholder, you can achieve this with the [`Image.frameBuiler`](https://api.flutter.dev/flutter/widgets/Image/frameBuilder.html) property.

The `Image.frameBuilder` property is responsible for building the Image widget and it has four arguments:

1. The build `context`.

1. The image widget `child`.

1. A number representing the `frame`, which is null when the image is still loading.

1. A boolean `wasSynchronouslyLoaded` that is true if the image is already loaded.

When implementing a placeholder widget, first check whether the image has already been loaded with `wasSynchronouslyLoaded` and, if so, return the `child`. If not, use [`AnimatedSwitcher`](https://api.flutter.dev/flutter/widgets/AnimatedSwitcher-class.html) to create a cross-fade between the placeholder and the image as it loads:

```
class ImageWidgetPlaceholder extends StatelessWidget {
  const ImageWidgetPlaceholder({
    required this.image,
    required this.placeholder,
  }) : super(key: key);

  final ImageProvider image;
  final Widget placeholder;

@override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool? wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded == true) {
          return child;
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: frame != null ? child : placeholder,
          );
        }
      },
    );
  }
}
```


After adding placeholders, the layout no longer shifts around, and instead the images fade in as they load:

<DashImage figure src="images/1ZI2zrU2e21dkkHtn49qskw.webp" alt="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=images_with_placeholders/lib&theme=dark)" caption="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=images_with_placeholders/lib&theme=dark)" />


## Precaching images before they are displayed

If your app has a splash or welcome screen before images are shown, you can also precache those images by calling the [`precacheImage`](https://api.flutter.dev/flutter/widgets/precacheImage.html) function.

```
precacheImage(NetworkImage(url), context);
```


The following GIF shows an example of precaching images on a Welcome screen:

<DashImage figure src="images/1iAiugn-WYkk7620I7TgMVg.webp" alt="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=precached_images/lib&theme=dark)" caption="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=precached_images/lib&theme=dark)" />


## Disabling navigation transitions on Flutter web

[Navigation transitions](https://material.io/design/navigation/navigation-transitions.html#about-navigation-transitions) occur when a user moves between pages, and it can be a great way to let the user orient themselves in a mobile application. However, for web applications, it’s not something you would typically see. For a perceived performance improvement, you can disable the page transition animation.

By default, `MaterialApp` uses page transitions for routing relevant to the platform (slide in upwards for Android or from the side for iOS). To override this behavior, you can create your own [`PageTransitionsTheme`](https://api.flutter.dev/flutter/material/PageTransitionsTheme-class.html) class. To detect when the application runs on the web, use the [`kIsWeb`](https://api.flutter.dev/flutter/foundation/kIsWeb-constant.html) constant. If it is on the web, disable the transition by returning the child:

```
import 'package:flutter/material.dart';

class NoTransitionsOnWeb extends PageTransitionsTheme {
  @override
  Widget buildTransitions<T>(
    route,
    context,
    animation,
    secondaryAnimation,
    child,
  ) {
    if (kIsWeb) {
      return child;
    }
    return super.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
```


Set the `pageTransitionsTheme` for our `MaterialApp`:

```
MaterialApp(
  theme: ThemeData(
    pageTransitionsTheme: NoTransitionsOnWeb(),
  ),
)
```


The page transition without any animation:

<DashImage figure src="images/1Db6XWyMRM9gGhSEpHY6w7A.webp" alt="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=precached_images/lib&theme=dark)" caption="[See full interactive example on DartPad.](https://dartpad.dev/embed-flutter.html?gh_owner=perclasson&gh_repo=flutter_code&gh_path=precached_images/lib&theme=dark)" />


## **Conclusion**

I hope you found some useful tips in this article for how to improve the perceived performance in a Flutter web application. For the [Flutter Gallery](https://gallery.flutter.dev/#/), we disabled the page transitions on the web and added placeholders for images to avoid a layout shift while loading. The implementation is similar to what is described in this article, and if you want to see the code you can find it on [GitHub](https://github.com/flutter/gallery).

Thank you for reading!

This post is a part of a series about what we learned when improving performance for the [Flutter Gallery](https://gallery.flutter.dev/#/). Articles in the *Creating performant Flutter web apps* series:

* [Optimizing performance in Flutter web apps with tree shaking and deferred loading](https://medium.com/flutter/optimizing-performance-in-flutter-web-apps-with-tree-shaking-and-deferred-loading-535fbe3cd674)

* Improving perceived performance with image placeholders, precaching, and disabled navigation transitions (this article)

* [Building performant Flutter widgets](https://medium.com/flutter/building-performant-flutter-widgets-3b2558aa08fa)