---
title: "Accessibility in Flutter on the Web"
description: "How Flutter aims to make canvas-rendered apps accessible to users of assistive technologies"
publishDate: 2024-04-16
author: tomayac
image: images/0pF3_jPjWNcie3LH0.webp
category: announcements
layout: blog
---

One of the target platforms the Flutter framework supports is the web. Flutter applications guarantee pixel perfection and platform consistency through rendering all UI onto a canvas element. However, by default canvas elements are not accessible. This case study explains how accessibility support works for such canvas-rendered Flutter apps.

<DashImage figure src="images/1YhNtNltzEiKubvyWKUXKVw.webp" />


Flutter has a large number of default widgets that [generate an accessibility tree](https://docs.flutter.dev/ui/accessibility-and-localization/accessibility?tab=browsers#:%7E:text=Flutter%E2%80%99s%20standard%20widgets%20generate%20an%20accessibility%20tree%20automatically.) automatically. An accessibility tree is a tree of accessibility objects that assistive technology can query for attributes and properties and perform actions on. For custom widgets, Flutter’s [`Semantics`](https://api.flutter.dev/flutter/widgets/Semantics-class.html) class lets developers describe the meaning of their widgets, helping assistive technologies make sense of the widget content.

For performance reasons, at the time of this writing, Flutter’s accessibility is opt-in by default. The Flutter team would like to eventually turn the semantics on by default in Flutter Web. However, at the moment, this would lead to noticeable performance costs in a significant number of cases, and requires some optimization before the default can be changed. Developers who want to always turn on Flutter’s accessibility mode can do so with the following code snippet.

```dart
import 'package:flutter/semantics.dart';

void main() {
  runApp(const MyApp());
  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }
}
```

> Note: If your app absolutely requires to know if a user is using accessibility devices like screen readers, allow users to opt-in.

Once you’ve opted in to Flutter’s accessibility support, the HTML changes automatically, as shown in the rest of this page.
> **Note:** Screen readers are only one example of assistive technology that profits from the described approach. For improved legibility, screen readers are used as a proxy for this and other assistive technologies in general.

## Flutter’s accessibility opt-in

Flutter’s opt-in mechanism is a hidden button. It places a button, exactly speaking, an `<flt-semantics-placeholder>` element with `role="button"` — which is invisible and unreachable to sighted users — in its HTML. It’s a custom element with styling applied so it doesn’t show and isn’t selectable unless you use a screen reader.

```xml
<flt-semantics-placeholder
  role="button"
  aria-live="polite"
  aria-label="Enable accessibility"
  tabindex="0"
  style="  
        position: absolute;  
        left: -1px;  
        top: -1px;  
        width: 1px;  
        height: 1px;"
></flt-semantics-placeholder>

/* `<flt-semantics-placeholder>` inherits from `<flutter-view>`. */
flutter-view {
  user-select: none;
}
```


## Changes after the opt-in

What happens when a screen reader user clicks this button? Consider a not too complex example like the [card](https://flutter-gallery-archive.web.app/#/demo/card) from the Flutter Gallery as displayed in the following screenshot.

<DashImage figure src="images/0mhvYLQo_t9Sm_ecS.webp" />


To better understand what’s changing when a user clicks the button, compare the before and after screenshots of Chrome DevTools when you [inspect the accessibility tree](https://developer.chrome.com/blog/full-accessibility-tree/). The second screenshot exposes a lot more semantic information than the first.

**Before opt-in:**

<DashImage figure src="images/0Y_VjMeKGuxCGCkSs.webp" />


**After opt-in:**

<DashImage figure src="images/0dxy3KYQVwetiInqh.webp" />


## Details of the implementation

The core idea in Flutter is to create an accessible DOM structure that reflects what’s right now displayed on the canvas. This consists of an `<flt-semantics-host>` parent custom element that has `<flt-semantics>` and `<flt-semantics-container>` child elements that in turn can be nested. Consider a button widget, such as [`TextButton`](https://api.flutter.dev/flutter/material/TextButton-class.html). This widget is represented by an `<flt-semantics>` element in the DOM. The ARIA annotations (e.g., [`role`](https://developer.mozilla.org/en-US/docs/Web/API/ElementInternals/role) or [`aria-label`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-label)) and other DOM properties ([`tabindex`](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/tabindex), event listeners) on the `<flt-semantics>` element allows the screen reader to announce the element as a button to the user, and support clicking and tapping on it, even though it’s not a literal [`<button>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/button) element. In the following screenshot the **Share** button is one example of such a button.

<DashImage figure src="images/05snhUrdCrAAauosx.webp" />


This `<flt-semantics>` element is absolutely positioned to appear exactly at the position where the corresponding button is painted on the canvas. This is because Flutter owns the layout of all widgets and it precomputes the positions and sizes of every semantic node. Absolute layout allows placing the accessibility element exactly where the user would expect it. However, what this also means is that whenever the user scrolls, the positions need to be adjusted, which can be expensive in some situations.

<DashImage figure src="images/0pF3_jPjWNcie3LH0.webp" />


## Expanding the approach to all default widgets

Since Flutter knows that what is represented as `<flt-semantics role="button">` in the DOM structure in the Flutter source code originally was a Flutter [`TextButton`](https://api.flutter.dev/flutter/material/TextButton-class.html), it’s relatively easy to expand the approach and create a mapping from all the existing [Flutter widgets](https://docs.flutter.dev/reference/widgets) to the corresponding [WAI-ARIA roles](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles), which is exactly what Flutter does out of the box for all its default widgets. For example, Flutter supports the following roles today:

* Text

* Buttons

* Checkboxes

* Radio boxes

* Text fields

* Links

* Dialogs

* Images

* Sliders

* Live regions

* Scrollables

* Containers and groups

Note that even though the list of roles is short, many different categories of widgets frequently share the same role. For example, Material [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html) and [`CupertinoTextField`](https://api.flutter.dev/flutter/cupertino/CupertinoTextField-class.html) can share the same text field role. Most layout widgets, such as Stack, Column, Row, Flex, etc., can all be represented by a container/group.

## Challenges with custom widgets

When building a custom widget, Flutter may not be able to automatically apply a correct role to it. If a widget is simply a decorated variant of an existing widget (e.g., a wrapper over [`EditableText`](https://api.flutter.dev/flutter/widgets/EditableText-class.html)), it may present itself correctly (as a text field). However, if you are building a widget from scratch, Flutter expects you to use the [`Semantics`](https://api.flutter.dev/flutter/widgets/Semantics-class.html) widget to describe its accessibility properties. WAI-ARIA defines many different widget roles. Flutter only supports a subset of roles, although this subset is continuously growing.

For example, you can explore the team class picker live in the [I/O Flip game](https://flip.withgoogle.com/), as shown in the following screenshot. In web terms, it’s essentially a `<select>`, or a [`listbox`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/listbox_role) in WAI-ARIA terms. And while the available options are represented as [`generic`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/generic_role) texts (they should rather be [`<option>`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/option_role) elements), an even bigger problem is that it’s not clear from the accessibility tree that there are more options to choose from but that are outside of the viewport of the widget. Note the available options in the accessibility tree before and after scrolling.

**Before scrolling:**

<DashImage figure src="images/0fouBgFDZseB3agw8.webp" />


**After scrolling:**

<DashImage figure src="images/0wY_EYxQGJey5Vn4f.webp" />


If you look at the [source code](https://github.com/flutter/io_flip/blob/a128c2ed1afcfbbd79edf2dfc21682bcc0dc3067/lib/prompt/view/prompt_form_view.dart), you can see that it doesn’t use the [`Semantics`](https://api.flutter.dev/flutter/widgets/Semantics-class.html) class, since Semantics doesn’t support the listbox and option role annotation use case yet. But it does use a [`ListWheelScrollView`](https://api.flutter.dev/flutter/widgets/ListWheelScrollView-class.html), which is similar to a regular [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html), so it knows it’s dealing with a list. Note, though, how the accessibility tree only ever shows the now visible items, plus a few items above and below the viewport, but never all items. (This is a common app performance trick that we almost got natively on the web, too, in the form of a [`<virtual-scroller>`](https://github.com/WICG/virtual-scroller).)

<DashImage figure src="images/0506M98hmpxgRJFd7.webp" />


Compare Flutter’s accessibility tree to that of the [scrollable listbox example](https://www.w3.org/WAI/ARIA/apg/patterns/listbox/examples/listbox-scrollable/) from the [ARIA Authoring Practices Guide](https://www.w3.org/WAI/ARIA/apg/patterns/), where all options are shown in the accessibility tree, even those outside of the viewport. Not fully supporting this listbox use case is at the time of this writing a shortcoming of the Flutter solution that will get addressed in the future.

<DashImage figure src="images/0clEvyPhHbCFI71Wc.webp" />


## Text editing

Flutter has an `<flt-text-editing-host>` element that has either an `<input>`or a `<textarea>` as its child that it places pixel-perfectly onto the corresponding canvas area. This means browser conveniences like autofill work as expected. This feature is always enabled, independent of whether accessibility is enabled or not. In the semantics tree, the text field is represented by an `<input>` element, potentially with an ARIA label describing it. The following [text field](https://flutter-gallery-archive.web.app/#/demo/text-field) example is from the Flutter Gallery. See how the `<input>` field is dynamically repositioned whenever the user presses the tab key.

<DashImage figure src="images/0MeogiafDXLMMaxtX.gif" />


While for sighted users the label texts displayed in the text inputs are visible, for screen reader users the text fields are announced as “edit, blank” with [NVDA](https://www.nvaccess.org/about-nvda/) on Windows or “edit text, blank” with [VoiceOver](https://www.apple.com/voiceover/info/guide/_1121.html) on macOS, since Flutter at the moment doesn’t create `<label>` elements yet. You can see VoiceOver’s screen reader output at the bottom of the images. This is something Flutter will fix in the future.

<DashImage figure src="images/0UpUS0j53XBPfPB8j.webp" />


When text fields are properly labeled, the screen reader announces the intended meaning, as depicted in the following pure HTML example.

<DashImage figure src="images/0X8hvqa_bbwsEtV-P.gif" />


## Conclusions

This case study has delved into the intricacies of how accessibility support functions within Flutter canvas applications on the web. Flutter’s accessibility unfolds through a hidden button with specific attributes and styling. Upon activation, this approach significantly improves the experience for users relying on screen readers and other assistive technologies. The core concept in Flutter involves creating an accessible DOM structure that mirrors the canvas display, utilizing custom elements such as `<flt-semantics-host>`, `<flt-semantics>`, `<flt-semantics-container>`, and others.

While Flutter adeptly maps default widgets to WAI-ARIA roles, the team acknowledges some remaining challenges. The exploration of text editing in Flutter showcases the trick with the `<flt-text-editing-host>` with `<input>` or `<textarea>`, demonstrating dynamic repositioning of input fields.

Looking ahead, there are opportunities for further refinement of Flutter’s accessibility framework that the team has already started working on. This includes addressing the listbox use case for custom widgets and enhancing label element creation for text editing. These anticipated enhancements aim to deliver a more encompassing and seamless accessibility experience, reflecting Flutter’s commitment to continuous improvement of its web compilation target.

## Acknowledgements

This case study was reviewed for accuracy by [Yegor Jbanov](https://www.linkedin.com/in/yegorjbanov/), [Kevin Moore](https://www.linkedin.com/in/kevmoo/), [Michael Thomsen](https://www.linkedin.com/in/msthomsen/), and [Shams Zakhour](https://www.linkedin.com/in/shams-zakhour-84a9b31) from the Flutter team. The editorial review is courtesy of [Rachel Andrew](https://rachelandrew.co.uk/) and [Shams Zakhour](https://www.linkedin.com/in/shams-zakhour-84a9b31).