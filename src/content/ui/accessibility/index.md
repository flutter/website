---
title: Accessibility
description: Information on Flutter's accessibility support.
---

## Background

Ensuring that apps are accessible to a broad range of users is an essential
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

[Assistive Technologies (Screen Reader) supports][]

[UI Design and styling]: /ui/accessibility/ui-design-and-styling
[Assistive Technologies (Screen Reader) supports]:/ui/accessibility/assistive-technologies

## Accessibility regulations

Accessibility standards and regulations help ensure that products are
accessible to people with disabilities. Many of these have been enacted into
laws and policies, making them requirements for products and services.

*   **WCAG 2**: [Web Content Accessibility Guidelines (WCAG) 2][] is an
internationally recognized standard for making web content more accessible
to people with disabilities. It is a stable, technical standard developed
by the World Wide Web Consortium (W3C).

*   **EN 301 549**: [EN 301 549][] is the European harmonized standard for
accessibility requirements for Information and Communication Technology (ICT)
products and services.

*   **VPAT**: The [Voluntary Product Accessibility Template (VPAT)][] is a
free template that translates accessibility requirements and standards into
 actionable testing criteria for products and services.

Laws around the world require digital content and services to be accessible
to people with disabilities.
In the U.S., the [Americans with Disabilities Act (ADA)][] prohibits
discrimination in public accommodations.
[Section 508 of the Rehabilitation Act ][] requires federal agencies and their
contractors to meet WCAG standards for all ICT.

In the EU, the [European Accessibility Act (EAA)][] requires a wide range of
public and private sector services to be accessible, primarily using
the [EN 301 549][] as its technical basis.



[Web Content Accessibility Guidelines (WCAG) 2]: https://www.w3.org/WAI/standards-guidelines/wcag/
[EN 301 549]: https://www.etsi.org/deliver/etsi_en/301500_301599/301549/03.02.01_60/en_301549v030201p.pdf
[Voluntary Product Accessibility Template (VPAT)]: https://www.itic.org/policy/accessibility/vpat

[Americans with Disabilities Act (ADA)]: https://www.ada.gov/
[Section 508 of the Rehabilitation Act]: https://www.section508.gov/
[European Accessibility Act (EAA)]: https://commission.europa.eu/strategy-and-policy/policies/justice-and-fundamental-rights/disability/union-equality-strategy-rights-persons-disabilities-2021-2030/european-accessibility-act_en


## Building with accessibility in mind

Ensuring that your app can be used by everyone means building accessibility
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
* **Tappable targets**. All tappable targets should be at least 48x48 pixels.
* **Errors**. Important actions should be able to be undone. In fields
  that show errors, suggest a correction if possible.
* **Color vision deficiency testing**. Controls should be usable and
  legible in colorblind and grayscale modes.
* **Scale factors**. The UI should remain legible and usable at very
  large scale factors for text size and display scaling.

[TalkBack]: https://support.google.com/accessibility/android/answer/6283677?hl=en
[VoiceOver]: https://www.apple.com/lae/accessibility/iphone/vision/

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
