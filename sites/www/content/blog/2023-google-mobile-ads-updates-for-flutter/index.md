---
title: "2023 Google Mobile Ads Updates for Flutter"
description: "We added new GMA Flutter features based on your feedback!"
publishDate: 2023-05-10
author: timothyhoang
image: images/1PLQQUPqp_e0LmXTbAgb_iQ.webp
category: announcement
layout: blog
---

<DashImage figure src="images/1PLQQUPqp_e0LmXTbAgb_iQ.webp" />

As you build and grow your Flutter apps, you may want your apps to make money. You can monetize your apps in many ways. Introducing advertising would be one of the most common strategies. To introduce ads, you can use the [Google Mobile Ads](https://pub.dev/packages/google_mobile_ads) (GMA) Flutter plugin. The GMA plugin can place ads from AdMob, Google Ad Manager, or AdSense in your Flutter mobile app.

Feature and tooling requests have grown in step with GMA Flutter plugin usage. Based on your Ad Manager and AdMob survey responses, the plugin now supports:

* Dart support for Native Ads

* Updated application samples

* WebView API for Ads

## Dart support for Native ads

With Native ads, you can customize the look and feel of the ads that appear in your app. You design the ads from the ground up. Configure how they look, where they’re placed, and how they work within your existing app design.

Native ads can match the layout of the surrounding content. This results in a more cohesive, natural app experience. You can implement these ads in a number of ways. Add them in your feeds, on transition screens and overlays, or anywhere else you want ads within your app.

<DashImage figure src="images/1CkTEpg9fxmW7j_UxQX481A.webp" />

Before, implementing Native ads required writing platform code. We agree this was a suboptimal developer experience and want to enable you to use Dart whenever possible.

We added Dart APIs to enable you to customize your Native ads using Dart. These APIs leverage GMA [Native Templates in Dart](https://developers.google.com/admob/flutter/native/templates) to accelerate the creation of your ad experiences. The new Dart APIs don’t replace platform code. If you want more control over platform-specific ad customization, you can continue to write platform code.

To learn more about best practices with building Native ad experiences, check out our [Native ads playbook](https://storage.googleapis.com/gweb-dblclk-native-gallery.appspot.com/NativePlaybook.pdf).

To get started with implementing these ads, check out our [developer documentation](https://developers.google.com/admob/flutter/native).

## Updated application samples

When you submit issues on the GMA Flutter plugin, it helps if you include a minimum reproducible app sample to investigate the issue. That said, we heard your feedback that you might have difficulty generating or sharing reproducible samples.

To simplify troubleshooting issues, we cut our big sample into smaller samples. We replaced our monolithic app sample with [samples for each ad format and mediation](https://github.com/googleads/googleads-mobile-flutter/tree/main/samples/admob). When you submit issues now, you can use these apps. These apps allow you to share a minimum reproducible sample. This helps when sharing a sample of your own app would be cumbersome or impossible.

<DashImage figure src="images/1AwHtPUcFDv1jToZIKjye_w.webp" />

We hope that these smaller individual app samples simplify testing out new formats or mediation. Each sample includes a readme that supplements our GMA developer documentation ([Ad Manager](https://developers.google.com/ad-manager/mobile-ads-sdk/flutter/quick-start), [AdMob](https://developers.google.com/admob/flutter/quick-start)).

Each sample app implements two important features:

1. Google test ads for [Android](https://developers.google.com/admob/android/test-ads) and [iOS](https://developers.google.com/admob/ios/test-ads)

1. A test application ID.

When testing functionality of your own ad units in the application samples, replace the ad unit IDs and app IDs with your own. Make sure you have [enabled test ads](https://developers.google.com/ad-manager/mobile-ads-sdk/flutter/test-ads). If you click on too many ads without being in test mode, you risk your account being flagged for invalid activity.

To illustrate with the [banner app sample](https://github.com/googleads/googleads-mobile-flutter/blob/main/samples/admob/banner_example/lib/main.dart#L25):

1. Replace the following test ad unit IDs with your own:

```dart
final String _adUnitId = Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/6300978111'
    : 'ca-app-pub-3940256099942544/2934735716';
```

2. Replace the following test application IDs in the [Android](https://github.com/googleads/googleads-mobile-flutter/blob/main/samples/admob/banner_example/android/app/src/main/AndroidManifest.xml#L30) and [iOS](https://github.com/googleads/googleads-mobile-flutter/blob/main/samples/admob/banner_example/ios/Runner/Info.plist#L51) config files with your own.

That’s all it takes to start testing functionality of your

To view all samples, check out [googleads-mobile-flutter/samples](https://github.com/googleads/googleads-mobile-flutter/tree/main/samples/admob).

## WebView API for Ads

We understand some developers prefer using WebViews in their mobile apps. This allows them to avoid the need to re-tag their ad inventory. As stated in our [AdSense policy](https://support.google.com/adsense/answer/48182?sjid=16092961064586512819-NA#trs) and [Ad Manager policy](https://support.google.com/admanager/answer/6310245?sjid=16092961064586512819-NA), we only supported monetization of web content in certain WebView technologies.

To support Ad Manager and AdSense monetization of mobile app WebViews, we’re introducing Flutter support for the GMA WebView API for Ads. If your app uses WebViews to display web content that serves ads from Ad Manager or AdSense, you must use the WebView API for Ads.

<DashImage figure src="images/1Vj2zT8BlnstyfZmvgSXuSw.webp" />

1. If you don’t need to request ads from an in-app WebView, implement the ad format using the GMA Flutter plugin ([Ad Manager guide](https://support.google.com/admanager/answer/6238696), [AdMob guide](https://support.google.com/admob/answer/6128738))

1. If you request ads from an in-app WebView, use the WebView API for Ads to register the WebView to follow our [AdSense policy](https://support.google.com/adsense/answer/48182?sjid=16092961064586512819-NA#trs) and [Ad Manager policy](https://support.google.com/admanager/answer/6310245?sjid=16092961064586512819-NA).

You can do either option, or even both, in the same app.

**Note**: The JavaScript in the [AdSense code](https://support.google.com/adsense/answer/9274634) or [Google Publisher Tag](https://support.google.com/admanager/answer/181073) builds and sends ad requests. You don’t need to make any ad requests with the SDK. Only the mobile web and desktop web [inventory formats](https://support.google.com/admanager/answer/9796545) may be used with this API.

To start implementing, check out our [developer documentation](https://developers.google.com/admob/flutter/webview).

## How do we determine what to build next?

Your feedback influences our product roadmap.

Since the open beta in 2020, we’ve been working with you in GitHub to troubleshoot issues and collect feature requests. Adoption of the GMA Flutter plugin has seen significant growth. We want to scale our support to meet this higher demand.

Starting in Q3 2023, if you report a bug or feature request via GitHub Issues, we recommend you visit our [developers forum](https://groups.google.com/group/google-admob-ads-sdk/) for your issue. The developers forum provides your best technical support option. We staff the forum with a technical support team. Developers who use the GMA SDK participate in the forum as well. If you have a question about the Flutter GMA SDK, the forum should provide the fastest and most accurate responses. We’re scaling support for Flutter in the forums to the same teams that support the Android, iOS, and Unity GMA plugins.

We welcome Flutter developers to the Google Mobile Ads community. We invite you to try the GMA SDK and consult with your fellow app publishers in the forum!
