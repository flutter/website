---
title: Platform Specific Behaviors and Adaptations
---

## Adaptation Philosophy

There are generally 3 categories of platform adaptiveness:

1. Things that are behaviors of the OS environment (such as text editing and
scrolling) and that would be 'wrong' a different behavior took place.
2. Things that are conventionally implemented in apps using the OEM's SDKs
(such as using parallel tabs on iOS).
3. Correct usage of corresponding platform APIs to export to TalkBack/VoiceOver,
status bar color theme etc. and to import notch metrics, locale settings etc.

This article mainly covers the automatic adaptations provided by Flutter
in case 1 on Android and iOS.

For case 2, Flutter bundles the means to produce the appropriate effects of
the platform conventions but does not adapt automatically when app design
choices are needed. For a discussion, see [#8410](https://github.com/flutter/flutter/issues/8410#issuecomment-468034023).

## Page Navigation

### Navigation Transitions

On Android, the default [Navigator.push](https://docs.flutter.io/flutter/widgets/Navigator/push.html)
transition is modeled after [startActivity()](https://developer.android.com/reference/android/app/Activity.html#startActivity(android.content.Intent))
which generally has one bottom-up animation variant.

On iOS, the default [Navigator.push](https://docs.flutter.io/flutter/widgets/Navigator/push.html)
API produces an iOS Show/Push style transition which animates from end to start
depending on the locale's RTL setting. The page behind the new route also
parallax-slides in the same direction like in iOS.

A separate bottom-up transition style
exists when pushing a page route where [PageRoute.fullscreenDialog](https://docs.flutter.io/flutter/widgets/PageRoute-class.html)
is true. This represents iOS's Present/Modal style transition and is typically
used on fullscreen modal pages.

<div class="container">
  <div class="row">
    <div class="col-sm text-center">
      <figure class="figure">
        <img src="../../images/platform-adaptations/navigation-android.gif" class="figure-img img-fluid rounded" alt="An animation of the bottom-up page transition on Android" />
        <figcaption class="figure-caption">
          Android
        </figcaption>
      </figure>
    </div>
    <div class="col-sm text-center">
      <figure class="figure">
        <img src="../../images/platform-adaptations/navigation-ios.gif" class="figure-img img-fluid rounded" alt="An animation of the end-start style push page transition on iOS" />
        <figcaption class="figure-caption">
          iOS push
        </figcaption>
      </figure>
    </div>
    <div class="col-sm text-center">
      <figure class="figure">
        <img src="../../images/platform-adaptations/navigation-ios-modal.gif" class="figure-img img-fluid rounded" alt="An animation of the bottom-up style present page transition on iOS" />
        <figcaption class="figure-caption">
          iOS present
        </figcaption>
      </figure>
    </div>
  </div>
</div>

### Platform-Specific Transition Details

On Android, 2 page transition animation styles exist depending on your OS
version. Pre API 28 uses a bottom-up animation that slides up and fades in. On
API 28 and later, the bottom-up animation slides and clip-reveals up.

On iOS, Flutter's bundled CupertinoNavigationBar and CupertinoSliverNavigationBar
will automatically animate each of its subcomponent to its corresponding
subcomponent on the next or previous page's CupertinoNavigationBar or
CupertinoSliverNavigationBar when the push style transition is used.

<div class="container">
  <div class="row">
    <div class="col-sm text-center">
      <figure class="figure">
        <img src="../../images/platform-adaptations/navigation-android.gif" class="figure-img img-fluid rounded" alt="An animation of the page transition on Android pre-Android P" />
        <figcaption class="figure-caption">
          Android Pre-P
        </figcaption>
      </figure>
    </div>
    <div class="col-sm">
      <figure class="figure text-center">
        <img src="../../images/platform-adaptations/navigation-android-p.gif" class="figure-img img-fluid rounded" alt="An animation of the page transition on Android on Android P" />
        <figcaption class="figure-caption">
          Android Post-P
        </figcaption>
      </figure>
    </div>
    <div class="col-sm">
      <figure class="figure text-center">
        <img src="../../images/platform-adaptations/navigation-ios-nav-bar.gif" class="figure-img img-fluid rounded" alt="An animation of the nav bar transitions during a page transition on iOS" />
        <figcaption class="figure-caption">
          iOS Nav Bar
        </figcaption>
      </figure>
    </div>
  </div>
</div>

### Back Navigation

On Android, the OS back button, by default, is sent to Flutter and pops the top
route of the [WidgetsApp](https://docs.flutter.io/flutter/widgets/WidgetsApp-class.html)'s
Navigator.

On iOS, an edge swipe gesture can be used to pop the top route.

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
