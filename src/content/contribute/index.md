---
title: Contribute to Flutter
shortTitle: Contribute
description: >-
  Learn about contributing to the Flutter project and its surrounding ecosystem.
showBreadcrumbs: false
---

![Dash and her friends excited for your contribution](/assets/images/dash/dash-contribute.png){:height="160px" style="float: right;"}

If you would like to contribute to the
Flutter project and its surrounding ecosystem,
we're happy to have your help!

Flutter is an open-source project that thrives on community contributions.
No matter whether you're fixing a bug, proposing a new feature,
improving documentation, or helping others in the community,
your efforts are valuable and appreciated.

This page provides a non-exhaustive overview of how you can get involved.
If you need help contributing or would like more suggestions on getting started,
consider reaching out on the [Flutter contributors Discord][].

:::important
Before beginning your journey of contributing to Flutter,
please make sure to read and follow Flutter's [Code of conduct][].

Also, learn more about Flutter's [culture of inclusivity][] and [core values][].
:::

[Flutter contributors Discord]: {{site.main-url}}/chat
[Code of conduct]: {{site.repo.flutter}}/blob/main/CODE_OF_CONDUCT.md
[culture of inclusivity]: https://flutter.dev/culture
[core values]: {{site.repo.flutter}}/blob/main/docs/about/Values.md

<div class="card-grid">
  <a class="card outlined-card" href="#develop-with-flutter">
    <div class="card-header">
      <span class="card-title">Use Flutter</span>
    </div>
    <div class="card-content">
      <p>Create your own apps with Flutter and provide valuable feedback.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#contribute-code">
    <div class="card-header">
      <span class="card-title">Contribute code</span>
    </div>
    <div class="card-content">
      <p>Contribute directly to the code underlying Flutter.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#write-documentation">
    <div class="card-header">
      <span class="card-title">Write docs</span>
    </div>
    <div class="card-content">
      <p>Enhance the Flutter learning experience by writing documentation.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#triage-issues">
    <div class="card-header">
      <span class="card-title">Triage issues</span>
    </div>
    <div class="card-content">
      <p>Ensure Flutter contributors can make the most impact.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#strengthen-the-package-ecosystem">
    <div class="card-header">
      <span class="card-title">Develop packages</span>
    </div>
    <div class="card-content">
      <p>Strengthen the Dart and Flutter package ecosystem.</p>
    </div>
  </a>
  <a class="card outlined-card" href="#support-the-community">
    <div class="card-header">
      <span class="card-title"><span>Support the community</span></span>
    </div>
    <div class="card-content">
      <p>Help other Flutter developers benefit from your expertise.</p>
    </div>
  </a>
</div>

## Develop with Flutter

Even just using Flutter and providing feedback is a valuable contribution!

### Provide feedback

Sharing your feedback and experiences helps the Flutter team
understand and prioritize developer needs and pain points.

You can provide valuable feedback through many avenues, including:

- Upvoting existing issues

  If you're experiencing an issue that has already been reported,
  consider upvoting it to help the Flutter team understand its importance.

  Avoid otherwise empty thumbs up, +1, or similar comments.
  However, if you have additional information,
  such as reproduction steps or additional version information,
  do consider providing those details in a new comment.
- Reporting new bugs

  If you experience a bug with Flutter that hasn't yet been reported,
  do [open a new issue][] with reproduction information.
- Requesting features

  If there's a feature you think Flutter should add or implement
  but hasn't yet been suggested, do [open a new issue][] with
  all relevant information as well as your use case.
- Partaking in surveys

  Occasionally, the Flutter team will run developer surveys and studies.
  To help understand pain points and improve the Flutter developer experience,
  consider responding with as much feedback and details as possible.

  To sign up for future UX research studies,
  visit [flutter.dev/research-signup][uxr-signup].
- Discussing proposals

  Major changes to Flutter are often discussed through [design documents][].
  Consider reading and providing feedback on proposals that are
  relevant to you or your apps.

  To find current design docs and proposals,
  check out [issues with the `design doc` label][design-doc-issues] on
  the GitHub issue database.
- Reviewing pull requests

  If you're familiar with a particular area of Flutter
  or a solution to a particular issue is important to you,
  consider reviewing open pull requests, trying them with your app,
  and providing any relevant feedback.

