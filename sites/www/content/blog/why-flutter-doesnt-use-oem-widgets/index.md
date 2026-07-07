---
title: "Why Flutter doesn’t use OEM widgets"
description: "A developer’s journey from skepticism to excitement for the future of non-OEM widgets, and bespoke mobile design"
publishDate: 2017-11-16
author: xster
image: images/1Tt9lpvpKa1700v74KcjcIw.png
category: announcements
layout: blog
---

<DashImage figure src="images/1Tt9lpvpKa1700v74KcjcIw.png" alt="Modern, consistent Material Design on a phone shipped **4 years** before Material Design was unveiled" caption="Modern, consistent Material Design on a phone shipped **4 years** before Material Design was unveiled" />


## Preface

Before joining the Flutter team early in 2017, I developed mobile applications for years — some in a fast-paced startup agency, and more recently for large-scale consumer applications inside Google.

Developers from both worlds are acutely aware of the benefits of a well-adopted mobile cross-platform solution. The scalability and productivity gains from such a solution are clear to both big and small players in the mobile app industry. Yet I also admittedly placed myself frequently on the side of caution and skepticism when facing existing development solutions that didn’t use OEM SDKs’ widgets.

* “Clients don’t want to pay all this money and end up with an app that doesn’t quite feel native”.

* “Won’t you have to keep playing catch-up vs Google and Apple who have hundreds of smart people building new UI?”

* “We want to build fast but we can’t compromise on UI quality or performance”

* “Designing uniform UI for both simultaneously will end up with the lowest common denominator”

These common questions were very much the same ones I asked myself as well when I first encountered Flutter.

However, rather than starting from the end results, this is not a point-by-point technical face-off of every Flutter characteristic vs every other application development platform. Instead I’m hoping to use the rest of the article to share what I’ve learned about Flutter’s different approach that excites me about the future of mobile app development. And I want to highlight how Flutter can improve the experience of both mobile app engineers and end-consumers in the mobile space.

## What do the People want?

Before diving head-first into how Flutter is built and why OEM widgets weren’t a part of it, it’s worth taking a step back and spending a brief moment reflecting on the end goal of all this.

This is the part that excites me the most. That is, going back to first principles and thinking about what helps mobile developers most efficiently add value for their users, and what types of products do people want to create.

To get to the heart of products that resonate the most with the needs of their customers, let’s look through some popular and editorial reviews and awards for past years’ trending apps. For example, MWC’s [Glomo Awards](https://www.globalmobileawards.com/nominee2017/), TIME’s [Best Apps of the Year](http://time.com/4549647/best-apps-year-2016/) and the Webby Awards’s [Mobile Apps](https://www.webbyawards.com/winners/2017/mobile-sites-apps/features-categories/best-practices/) section, with their People’s Voice awards selected by popular votes.

Here’s a selection of highly acclaimed, award-winning apps we’ve all likely used and can extract learnings from:

<DashImage figure src="images/1xIdaloHvQPE78oAXLJ7Rzg.png" />


<DashImage figure src="images/1cxcLBy8_MnUprKE_JliA7w.png" />


<DashImage figure src="images/1nQ9gwT4kdN8SIXzxq0XyYg.png" />


<DashImage figure src="images/1CWtefgiPMBwNi8Q1dxPI5A.png" />


<DashImage figure src="images/1WiPwyMCRrVn_iit7HiG4Pg.png" />


<DashImage figure src="images/1N2U8dMlt2pD5ozUGHOTXwg.png" />


<DashImage figure src="images/1jSlI0OpsEEqomXhgEbZNTA.png" />


<DashImage figure src="images/1eKLcIR16WZCNmwFcBzL8Zw.png" alt="A collection of 2016’s design award winning apps in both Android and iOS forms" caption="A collection of 2016’s design award winning apps in both Android and iOS forms" />


You’re likely to have already noticed some common patterns here.

Starting off with an easy one, the first derivation we can make from these examples is that successful products need to appear on both mobile platforms :)

Looking further now at the screenshots above, one must notice the marked similarity of the products between the two platforms as well as the creative differences between the different products themselves.

Therefore, I believe the other key observation to make here with respect what the end-users want is that: the most successful developers take their users to the limits of their imaginations, rather than to the molds of stock cookie-cutters. And they do so to offer a unique and tailored user experience best fitted for the specific problem domain their product is trying to solve.

In other words, in today’s market, a branded, custom UI is king.

It should also not be a surprise. Web designers have already known this for years, distinguishing their products from competitors with unique, branded (and non-OEM styled) designs.

