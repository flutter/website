---
title: "Flutter Hot Reload"
description: >-
  What happens during a hot reload, and how we made it faster for Flutter 2.2.
publishDate: 2021-08-19
author: jensjohansen
image: images/1iaLz5LEBdsZJRR_W8UCQcQ.webp
category: engineering
layout: blog
---

Hot reload was fast in Flutter 2.0, but it’s faster in Flutter 2.2. Read on for details on hot reload in general, and how we made it faster for Flutter 2.2.

<DashImage figure src="images/1iaLz5LEBdsZJRR_W8UCQcQ.webp" />

## Introduction

One of Flutter’s great features is *hot reload*. You press `r` on your keyboard, and moments later the impact of your changes can be seen on the device. In your terminal (or maybe at the bottom of your IDE) you can read something like `Reloaded 1 of 553 libraries in 297ms`. But what actually goes on under the hood when you initiate a hot reload, and how did the Dart and Flutter teams make it even faster?

## Overview of a hot reload

A hot reload in Flutter roughly consists of the following five steps:

1. `flutter_tools` scans the needed files for changes. It looks at every needed file and checks if its last changed timestamp is newer than the previous compile timestamp.

1. `flutter_tools` instructs a running Dart compiler to recompile the application and tells it which files have changed. The Dart compiler recompiles.

1. `flutter_tools` sends the updated files to the device. This includes any changed assets and the newly compiled *delta kernel file* (the output of the compilation, a file that the Dart VM can understand).

1. `flutter_tools` asks all isolates in the Dart VM on the device to reload their sources (to read the changed delta kernel file and perform its magic).

1. `flutter_tools` instructs the application on the device to reassemble — to rebuild all widgets on screen, reload assets, redo layout, repaint, etc.

On my developer machine, with the target device being Linux (that is, a desktop application running locally), performing the first hot reload on a freshly created `flutter create` application after only updating the timestamp on the `lib/main.dart` file I get timings like these (extracted from `flutter run -v`):

1. Scanning files takes ~13 ms.

1. Recompiling takes ~67 ms.

1. Sending files to the device takes ~2 ms.

1. The Dart VM reloads the sources in ~96 ms.

1. Reassembling takes ~114 ms.

If I instead have a bigger application (and change some other file) I might instead get times like these:

1. Scanning files takes ~12 ms.

1. Recompiling takes ~386 ms.

1. Sending files to the device takes ~2 ms.

1. The Dart VM reloads the sources in ~171 ms.

1. Reassembling takes ~229 ms.

In both cases the following steps take the most time:

* Recompiling

* Reloading

* Reassembling

To make hot reload faster we have to make one or more of those three steps faster.

Here I’ll focus on the first part: recompiling the changed source files into something that the Dart VM can use.

## Recompiling

Logically if I as a user change a file — say, `foo.dart` — I might expect a recompilation to look like this:

1. The compiler has the old state in memory.

1. The compiler is told that `foo.dart` has changed.

1. The compiler throws away its internal state for `foo.dart`.

1. The compiler recompiles `foo.dart`.

1. Done.

This would be great. That would mean that whichever file I change I’d only recompile that file and — presumably — the recompilation would be fast.

Unfortunately recompilation doesn’t generally work like that. Here are two examples of why recompilation might not be so simple:

* `foo.dart` used to contain class `Foo`, which is used all over the place. The changed file doesn’t contain this class (maybe it was manually renamed), and every file using the class should get a compile error.

* `foo.dart` used to have a field defined as `var z = 42`. Another file uses this field: `var z2 = z * 2`. Dart type inference figured out that `z` was an integer and that `z2` was an integer because `z` was one. Now the field changed to say `var z = 42.2`. This time Dart type inference will figure out that the field is a double, but without recompiling the other library as well `z2` will still (incorrectly) be marked as an integer.

For this reason, a recompilation in Dart has long looked like this:

1. The compiler has the old state in memory.

1. The compiler is told that `foo.dart` has changed.

1. The compiler throws away its internal state for `foo.dart`.

1. The compiler checks which files import or export `foo.dart` and throws those away too.

1. The compiler checks which files import or export the files in step 4 and throws those away too.

1. On and on: throw away all transitive importers and exporters.

1. The compiler recompiles all (now) “missing” libraries.

1. Done.

This might sound bad, but in many cases it isn’t. Although changing your own custom widget set might result in recompiling all the code *you* wrote, it doesn’t result in recompiling the Flutter framework itself, for example, because the Flutter framework doesn’t import or export your libraries. On the other hand, if you change a file that’s central to the Flutter framework, you’ll end up recompiling (almost) everything.

