---
layout: page
title: Preparing an iOS App for Release

permalink: /ios-release/
---

This guide provides a step-by-step walkthrough of releasing a Flutter app to
the [App Store][appstore] and [TestFlight][testflight].

* TOC Placeholder
{:toc}

## Preliminaries

Before beginning the process of releasing your app, ensure that it meets
Apple's [App Review Guidelines][appreview].

In order to publish your app to the App Store, you'll need to enroll in the
[Apple Developer Program][devprogram]. You can read more about the various
membership options in Apple's [Choosing a Membership][devprogram_membership]
guide.

## Register your app on iTunes Connect

[iTunes Connect][itunesconnect] is where you'll manage your app's life cycle.
You will define your app name and description, add screenshots, set pricing,
and manage releases to the App Store and TestFlight.

Registering your app involves two steps: registering a unique Bundle ID, and
creating an application record on iTunes Connect.

For a detailed overview of iTunes Connect, see the [iTunes Connect][itunesconnect_guide]
guide.

### Register a Bundle ID

Every iOS application is associated with a Bundle ID, a unique identifier
registered with Apple. To register a Bundle ID for your app, follow these
steps:

1. Open the [App IDs][devportal_appids] page of your developer account.
1. Click **+** to create a new Bundle ID.
1. Enter an app name, select **Explicit App ID**, and enter an ID.
1. Select the services your app will use, then click **Continue**.
1. On the next page, confirm the details and click **Register** to register
   your Bundle ID.

### Create an application record on iTunes Connect

Next, you'll register your app on iTunes Connect:

1. Open [iTunes Connect][itunesconnect_login] in your browser.
1. On the iTunes Connect landing page, click **My Apps**.
1. Click **+** in the top-left corner of the My Apps page, then select
   **New App**.
1. Fill in your app details in the form that appears. In the Platforms section,
   ensure that iOS is checked. Since Flutter does not currently support tvOS,
   leave that checkbox unchecked. Click **Create**.
1. Navigate to the application details for your app and select **App
   Information** from the sidebar.
1. In the General Information section, select the Bundle ID you registered in
   the preceding step.

For a detailed overview, see [Add an app to your account][itunesconnect_guide_register].

## Review Xcode project settings

In this step, you'll review the most important settings in the Xcode workspace.
For detailed procedures and descriptions, see [Prepare for app distribution]
[distributionguide_config].

Navigate to your target's settings in Xcode:

1. In Xcode, open `Runner.xcworkspace` in your app's `ios` folder.
1. To view your app's settings, select the **Runner** project in the Xcode
   project navigator. Then, in the main view sidebar, select the **Runner**
   target.
1. Select the **General** tab.

Next, you'll verify the most important settings:

In the Identity section:

  * `Display Name:` the name of the app to be displayed on the home screen and
    elsewhere.
  * `Bundle Identifier:` the App ID you registered on iTunes Connect.

In the Signing section:

  * `Automatically manage signing:` whether Xcode should automatically manage
    app signing and provisioning. This is set `true` by default, which should
    be sufficient for most apps. For more complex scenarios, see the [Code
    Signing Guide][codesigning_guide].
  * `Team:` select the team associated with your registered Apple Developer
    account. If required, select **Add Account...**, then update this setting.

In the Deployment Info section:

  * `Deployment Target:` the minimum iOS version your app will support.
    Flutter supports iOS 8.0 and later. If your app includes Objective-C or
    Swift code that makes use of APIs that were unavailable in iOS 8, update
    this setting appropriately.

The General tab of your project settings should resemble the following:

![Xcode Project Settings](/images/releaseguide/xcode_settings.png)

For a detailed overview of app signing, see [Create, export, and delete signing
certificates][appsigning].

## Add an App Icon

When a new Flutter app is created, a placeholder icon set is created. In this
step, you'll replace these placeholder icons with your app's icons:

1. Review the [iOS App Icon][appicon] guidelines.
1. In the Xcode project navigator, select `Assets.xcassets` in the `Runner`
   folder. Update the placeholder icons with your own app icons.
1. Verify the icon has been replaced by running your app using `flutter run`.

## Create a build archive

In this step, you'll create a build archive and upload your build to iTunes
Connect.

During development, you've been building, debugging, and testing with *debug*
builds. When you're ready to ship your app to users on the App Store or
TestFlight, you'll need to prepare a *release* build.

On the command line, follow these steps in your application directory:

