---
title: "Adding an Apple Watch extension"
description: "Learn how to add an Apple Watch target to a Flutter app."
---

While you cannot build an Apple Watch app with Flutter,
it is possible to add a native Apple Watch extension to a Flutter app.

## Step 1: Enable bitcode in Xcode

Apple Watch targets require bitcode to be enabled,
so follow the steps in
[Creating an iOS Bitcode enabled app](https://github.com/flutter/flutter/wiki/Creating-an-iOS-Bitcode-enabled-app)
to use bitcode in your app.

## Step 2: Add an Apple Watch target

In the menu, select **File > New > Target**. Once the dialog opens, select
**watchOS** at the top and click **Watch App for iOS App**. Click **Next**, 
enter a product name, and select **Enter**.

![Adding an Apple Watch target](/images/AppleWatchTarget.png){:width="70%"}


[Creating an iOS Bitcode enabled app]: {{site.github}}/flutter/flutter/wiki/Creating-an-iOS-Bitcode-enabled-app-(experimental)
