---
title: "How to Choose Which Flutter Animation Widget is Right for You?"
description: "There are many widgets for animations, but which one to use?"
publishDate: 2020-04-01
author: fitzface
image: images/0oiCAPHSQGyFgZlUd.webp
category: tutorial
layout: blog
---

*To watch this post in video form, check out [our YouTube video here](https://youtu.be/GXIJJkq_H8g).*

*This article was originally authored by Emily Fortuna, and has been posted on her behalf.*

So, you’ve decided to include an animation in your Flutter app — how exciting! The thing is, there are a lot of different animation widgets so figuring out which one is most appropriate can feel overwhelming. Fortunately, this article is here to help!

I’ll walk through a series of questions you can ask yourself about the animation you have in mind, to help you determine how you should create it. The other thing to remember is that the animation widgets provided in the core Flutter library are pretty low-level. This means that if you have a complex animation in mind, I recommend you check out some of the animation packages available on [pub.dev](https://pub.dev/) that provide higher-level interfaces.

Take a look at the following decision tree, which I’ll explain in this article:

<DashImage figure src="images/0T-YZa36Dv2a9xTLc.webp" alt="*A pocket flow chart for all your animation decisions.*" caption="*A pocket flow chart for all your animation decisions.*" />


Broadly speaking, there are two main types of animations that you might want to include in your Flutter app: drawing-based animations, and code-based animations.

*Code-based animations* are widget-focused and are rooted in standard layout and style primitives like rows, columns, colors, or text styles. That’s not to say they’re boring or simple, but at their heart they tend to enhance a particular existing widget’s appearance or transition rather than act as a standalone widget in their own right.

*Drawing-based animations*, in contrast, look like someone drew them. They often are stand-alone sprites, like game characters, or involve transformations that would be challenging to express purely in code.

So the first question to ask yourself is: “Is my animation more like a drawing, or does it look like something that you can build out of Flutter widget primitives?” If your animation is more like a drawing, or you are working with a design team who will provide vector or raster image assets, then I recommend you use a third-party tool such as Rive or Lottie to build your animation graphically, and then export it to Flutter. There are several packages that can help you include these assets in your Flutter app.

Otherwise, if your animations involve mutating widgets — such as changing colors, shapes, or positions — you’ll get to write some Flutter code!

## Explicit or implicit?

Flutter code-based animations come in two flavors: implicit and explicit animations. The next step is figuring out which type you need.

<DashImage figure src="images/0LJO-BZLYkE68UdlX.webp" alt="*Implicit Animation Widgets animate when the values change.*" caption="*Implicit Animation Widgets animate when the values change.*" />


Implicit animations rely on simply setting a new value for some widget property and Flutter takes care of animating it from the current value to the new value. These widgets are easy to use and are amazingly powerful. All of the animations you see above are done with implicitly animated widgets. Implicit animations are a good place to start when looking to animate something.

Explicit animations require an AnimationController. They are called “explicit” because they only start animating when explicitly asked to. You can use explicit animations to do everything you can with implicit animations, plus a little more. The annoying thing is you have to manually manage the life-cycle of the AnimationController since it’s not a widget, which means putting it inside a stateful widget. For that reason, your code is generally simpler if you can get away with using an implicit animation widget.

There are three questions to ask yourself to determine what type of widget you need: Does my animation repeat forever? By “forever” I mean while it’s on a certain screen, or as long as a certain condition is true, such as music playing.

The second question to ask yourself is whether the values in your animation are discontinuous. An example of what I mean by a discontinuous animation is this growing circle animation. The circle repeatedly grows small-large, small-large. It never grows small-large and then shrinks back down again. In this case, the circle’s size is discontinuous.

<DashImage figure src="images/0VMomX3dS34GVis3W.webp" alt="*A circle that only grows, never shrinks. It’s a discontinuous animation!*" caption="*A circle that only grows, never shrinks. It’s a discontinuous animation!*" />


The last question to ask yourself is whether multiple widgets are animating in a coordinated fashion together? For example:

<DashImage figure src="images/0fjdxxt_qXL1o9y_V.webp" alt="*Multiple boxes animating together.*" caption="*Multiple boxes animating together.*" />


If you answered “yes” to any of those three questions, you need to use an explicit widget. Otherwise, you can use an implicit widget! Once you’ve decided whether you need an implicit or explicit widget, the last question will lead you to finding the specific widget you need.

## Which widget?

Ask yourself, is there a built-in widget for my needs? If you’re looking for a built-in implicit animation widget, look for widgets named AnimatedFoo where “*Foo*” is the property you want to animate, such as [AnimatedOpacity](https://flutter.dev/docs/cookbook/animation/opacity-animation). Also check [AnimatedContainer](https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html) as it is an extremely powerful and versatile widget for many different implicit animations.

If you can’t find the built-in implicit animation you need, you can use [TweenAnimationBuilder](https://api.flutter.dev/flutter/widgets/TweenAnimationBuilder-class.html) to create a custom implicit animation. Conversely, if you’re looking for a built-in explicit widget, they are usually called *Foo*Transition, where “*Foo*” is the property you’re animating, such as [SlideTransition](https://api.flutter.dev/flutter/widgets/SlideTransition-class.html).

If you can’t find a relevant built-in explicit animation, there is one last question you need to ask yourself: *Do I want my animation to be a standalone widget or part of another surrounding widget?* The answer to this is mostly of a matter of taste. If you want a standalone custom explicit animation, you should extend [AnimatedWidget](https://api.flutter.dev/flutter/widgets/AnimatedWidget-class.html). Otherwise, you can use [AnimatedBuilder](https://api.flutter.dev/flutter/widgets/AnimatedBuilder-class.html).

There’s one last option to consider if you’re seeing performance problems, and that is animating with CustomPainter. You can use it much like AnimatedWidget, but CustomPainter paints directly to the Canvas, without the standard widget build paradigm. When used well, you can create some neat, extremely custom effects or save on performance. When misused, though, your animation could cause more performance issues. So, take care and, much like manual memory management, make sure you know what you’re doing before sprinkling shared pointers everywhere.

## Conclusion

In summary, there are a series of high-level questions you can ask yourself that guide how to create your animation. That sequence of questions creates a decision tree for determining what widget or package is right for your needs. If you collapse those end-points, they fall into a line, approximately indicating difficulty from left to right. Thanks for reading, and go forth and create great Flutter animations — through a third-party framework, or with packages, either explicitly, or implicitly!

<DashImage figure src="images/0oiCAPHSQGyFgZlUd.webp" alt="*Animation widgets from easiest … to hardest.*" caption="*Animation widgets from easiest … to hardest.*" />


Articles in this series:

* [How to Choose Which Flutter Animation Widget is Right for You?](https://medium.com/p/79ecfb7e72b5/edit) (this article)

* [Flutter animation basics with implicit animations](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916)

* [Custom Implicit Animations in Flutter…with TweenAnimationBuilder](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185)

* [Directional animations with built-in explicit animations](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7)

* [When should I useAnimatedBuilder or AnimatedWidget?](https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8)

* [Animation deep dive](https://medium.com/flutter/animation-deep-dive-39d3ffea111f)