In my experience working in a mobile design house, we also know this is what the clients want, but unfortunately often not what the clients get. The challenge in this case is the [high development cost](https://news.ycombinator.com/item?id=13332501) for mobile apps, let alone mobile apps with beautiful custom UI.

Therefore, rather than just a cross-platform tool to connect the 2 platforms’ SDKs, the first order of business for the developers of the Flutter framework was to create **the best possible framework available for creating customized mobile designs**. One that most empowers developers to easily express any type of design language, any UI components and any UX suited for their customized solution, across platforms, and with high performance.

Back then to the topic of seeing how that aspiration relates to the usage or non-usage of OEM UI widgets. This objective translated into the following UI design principles for Flutter:

### 1. Declarative API

While OEM toolkit views implement a mutable imperative style of UI API, Flutter is excited and [inspired](https://twit.tv/shows/floss-weekly/episodes/439) by the recent popularity of [new UI programming paradigms](https://youtu.be/KVZ-P-ZI6W4) as a solution to manage the scalability of UI logic as the number of input signals affecting the UI output of today’s apps increases in both number and complexity. As such, Flutter uses a [reactive, declarative style UI API](https://hackernoon.com/whats-revolutionary-about-flutter-946915b09514#---0-25).

This frees up the developer to focus on the higher value-add task of describing the desired end state. It leaves the more arduous, error-prone task of performing the optimized mutations and animations between those states to the framework.

### 2. Modularity

To empower the developers to be experience creators rather than assemblers, the Flutter toolkit is built by composition with accessible APIs at every layer.

The same UI building components were used by the Flutter team to create the higher level ‘skinned’ UI widgets, such as Material Design widgets. And these components are designed to be consumable, replaceable, tweakable at every level by the developers. In other words, we bundled ‘skins’ that are high fidelity but not special in privilege. And while building them, we created a toolset that makes it easy to build any UI style and widget.

It also means there is no hidden magic anywhere. You can go-to-definition through the framework stack in your IDE, read, modify and have the modified app or framework behaviors hot-reloaded into a live running app on a phone in sub-second time!

### 3. Predictable consistency

The customer is always right. In other words if the app creator, the domain expert of the problem he/she is trying to solve, has already decided on the look and feel of the solution then that solution is consistently, predictably and exactly what the developer and their users should get. And that should be true regardless of compat library versions, regardless of platform, regardless of OS versions, regardless of phone manufacturer skinning(unless the developer wants them to be different).

As is noticeable in many of the example apps’ screenshots above, despite the developers’ seeming attempts to create the same interface on both platforms by wrangling very different toolsets and by possibly different teams, many minor discrepancies nevertheless exist. While their users won’t be comparing the app on each platform and version side by side and pixel by pixel, behavioral and visual divergences can nevertheless have a productivity cost in their future fragility to modifications or bugs.

Meanwhile predictable consistency in outputs can increase development confidence and speed.

### 4. Don’t surprise the user

We might call the previous section “don’t surprise the developer”. Though it’s just as important as “don’t surprise the users” as well.

In other words, emphasize that it’s important to acknowledge the common native environments’ patterns and offer a seamless experience between the application and the OS to match the users’ expectations and muscle memories.

Whether it’s the menu bar placement and modifier key shortcuts on desktop, or the scrolling drag coefficient and typography on mobile, the app should feel naturally at home and not stick out like a sore thumb.

### 5. Fluid motions

As current design trend are indicating, motion design and development are treated as a first-class citizen, along with *UI performance*. In Flutter, motion expressivity and performance is deeply embedded in the API design and higher level widgets.

## How to get there

With now the established primary goal of making it easy for developers to create any custom UI, we explore some possible implementation options. While various approaches can get us very close, we really wanted to hit all the principles listed above to offer the best workflow and experience.

[[A good article from Wm](https://hackernoon.com/whats-revolutionary-about-flutter-946915b09514) describing the different approaches’ categorization]

### Approach 1 — Web technology

Fixed on solving the mobile development productivity problem for many years, the Flutter team includes many web technology luminaries. So we first investigated the popular ‘[hybrid](https://en.wikipedia.org/wiki/HTML5_in_mobile_devices#Hybrid_Mobile_Apps)’ cross-platform approach. The team spared no expense stripping down various web components to fit the mobile needs. But maintaining the existing compatibility of the web’s extensive flexibility made it too difficult to achieve the necessary performance characteristics, especially with respect to motion when web components are molded to a native look and feel.

### Approach 2 — Native widget wrapping

The second approach involved wrapping OEM widgets with another full-featured declarative-style UI API in a common third language.

We really wanted to offer our users a highly modularized set of tools to facilitate custom experience creation. However, we didn’t have a good way of breaking everything into small modular units that then maps back to large, feature-rich, high-powered, mutable OEM widgets on the 2 platforms. We also weren’t able to achieve the desired motion fluidity or UI consistency by letting lightweight, layered, composable UI units manipulate heavy OEM widgets with very different APIs on 2 platforms via a high traffic interop bridge.

### Approach 3 — full stack rendering

In order to fully achieve the all the traits of a framework we think will be the best for expressing mobile UI, the Flutter team experimented further and pushed into more ambitious territories beyond reusing OEM widgets.

At the bottom, for solid battle-tested consistency, Flutter started with [Skia](https://skia.org/), a very mature graphics engine used to render Chrome, Firefox and Android’s low-level graphics. By rendering directly via OpenGL or Vulkan GPU instructions, this ensures any UI built by a framework on top of it look predictable and consistent across different runtime environments.

On top of this reliable and efficient drawing functionality, we designed and created our desired modular UI building toolset with the right level of granularity and developer control.

And because this toolset is written in [Dart](https://www.dartlang.org/) that’s not only expressive but also entirely compiles down to ARM code, its performance characteristics match apps built on OEM SDKs.

<DashImage figure src="images/1RLKlDP0xpOdbQYkdzNtVFw.jpeg" alt="Performance is literally right in our faces as we develop the framework" caption="Performance is literally right in our faces as we develop the framework" />


Because Dart is both expressive and fast, it even allowed us to further empower our layered modularity principle by preserving as much composable UI building blocks accessible on the Dart side as possible vs the underlaying C++ side. For instance, the [layout mechanisms](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/rendering.dart) are developer customizable whereas they were buried deeper in the inaccessible C++ side for web browsers.

And it is on this foundation that Flutter tied it all together with a declarative API pattern. Dart is also especially optimized for this design pattern because of its cheap instantiation costs of immutable virtual UI trees.

Then, using this UI building API, we created a batteries-included set of rich [Material Design](https://flutter.io/widgets/material/) and [Cupertino (iOS)](https://flutter.io/widgets/cupertino/) widgets to get developers up and running quickly without compromising their future ability to get deeper and customize.

We also made sure these widgets (both included ones and the ones you create) easily conforms to platform conventions. For instance, in no particular order:

* Scrolling and overscrolling have different tightly modeled physics simulations between Android and iOS

* Components like app navigation bars (either skinned or unskinned) by default match the text alignment and paddings etc of the OS

* Page transitions’ animation curves, directions, durations, opacity changes etc match the OS

* Platform specific behaviors like edge swipe to go back, status bar tap to scroll up on iOS and tap outside dialogs to dismiss on Android work as expected

<YoutubeEmbed id="Zqv160V-oLo" title="Flutter's platform UI adaptations" fullwidth="true"/>


With this full stack rendering approach, Flutter is able to deliver a UI building experience without compromising on performance, expressivity, flexibility, or consistency. And, by fulfilling these principles, we think we’ve created a tool that best allows developers to create customized UIs like those award-winning apps presented in the earlier screenshots.

## Design implications

Given now these design choices of the Flutter framework, let’s look forward again and evaluate their other exciting impacts for the Flutter developers.

### Development speed

Thanks to the declarative and reactive UI style, and Dart’s properties, Flutter apps is hot-reloadable and can be reloaded quickly and without losing application state. Because of the declarative style’s central ability to interpolate between desired resting states, hot-reload works even in the middle of animations or other transient tasks whose present state is unknown to the explicit user program.

Sub-second development cycles drastically reduces UI development costs and can eliminate the need for a [separate prototyping tool](https://www.youtube.com/watch?v=BJCqRpvvTrM) or a static layout builder tool since your production UI is the output feedback.

Not only it was important to save the waiting time for the rebuild, it was doubly impactful to let the developer continue the task within [human attention span](https://www.nngroup.com/articles/response-times-3-important-limits/) to prevent [context switching](https://blog.codinghorror.com/the-multi-tasking-myth/). I certainly lost count of the number of times in the past that I went for a snack run while a fix was being rebuilt into the app and never again returned to the same task that day.

This is even more important as the app complexity increases and certain UI bugs only surface through some non-trivial repro steps. Because of Flutter’s separation of UI description from UI state, UI and behaviour can be reloaded and retested while preserving the existing runtime state.

### Testability

A UI toolkit built by composition is **inherently more testable**. Semantic UI testing have always been a huge headache for native mobile developers using a variety of tacked-on mechanisms like [EarlGrey](https://github.com/google/EarlGrey), [Espresso](https://developer.android.com/training/testing/ui-testing/espresso-testing.html), [UI Automator](https://developer.android.com/training/testing/ui-automator.html), [KIF](https://github.com/kif-framework/KIF) etc. Even then, you can only write unwieldy, flaky top-level integration tests that are costly to run in both time and resource because they require a full application runtime (which again triggering the dreaded context switch when doing test driven development).

Flutter, by contrast, has modular [UI testing](https://flutter.io/testing/) built “batteries-included” into the framework. It lets you drive, test and assert UI logic at every level such as layout, gestures, animations, text layouts, colors etc. And most importantly, it runs at [TDD](https://en.wikipedia.org/wiki/Test-driven_development) speed because it can run in headless mode without any device or simulators.

On top of hot-reload time savings, for the first time, I can write UI code and check the correct UI look and behavior without ever looking at any UI via tests! And this is possible because we draw our own widgets and codified various layers of this widget drawing as public APIs.

### Developer control

And I felt necessary to mention developer control again because this has bitten me so frequently in the past :)

All UI toolkit and framework developers strive to make the perfect product, as much as possible. But everyone makes mistakes or fails to foresee a particular use case. Sometimes it’s one use case that you unfortunately landed on, and no matter how much you upvote that new API feature request or bug fix, you won’t get it before your product is due to ship.

In other words, we’re all bound to hit the “that widget is perfect but if only I can change the border radius there” or the “this view group thing is great if only I can change where it folds onto the next row” moment at some point.

With Flutter, we built the framework knowing we can’t perfectly predict future market directions with centralized 5-year economic plans, so to speak. So all parts of the UI building framework can be clicked into, read without having to cross-reference your OS version, modified live while your app is running and have the change hot-reloaded into the running app.

This way, developers don’t have any API walls they can hit that limits their creativity. And those ‘extravagant design ambitions’ from the design team no longer need to be bound (we hope) by the wise, pragmatic engineer who points out that certain parts of the mockup have exponentially higher implementation costs, and need to be cut to meet the schedule.

And this is also possible not only because of Flutter’s modular design, but again owns much to Dart’s compile-to-native performance which allowed us to elevate previously inaccessible parts of the UI framework such as the physics simulation and the layout engine out of deeper C++ code into easy-to-use and easy-to-modify Dart code.

### Environment decoupling

Flutter decouples the UI toolkit from the OS.

By shipping the natively compiled framework in user space, the user’s experience is predictable, inherently stable and controlled by the developer — not by the user’s phone, the OS version, the phone manufacturer’s UI skins, compat library versions etc, unless the developer chooses so.

Material Design can be implemented with as much fidelity on an early iOS 11 beta as it can be on a 2010 Nexus S (released 4 years before Material Design is even created!) on Android 4.1.2. Not that we necessarily encourage anyone to do it.

<DashImage figure src="images/1G2Bl4jOqWjj1s3ojNLgERQ.png" />


<DashImage figure src="images/1t3UOazDW4es-wlm5WhHlLw.png" alt="Consistent Material Design (or your design) on phones made way before Material Design existed" caption="Consistent Material Design (or your design) on phones made way before Material Design existed" />


Correspondingly, we can not only go back 7 years and ship the native iOS 11 beta look and feel on a 2010 Android device, we also made it easy enough to create any UI that we could do so before iOS 11 itself released. Again, not that anyone would want to make an iOS looking app on Android, but we hoped to use it as a litmus to make sure it’s easy to create any UI, whether stock or branded.

<DashImage figure src="images/1mWZiUb3dO9aMN1iV8YFxCw.gif" alt="iOS 11 on an old, single-core 1GHz Android phone before iOS 11 came out" caption="iOS 11 on an old, single-core 1GHz Android phone before iOS 11 came out" />


## Conclusion

While there are many ways of creating a UI framework, I gradually learned that Flutter’s goal of creating the best tool to build tailored UI experiences led the team through a number of conceptual iterations that ended with the version we have today.

Through this exploration, I quelled my initial skeptical reflex about Flutter’s non-use of OEM widgets. Rather I’m now excited about the potentials it unlocked and how it aligned with the principles we identified for creating the best UI building framework.

I believe Flutter’s approach can drastically lower the barrier of entry for the creation of beautiful award-winning mobile apps while making it more enjoyable for the developers. And I’m excited to see what people can create with it. So far, our users’ experiences corroborate with our expectations that we can help users create beautiful applications for both platforms at a cost lower than the cost of creating the same application for a single platform using the platform’s native SDKs.

Give it a spin and see for yourself at [flutter.io](https://flutter.io) and give us your thoughts on our [chat channel](https://gitter.im/flutter/flutter) or on [GitHub](https://github.com/flutter/flutter)!