[open a new issue]: {{site.repo.flutter}}/issues/new
[uxr-signup]: {{site.main-url}}/research-signup
[design documents]: {{site.repo.flutter}}/blob/main/docs/contributing/Design-Documents.md
[design-doc-issues]: {{site.repo.flutter}}/issues?q=is%3Aopen+is%3Aissue+label%3A%22design+doc%22

### Try out the beta channel

To help ensure Flutter's stability and improve upcoming features,
help test upcoming releases before they reach the stable channel.

Consider testing releases on the `beta` channel,
both for general development and for testing compatibility with your apps.

Any feedback you have or regressions you encounter,
make sure to [report them][report-bugs] to the Flutter team.

To get started,
[switch][switch-channels] to the [`beta` channel][beta-channel] today
and account for any [necessary migrations][].

[switch-channels]: /install/upgrade#change-channels
[beta-channel]: /install/upgrade#the-beta-channel
[report-bugs]: {{site.github}}/flutter/flutter/issues/new/choose
[necessary migrations]: /release/breaking-changes

## Contribute code

Directly improve Flutter's codebase and related tools.

### Flutter framework

Found a bug in a built-in widget, have an idea for a new one,
love adding tests, or just interested in the internals of Flutter?
Consider contributing to the Flutter framework itself
and improving the core of Flutter for everyone.

To learn about contributing to the Flutter framework,
check out the Flutter [contribution guide][framework-contribute].

[framework-contribute]: {{site.repo.flutter}}/blob/main/CONTRIBUTING.md

### Flutter engine

Interested in implementing the primitives and platform integrations
that underlay Flutter or have a knack for graphics programming?
Consider contributing to the Flutter engine and
making Flutter even more portable, performant, and powerful.

To learn about contributing to the Flutter engine,
check out the Flutter [contribution guide][framework-contribute]
and how to [Set up the engine development environment][engine-setup].

[framework-contribute]: {{site.repo.flutter}}/blob/main/CONTRIBUTING.md
[engine-setup]: {{site.repo.flutter}}/blob/main/engine/src/flutter/docs/contributing/Setting-up-the-Engine-development-environment.md

### Flutter packages

Contribute to first-party packages that are
maintained by the Flutter team.
The first-party packages provide essential functionality for apps
as well as encapsulate various platform-specific functionality.

To learn about contributing to the first-party packages,
check out the Flutter [contribution guide][framework-contribute]
as well as the packages-specific [contribution guide][packages-contribute].

[framework-contribute]: {{site.repo.flutter}}/blob/main/CONTRIBUTING.md
[packages-contribute]: {{site.repo.packages}}/blob/main/CONTRIBUTING.md

### DevTools

Contributing to the [Dart and Flutter DevTools][] is a
great place to begin contributing due to its relatively low-cost setup.
Enhance and fixes can greatly impact the developer experience
for Flutter developers and perhaps help you develop your own apps.

To get started, check out
the [DevTools `CONTRIBUTING.md` guide][devtools-contribute].

[Dart and Flutter DevTools]: /tools/devtools
[devtools-contribute]: {{site.repo.organization}}/devtools/blob/master/CONTRIBUTING.md

### Site infrastructure

Fix bugs, improve accessibility, or add features to the
Dart and Flutter websites.

If you're familiar with web development or site generation,
contributing to the Dart and Flutter websites can be a great avenue
to improve the learning experience of Flutter developers.

Depending on your interests,
you might want to contribute to:

- The pub.dev site
  - **Live site:** [`pub.dev`]({{site.pub}})
  - **Repository:** [`dart-lang/pub-dev`]({{site.github}}/dart-lang/pub-dev)
  - **Contribution guide:** [`CONTRIBUTING.md`]({{site.github}}/dart-lang/pub-dev/blob/master/CONTRIBUTING.md)
- The Flutter documentation site
  - **Live site:** [`docs.flutter.dev`]({{site.url}})
  - **Repository:** [`flutter/website`]({{site.repo.this}})
  - **Contribution guide:** [`CONTRIBUTING.md`]({{site.github}}/flutter/website/blob/main/CONTRIBUTING.md)
- The Dart documentation site
  - **Live site:** [`dart.dev`]({{site.dart-site}})
  - **Repository:** [`dart-lang/site-www`]({{site.github}}/dart-lang/site-www)
  - **Contribution guide:** [`CONTRIBUTING.md`]({{site.github}}/dart-lang/site-www/blob/main/CONTRIBUTING.md)
