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
* [CircleCI][]
    * [Building and deploying Flutter apps with Fastlane][]

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
    * ![Android]({{site.url}}/assets/images/docs/cd/android.png) `flutter build appbundle`; and
    * ![iOS]({{site.url}}/assets/images/docs/cd/ios.png) `flutter build ipa`.
1. Initialize the fastlane projects for each platform.
    * ![Android]({{site.url}}/assets/images/docs/cd/android.png) In your `[project]/android`
    directory, run `fastlane init`.
    * ![iOS]({{site.url}}/assets/images/docs/cd/ios.png) In your `[project]/ios` directory,
    run `fastlane init`.
1. Edit the `Appfile`s to ensure they have adequate metadata for your app.
    * ![Android]({{site.url}}/assets/images/docs/cd/android.png) Check that `package_name` in
    `[project]/android/fastlane/Appfile` matches your package name in AndroidManifest.xml.
    * ![iOS]({{site.url}}/assets/images/docs/cd/ios.png) Check that `app_identifier` in
    `[project]/ios/fastlane/Appfile` also matches Info.plist's bundle identifier. Fill in
    `apple_id`, `itc_team_id`, `team_id` with your respective account info.
1. Set up your local login credentials for the stores.
    * ![Android]({{site.url}}/assets/images/docs/cd/android.png) Follow the [Supply setup steps][]
    and ensure that `fastlane supply init` successfully syncs data from your
    Play Store console. _Treat the .json file like your password and do not check
    it into any public source control repositories._
    * ![iOS]({{site.url}}/assets/images/docs/cd/ios.png) Your iTunes Connect username is already
    in your `Appfile`'s `apple_id` field. Set the `FASTLANE_PASSWORD` shell
    environment variable with your iTunes Connect password. Otherwise, you'll be
    prompted when uploading to iTunes/TestFlight.
1. Set up code signing.
    * ![Android]({{site.url}}/assets/images/docs/cd/android.png) Follow the [Android app signing steps][].
    * ![iOS]({{site.url}}/assets/images/docs/cd/ios.png) On iOS, create and sign using a
      distribution certificate instead of a development certificate when you're
      ready to test and deploy using TestFlight or App Store.
        * Create and download a distribution certificate in your
          [Apple Developer Account console][].
        * `open [project]/ios/Runner.xcworkspace/` and select the distribution
          certificate in your target's settings pane.
1. Create a `Fastfile` script for each platform.
    * ![Android]({{site.url}}/assets/images/docs/cd/android.png) On Android, follow the
      [fastlane Android beta deployment guide][].
      Your edit could be as simple as adding a `lane` that calls
      `upload_to_play_store`.
      Set the `aab` argument to `../build/app/outputs/bundle/release/app-release.aab`
      to use the app bundle `flutter build` already built.
    * ![iOS]({{site.url}}/assets/images/docs/cd/ios.png) On iOS, follow the
      [fastlane iOS beta deployment guide][].
      You can specify the archive path to avoid rebuilding the project. For example:
      
      ```ruby
      build_app(
        skip_build_archive: true,
        archive_path: "../build/ios/archive/Runner.xcarchive",
      )
      upload_to_testflight
      ```

You're now ready to perform deployments locally or migrate the deployment
process to a continuous integration (CI) system.

### Running deployment locally

1. Build the release mode app.
    * ![Android]({{site.url}}/assets/images/docs/cd/android.png) `flutter build appbundle`.
    * ![iOS]({{site.url}}/assets/images/docs/cd/ios.png) `flutter build ipa`.
1. Run the Fastfile script on each platform.
    * ![Android]({{site.url}}/assets/images/docs/cd/android.png) `cd android` then
    `fastlane [name of the lane you created]`.
    * ![iOS]({{site.url}}/assets/images/docs/cd/ios.png) `cd ios` then
    `fastlane [name of the lane you created]`.

### Cloud build and deploy setup

First, follow the local setup section described in 'Local setup' to make sure
the process works before migrating onto a cloud system like Travis.

The main thing to consider is that since cloud instances are ephemeral and
untrusted, you won't be leaving your credentials like your Play Store service
account JSON or your iTunes distribution certificate on the server.

Continuous Integration (CI) systems generally support encrypted environment 
variables to store private data. You can pass these environment variables 
using `--dart-define MY_VAR=MY_VALUE` while building the app.

**Take precaution not to re-echo those variable values back onto the console in
your test scripts**. Those variables are also not available in pull requests
until they're merged to ensure that malicious actors cannot create a pull
request that prints these secrets out. Be careful with interactions with these
secrets in pull requests that you accept and merge.

1. Make login credentials ephemeral.
    * ![Android]({{site.url}}/assets/images/docs/cd/android.png) On Android:
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
    * ![iOS]({{site.url}}/assets/images/docs/cd/ios.png) On iOS:
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

## Xcode Cloud

[Xcode Cloud][] is a continuous integration and delivery service for building,
testing, and distributing apps and frameworks for Apple platforms.

### Requirements

* Xcode Version 13.4.1 or higher.
* Be enrolled in the [Apple Developer Program][].

### Custom build script

Xcode Cloud recognizes three different [custom build scripts][] that can be
used to perform additional tasks at a designated time.

{{site.alert.note}}
The temporary build environment that Xcode Cloud uses includes tools that are
part of macOS and Xcode — for example, Python — and additionally Homebrew to
support installing third-party dependencies and tools.
{{site.alert.end}}

#### Post-clone script

Leverage the `post-clone` script that runs after Xcode Cloud
clones your Git repository using the following instructions:

1. Navigate to the `ios` folder in your project root.

2. Create a new folder named `ci_scripts`. 

