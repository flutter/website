---
title: "Developing Flutter apps for Large screens"
description: "How to optimize your Flutter app to meet Android’s large screen requirements"
publishDate: 2023-09-26
author: mariam_hasnany
image: images/04I4h-v1nPuUbxBt4.gif
category: announcements
layout: blog
---

Last year, we partnered with the team at gSkinner to develop [Wonderous](https://wonderous.app/), a reference app to showcase the high-quality experiences possible with Flutter.

[One of the goals for creating Wonderous](https://medium.com/flutter/wonderous-explore-the-world-with-flutter-f43cce052e1) was to provide an open-source example that demonstrates best practices. In that same spirit, we audited Wonderous against [Android’s large screen guidelines](https://developer.android.com/docs/quality-guidelines/large-screen-app-quality). We wanted to ensure a high-quality Flutter app across all Android devices. Android has three tiers for meeting their guidelines:

**Tier 3** — large screen ready — app runs on full screen (or full window in multi-window mode), but app layout might not be ideal

**Tier 2** — large screen optimized — app layout is optimized for all screen sizes and handles external input devices

**Tier 1** — large screen differentiated — app designed specifically with foldables in mind, ensuring the layout supports table-top mode with the hinge

In January 2023, we updated the [Wonderous app to adapt to different device formats](https://medium.com/flutter/adapting-wonderous-to-larger-device-formats-ac51e1c00bc0). While these updates made the app “large screen ready”, the app wasn’t yet “large screen optimized”.

So we again engaged gSkinner to elevate Wonderous to Tier 2 (or better) and optimized for [Android’s new large screen pixel devices](https://android-developers.googleblog.com/2023/06/the-new-pixel-fold-pixel-tablet-are-here-optimizing-for-large-screens.html).

In this article, we share what we learned and what you should consider as you develop your app to meet Android’s large screen guidelines.

## Why large are screens important

Before diving into how we optimized Wonderous to meet Android’s Large Screen guidelines, let’s understand the benefits to supporting large screens.

When we say [large screens](https://developer.android.com/guide/topics/large-screens/get-started-with-large-screens), we mean tablets, foldables, and ChromeOS devices running Android. Demand for large screens is increasing. Today, more than [270 million active large screen](https://developer.android.com/large-screens#:~:text=More%20than%20270%20million%20large%20screen%20Android%20devices) and foldable devices run on Android.

Why this matters for developers:

* Increases business metrics, such as increased user engagement on tablets for apps with layouts optimized to fill the full screen.

* Improves [Technical quality](https://developer.android.com/quality/technical) to increase visibility for your app in the Play Store on these devices. Recent [Play Store updates](https://android-developers.googleblog.com/2022/03/helping-users-discover-quality-apps-on.html) show ratings by device type and notifies users when an app lacks large screen support.

## Learnings from optimizing Wonderous

Another goal for the Wonderous app is to serve as a source for creating learning materials and documentation. In this section, we share the details where Wonderous didn’t address large-screen requirements. These issues might be common problems Flutter developers encounter so we share how we fixed them.

## App continuity & configuration changes

**Requirement:** Apps should change orientation and retain or restore state as the device rotates, changes window size or folds and unfolds.

### Problem: Folding/Unfolding causes state-loss

When Wonderous was folded and unfolded, the app experienced state-loss and would always go back to the initial screen. This issue took a long time for us to figure out. We first assumed this was default behavior in Flutter with folding/unfolding a device, but couldn’t reproduce it with a Flutter counter app. We then realized it might be a plugin that was causing state loss, specifically the [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview) plugin.

**Fix:** Replace the flutter_inappwebview plugin with [webview_flutter](https://pub.dev/packages/webview_flutter), which fixed maintaining state during device configuration.

**Learning:** Your app should not lose state when the device is folded/unfolded, Flutter should maintain state by default. If your app is losing state, verify that the plugins you use support large screen devices. A native extension could cause state-loss when the device changes position.

### Problem: Maintaining scroll position state

We thought we might need a lot of boilerplate code to ensure that a list maintained its scroll position when the screen size changed. We first used the key:PageStorageKey API and it fixed most of our list views. The “learnings” section below describes the situation where you need to go further.

<DashImage figure src="images/04I4h-v1nPuUbxBt4.gif" alt="Collections page in Wonderous app not maintaining scroll position" caption="Collections page in Wonderous app not maintaining scroll position" />


**Fix:** Use the ****key: PageStorageKey API to maintain scroll position for lists that keep their layout the same when device orientation changes. ****By [adding a PageStorageKey to the collections page](https://github.com/gskinnerTeam/flutter-wonderous-app/blob/8a29d6709668980340b1b59c3d3588f123edd4d8/lib/ui/screens/wonder_events/widgets/_events_list.dart#L64) the scroll position of the SingleChildScrollView widget [will be stored automatically](https://api.flutter.dev/flutter/widgets/PageStorage-class.html)**.**

**Learning:** While key: PageStorageKey offers an elegant way to maintain scroll position with a list, it doesn’t work if your List changes layout from vertical to horizontal. The previous GIF shows what happened with some of the Wonderous pages. In this case, you might have to [do a bit of math and change the scroll position on screen rotation](https://github.com/gskinnerTeam/flutter-wonderous-app/blob/34e49a08084fbbe69ed67be948ab00ef23819313/lib/ui/screens/collection/widgets/_collection_list.dart#L39).

## Multi-window & split screen

**Requirement:** App has full functionality running in multi-window mode. The app updates its UI, continuing to play media, for example, when the app doesn’t have top focus.

### Problem: Letterboxing due to split screen view

With the advent of[ “screen splitting”](https://developer.android.com/guide/topics/large-screens/multi-window-support), the user can, with some orientations and aspect ratios, put the app into less than two inches of vertical space. When the screen was split to ⅓ of the display area, the Wonderous app was [letterboxed](https://developer.android.com/guide/topics/large-screens/large-screen-compatibility-mode#letterboxing) or positioned in the center of the display area with a solid color background filling the unused area (shown below).

<DashImage figure src="images/0CUG7wMHjzHSFKMpV.gif" alt="Wonderous app being letterboxed in split-screen mode on Pixel Fold" caption="Wonderous app being letterboxed in split-screen mode on Pixel Fold" />


This happened because we chose to disable landscape on smaller screens by using MediaQuery to determine the size of the device. Unfortunately, MediaQuery doesn’t actually give you the screen size when you’re in split-screen mode and mistakenly identifies large devices with split-screens as small devices.

**Fix:** We added a new API to Flutter to add support for [Android’s new window size class](https://developer.android.com/guide/topics/large-screens/support-different-screen-sizes#window_size_classes). By switching to the Display API we were able to get the full screen size and accurately distinguish a small device from a large device with multiple windows. With this API, you can retrieve various properties of a display. The new [FlutterView.display](https://master-api.flutter.dev/flutter/dart-ui/FlutterView/display.html) getter returns a [Display](https://master-api.flutter.dev/flutter/dart-ui/Display-class.html) object. The Display object reports the physical size, the device pixel ratio, and the refresh rate of the display. To check out an example that uses the new API, visit the [setPreferredMethod API](https://master-api.flutter.dev/flutter/services/SystemChrome/setPreferredOrientations.html).

**Learning:** When disabling landscape on smaller devices (using SystemChrome.setPreferredOrientations()), use the Display API to determine the device size rather than MediaQuery.

## Keyboard, mouse and trackpad input

**Requirement:** Apps should support basic mice or trackpads, and keyboard shortcuts. Main user flows should support keyboard navigation to ensure accessibility.

### Problem: Focus states

Flutter’s Material buttons handle basic focus states by default. In the case of Wonderous, we changed the default styling of the Material buttons to set the overlayColor to transparent. This ended up breaking the focus state of the buttons. With large screen devices that have keyboards and trackpads, your app must handle navigation and provide accessible solutions for those peripheral devices.

**Fix:** [Changed the button style](https://github.com/gskinnerTeam/flutter-wonderous-app/blob/8a29d6709668980340b1b59c3d3588f123edd4d8/lib/ui/common/controls/buttons.dart#L143) to have an outline when the button is focused. We used the FocusNode [hasFocus property](https://api.flutter.dev/flutter/widgets/FocusNode/hasFocus.html) to check when the button node had focus input and added a border to the button.

**Learning:** Make sure to implement a focus state for any custom buttons or gesture detectors in your app. If you change the default Material button styles, make sure you are testing for keyboard focus states, and implementing your own if needed.

### Problem: Mouse scroll slow

The mouse scroll wheel didn’t work well on some devices throughout the app. A user had to move the scroll wheel a lot for the screen to respond . This was a known[ issue](https://github.com/flutter/flutter/issues/82973), thanks to our community. We noticed that it was more pronounced on tablets and foldables.

<DashImage figure src="images/0-7rhN0eWj8p1EZ3_.gif" alt="Scrolling Wonderous app with a mouse is slow" caption="Scrolling Wonderous app with a mouse is slow" />


**Fix:** We [fixed](https://github.com/flutter/engine/pull/44724) it in the framework since it affected all Flutter apps and it will be in the next Flutter stable release.

**Learning:** Sometimes the issue is not unique to your app and needs to be fixed by the Flutter team :)

## App UX layout

**Requirement:** Apps should provide adaptive layouts and responsive visual elements that change for available screen space or device orientation.

### Problem: Navigation rail

In the first iteration of Wonderous, we disabled the rotation of the app on small form factors since the app lacked proper landscape support on smaller screens. As mentioned earlier, we fixed the app to be able to support landscape mode for smaller screens during split-screen mode on large screen devices. While this approach fixed the letterboxing issue, it became more obvious that the app’s navigation lacked the proper ergonomics for larger screens.

<DashImage figure src="images/0FkMJSwc7jtu4K7HR.gif" alt="Before using Material’s Navigation rail" caption="Before using Material’s Navigation rail" />


This required the app to layout the navigation close to the edges of the screen where it is easier to reach, such as the left side edge of a tablet to free up precious vertical space for app content in landscape mode.

**Fix:** Update the design and implement a navigation similar to [Material’s Navigation rail](https://material.io/components/navigation-rail).

**Learning:** Make sure the layouts and navigation in your app can function properly in large screen devices and ~2” of vertical space if the screen is in split-mode. To make this feasible use [adaptive widgets](https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps) like Material’s Navigation rail**.**

<DashImage figure src="images/1T0mBXs1X6YdvCQmQlP5ryg.gif" alt="After using Material’s Navigation rail" caption="After using Material’s Navigation rail" />


## Other things to consider

### Problem: Camera preview and media projection

[To achieve Android’s Tier 3 ](https://developer.android.com/docs/quality-guidelines/large-screen-app-quality#T3-7)status, your app needs to support camera preview and media projection in different orientations, screen sizes, and in multi-window mode. Since Wonderous doesn’t have a camera feature, this requirement didn’t apply.

**Learning:** [Showing camera previews](https://developer.android.com/guide/topics/large-screens/large-screen-app-compatibility#camera_preview) can be surprisingly complex, but the [Jetpack CameraX library](https://developer.android.com/training/camerax) handles many of these details for you. In Flutter 3.10, we added preliminary support for CameraX to our Flutter camera plugin. To try it, opt in by adding the following line to your pubspec.yaml file.

```yaml
Dependencies:
camera: ^0.10.4 # Latest camera version
camera_android_camerax: ^0.5.0
```


### Not just for Android

While these fixes and learnings are presented for Android’s large screen devices, some might apply to other platforms. They can make your app run and feel better on iPads, desktop browsers, and desktop devices. The same learnings apply: leveraging the PageStorageKey API, using adaptive widgets and layouts, or ensuring the plugins you use work well with large form factors.

## In summary

Our main goal for optimizing the Wonderous app for [large screens](https://developer.android.com/guide/topics/large-screens/get-started-with-large-screens) was to demonstrate best practices for developing Flutter apps that provide a great experience across all Android devices.

In the process of meeting Android’s comprehensive set of requirements for [Tier 2 status](https://developer.android.com/docs/quality-guidelines/large-screen-app-quality#large_screen_optimized), we discovered how to fix problems that might be common in other Flutter apps running on large screens. Here are some of the key learnings:

* Maintain and restore [app state](https://developer.android.com/jetpack/compose/state#store-state) when changing device orientation or folding/unfolding a device

* Ensure your app isn’t letterboxed by accurately determining the screen size using [Display API](https://master-api.flutter.dev/flutter/services/SystemChrome/setPreferredOrientations.html)

* Handle external [input devices](https://developer.android.com/guide/topics/large-screens/input-compatibility-large-screens), such as scrolling with a mouse or keyboard

* Design your app layout specifically with large screen devices in mind, such as leveraging [Material’s navigation rails](https://material.io/components/navigation-rail)

You can learn more about Android’s [Large screen app quality](https://developer.android.com/docs/quality-guidelines/large-screen-app-quality) guidelines on Android’s developer site.

We hope you’ll leverage [Wonderous](https://wonderous.app/) as a reference while developing your own Flutter apps to meet Android’s large screen requirements.

If you have any feedback on the app, please [file an issue on Github](https://github.com/gskinnerTeam/flutter-wonderous-app). If you have any thoughts on Flutter’s Android support or supporting large screen devices, feel free to message me on [X](https://twitter.com/marihasnany) (@marihasnany).