- DartPad
  - **Live site:** [`dartpad.dev`]({{site.dartpad}})
  - **Repository:** [`dart-lang/dart-pad`]({{site.github}}/dart-lang/dart-pad)
  - **Contribution guide:** [`CONTRIBUTING.md`]({{site.github}}/dart-lang/dart-pad/blob/main/CONTRIBUTING.md)
- The `dartdoc` tool
  - **Live site:** [`api.flutter.dev`]({{site.api}})
  - **Repository:** [`dart-lang/dartdoc`]({{site.github}}/dart-lang/dartdoc)
  - **Contribution guide:** [`CONTRIBUTING.md`]({{site.github}}/dart-lang/dartdoc/blob/main/CONTRIBUTING.md)

### Dart SDK

Contribute to the Dart language and surrounding tooling,
improving the client-optimized language that
forms the foundation of Flutter's excellent developer experience.

Dart's contribution workflow is slightly different,
so if you're interested, make sure to check out its
[contribution][dart-contribute] and [building][dart-build] guides.

[dart-contribute]: {{site.github}}/dart-lang/sdk/blob/main/CONTRIBUTING.md
[dart-build]: {{site.github}}/dart-lang/sdk/blob/main/docs/Building.md

### Code samples

Improve or add samples demonstrating Flutter features,
helping developers that prefer to learn by example.

You can always share your own samples or templates,
or you can contribute to Flutter-maintained samples:

- Full project samples
  - **Location:** [`flutter/samples`]({{site.repo.samples}})
  - **Contribution guide:** [`CONTRIBUTING.md`]({{site.repo.samples}}/blob/main/CONTRIBUTING.md)
- API doc samples
  - **Location:** [`flutter/flutter/packages/flutter`]({{site.repo.flutter}}/tree/main/packages/flutter)
  - **Contribution guide:** [`README.md`]({{site.repo.flutter}}/tree/main/dev/snippets)
- Website code snippets
  - **Location:** [`flutter/website/examples`]({{site.repo.this}}/tree/main/examples)
  - **Contribution guide:** [`CONTRIBUTING.md`]({{site.repo.this}}/blob/main/CONTRIBUTING.md)
- Flutter repo samples
  - **Location:** [`flutter/flutter/examples`]({{site.repo.flutter}}/tree/main/examples)
  - **Contribution guide:** [`CONTRIBUTING.md`]({{site.repo.flutter}}/blob/main/CONTRIBUTING.md)

## Write documentation

Contributing to Flutter documentation, no matter the form,
is one of the most impactful ways you can help Flutter.

### Flutter API docs

The API docs are heavily relied on by many Flutter developers,
both online and in their code editors.

Whether you're interested in writing new docs, updating existing ones,
adding relevant code snippets, or even creating new visuals like diagrams,
your contribution to the API docs will be
appreciated by every Flutter developer.

To get started, check out
the [Flutter SDK contribution guide][flutter-contribute],
particularly its section on [API documentation][flutter-api-contribute]

[flutter-contribute]: {{site.repo.flutter}}/blob/main/CONTRIBUTING.md
[flutter-api-contribute]: {{site.repo.flutter}}/blob/main/CONTRIBUTING.md#api-documentation

### Documentation website

Consider contributing to this very site,
guiding developers as they learn and explore Flutter.

To learn about contributing to the Flutter documentation website,
check out the website's [contribution documentation][website-contribute].

You can also contribute to the [Dart website][],
enhancing the documentation for the client-optimized language
that forms the foundation of Flutter.
To learn how to contribute,
check out the [`dart-lang/site-www` contribution docs][dart-dev-contribute].

[website-contribute]: {{site.repo.this}}/blob/main/CONTRIBUTING.md
[Dart website]: {{site.dart-site}}
[dart-dev-contribute]: {{site.github}}/dart-lang/site-www/tree/main?tab=readme-ov-file#getting-started

## Triage issues

Help the Flutter team by triaging incoming bug reports and feature requests.