3. Create a file named `ci_post_clone.sh` in the `ci_scripts` folder.
    * Add a shebang line at the top of the script.
      ```sh
      #!/bin/sh
      ```

4. This file should be added to your git repository and marked as executable.
    ```terminal
    $ git add --chmod=+x ios/ci_scripts/ci_post_clone.sh
    ```

#### Working Directory

Xcode Cloud includes a set of [predefined environment variables][], such as
`$CI_WORKSPACE` which is the locaiton of your cloned repository.

The working directory for Xcode Cloud's custom build scripts is the `ci_scripts/`
folder, hence you need to navigate to the root of your cloned project by adding
the following command to your `ci_post_clone` script below the shebang line.

```sh
cd $CI_WORKSPACE
```

#### Install Flutter

The Flutter SDK must be installed manually, [Download Flutter via Git][] by
adding the commands below to your `ci_post_clone` script:

```sh
git clone https://github.com/flutter/flutter.git -b stable $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"
```

#### Install CocoaPods

CocoaPods can be installed by adding the following to your `ci_post_clone` script:

```sh
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates
brew install cocoapods
```

#### Complete Script

```sh
#!/bin/sh

# by default, the execution directory of this script is the ci_scripts directory.
# CI_WORKSPACE is the directory of your cloned repo.
cd $CI_WORKSPACE # change working directory to the root of your cloned repo.

# Install Flutter using git.
git clone https://github.com/flutter/flutter.git -b stable $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios

# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods

# Install CocoaPods dependencies".
cd ios && pod install # run `pod install` in the `ios` directory.

exit 0
```

### Workflow Configuration

A [Xcode Cloud workflow][] defines the steps performed in the CI/CD process
when your workflow is triggered.

{{site.alert.note}}
This requires that your project is already initialized with Git and linked to a
remote repository.
{{site.alert.end}}

To create a new workflow in Xcode:

1. Choose Product > Xcode Cloud > Create Workflow to open the Create Workflow
    sheet.

2. Select the product (app) that the workflow should be attached to, then click
   the Next button.

3. The next sheet displays an overview of the default workflow provided by Xcode,
    and can be customized by clicking the **Edit Workflow** button.

#### Branch Changes

By default Xcode suggests the Branch Changes condition that starts a new build
for every change to your Git repository’s default branch.

For your app's iOS variant, it's reasonable that you would want Xcode Cloud to
trigger your workflow after you've made changes to your flutter packages, or
modified either the Dart or iOS source files within the `lib\` and `ios\`
directories.

This can be achieved by using the following Files and Folders conditions:

![Xcode Workflow Branch Changes]({{site.url}}/assets/images/docs/releaseguide/xcode_workflow_branch_changes.png){:width="100%"}

### Next Build Number

Xcode Cloud defaults the build number for new workflows to `1` and increments
it per successful build. If you're using an existing app with a higher build
number, you'll need to configure Xcode Cloud to use the correct build number
for it's builds by simply specifying the `Next Build Number` in your iteration.

Check out [Setting the next build number for Xcode Cloud builds][] for more
information.

[Android app signing steps]: {{site.url}}/deployment/android#signing-the-app
[Appcircle]: https://appcircle.io/blog/guide-to-automated-mobile-ci-cd-for-flutter-projects-with-appcircle/
[Apple Developer Account console]: {{site.apple-dev}}/account/ios/certificate/
[Bitrise]: https://devcenter.bitrise.io/getting-started/getting-started-with-flutter-apps/
[CI Options and Examples]: #reference-and-examples
[Cirrus]: https://cirrus-ci.org
[Cirrus script]: {{site.repo.flutter}}/blob/master/.cirrus.yml
[Codemagic]: https://blog.codemagic.io/getting-started-with-codemagic/
[fastlane]: https://docs.fastlane.tools
[fastlane Android beta deployment guide]: https://docs.fastlane.tools/getting-started/android/beta-deployment/
[fastlane CI documentation]: https://docs.fastlane.tools/best-practices/continuous-integration
[fastlane iOS beta deployment guide]: https://docs.fastlane.tools/getting-started/ios/beta-deployment/
[Flutter Gallery Project]: {{site.repo.gallery}}
[Github Action in Flutter Project]: {{site.github}}/nabilnalakath/flutter-githubaction
[GitHub Actions]: {{site.github}}/features/actions
[Github Actions workflows]: {{site.repo.gallery}}/tree/main/.github/workflows
[GitLab]: https://docs.gitlab.com/ee/ci/README.html#doc-nav
[CircleCI]: https://circleci.com
[Building and deploying Flutter apps with Fastlane]: https://circleci.com/blog/deploy-flutter-android
[Match]: https://docs.fastlane.tools/actions/match/
[Supply setup steps]: https://docs.fastlane.tools/getting-started/android/setup/#setting-up-supply
[Travis]: https://travis-ci.org/
[Apple Developer Program]: https://developer.apple.com/programs
[Xcode Cloud]: https://developer.apple.com/xcode-cloud
[Xcode Cloud workflow]: https://developer.apple.com/documentation/xcode/xcode-cloud-workflow-reference
[Download Flutter via Git]: {{site.url}}/get-started/install/macos#downloading-straight-from-github-instead-of-using-an-archive
[custom build scripts]: https://developer.apple.com/documentation/xcode/writing-custom-build-scripts
[predefined environment variables]: https://developer.apple.com/documentation/xcode/environment-variable-reference
[Setting the next build number for Xcode Cloud builds]: https://developer.apple.com/documentation/xcode/setting-the-next-build-number-for-xcode-cloud-builds#Set-the-next-build-number-to-a-custom-value