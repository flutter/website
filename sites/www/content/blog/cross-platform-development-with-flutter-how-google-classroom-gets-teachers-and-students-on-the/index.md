---
title: "Cross Platform development with Flutter — How Google Classroom gets teachers and students on the…"
description: "Google’s Classroom app, which originally launched in 2014, is used by 150 million educators and students around the world to organize…"
publishDate: 2024-05-07
author: craiglabenz
image: images/1-u0y5vTqoC_sCyOHpvUnNA.webp
category: story
layout: blog
---

## Cross Platform development with Flutter — How Google Classroom gets teachers and students on the same page

Google’s Classroom app, which originally launched in 2014, is used by 150 million educators and students around the world to organize homework, grades, and communication in the classroom. Available on Android and iOS, development originally began earlier that year and has spanned eras of tremendous change on both mobile platforms. Managing that divergent change, it turned out, was challenging.

Despite efforts toward synchronization, 7 years later in 2021, the Classroom app’s distinct Android and iOS codebases had incrementally drifted apart in features, UI, and implementation. From the most obvious, like screens that took different approaches to the same UI, to the less obvious, like authentication and app start-up logic differences; Classroom had slowly turned into a difficult app to maintain and improve, with two codebases taxing a small developer pool.

A spectrum of options were available, ranging from persevering with the status quo, to adding more developers, to a complete rewrite of both codebases with a cross-platform framework. The team was committed to improvement, which ruled out the status quo option, and then assessed what it would take to stabilize the two existing codebases, which ruled out merely adding more developers. In the end, the team settled on its third choice: reimagine Classroom with a single-source, cross-platform solution, which was ultimately Flutter.

## How Flutter simplified the Classroom app

### Inconsistent UIs

The most visible of Classroom’s issues — UI variations — forced teachers to intimately know both the Android and iOS UIs. After all, it’s easy to imagine students asking questions about this homework screen and instructions from one platform’s perspective not making much sense against what a student was seeing on their device from the other platform.

<DashImage figure src="images/1-u0y5vTqoC_sCyOHpvUnNA.webp" />


