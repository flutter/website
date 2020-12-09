---
title: Continuous delivery with Flutter
description: How to automate continuous building and releasing of your Flutter app.
---

Follow continuous delivery best practices with Flutter to make sure your
application is delivered to your beta testers and validated on a frequent basis
without resorting to manual workflows.

## fastlane

This guide shows how to integrate [fastlane][], an
open-source tool suite, with your existing testing and continuous integration
(CI) workflows (for example, Travis or Cirrus).

### Local setup

It's recommended that you test the build and deployment process locally before
migrating to a cloud-based system. You could also choose to perform continuous
delivery from a local machine.

1. Install fastlane `gem install fastlane` or `brew install fastlane`.
Visit the [fastlane docs][fastlane] for more info.
1. Create your Flutter project, and when ready, make sure that your project builds via
    * ![Android](/images/cd/android.png) `flutter build appbundle`; and
    * ![iOS](/images/cd/ios.png) `flutter build ios --release --no-codesign`.
1. Initialize the fastlane projects for each platform.
    * ![Android](/images/cd/android.png) In your `[project]/android`
    directory, run `fastlane init`.
    * ![iOS](/images/cd/ios.png) In your `[project]/ios` directory,
    run `fastlane init`.
1. Edit the `Appfile`s to ensure they have adequate metadata for your app.
    * ![Android](/images/cd/android.png) Check that `package_name` in
    `[project]/android/fastlane/Appfile` matches your package name in AndroidManifest.xml.
    * ![iOS](/images/cd/ios.png) Check that `app_identifier` in
    `[project]/ios/fastlane/Appfile` also matches Info.plist's bundle identifier. Fill in
    `apple_id`, `itc_team_id`, `team_id` with your respective account info.
1. Set up your local login credentials for the stores.
    * ![Android](/images/cd/android.png) Follow the [Supply setup steps][]
    and ensure that `fastlane supply init` successfully syncs data from your
    Play Store console. _Treat the .json file like your password and do not check
    it into any public source control repositories._
    * ![iOS](/images/cd/ios.png) Your iTunes Connect username is already
    in your `Appfile`'s `apple_id` field. Set the `FASTLANE_PASSWORD` shell
    environment variable with your iTunes Connect password. Otherwise, you'll be
    prompted when uploading to iTunes/TestFlight.
