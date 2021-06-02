---
title: Continuous delivery with Flutter
description: How to automate continuous building and releasing of your Flutter app.
---

Follow continuous delivery best practices with Flutter to make sure your
application is delivered to your beta testers and validated on a frequent basis
without resorting to manual workflows.


## CI/CD Options

There are a number of continuous integration (CI) and continuous delivery (CD)
options available to help automate the delivery of your application.

### All-in-one options with built-in Flutter functionality
* [Codemagic][]
* [Bitrise][]
* [Appcircle][]

### Integrating fastlane with existing workflows

You can use fastlane with the following tooling:

* [GitHub Actions][]
    * Example: Flutter Gallery's [Github Actions workflows][]
    * Example: [Github Action in Flutter Project][]
* [Cirrus][]
* [Travis][]
* [GitLab][]

This guide shows how to set up fastlane and then integrate it with 
your existing testing and continuous integration (CI) workflows. 
For more information, see "Integrating fastlane with existing workflow".

## fastlane

[fastlane][] is an open-source tool suite to automate releases and deployments 
for your app.

### Local setup

It's recommended that you test the build and deployment process locally before
migrating to a cloud-based system. You could also choose to perform continuous
delivery from a local machine.

1. Install fastlane `gem install fastlane` or `brew install fastlane`.
Visit the [fastlane docs][fastlane] for more info.
1. Create an environment variable named `FLUTTER_ROOT`,
    and set it to the root directory of your Flutter SDK.
    (This is required for the scripts that deploy for iOS.)
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
    * ![Android](/images/cd/android.png) Follow the [Android app signing steps][].
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

Continuous Integration (CI) systems generally support encrypted environment 
variables to store private data.

**Take precaution not to re-echo those variable values back onto the console in
your test scripts**. Those variables are also not available in pull requests
until they're merged to ensure that malicious actors cannot create a pull
request that prints these secrets out. Be careful with interactions with these
secrets in pull requests that you accept and merge.

1. Make login credentials ephemeral.
    * ![Android](/images/cd/android.png) On Android:
        * Remove the `json_key_file` field from `Appfile` and store the string
          content of the JSON in your CI system's encrypted variable. 
          Read the environment variable directly in your `Fastfile`.
          ```
          upload_to_play_store(
            ...
            json_key_data: ENV['<variable name>']
          )
          ```
        * Serialize your upload key (for example, using base64) and save it as
          an encrypted environment variable. You can deserialize it on your CI
          system during the install phase with
          ```bash
          echo "$PLAY_STORE_UPLOAD_KEY" | base64 --decode > [path to your upload keystore]
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
    * See [fastlane CI documentation][] for CI specific setup.
    * Shard your script to run on both Linux and macOS platforms.
    * During the setup phase of the CI task, do the following:
         * Ensure Bundler is available using `gem install bundler`.
         * Run `bundle install` in `[project]/android` or `[project]/ios`.
         * Make sure the Flutter SDK is available and set in `PATH`.
         * For Android, ensure the Android SDK is available and the `ANDROID_SDK_ROOT`
           path is set.
         * For iOS, you may have to specify a dependency on Xcode (for example
           `osx_image: xcode9.2`).
    * In the script phase of the CI task:
         * Run `flutter build appbundle` or
           `flutter build ios --release --no-codesign`,
           depending on the platform.
         * `cd android` or `cd ios`
         * `bundle exec fastlane [name of the lane]`


[Android app signing steps]: https://flutter.dev/docs/deployment/android#signing-the-app
[Appcircle]: https://appcircle.io/blog/guide-to-automated-mobile-ci-cd-for-flutter-projects-with-appcircle/
[Apple Developer Account console]: https://developer.apple.com/account/ios/certificate/
[Bitrise]: https://devcenter.bitrise.io/getting-started/getting-started-with-flutter-apps/
[CI Options and Examples]: #reference-and-examples
[Cirrus]: https://cirrus-ci.org
[Cirrus script]: {{site.github}}/flutter/flutter/blob/master/.cirrus.yml
[Codemagic]: https://blog.codemagic.io/getting-started-with-codemagic/
[fastlane]: https://docs.fastlane.tools
[fastlane Android beta deployment guide]: https://docs.fastlane.tools/getting-started/android/beta-deployment/
[fastlane CI documentation]: https://docs.fastlane.tools/best-practices/continuous-integration
[fastlane iOS beta deployment guide]: https://docs.fastlane.tools/getting-started/ios/beta-deployment/
[Flutter Gallery Project]: {{site.github}}/flutter/gallery
[Github Action in Flutter Project]: {{site.github}}/nabilnalakath/flutter-githubaction
[GitHub Actions]: https://github.com/features/actions
[Github Actions workflows]: {{site.github}}/flutter/gallery/tree/master/.github/workflows
[GitLab]: https://docs.gitlab.com/ee/ci/README.html#doc-nav
[Match]: https://docs.fastlane.tools/actions/match/
[Supply setup steps]: https://docs.fastlane.tools/getting-started/android/setup/#setting-up-supply
[Travis]: https://travis-ci.org/
