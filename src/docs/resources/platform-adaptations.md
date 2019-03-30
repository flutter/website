---
title: Platform Specific Behaviors and Adaptations
---

## Adaptation Philosophy

There are generally 3 categories platform adaptiveness:

1. Things that are behaviors of the OS environment (such as text editing and
scrolling) and that would be 'wrong' a different behavior took place.
2. Things that are conventionally implemented in apps using the OEM's SDKs
(such as using parallel tabs on iOS).
3. Correct usage of corresponding platform APIs to export to TalkBack/VoiceOver,
status bar color theme etc. and to import notch metrics, locale settings etc.

This article mainly covers the automatic adaptations provided by Flutter
in case 1 on Android and iOS.

For a discussion on case 2, see [#8410](https://github.com/flutter/flutter/issues/8410#issuecomment-468034023).

## Page Navigation

### Navigation Transitions

### Transition Types

On Android, the transition is modeled after [startActivity()](https://developer.android.com/reference/android/app/Activity.html#startActivity(android.content.Intent))
which generally has one animation variant. On iOS,

### Platform-Specific Transition Animations Details

On Android, 2 page transition animation styles exist depending on your OS
version.

On iOS, Flutter's bundled CupertinoNavigationBar and CupertinoSliverNavigationBar
will automatically each of its subcomponent to its corresponding subcomponent
on the next or previous page's CupertinoNavigationBar or CupertinoSliverNavigationBar
when the push style transition is used.

## Scrolling

### Physics Simulation

### Overscroll Behavior

## Typography

When using the Material package, the typography automatically default to the
font family appropriate for the platform. On Android, the Roboto font is used.
On iOS, the OS's San Francisco font family is used.

When using the Cupertino package, the [default theme](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/cupertino/text_theme.dart)
always uses the San Francisco font.

The San Francisco font license limits its usage to software running on iOS,
macOS or tvOS only. Therefore a fallback font is used when running on Android
if the platform is debug-overridden to iOS or the default Cupertino theme is
used.

## Iconography

When using the Material package, certain icons automatically show different
graphics depending on the platform. For instance, the overflow button's 3 dots
are vertical on iOS and horizontal on Android. The back button is a simple
chevron on iOS and has a stem/shaft on Android.

## Haptic Feedback

The Material and Cupertino packages automatically trigger the platform
appropriate haptic feedback in certain scenarios.

For instance, a word selection via text field long-press triggers a 'buzz'
vibrate on Android and not on iOS.

Scrolling through picker items on iOS triggers a 'light impact' knock and
no feedback on Android.

## Text Editing

### Keyboard Gesture Navigation

### Text Selection Toolbar

### Single Tap Gesture

### Long-Press Gesture

### Long-Press-Drag Gesture

### Double Tap Gesture


[issues]: {{site.github}}/flutter/flutter/issues
[apidocs]: {{site.api}}
[so]: {{site.so}}/tags/flutter
[mailinglist]: {{site.groups}}/d/forum/flutter-dev
[gitter]: https://gitter.im/flutter/flutter
