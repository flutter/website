---
title: Platform specific behaviors and adaptations
---

## Adaptation philosophy

There are generally 2 cases of platform adaptiveness:

1. Things that are behaviors of the OS environment (such as text editing and
scrolling) and that would be 'wrong' if a different behavior took place.
2. Things that are conventionally implemented in apps using the OEM's SDKs
(such as using parallel tabs on iOS or showing an [android.app.AlertDialog](https://developer.android.com/reference/android/app/AlertDialog.html)
on Android).

This article mainly covers the automatic adaptations provided by Flutter
in case 1 on Android and iOS.

For case 2, Flutter bundles the means to produce the appropriate effects of
the platform conventions but does not adapt automatically when app design
choices are needed. For a discussion, see [#8410](https://github.com/flutter/flutter/issues/8410#issuecomment-468034023).

## Page navigation

Flutter provides the navigation patterns seen on Android and iOS and also
automatically adapts the navigation animation to the current platform.

### Navigation transitions

On **Android**, the default [Navigator.push]({{site.api}}/flutter/widgets/Navigator/push.html)
transition is modeled after [startActivity()](https://developer.android.com/reference/android/app/Activity.html#startActivity(android.content.Intent))
which generally has one bottom-up animation variant.

On **iOS**:

* The default [Navigator.push]({{site.api}}/flutter/widgets/Navigator/push.html)
API produces an iOS Show/Push style transition which animates from end to start
depending on the locale's RTL setting. The page behind the new route also
parallax-slides in the same direction like in iOS.
* A separate bottom-up transition style
exists when pushing a page route where [PageRoute.fullscreenDialog]({{site.api}}/flutter/widgets/PageRoute-class.html)
is true. This represents iOS's Present/Modal style transition and is typically
used on fullscreen modal pages.

<div class="container">
  <div class="row">
    <div class="col-sm text-center">
      <figure class="figure">
        <img src="../../images/platform-adaptations/navigation-android.gif" class="figure-img img-fluid rounded" alt="An animation of the bottom-up page transition on Android" />
        <figcaption class="figure-caption">
          Android page transition
        </figcaption>
      </figure>
    </div>
    <div class="col-sm text-center">
      <figure class="figure">
        <img src="../../images/platform-adaptations/navigation-ios.gif" class="figure-img img-fluid rounded" alt="An animation of the end-start style push page transition on iOS" />
        <figcaption class="figure-caption">
          iOS push transition
        </figcaption>
      </figure>
    </div>
    <div class="col-sm text-center">
      <figure class="figure">
        <img src="../../images/platform-adaptations/navigation-ios-modal.gif" class="figure-img img-fluid rounded" alt="An animation of the bottom-up style present page transition on iOS" />
        <figcaption class="figure-caption">
          iOS present transition
        </figcaption>
      </figure>
    </div>
  </div>
</div>

### Platform-specific transition details

On **Android**, 2 page transition animation styles exist depending on your OS
version:

* Pre API 28 uses a bottom-up animation that [slides up and fades in]({{site.api}}/flutter/material/FadeUpwardsPageTransitionsBuilder-class.html).
* On API 28 and later, the bottom-up animation [slides and clip-reveals up]({{site.api}}/flutter/material/OpenUpwardsPageTransitionsBuilder-class.html).

On **iOS**, Flutter's bundled [CupertinoNavigationBar]({{site.api}}/flutter/cupertino/CupertinoNavigationBar-class.html)
and [CupertinoSliverNavigationBar]({{site.api}}/flutter/cupertino/CupertinoSliverNavigationBar-class.html)
will automatically animates each of its subcomponent to its corresponding
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

### Back navigation

On **Android**, the OS back button, by default, is sent to Flutter and pops the top
route of the [WidgetsApp]({{site.api}}/flutter/widgets/WidgetsApp-class.html)'s
Navigator.

On **iOS**, an edge swipe gesture can be used to pop the top route.

## Scrolling

Scrolling is an important part of the platform's look and feel and Flutter
automatically adjusts the scrolling behavior to match the current platform.

### Physics simulation

\[WIP\]

### Overscroll behavior

On **Android**, scrolling past the edge of a scrollable shows an [overscroll glow indicator]({{site.api}}/flutter/widgets/GlowingOverscrollIndicator-class.html)
(based on the color of the current Material theme).

On **iOS**, scrolling past the edge of a scrollable [overscrolls]({{site.api}}/flutter/widgets/BouncingScrollPhysics-class.html)
with increasing resistance and snaps back.

### Return to top

On **iOS**, tapping the OS status bar will scroll the primary scroll controller
to the top position. No equivalent behavior is on **Android**.

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

## Haptic feedback

The Material and Cupertino packages automatically trigger the platform
appropriate haptic feedback in certain scenarios.

For instance, a word selection via text field long-press triggers a 'buzz'
vibrate on Android and not on iOS.

Scrolling through picker items on iOS triggers a 'light impact' knock and
no feedback on Android.

## Text editing

Flutter also makes the below adaptations while editing the content of text
fields to match the current platform.

### Keyboard gesture navigation

On **Android**, horizontal swipes can be made on the soft keyboard's spacebar
to move the cursor in Material and Cupertino text fields.

On **iOS** devices with 3D Touch capabilities, a force-press-drag gesture
could be made on the soft keyboard to move the cursor in 2D via a floating
cursor. This works on both Material and Cupertino text fields.

### Text selection toolbar

With **Material on Android**, the Android style selection toolbar is shown when
a text selection is made in a text field.

With **Material on iOS** or when using **Cupertino**, the iOS style selection
toolbar is shown whe a text selection is made in a text field.

### Single tap gesture

With **Material on Android**, a single tap in a text field puts the cursor at
the location of the tap.

With **Material on iOS** or when using **Cupertino**, a single tap in a text
field puts the cursor at the nearest edge of the word tapped.

### Long-press gesture

With **Material on Android**, a long press selects the word under the long
press. The selection toolbar is shown upon release.

With **Material on iOS** or when using **Cupertino**, a long press places the
cursor at the location of the long pres. The selection toolbar is shown upon
release.

### Long-press drag gesture

With **Material on Android**, dragging while holding the long press expands
the words selected.

With **Material on iOS** or when using **Cupertino**, dragging while holding
the long press moves the cursor.

### Double tap gesture

On both Android and iOS, a double tap selects the word double tapped and shows
the selection toolbar.

