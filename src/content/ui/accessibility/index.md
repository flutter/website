---
title: Accessibility
description: Information on Flutter's accessibility support.
---

## Background
Ensuring apps are accessible to a broad range of users is an essential
part of building a high-quality app. Applications that are poorly
designed create barriers to people of all ages. The [UN Convention on
the Rights of Persons with Disabilities][CRPD] states the moral and legal
imperative to ensure universal access to information systems; countries
around the world enforce accessibility as a requirement; and companies
recognize the business advantages of maximizing access to their services.

We strongly encourage you to include an accessibility checklist
as a key criteria before shipping your app. Flutter is committed to
supporting developers in making their apps more accessible, and includes
first-class framework support for accessibility in addition to that
provided by the underlying operating system, including:

[UI Design and styling][]

[Screen Readers supports][]

## Laws and Acessibility Standards

(TODO: hangyujin) Add some acessibility standards 

Laws such as the Americans with Disabilities Act (ADA) in the US emphasize the importance of accessible websites and web applications. The ADA clarifies:

Websites and web applications are defined as places of public accommodation, especially those that offer public services such as federal websites. All public sector bodies and commercial facilities need to offer equal access to their web pages in conformity with the WCAG 2.0 requirements.

— ADA.

Accordingly, public websites must be designed in accordance with the standards of WCAG 2.0 (Web Content Accessibility Guidelines) to ensure that they are accessible to all users.

In Europe, the accessibility of digital applications is also becoming increasingly important. From 2025, for example, the European Accessibility Act (EAA) will require all travel, banking and E-commerce apps to be fully accessible (Source: mobilea11y).

In Germany, the Barrierefreie-Informationstechnik-Verordnung (BITV 2.0) (“Barrier-free Information Technology Ordinance”) regulates the implementation of the WCAG 2.0 standards to ensure accessibility in digital offerings. The test criteria of BITV 2.0 are almost identical to those of WCAG 2.0.


## Building with accessibility in mind

Ensuring your app can be used by everyone means building accessibility
into it from the start. For some apps, that's easier said than done.
In the video below, two of our engineers take a mobile app from a dire
accessibility state to one that takes advantage of Flutter's built-in
widgets to offer a dramatically more accessible experience.

{% ytEmbed 'bWbBgbmAdQs', 'Building Flutter apps with accessibility in mind' %}


## Accessibility release checklist

Here is a non-exhaustive list of things to consider as you prepare your
app for release.

* **Active interactions**. Ensure that all active interactions do
something. Any button that can
be pushed should do something when pushed. For example, if you have a
no-op callback for an `onPressed` event, change it to show a `SnackBar`
on the screen explaining which control you just pushed.
* **Screen reader testing**. The screen reader should be able to
describe all controls on the page when you tap on them, and the
descriptions should be intelligible. Test your app with [TalkBack][]
(Android) and [VoiceOver][] (iOS).
* **Contrast ratios**. We encourage you to have a contrast ratio of at
least 4.5:1 between controls or text and the background, with the
exception of disabled components. Images should also be vetted for
sufficient contrast.
* **Context switching**. Nothing should change the user's context
automatically while typing in information. Generally, the widgets
should avoid changing the user's context without some sort of
confirmation action.
* **Tappable targets**. All tappable targets should be at least 48x48
pixels.
* **Errors**. Important actions should be able to be undone. In fields
that show errors, suggest a correction if possible.
* **Color vision deficiency testing**. Controls should be usable and
legible in colorblind and grayscale modes.
* **Scale factors**. The UI should remain legible and usable at very
large scale factors for text size and display scaling.

## Learn more

To learn more about Flutter and accessibility, check out
the following articles written by community members:

* [A deep dive into Flutter's accessibility widgets][]
* [Semantics in Flutter][]
* [Flutter: Crafting a great experience for screen readers][]

[CRPD]: https://www.un.org/development/desa/disabilities/convention-on-the-rights-of-persons-with-disabilities/article-9-accessibility.html
[A deep dive into Flutter's accessibility widgets]: {{site.medium}}/flutter-community/a-deep-dive-into-flutters-accessibility-widgets-eb0ef9455bc
[Flutter: Crafting a great experience for screen readers]: https://blog.gskinner.com/archives/2022/09/flutter-crafting-a-great-experience-for-screen-readers.html
[Semantics in Flutter]: https://www.didierboelens.com/2018/07/semantics/
[UI Design and styling]: /ui/accessibility/ui-design-and-styling
[Screen Readers supports]:/ui/accessibility/assistive-technologies