Looking back at the (incomplete) list of reasons why just recompiling the single changed file doesn’t work, though, we might see a pattern: It doesn’t work because you made *global* changes — changes that influence other libraries. But what if you only changed a comment? Or added another debug-print to your build method? Or fixed an off-by-one bug in your utility method? Those changes aren’t global, and we should be able to do better!

## Doing better

For non-global changes — changes that can’t influence the compilation of other libraries — we could in fact recompile only the changed library and still preserve semantics. The main problem is figuring out when a change is global and when it isn’t (and doing so fast). Luckily this can be done in incremental steps: we don’t have to make it perfect right away (or at all).

A first step might be to compare the file as it was with the file as it is now while ignoring comments in both versions of the file. If, when comparing this way, both versions of the file are equal, we conclude that there were no global changes and we proceed to recompile the single changed file instead of the transitive import-export graph. This technique isn’t perfect. For example, it would still trigger the recompilation of all transitive importers and exporters when fixing that off-by-one bug in your utility method. But it would allow you to fix that spelling mistake in your comments while recompiling only that one file.

A quick side note here: Why do we have to recompile at all if we’re only changing comments? It’s mostly because of stack traces. Internally some nodes (representing your code) contain *offsets* — information about their placement in the file. If this information becomes out of date, your stack trace contains invalid information. For example, it might claim that something happened at line 42 when really it didn’t.

To get to a place where you can in fact fix that off-by-one bug in your utility method while still only recompiling that file, we have to ignore one more thing when checking for global changes: function bodies. Again we’ll compare the before and after version of the changed file, this time ignoring both comments and function bodies. If they’re the same we’ll recompile only that file.

Now we’re actually in a position where you can make a number of useful changes without recompiling more than the file you’ve changed. You can add, remove, and otherwise change comments. You can add (and remove) debug-prints to your build methods. You can even fix bugs in your utility methods.

## Good news!

As it turns out these improvements to recompilation have actually been made. If you’re using Flutter 2.2 you might even have noticed it already. If not, maybe you will now. Truth be told, for small applications you likely won’t notice much of a speedup, but for larger applications you should.

I’ve made a few examples of non-global changes to gauge the effect.

For the [Veggie Seasons](https://github.com/flutter/samples/tree/master/veggieseasons) sample application (a relatively small application):

* Changing `lib/main.dart` offers no improvement. It compiled one file before and one file now.

* Changing `lib/data/veggie.dart` gives improvements in the 30% range. Actual compilation time on my computer goes from 100+ ms to <20 ms (it used to compile 18 files, now only compiles 1 file). This naturally is much more than 30%, but because recompilation was only one out of three timesinks (the other two being reloading and reassembly) the overall change comes out at around 30%.

For [Flutter Gallery](https://github.com/flutter/gallery) (a relatively large application):

* Changing `lib/main.dart` yields very minor improvements (it compiles 1 file instead of 2).

* Changing `lib/layout/adaptive.dart` results in almost halving the reload time. Recompilation time alone goes from almost 400 ms to 40 ms (recompiling 1 file instead of 47 files).

You should expect real world hot reloads to, on average, be in the order of 30% faster in Flutter 2.2 than they were in Flutter 2.0. To put this in perspective, this change saves Flutter developers, collectively, more than a year of waiting for hot reload every 5 days.

## Caveats

Our changes to hot reload don’t always mean that the compiler does less work. For example, if you add or remove a method, the compiler won’t do less work. If you change the initializer of a field, the compiler won’t do less work. If you change the class hierarchy, the compiler won’t do less work. If you change the body of a function — a case where the compiler generally *should* do less work — because of technicalities around mixins and FFI, the compiler might *still* need to do as much work.

Also, we skipped a couple of technical details when we talked about comparing files. First, we can’t ignore *every* comment: we need to keep the [`@dart` version marker](https://dart.dev/guides/language/evolution#per-library-language-version-selection) because it has semantic meaning. Second, we can’t ignore every function body because of implementation-specific challenges around mixins and FFI.

## Conclusion

Hot reload was fast in Flutter 2.0, but it’s faster in Flutter 2.2. On average, hot reload is around 30% faster in Flutter 2.2 than in Flutter 2.0, saving Flutter developers, collectively, more than a year of waiting for hot reload every 5 days.

If you haven’t updated yet (or haven’t even tried Flutter yet), now might be a good time to visit [flutter.dev](https://flutter.dev) and give it a try.