The conventional approach is for separate client apps, developed by separate teams, that diverge over time. Only consistent, painstaking work to synchronize every feature can prevent this. In contrast, Flutter’s very nature inverts this default outcome. With Flutter, UIs are the same by default [1] until active work ([often in pursuit of adaptability](https://medium.com/flutter/extreme-ui-adaptability-in-flutter-how-google-earth-supports-every-use-case-on-earth-6db4661e7a17)) forces them to diverge for the benefit of the user.
> [1] In Classroom’s Flutter client, small, intentional differences remain, like system bars and bottom controls. Flutter preserves those idiomatic platform details while leaving the middle 90% of the screen to be filled by a single UI implementation.

### Muddled business logic

Estranged UIs were not the only place where Classroom’s Android and iOS clients were at odds. Shaped by a server-side solution that offloaded some complex business logic to the client, the old Classroom app also dealt with differences across core implementations. Aside from giving rise to the occasional platform-specific bug (which can frustrate an engineer’s attempt to reproduce!), this imposed a considerable mental tax on anyone assessing the correctness of either implementation.

Rewriting Classroom with Flutter solved a slew of bugs, both previously reported and not, simply because of how Flutter handles native platform interactions.

In the original code, years of constant development had occasionally blurred the lines between UI, business, and platform-specific logic. This meant that users’ bug reports were almost always a tremendous effort to isolate, as the whole call stack was potentially guilty. Was a requested file not loading because the file system was being read incorrectly, because of a miscommunication in business logic, or because the UI received the file, but then lost track of it? The only way to find out was to *investigate everything*.

Of course, Flutter developers can blur these lines and mix logic just like anyone else, but the Classroom engineering team found that following framework best practices made attempts to do so painfully obvious. Flutter’s system of declarative UI strongly advises against accidentally placing business logic within UI widgets, and a new MVVM architecture even helped enforce clear layers of responsibility within the vast codebase that sits behind Flutter widgets.

Flutter apps still periodically talk to the underlying platform — after all, the user journey of uploading and viewing homework can’t happen without using the file system — but here again Flutter’s pattern of quarantining platform-specific logic into dedicated plugins prevents something like routine disk I/O from sneaking into places where it doesn’t belong. The following example shows a realistic way Flutter apps access the file system without muddying up the whole call stack.

```dart
import "dart:io";
import "package:path/path.dart" as path;
import "package:path_provider/path_provider.dart" as path_provider;

// Loads the student's saved homework for a given assignment.
// Return value's exists() function will return False if the
// student's dog ate their homework.
Future<File> getHomework(Assignment assignment) async {
  // Use the `path_provider` package to abstract away platform-specific
  // file system quirks
  final Directory homeworkDirectory = 
    await path_provider.getApplicationSupportDirectory();

  // Extract the student's uploaded homework
  return File(
    path.join([homeworkDirectory.absolute.path, assignment.name]),
  );
}
```


This example is simple, and the Classroom engineering team ultimately developed several of their own plugins to contain more complicated interactions with the host platform. Interestingly, doing so made their native code *easier to debug* than it had been in their original native apps. How was this possible? Following Don’t Repeat Yourself (DRY) principles in Flutter plugins means hoisting as much business logic as possible into Dart code, leaving only the simplest in-and-out method calls for native interactions. This forces a rock-solid separation between domain logic and platform logic; meaning that any errors in Classroom’s Android or iOS code were probably in isolated, single-responsibility functions that were easily reasoned about.

### Performance drains

When a user journey fails, a concrete bug is filed that everyone can agree needs to be fixed. But what happens for softer problems, like slow app startup time that has been getting worse year after year since an app’s launch? Sprinkle in concerns about keeping multiple clients in sync, and suddenly troubleshooting an app’s lethargic bootstrapping flow feels like a hopeless task.

Here, Flutter helped by being fast enough itself to not make the problem worse and, more importantly, by offering the chance at a clean slate. Knowing they were building something new instead of working around the skeletons from years of development, the Classroom team crystallized their authorization and bootstrapping flows by removing redundant API calls, parallelizing other independent API calls, and showing shimmer effects and other UI previews while everything resolved. The result was a staggering *80% reduction in app launch time!*

### Annotation feature

Most of Classroom’s functionality could be seen as a fairly routine app bringing together users around shared content, like the assignments and uploaded homework. But, one feature stands out as *obviously tricky*. One of Classroom’s banner features is file sharing, where both teachers and students can create, view, and edit files, including free-form annotation as if drawing on real paper with a pen or marker. This annotation-sharing feature already existed in Classroom’s native Android and iOS clients, so any friction porting it to Flutter would be a deal-breaker.

The Classroom team was able to re-package this annotation functionality in a plugin that delegates platform-specific implementations to separate libraries. For file annotation, those became thin wrappers around the pre-existing native libraries already used in Google One, Google Keep, and the old Classroom app. Internally, Android and iOS have different implementation requirements around file-sharing. On iOS, the Classroom app accesses files through native views, but on Android it opens the Google Keep app directly. However, good plugin design principles were able to isolate these implementation details and still expose a clean, singular Dart API for the rest of the app to navigate. In the end, one of Classroom’s “trickiest” features had been successfully ported to Flutter.

Below is a visualization of Classroom’s annotation feature on Android, outlining the mixture of native and Flutter UI components.

<DashImage figure src="images/1yJhbJRuTHa2wt-ofA9fazw.webp" alt="Four mobile screens side by side, collectively showing the user flow to select and annotate a file" caption="Four mobile screens side by side, collectively showing the user flow to select and annotate a file" />


More broadly, typical plugin design in Flutter looks like the following, where a single, streamlined interface loads platform-specific libraries which, in turn, use FFI or JNI to talk to the underlying platform. This allows Flutter apps to engage with platform-specific native APIs across all of their build targets without leaking those considerations into Dart code.

<DashImage figure src="images/1slexehY5Bz7L36tuIuxP4g.webp" alt="A diagram of how to design a Flutter plugin" caption="A diagram of how to design a Flutter plugin" />


## Looking back

### Developer velocity

The Classroom team spent 2 years rewriting their app with a team that grew from 1 engineer (for the initial prototyping phase) to 10 full-time engineers at peak development. This is no small investment, but the team made it on the promise of faster development and maintenance in perpetuity. Classroom launched their Flutter rewrite on iOS in June, 2023 and completed the project by launching on Android in January, 2024. Since then, average engineering time spent on new features has decreased by two-thirds, which is a tripling of developer velocity! After waiting 2 years for any new features, stakeholders have been delighted by the long-awaited arrival of ✨faster feature development✨.

Part of the Classroom team’s decision to rewrite was, knowing that their project would never be “done”, new features were likely to be added long into the future. This allowed for a compelling case that a rewrite, even an expensive one, would eventually pay for itself. The formula for when the Classroom team would hit the break-even point on investment from their rewrite is:

<DashImage figure src="images/1JS2z5_kG8Z8hAfbrxeOtCw.webp" alt="The formula for estimating when increased velocity from rewriting an app in Flutter will exceed the time spent rewriting. The formula is time spent rewriting divided by the reduction in time spent writing features in Flutter equals the number of post-launch features to break even." caption="The formula for estimating when increased velocity from rewriting an app in Flutter will exceed the time spent rewriting. The formula is time spent rewriting divided by the reduction in time spent writing features in Flutter equals the number of post-launch features to break even." />


In the 9 months since launching iOS, Classroom estimates to have already reclaimed 40% of that initial investment through the tripling of developer velocity offered by Flutter.

### Developer experience

The only people made happier by increased developer velocity than stakeholders is — *the developers themselves*. For the Classroom team, their 3x increase in velocity came from a mixture of only writing each feature once (or at most, 1.5 times in scenarios with heavy native components), eliminating the costs of coordination for two teams whose schedules were often months apart and, of course, hot reload. Hot reload alone, with its ~99% reduction in rebuild times, buoyed the Classroom team’s morale above where it had ever been with their two native clients. In the end, the Classroom team found it easy to attract and retain engineers after their switch to Flutter.

Additionally, the Classroom team found that new features, on average, required at least 50% fewer lines of code to implement. In reality, the decrease is likely quite a bit higher, since not every feature that they built during the rewrite was even properly implemented in the two native clients! Put differently, 50% as many lines of code delivered all the old features, plus coverage of *large* feature gaps (including offline support on iOS).

## Conclusion

Roughly two years after beginning their rewrite, the Classroom team has shipped their app to Android and iOS and added enough additional features to pay down 40% of their upfront investment. Their new app launches almost *five times as fast* as the old, saving both developers and end-users time and frustration. Looking forward, new features average one-third the development cost in comparison to the old status quo, enjoy simultaneous release on both platforms, *and* are easier to troubleshoot and maintain. Ultimately, user, developer, and stakeholder morale has never been higher than it became after Classroom switched to Flutter to reinvest in their future.