1. Set up code signing.
    * ![Android](/images/cd/android.png) On Android, there are two
      signing keys: deployment and upload. The end-users download the .apk signed
      with the 'deployment key'. An 'upload key' is used to authenticate the .aab / .apk
      uploaded by developers onto the Play Store and is re-signed with the
      deployment key once in the Play Store.
        * It's highly recommended to use the automatic cloud managed signing for
          the deployment key. For more information,
          see the [official Play Store documentation][].
        * Follow the [key generation
          steps]({{site.android-dev}}/studio/publish/app-signing#sign-apk)
          to create your upload key.
        * Configure gradle to use your upload key when building your app in
          release mode by editing `android.buildTypes.release` in
          `[project]/android/app/build.gradle`.
    * ![iOS](/images/cd/ios.png) On iOS, create and sign using a
      distribution certificate instead of a development certificate when you're
      ready to test and deploy using TestFlight or App Store.
        * Create and download a distribution certificate in your
          [Apple Developer Account console][].
        * `open [project]/ios/Runner.xcworkspace/` and select the distribution
          certificate in your target's settings pane.
1. Create a `Fastfile` script for each platform.
    * ![Android](/images/cd/android.png) On Android, follow the
      [fastlane Android beta deployment guide][].
      Your edit could be as simple as adding a `lane` that calls
      `upload_to_play_store`.
      Set the `aab` argument to `../build/app/outputs/bundle/release/app-release.aab`
      to use the app bundle `flutter build` already built.
    * ![iOS](/images/cd/ios.png) On iOS, follow the
      [fastlane iOS beta deployment guide][].
      Your edit could be as simple as adding a `lane` that calls `build_ios_app` with
      `export_method: 'app-store'` and `upload_to_testflight`. On iOS an extra
      build is required since `flutter build` builds an .app rather than archiving
      .ipas for release.

You're now ready to perform deployments locally or migrate the deployment
process to a continuous integration (CI) system.

### Running deployment locally

1. Build the release mode app.
    * ![Android](/images/cd/android.png) `flutter build appbundle`.
    * ![iOS](/images/cd/ios.png) `flutter build ios --release --no-codesign`.
    No need to sign now since fastlane will sign when archiving.
1. Run the Fastfile script on each platform.
    * ![Android](/images/cd/android.png) `cd android` then
    `fastlane [name of the lane you created]`.
    * ![iOS](/images/cd/ios.png) `cd ios` then
    `fastlane [name of the lane you created]`.

### Cloud build and deploy setup

First, follow the local setup section described in 'Local setup' to make sure
the process works before migrating onto a cloud system like Travis.

The main thing to consider is that since cloud instances are ephemeral and
untrusted, you won't be leaving your credentials like your Play Store service
account JSON or your iTunes distribution certificate on the server.

Continuous Integration (CI) systems, such as [Cirrus][]
generally support encrypted environment variables to store private data.

**Take precaution not to re-echo those variable values back onto the console in
your test scripts**. Those variables are also not available in pull requests
until they're merged to ensure that malicious actors cannot create a pull
request that prints these secrets out. Be careful with interactions with these
secrets in pull requests that you accept and merge.

1. Make login credentials ephemeral.
    * ![Android](/images/cd/android.png) On Android:
        * Remove the `json_key_file` field from `Appfile` and store the string
          content of the JSON in your CI system's encrypted variable. Use the
          `json_key_data` argument in `upload_to_play_store` to read the
          environment variable directly in your `Fastfile`.
        * Serialize your upload key (for example, using base64) and save it as
          an encrypted environment variable. You can deserialize it on your CI
          system during the install phase with
          ```bash
          echo "$PLAY_STORE_UPLOAD_KEY" | base64 --decode > /home/cirrus/[directory # and filename specified in your gradle].keystore
          ```
    * ![iOS](/images/cd/ios.png) On iOS:
        * Move the local environment variable `FASTLANE_PASSWORD` to use
          encrypted environment variables on the CI system.
        * The CI system needs access to your distribution certificate.
          fastlane's [Match][] system is
          recommended to synchronize your certificates across machines.

2. It's recommended to use a Gemfile instead of using an indeterministic
   `gem install fastlane` on the CI system each time to ensure the fastlane
   dependencies are stable and reproducible between local and cloud machines.
   However, this step is optional.
    * In both your `[project]/android` and `[project]/ios` folders, create a
      `Gemfile` containing the following content:
        ```
        source "https://rubygems.org"

        gem "fastlane"
        ```
    * In both directories, run `bundle update` and check both `Gemfile` and
      `Gemfile.lock` into source control.
    * When running locally, use `bundle exec fastlane` instead of `fastlane`.

3. Create the CI test script such as `.travis.yml` or `.cirrus.yml` in your
   repository root.
    * Shard your script to run on both Linux and macOS platforms.
    * Remember to specify a dependency on Xcode for macOS (for example
      `osx_image: xcode9.2`).
    * See [fastlane CI documentation][] for CI specific setup.
    * During the setup phase, depending on the platform, make sure that:
         * Bundler is available using `gem install bundler`.
         * For Android, make sure the Android SDK is available and the `ANDROID_SDK_ROOT`
           path is set.
         * Run `bundle install` in `[project]/android` or `[project]/ios`.
         * Make sure the Flutter SDK is available and set in `PATH`.
    * In the script phase of the CI task:
         * Run `flutter build appbundle` or
           `flutter build ios --release --no-codesign`,
           depending on the platform.
         * `cd android` or `cd ios`
         * `bundle exec fastlane [name of the lane]`

### Reference

See the Flutter framework repository's [Cirrus script][].

## Other services

The following are some other options available to help automate
the delivery of your application.

* [Codemagic CI/CD for Flutter][]
* [Flutter CI/CD with Bitrise][]
* [Appcircle CI/CD for Flutter][]
* [GitHub Actions- CI/CD on GitHub][]
  Get an [Example Project][]


[Apple Developer Account console]: https://developer.apple.com/account/ios/certificate/
[Cirrus]: https://cirrus-ci.org/guide/writing-tasks/#encrypted-variables
[Cirrus script]: {{site.github}}/flutter/flutter/blob/master/.cirrus.yml
[Codemagic CI/CD for Flutter]: https://blog.codemagic.io/getting-started-with-codemagic/
[Appcircle CI/CD for Flutter]: https://appcircle.io/blog/guide-to-automated-mobile-ci-cd-for-flutter-projects-with-appcircle/
[Example Project]: {{site.github}}/nabilnalakath/flutter-githubaction
[fastlane]: https://docs.fastlane.tools
[fastlane Android beta deployment guide]: https://docs.fastlane.tools/getting-started/android/beta-deployment/
[fastlane CI documentation]: https://docs.fastlane.tools/best-practices/continuous-integration
[fastlane iOS beta deployment guide]: https://docs.fastlane.tools/getting-started/ios/beta-deployment/
[Flutter CI/CD with Bitrise]: https://devcenter.bitrise.io/getting-started/getting-started-with-flutter-apps/
[Flutter Gallery Project]: {{site.github}}/flutter/gallery
[GitHub Actions- CI/CD on GitHub]: https://github.com/features/actions
[GitLab Continuous Integration (GitLab CI/CD)]: https://docs.gitlab.com/ee/ci/README.html#doc-nav
[Match]: https://docs.fastlane.tools/actions/match/
[official Play Store documentation]: https://support.google.com/googleplay/android-developer/answer/7384423?hl=en
[Supply setup steps]: https://docs.fastlane.tools/getting-started/android/setup/#setting-up-supply
