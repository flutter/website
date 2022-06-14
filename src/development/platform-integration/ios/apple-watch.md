---
title: Adding an Apple Watch extension
description: Learn how to add an Apple Watch target to a Flutter app.
---

While you cannot build an Apple Watch app with Flutter,
you can add a native Apple Watch extension to a Flutter app.

## Step 1: Enable bitcode in Xcode

Apple Watch targets require bitcode to be enabled,
so follow the steps in [Creating an iOS Bitcode enabled app][bitcode]
to use bitcode in your app.

[bitcode]: {{site.repo.flutter}}/wiki/Creating-an-iOS-Bitcode-enabled-app

## Step 2: Add an Apple Watch target

In the menu, select **File > New > Target**.
Once the dialog opens, select **watchOS**
at the top and click **Watch App for iOS App**.
Click **Next**, enter a product name, and select **Enter**.

![Adding an Apple Watch target]({{site.url}}/assets/images/docs/AppleWatchTarget.png){:width="70%"}