There are plenty of ways to help in [Flutter's issue database][flutter-issues],
including but not limited to:

- Determining issue validity
- Ensuring actionability
- Documenting affected versions
- Adding reproduction steps
- Identifying duplicate or resolved issues
- Solving or redirecting support queries

To get started helping with issues,
read about [helping out in the issue database][issue-contribute] and
learn about Flutter's approach to
[issue triage][] and [issue hygiene][issue hygiene].

[flutter-issues]: {{site.repo.flutter}}/issues
[issue-contribute]: {{site.repo.flutter}}/blob/main/CONTRIBUTING.md#helping-out-in-the-issue-database
[issue triage]: {{site.repo.flutter}}/blob/main/docs/triage/README.md
[issue hygiene]: {{site.repo.flutter}}/tree/main/docs/contributing/issue_hygiene

## Strengthen the package ecosystem

Help grow and support the collection of
available Dart and Flutter packages on [pub.dev](https://pub.dev/).

### Contribute to packages you use

To give back to packages you depend on and potentially even help your own apps,
find packages you rely on and contribute back to them.

To contribute to a package,
navigate to its page on the [pub.dev site][]
and find the repository linked in the page's sidenav.

Before contributing, do make sure to
follow each package's contribution guide,
discuss your contribution with the maintainers, and
keep in mind Flutter's [Code of conduct][].

[pub.dev site]: {{site.pub}}
[Code of conduct]: {{site.repo.flutter}}/blob/main/CODE_OF_CONDUCT.md

### Open source reusable functionality from your app

If you've built a cool, generic widget or utility in your app,
consider extracting it into a package and publishing it to pub.dev.

To get started, learn about
[Creating Dart packages][] and [Developing Flutter packages][].
Then, when you're ready to publish your package to the [pub.dev site][],
follow the guide and best practices on [Publishing packages][].

[Creating Dart packages]: {{site.dart-site}}/tools/pub/create-packages
[Developing Flutter packages]: /packages-and-plugins/developing-packages
[pub.dev site]: {{site.pub}}
[Publishing packages]: {{site.dart-site}}/tools/pub/publishing

### Add Dart or Flutter support to popular SDKs

Create or contribute to packages that wrap native SDKs or web APIs.

Before creating a new package,
first try to find any existing wrappers that you
could use or contribute to on the [pub.dev site][].

Depending on the SDK and platform,
you might need to [Write platform-specific code][],
use [JS interop][], wrap a REST API using [`package:http`][],
or reimplement the required functionality in Dart.

If you're planning to create a new package, learn about
[Creating Dart packages][] and [Developing Flutter packages][].
Then, when you're ready to publish your package to the [pub.dev site][],
follow the guide and best practices on [Publishing packages][].

[pub.dev site]: {{site.pub}}
[Write platform-specific code]: /platform-integration/platform-channels
[JS interop]: {{site.dart-site}}/interop/js-interop
[`package:http`]: {{site.pub-pkg}}/http

## Support the community

Help other developers learn Flutter and
succeed as they build their own apps.

### Help other developers

Share your Flutter knowledge and expertise
to help your fellow Flutter developers succeed.

This can take many forms from starting a Flutter help channel in your company
to answering questions on public forums.

Some common locations Flutter developers look for help include:

- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter Dev Discord](https://discord.com/invite/rflutterdev)
- [Dart Community Discord](https://discord.com/invite/Qt6DgfAWWx)
- [r/FlutterDev on Reddit](https://www.reddit.com/r/FlutterDev)
- [GitHub issues]({{site.repo.flutter}}/issues)
- [Flutter Forum](https://forum.itsallwidgets.com/)

### Host events

Connect with other Flutter enthusiasts and
organize local, national, and even virtual events.
Events can be anything, from study groups and simple meetups,
to workshops and hackathons.

For inspiration and support,
check out existing [Flutter events][],
learn more about the [Flutter community][], and
explore the [Flutter Meetup Network][].

[Flutter events]: {{site.main-url}}/events
[Flutter community]: {{site.main-url}}/community
[Flutter Meetup Network]: https://www.meetup.com/pro/flutter/

### Post about Flutter

Share your insights and projects with the wider Flutter community.

There are endless options for sharing about Flutter
and connecting with the developer community.
Some common outlets include:

- Blog posts
- Video tutorials
- Short-form posts
- Forum threads
- GitHub discussions
- Link aggregation boards

Post or share about whatever you're passionate about,
but if you're not sure what to post,
consider posting about topics that developers often ask about.

If the platform you're posting on supports tagging posts,
consider adding the `#Flutter` and `#FlutterDev` hashtags
to help other developers find your content.
