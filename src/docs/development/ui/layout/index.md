---
title: "Flex with the Expanded widget"
description: "A codelab that uses DartPad2 to teach Flutter layout concepts."
toc: true
---

Flutter, eh?? What's the point? Well, Flutter is Google's portable UI toolkit for building beautiful and natively compiled applications. These applications, whether they're for mobile, web, or desktop apps, are built from a single codebase. But why does all that matter? Who cares?! Uh, developers care. And, if you plan to develop an app, you should, too. You're a developer. 

### Introduction

This document briefly covers technical issues that you may face when sizing widgets. It also covers how to fix those issues by explaining how to use the Expanded widget.  

This document doesn't cover how to develop Flutter apps or explain how to code in Dart. It assumes you have a functioning knowledge of object-oriented programming. However, don't be intimidated to read through this document and interact with the code demos.   

{{site.alert.note}} Dart is the coding language that Flutter developers use to create their apps. What's great about Dart is that it's object oriented and widget based. For example, *images*, *icons*, and *text* are widgets. *Columns*, *rows*, and *grids* also are  widgets. Widgets compile the ins and outs of Flutter, and, because Flutter is object oriented, you not only can create, but also collaborate with other Flutter developers to fix technical issues more easily.   
{{site.alert.end}}

### Sizing widgets can be tricky

When a group of widgets are too large for a row, a striped pattern appears along the affected edge. Now, run the code and then check the output.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=e857a9b4e8584dfb06e9105fb3d49569&fw=true" width="100%" height="400px"></iframe>


After running the code, you see one of three images appear in Demo1. At the image's right edge, you also see a black, rectangular box with vertical text reading "RIGHT OVERFLOWED BY 522 PIXELS." You might ask, "Where's the striped pattern?" Well, if you haven't checked the output already, once again, check it. The output tells you that the black, rectangular box is the striped pattern. Moreover, the output tells you how to fix the problem: use an Expanded widget. 

### The Expanded widget

In a row, space is divided among children. Children can be considered inflexible until they're wrapped in an Expanded widget. An Expanded widget stretches a child to fill extra space, thus making the child flexible. When children are laid out in a row, inflexible children are spaced first. The remaining space is then divided among the flexible children. In Demo2, wrap each of the three children beginning with "Image.network" in an expanded widget. To wrap a child in an expanded widget, follow these steps:

1. Specify the child that's being expanded by entering `child:` before it (for example, `child: Image.network`)
2. Create a new line above the child
3. On the newly created line, enter `Expanded(`
4. Create a new line below the child
5. On the newly created line, enter `),`

After you wrap each child in an Expanded widget, run the code.  

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=eeab49f02be2ca79928458b58391c775&fw=true" width="100%" height="400px"></iframe> 

You now see all three images clearly and without any affected edges. But now you might ask, "Wait, doesn't the Expanded widget only fill extra space?" Here's one way to think about the Expanded widget. When you wrap a child in an Expanded widget, you make the child flexible. The child is going to fit in the space that's available. 

{{site.alert.tip}} If you have trouble wrapping each of the images in an Expanded widget, you can click **Hint** and then display the solution. From there, you can replace your code with the solution code.
{{site.alert.end}} 

### Flex

The Expanded widget is a flex factor that works with available space. But what if you want one of your children to appear twice as large as its siblings? To do that, use the Expanded widget's flex property. Run the code for an example. 

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=b94c33c08f3031b5ef9181e215c2006a&fw=true" width="100%" height="400px"></iframe>

In your code, you see that the middle child is not only wrapped in an Expanded widget, but also has a flex property of 2. `flex` is an interger that determines how much space a flex factor will occupy. You see in Demo3 that the middle image now appears twice as large as the other images. However, the image isn't twice as large; it's occupying twice as much space. Because the Expanded widget is a flex factor, you can determine how much space it'll occupy by adding a flex property. 
