---
title: "Insights from Flutter’s first user survey of 2019"
description: "As we do every quarter, the Flutter UX research team ran a user survey in Q1 to gather your opinions, and we are back to share the results…"
publishDate: 2019-04-12
author: jayoung-lee
image: images/1BvDZf83WrPTc4yqukshP-w.webp
category: announcement
layout: blog
---

As we do every quarter, the Flutter UX research team ran a user survey in Q1 to gather your opinions, and we are back to share the results. In this survey, we heard from 1,961 users. As shown in the graph below, we discovered that 42% of the respondents had used Flutter for less than 3 months. So first of all, welcome all new users to the community!

<DashImage figure src="images/1BvDZf83WrPTc4yqukshP-w.webp" alt="42% of the respondents had used Flutter for less than 3 months" caption="42% of the respondents had used Flutter for less than 3 months" />


## Are users satisfied with Flutter?

Very similar to last time, 91% of the respondents were somewhat or very satisfied with Flutter ([92%](https://medium.com/flutter-io/what-weve-learned-from-the-july-2018-flutter-user-survey-cbbf1e04370c) and [93%](https://medium.com/flutter-io/how-we-use-user-surveys-to-prioritize-engineering-effort-in-flutter-october-2018-edition-a26e45abf5aa) in recent surveys). Because the number of Flutter users has tripled over the last three quarters, keeping up the high level of satisfaction has been a surprise and delight to the team.

Of all respondents, about half (49%) have already invested significant effort into Flutter by publishing an app or testing an app for release. Another half of the respondents (41%) said that they were experimenting with Flutter’s functionality. Whether you are in the former or the latter category, please file an issue on [GitHub](https://github.com/flutter/flutter/issues) with any problems that you encounter, so the team can improve your development experience.

The purpose of the quarterly survey is to get feedback on what needs improving so that we can continue to please the developers.

## What can we do better?

We identified some room for improvement. First, satisfaction with package and plugin ecosystem decreased (74 → 67% satisfied), and 55% of the respondents said that the immature ecosystem is the major blocker of adopting Flutter for main job. Because ecosystem has been one of our main themes to focus in year 2019, we will continue investing in growing the ecosystem around the core Flutter technologies. We plan to improve the quality of Flutter’s first-party plugins, as described in our [published roadmap](https://github.com/flutter/flutter/wiki/Roadmap). If you are interested in contributing to Flutter’s ecosystem, please take a look at the “[Developing packages and plugins](https://flutter.dev/docs/development/packages-and-plugins/developing-packages)” documentation. As a part of the effort to improve the ecosystem, we are [refactoring how Android plugins are compiled](https://github.com/flutter/flutter/issues/29328) to mitigate the [AndroidX](https://flutter.dev/docs/development/packages-and-plugins/androidx-compatibility) incompatibility problem. We are also improving our ability to respond to pull requests with a new pull request [template](https://github.com/flutter/plugins/blob/master/.github/PULL_REQUEST_TEMPLATE.md) and a simple [integration testing](https://github.com/flutter/plugins/blob/master/CONTRIBUTING.md#running-the-tests) method.

Second, we found that the satisfaction with Cupertino (iOS-style) widgets is still much lower than that of Material Design widgets (66% vs. 88%), though we’ve made a lot of improvements in the past few quarters. Respondents said that it is hard to learn how to use the existing Cupertino widgets (42%), and the widgets are incomplete in their functionality (40%) or not available (38%). This is probably because our official documentation mainly focuses on customizing UIs more than using platform-specific widgets like Cupertino. We will continue our effort on dedicating more website resources to document iOS specific features, supporting more widgets, and improving the fidelity of the widgets. As we address these needs, you can track the improvements in our [changelog](https://github.com/flutter/flutter/wiki/Changelog) and [documentation](https://flutter.dev/docs/development/ui/widgets/cupertino).

Lastly, we learned that three quarters (75%) of respondents were satisfied with Dart programming language. Similar to Cupertino widgets, unsatisfied users said that Dart lacks learning materials (39%), although it is easy to learn (only 8% finding it difficult). Users also mentioned that Dart lacks language features (37%). We internalize it as a shortfall of documentation and socialization, as well as room for improvement as a language. To respond to these needs, the Dart team is working on a redesigned Dart website with additional documentation, and on evolving the Dart programming language, for example with the recently introduced [Set Literal](https://medium.com/dartlang/announcing-dart-2-2-faster-native-code-support-for-set-literals-7e2ab19cc86d), the upcoming [UI-as-code features](https://medium.com/dartlang/making-dart-a-better-language-for-ui-f1ccaf9f546c), and investigations of a larger set of [potential future features](https://github.com/dart-lang/language/projects/1).

## Breaking changes for the greater good?

Breaking changes refer to changes that occur with version upgrades that would involve having to change your previously written code. If a breaking change is introduced in Flutter, the API for new code would be easier to learn and use, but you may not be able to run code written in the past using the up-to-date SDK.

As described in the [Wiki](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes), in general, we want to avoid making changes to Flutter, its dependencies, our plugins, or our packages, that force developers using Flutter to change their code in order to upgrade to new versions of Flutter. Sometimes, however, breaking changes are necessary for the greater benefit to the community, for example, when better features are developed or function issues emerge.

Hence, we were interested in learning your opinions on breaking changes. In the survey, 30% of the respondents who had upgraded Flutter in the past experienced breaking changes. 32% of them said that it was frustrating that they had to keep updating the code. Yet, more people — 47% — thought that the changes made the code cleaner, and 49% thought that the changes were valuable to them. Most surprising of all, however, 70% of the people who said they were frustrated with updating their code due to a breaking change said that they would nonetheless like us to make necessary breaking changes to improve our APIs. (Overall, 78% said that they would like us to make breaking changes to have the cleanest possible API that is easy to learn and use.)

From this result, we could learn that Flutter’s current user base has more positive than negative attitude towards breaking changes.

## How do users want Flutter’s API to evolve?

We presented three specific scenarios to gauge the preference between unmodified APIs versus clean APIs. The first scenario was as follows:.

*“Imagine that you are in the year 2020. You find a seemingly relevant Flutter sample online, which dates back to 2018. But there are compiler errors because the Flutter API has evolved over the last two years. What would you think?”*

To this question, 86% said that such broken sample is acceptable, and they were willing to deal with some breaking changes as a trade-off for a cleaner API.

Similarly, we posed another scenario where Flutter for desktop introduces breaking changes. The question was:

*“When we add support for building desktop applications to Flutter, which of the following would be preferable for you?”*

To this question, 75% selected *“For the API to be clean, even though this would require significant changes to your mobile apps as well”* over *“For existing apps to continue working unmodified in future Flutter SDKs that provide desktop support, even though this might mean that the desktop API features for desktop features are hard to use.”* Remarkably, even half of those who are very *unlikely* to build a desktop app with Flutter (47%) picked the former option as well.

In addition, more than half of the users expressed interest in some specific breaking changes, such as: a modern string API, changing widget names to make them more consistent (e.g., renaming SliverMultiBoxAdapt**o**rWidget to SliverMultiBoxAdapt***e***rWidget to be more consistent with SliverToBoxAdapt***e***r), and non-nullable-by-default types.

We also carefully read all the comments and learned that although it could be frustrating, respondents were generally less worried about updating code, as the users can pin their target client version and change slowly. We learned that breaking changes could be less disruptive if we:

* change slowly, e.g. start from beta channel, introduce it as a library first

* offer a good migration tool

* provide documentation, e.g., examples, tutorials, version change logs

* clearly explain the benefit

* broadly announce it

Many comments suggested to change early, with some careful steps. Some quotes from the survey are below.
> “Breaking change should be done as soon as possible, while Flutter is yet getting its popularity.”
> “I don’t mind having breaking changes it there is information provided by the debugger or an automated tool to specify what has changed and specifying how it should be now.”
> “I wish you change slowly, fully documented, and broadly announced”

The survey results helped the team understand preferences and concerns around breaking changes. However, the fact that many people favored clean API does not mean we could take breaking change decisions lightly. We hear that respondents also had deep concerns about breaking package and dependencies. Before each change, we will carefully assess its benefit, solicit feedback from the community, and make appropriate decisions. In the near future, we will publish a formal breaking change policy on the GitHub Wiki that evolves [our current policy](https://github.com/flutter/flutter/wiki/Tree-hygiene#handling-breaking-changes) with the lessons we’ve taken from this feedback.

## And finally…

Thank you again everyone for participating in the survey. Please look out for the next survey, which will be announced on the flutter.dev website and community channels like Twitter ([@flutterdev](https://twitter.com/flutterdev)) and Reddit ([r/FlutterDev](https://www.reddit.com/r/FlutterDev/)).

Flutter’s UX research team is also performing a wide variety of user experience studies to make your experience with Flutter more pleasant. If you are interested in participating, you can [sign up](https://flutter.dev/research-signup) for future studies.