1. Run `flutter build ios` to create a release build (`flutter build` defaults to `--release`).
1. To ensure that Xcode refreshes the release mode configuration, close and
   re-open your Xcode workspace. For Xcode 8.3 and later, this step is not
   required.

In Xcode, configure the app version and build:

1. In Xcode, open `Runner.xcworkspace` in your app's `ios` folder.
1. Select **Product > Scheme > Runner**.
1. Select **Product > Destination > Generic iOS Device**.
1. Select **Runner** in the Xcode project navigator, then select the **Runner**
   target in the settings view sidebar.
1. In the Identity section, update the **Version** to the user-facing
   version number you wish to publish.
1. In the Identity section, update the **Build** identifier to a unique
   build number used to track this build on iTunes Connect. Each upload requires a
   unique build number.

Finally, create a build archive and upload it to iTunes Connect:

1. Select **Product > Archive** to produce a build archive.
1. In the sidebar of the Xcode Organizer window, select your iOS app, then
   select the build archive you just produced.
1. Click the **Validate...** button. If any issues are reported, address them
   and produce another build. You can reuse the same build ID until you upload
   an archive.
1. After the archive has been successfully validated, click **Upload to App
   Store...**. You can follow the status of your build in the Activities
   tab of your app's details page on [iTunes Connect][itunesconnect_login].

You should receive an email within 30 minutes notifying you that your build has
been validated and is available to release to testers on TestFlight. At this
point you can choose whether to release on TestFlight, or go ahead and release
your app to the App Store.

For more details, see [Upload an app to iTunes Connect][distributionguide_upload].

## Release your app on TestFlight

[TestFlight][testflight] allows developers to push their apps to internal and
external testers. In this optional step, you'll release your build on
TestFlight.

1. Navigate to the TestFlight tab of your app's application details page on
   [iTunes Connect][itunesconnect_login].
1. Select **Internal Testing** in the sidebar.
1. Select the build to publish to testers, then click **Save**.
1. Add the email addresses of any internal testers. You can add additional
   internal users in the Users and Roles page of iTunes Connect, available from
   the dropdown menu at the top of the page.

For more details, see [Distribute an app using TestFlight]
[distributionguide_testflight].

## Release your app to the App Store

When you're ready to release your app to the world, follow these steps to
submit your app for review and release to the App Store:

1. Select **Pricing and Availability** from the sidebar of your app's
   application details page on [iTunes Connect][itunesconnect_login] and
   complete the required information.
1. Select the status from the sidebar. If this is the first release of this
   app, its status will be **1.0 Prepare for Submission**. Complete all
   required fields.
1. Click **Submit for Review**.

Apple will notify you when their app review process is complete. Your app will
be released according to the instructions you specified in the **Version
Release** section.

For more details, see [Distribute an app through the App Store]
[distributionguide_submit].

## Troubleshooting

The [Distribute your app][distributionguide] guide provides a detailed overview of
the process of releasing an app to the App Store.

[appicon]: https://developer.apple.com/ios/human-interface-guidelines/graphics/app-icon/
[appreview]: https://developer.apple.com/app-store/review/
[appsigning]: https://help.apple.com/xcode/mac/current/#/dev154b28f09
[appstore]: https://developer.apple.com/app-store/submissions/
[codesigning_guide]: https://developer.apple.com/library/content/documentation/Security/Conceptual/CodeSigningGuide/Introduction/Introduction.html
[devportal_appids]: https://developer.apple.com/account/ios/identifier/bundle
[devprogram]: https://developer.apple.com/programs/
[devprogram_membership]: https://developer.apple.com/support/compare-memberships/
[distributionguide]: https://help.apple.com/xcode/mac/current/#/dev8b4250b57
[distributionguide_config]: https://help.apple.com/xcode/mac/current/#/dev91fe7130a
[distributionguide_submit]: https://help.apple.com/xcode/mac/current/#/dev067853c94
[distributionguide_testflight]: https://help.apple.com/xcode/mac/current/#/dev2539d985f
[distributionguide_upload]: https://help.apple.com/xcode/mac/current/#/dev442d7f2ca
[itunesconnect]: https://developer.apple.com/support/itunes-connect/
[itunesconnect_guide]: https://developer.apple.com/support/itunes-connect/
[itunesconnect_guide_register]: https://help.apple.com/itunes-connect/developer/#/dev2cd126805
[itunesconnect_login]: https://itunesconnect.apple.com/
[testflight]: https://developer.apple.com/testflight/
