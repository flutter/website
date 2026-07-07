---
title: "We rebuilt Flutter’s websites with Dart and Jaspr"
description: "Despite Dart starting out as a web language and being used every day to build apps across platforms, including the web, our own websites…"
publishDate: 2026-04-15
author: parlough
image: images/1y6lc2WLpxXBKsuoKJywapQ.png
layout: blog
---

<DashImage figure src="images/1y6lc2WLpxXBKsuoKJywapQ.png" alt="Rebuilding three websites using Jaspr, a Dart-based, open-source web framework." caption="Rebuilding three websites using Jaspr, a Dart-based, open-source web framework." />


Despite Dart starting out as a web language and being used every day to build apps across platforms, including the web, our own websites ([dart.dev](https://dart.dev), [flutter.dev](https://flutter.dev), [docs.flutter.dev](https://docs.flutter.dev)) relied on a fragmented mix of non-Dart tools. That’s finally changed. We’ve migrated all three websites to use [Jaspr](https://jaspr.site/), an open-source framework for building websites with Dart.

The result is a unified stack with a consistent developer experience where contributing only requires Dart. If you’re curious about building web experiences with Dart beyond standard Flutter web apps, this post explores what motivated our migration and how Dart and Jaspr made it all possible.

## A fragmented and unfamiliar technical stack

While the previous setup of our sites worked, their implementations were fragmented, and required increasingly more effort to update the sites to meet our evolving needs. The documentation sites were built with [Eleventy](https://www.11ty.dev/), a Node.js static-site generator. Meanwhile, flutter.dev had a completely separate setup, powered by [Wagtail](https://wagtail.org/), a CMS built on Python and Django.

This fragmentation meant that anyone wanting to contribute to or maintain our sites needed additional experience and tooling outside the Dart ecosystem: Node.js tooling for one set of sites, Python for another. While some surrounding infrastructure and interactive components were already built with Dart, the separate ecosystems limited code sharing, significantly increased set-up and contribution friction, and grew increasingly complicated.

We wanted to change that. We wanted a single, unified stack built on the language and tools our team and community already know. We also had growing ambitions and needs for interactivity on our sites, from richer code samples to quizzes for tutorials. Our existing setups made each new interactive element an uphill battle, often requiring one-off imperative DOM logic.

## Finding a unified solution in Jaspr

Jaspr is a versatile Dart web framework that supports client-side rendering, server-side rendering, and static site generation. Beyond being a traditional DOM-based (with HTML and CSS) web framework and being written in the language we already know, Jaspr stood out for a few reasons:

**Flutter skills transfer directly.** The Jaspr framework and its component model were designed to feel natural and familiar to any Flutter developer while being compatible with the DOM model of the web. If you’ve written a Flutter widget before, you can read this:

```dart
class FeatureCard extends StatelessComponent {
  const FeatureCard({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Component build(BuildContext context) {
    return div(classes: 'feature-card', [
      h3([.text(title)]),
      p([.text(description)]),
    ]);
  }
}
```


With Jaspr, contributors can directly apply the Dart and Flutter experience they already have to a new platform, significantly lowering the barrier to entry for team and community members who want to improve our documentation and websites.

**Seamless support for partial hydration.** One major underlying reason for this exploration and migration was to make it easier to build and integrate interactive experiences on our sites. Jaspr’s built-in support for partial hydration allows each page to be prerendered as static HTML, then the client-side logic is attached only for the components that need it. This is perfect for websites like ours, where the majority of the content is static and only small pockets of interactivity are needed, ensuring quick page loading and good SEO.

**Jaspr Content for Markdown-driven sites.** Jaspr also provides [Jaspr Content](https://docs.jaspr.site/content), a package that supports quickly building content-driven sites. It provides enough out-of-the-box functionality to create a running Markdown-based website in just a few minutes while also being easy to expand and customize extensively. This built-in functionality saved a significant amount of time while the customizability enabled us to keep our original functionality and content practices intact.

## What we gained

The migration brought all the benefits we imagined and more, both for the sites themselves and the contribution experience.

**A singular, unified toolchain.** With everything written in Dart, not only do you need just one SDK to contribute, we also gained access to Dart’s powerful, unified tooling. We can manage all dependencies with `dart pub`, format code with `dart format`, analyze it with `dart analyze`, and then test it with `dart test`. Managing the site now requires only one set of tools to know, one set of conventions to follow, and one ecosystem to stay current with, and it’s the one we’re already most familiar with.

**A stack our contributors already know.** Our websites have a lot of contributors, from engineers, to technical writers, to passionate community members. We want everyone to be able to contribute, but the fragmented setup was complex and unfamiliar to most. Now the sites are implemented as standard Dart projects, and if you know Dart, you have everything you need. We hope this lowers the barrier for team and community members who want to help improve Flutter and Dart’s documentation.

**Less had to change than you’d expect.** With Jaspr Content supporting most of what we needed out of the box, such as templating support, Markdown, and data loading, our content and writing workflows barely needed to change. Nor did our styles, as we already used [Sass](https://sass-lang.com/), a CSS extension language, which is actually implemented in Dart, and therefore requires an even simpler setup than we had before.

## The collaborative migration

Overall, the site migration to Jaspr and Jaspr Content went well, but there were, of course, some challenges along the way. We occasionally ran into issues as well as opportunities for improvement with both Dart’s web tooling and Jaspr itself.

What made the migration possible was [Kilian](https://github.com/schultek), Jaspr’s creator and maintainer. Beyond creating Jaspr, he supported us throughout the migration. He migrated components as early proofs of concept, responded to issues, shipped fixes, improved the developer experience, and even built out Jaspr Content with our websites as a driving use case. To support this ongoing effort and formalize the collaboration, we partnered with Kilian and his consultancy, [Netlight](https://www.netlight.com/), to help us migrate the rest of our web presence and continue investing directly in Jaspr. It was a genuinely collaborative process. Our sites and Jaspr both grew as a result.

In the Dart and Flutter ecosystem, **the community is everything** and what Kilian has provided to the community with Jaspr is a great example of that. Jaspr has shown itself to be a powerful and modern web framework that is well maintained, responsive to feedback, and ready for you to try out. Thank you, Kilian!

To hear Kilian’s perspective on building and maintaining the framework, check out his article: Jaspr: [Why web development in Dart might just be a good idea](https://opensource.googleblog.com/2026/04/jaspr-why-web-development-in-dart-might-just-be-a-good-idea.html).

## Dart and Jaspr growing together

One of the most rewarding aspects of building on an all-Dart stack is that improvements to the Dart language and surrounding tooling benefit everything. Not just your Flutter apps, but your websites too. Here are a few recent Dart features that have directly impacted and improved the experience of building with Jaspr.

**Dot shorthands make component trees cleaner.** Dart 3.10 introduced support for a [dot shorthand syntax](https://dart.dev/language/dot-shorthands) enabling you to omit the type name from static member accesses when they can be inferred from the context. Kilian took advantage of this by consolidating several component constructors onto the `Component` class and designing them to work naturally with the new syntax:

```dart
Component build(BuildContext context) => const div([
  // After the API changes:
  h1([Component.text('Dash says hi!')]),
  Component.fragment([
    Component.text('First element'),
    Component.text('Second element'),
  ]),
  Component.empty(),

  // With dot shorthands:
  h1([.text('Dash says hi!')]),
  .fragment([
    .text('First element'),
    .text('Second element'),
  ]),
  .empty(),
]);
```


The result was a more consistent API with better discoverability and a concise syntax that still works in constant contexts. Best of all, Jaspr’s CLI comes with a `jaspr migrate` command that automatically handled the migration to the new API as well as other changes.

**Null-aware collection elements simplify conditional rendering.** Dart 3.8 added support for [null-aware collection elements](https://dart.dev/language/collections#null-aware-element), providing a clean syntax to conditionally include non-null values in collections. In Jaspr code, where you’re regularly composing lists of child components, they offer an elegant way to handle conditional UI elements:

```dart
Component build(BuildContext context) => div(classes: 'header', [
  h1([.text('Welcome to Flutter!')]),

  // Before null-aware collection elements:
  if (eventBanner != null) eventBanner!,

  // With a null-aware collection element:
  ?eventBanner,
]);
```


No more verbose `if` checks and not-null assertions cluttering your component trees.

**Modern, lightweight JS interop and compilation to WebAssembly.** To enable efficient access to modern web APIs and compilation to WebAssembly, Dart 3.3 introduced new [JS interop](https://dart.dev/interop/js-interop) libraries as well as `package:web`. Jaspr was quick to migrate to and support the new APIs, ensuring Jaspr developers could benefit from their new capabilities and build modern Dart apps. Building on this, Jaspr additionally supports experimental compilation to WebAssembly when running on the client. In fact, dart.dev already uses and benefits from this support on compatible browsers.

**A helpful, integrated analyzer plugin.** For a while, Jaspr had a helpful linting package built on top of `package:custom_lint`, helping developers write idiomatic and correct Jaspr code. With the release of official [analyzer plugin](https://dart.dev/tools/analyzer-plugins) support in Dart 3.10, Jaspr migrated to adopt the feature. The plugin provides a great example of what is possible, providing Jaspr-specific diagnostics and code assists. For example, it can convert between component types or quickly wrap a component with another, similar to the assists you might already be used to with Flutter.

None of these features were built specifically for Jaspr. They’re improvements to the Dart language and tooling that benefit the entire ecosystem, not just Flutter. For some of them, Jaspr was able to immediately take advantage, while others required framework changes from Kilian and contributors to unlock their potential. Either way, it’s clear that Dart keeps evolving and that evolution continues to open up improvements and possibilities for everything built with it, including Jaspr and Flutter.

## What’s next and how to get started

We’re not done yet. Now that our websites share this new technical stack, we can start to share more code, build new interactive features, and continue to improve Dart’s web development story. We’re also migrating the Dart and Flutter blogs from Medium to being directly hosted on our Jaspr-powered sites. You’ll hopefully be able to read this very post there soon.

If you’re a Dart or Flutter developer curious about building websites with the skills you already have, there’s never been a better time to try. Jaspr is a great option for content-heavy sites, such as landing pages and documentation. It can even naturally [integrate with your Flutter web apps](https://docs.jaspr.site/going_further/flutter_embedding). Try it out now on Jaspr’s [online playground](https://playground.jaspr.site/) (which is also built with Jaspr!) or by following the [Jaspr quickstart](https://docs.jaspr.site/quick_start).

Or, if you’re interested in contributing to the [Flutter](https://github.com/flutter/website) or [Dart](https://github.com/dart-lang/site-www) documentation sites, the barrier to entry just got a lot lower. Now with Jaspr, **all you need is Dart**.