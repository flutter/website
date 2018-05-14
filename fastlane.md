---
layout: page
title: Continuous Delivery using Fastlane with Flutter

permalink: /fastlane-cd/
---

It's possible to follow continuous delivery best practices on top of existing
testing to make sure your application is delivered to your beta testers and
validated on a frequent basis without resorting to manual workflows.

In this example, the open-source tool suite [Fastlane](https://docs.fastlane.tools/)
is leveraged for its ability to seamlessly integrate with platform resources
like the Play Store and the App Store.

* TOC Placeholder
{:toc}

## Local setup

Follow these steps while testing the build and deployment process before
migrating to a cloud-based system or if you will ultimately perform the
continuous delivery from a local machine.

1. Install Fastlane `gem install fastlane` or `brew cask install fastlane`.
1. Create your Flutter project and when ready, make sure that your project builds via
    * ![Android](/images/fastlane-cd/android.png) `flutter build apk --release`; and
    * ![iOS](/images/fastlane-cd/ios.png) `flutter build ios --release --no-codesign`.
1. Initialize the Fastlane projects for each platform.
    * ![Android](/images/fastlane-cd/android.png) In your `[project]/android`
    directory, run `fastlane init`.
    * ![iOS](/images/fastlane-cd/ios.png) In your `[project]/ios` directory,
    run `fastlane init`.
1. Edit the `Appfile`s to ensure it has adequate matadata for your app.
    * ![Android](/images/fastlane-cd/android.png) Ensure `package_name` in
    `[project]/android/Appfile` matches your package in pubspec.yaml.
    * ![iOS](/images/fastlane-cd/ios.png) Ensure `app_identifier` in
    `[project]/ios/Appfile` also matches. Also fill in `apple_id`, `itc_team_id`,
    `team_id` with your respective account info.
1. Set up your local login credentials for the stores.
    * ![Android](/images/fastlane-cd/android.png) Follow the [Supply setup steps](https://docs.fastlane.tools/getting-started/android/setup/#setting-up-supply)
    and ensure that `fastlane supply init` can successfully sync data from your
    Play Store console. _Treat the .json file like your password and do not check
    it into any public source control repositories._
    * ![iOS](/images/fastlane-cd/ios.png) Your iTunes Connect username is already
    in your `Appfile`'s `apple_id` field. You can set `FASTLANE_PASSWORD` shell
    environment variable with your iTunes Connect password. Otherwise, you'll be
    prompted whe uploading to iTunes/TestFlight.
1. Set up code signing.
    * ![Android](/images/fastlane-cd/android.png) On Android, there are 2 signing
    keys. The 'deployment key' is used to sign the .apk end-users ultimately
    download. An 'upload key' is used to authenticate the .apk uploaded by
    developers onto the Play Store and is re-signed over with the deployment key
    once in the Play Store.
        * It's highly recommended to use the automatic cloud managed signing for
        the deployment key. See details at from the [official Play Store documentation](https://support.google.com/googleplay/android-developer/answer/7384423?hl=en).
        * Follow the [key generation steps](https://developer.android.com/studio/publish/app-signing#sign-apk)
        to create your upload key.
        * Configure gradle to use your upload key when building your app in
        release mode by editing `android.buildTypes.release` in
        `[project]/android/app/build.gradle`.
    * ![iOS](/images/fastlane-cd/ios.png) On iOS, you need to create and sign
    using a distribution certificate instead of a development certification when
    you're ready to test and deploy using TestFlight or App Store.
        * Create and download a distribution certificate in your [Apple Developer Account console](https://developer.apple.com/account/ios/certificate/).
        * `open [project]/ios/Runner.xcworkspace/` and select the distribution
        certificate in your target's settings pane.
1. Create a `Fastfile` script for each platform.
    * ![Android](/images/fastlane-cd/android.png) On Android, follow the
    [Fastlane Android beta deployment guide](https://docs.fastlane.tools/getting-started/android/beta-deployment/).
    It could be as simple as a `lane` that calls `upload_to_play_store`. The
    `apk` argument can be set to `../build/app/outputs/apk/release/app-release.apk`
    to use the apk `flutter build` already built.
    * ![iOS](/images/fastlane-cd/ios.png) On iOS, follow the [Fastlane iOS beta deployment guide](https://docs.fastlane.tools/getting-started/ios/beta-deployment/).
    It could be as simple as a `lane` that calls `build_ios_app` with
    `export_method: 'app-store'` and `upload_to_testflight`. An extra build is
    used after `flutter build` on iOS since `flutter build` builds and .app and
    doesn't archive .ipas for release.

You're now ready to perform deployments locally or migrate the deployment
process to a CI system.

## Running deployment locally

1. Build the release mode app.
    * ![Android](/images/fastlane-cd/android.png) `flutter build apk --release`.
    * ![iOS](/images/fastlane-cd/ios.png) `flutter build ios --release --no-codesign`.
    No need to sign now since we'll archive using Fastlane which will sign at that point.
1. Run the Fastfile script on each platform.
    * ![Android](/images/fastlane-cd/android.png) `cd android` then
    `fastlane [name of the lane you created]`.
    * ![iOS](/images/fastlane-cd/ios.png) `cd ios` then
    `fastlane [name of the lane you created]`.

## Cloud build and deploy setup

Follow the local setup section above first to make sure the process works before
migrating onto a cloud system like Travis.

The main aspects to consider is that since cloud instances are ephemeral and
untrusted, you won't be leaving your credentials like your Play Store service
account JSON or your iTunes distribution certificate on the server.

Both [Travis](https://docs.travis-ci.com/user/environment-variables/#Encrypting-environment-variables)
and [Cirrus](https://cirrus-ci.org/guide/writing-tasks/#encrypted-variables)
(randomly chosen examples, you can use any CI systems you wish) support the
concept of encrypted environment variables to store private data.

**Take precaution to not re-echo those variable values back onto the console in
your test scripts**. Those variables are also not available in pull requests
until they're merged to ensure that malicious actors cannot create a pull
request that prints these secrets out. Be careful with interactions with these
secrets in pull requests you accept and merge.

1. Make login credentials ephemeral.
    * ![Android](/images/fastlane-cd/android.png) On Android:
        * Remove the `json_key_file` field from `Appfile` and store the string
        content of the JSON in your CI system's encrypted variable. Use the
        `json_key_data` argument in `upload_to_play_store` to read the
        environment variable directly in your `Fastfile`.
        * Serialize your upload key such as with base64 and save as a encrypted
        environment variable. You can deserialize it on your CI system during the
        install phase with
        ```bash
        echo "$PLAY_STORE_UPLOAD_KEY" | base64 --decode > /home/travis/[directory and filename specified in your gradle].keystore
        ```
    * ![iOS](/images/fastlane-cd/ios.png) On iOS:
        * Move the `FASTLANE_PASSWORD` variable to use encrypted environment variables.
        * The CI system needs access to your distribution certificate. Fastlane's
        [Match](https://docs.fastlane.tools/actions/match/) system is
        recommended to synchronize your certificates across machines.

2. It's recommended to use a Gemfile instead of using an indeterministic `gem
install fastlane` on the CI system each time to ensure the Fastlane
dependencies are stable and reproducible between local and cloud machines.
    * In both your `[project]/android` and `[project]/ios` folders, create a
    `Gemfile` and as content, add
      ```
      source "https://rubygems.org"

      gem "fastlane"
      ```
    * In both directories, run `bundle update` and check in both `Gemfile` and
    `Gemfile.lock` into source control.
    * When running locally, use `bundle exec fastlane` instead of `fastlane`.

3. Create the CI test script such `.travis.yml` or `.cirrus.yml` in your
repository root.
    * Shard your script to run on both Linux and OSX platforms.
    * Be sure to specify a dependency on Xcode for OSX such as with
    `osx_image: xcode9.2`.
    * See [Fastlane CI documentation](https://docs.fastlane.tools/best-practices/continuous-integration/)
    for CI specific setup.
    * During the setup phase, depending on the platform, make sure:
         * Bundler is available via `gem install bundler`.
         * For Android, make sure the Android SDK is available and `ANDROID_HOME`
         path is set.
         * Run `bundle install` in `[project]/android` or `[project]/ios`.
         * Make sure the Flutter SDK is available and in `PATH`.
    * In the script phase of the CI task:
         * Run `flutter build apk --release` or `flutter build ios --release
         --no-codesign` depending on the platform.
         * `cd android` or `cd ios`.
         * `bundle exec fastlane [name of the lane]`.

## Reference

The [Flutter Gallery in the Flutter repo](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)
uses the above for continuous deployment. It can be used as an example. The
Travis script is at https://github.com/flutter/flutter/blob/master/.travis.yml.
