---
title: "Announcing Dart null safety beta"
description: "Beginning the journey to migrate packages to a sound, safer state"
publishDate: 2020-11-19
author: mit-mit
image: images/1kr-aQjGvnhY0JDCx1CGzRg.webp
category: announcement
layout: blog
---

*Cross-posted here and on the [Dart blog](https://medium.com/dartlang).*

Today we’re announcing that **sound null safety is available in beta** for Dart and Flutter. Null safety is our latest major productivity feature, intended to [help you avoid null errors](https://dart.dev/null-safety), a class of bugs that are often hard to spot. If you’re looking for a quick summary of why we’re excited about null safety, check out this new video:

<YoutubeEmbed id="iYhOU9AuaFs" title="Null safety in Dart - Introduction" fullwidth="true"/>


With null safety graduating to beta, **it’s time to start community migration** of the thousands of packages available on [pub.dev](https://pub.dev/). We’ve migrated the Dart core libraries, the Flutter framework, and [more than 40](https://pub.dev/packages?q=&prerelease-null-safe=1) Dart and Flutter packages. With that we hope to see the community embrace null safety by migrating their packages.

<DashImage figure src="images/1kr-aQjGvnhY0JDCx1CGzRg.webp" />


With beta, we’re also starting the home stretch before shipping a stable version of the null safety feature. We hope that you’ll use the feature and let us know if parts of it can be improved, if UI messages can be made easier to understand, or if documentation can be made clearer. We’re **really looking forward to [your feedback](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here)**.

## Opting in to null safety

Before we discuss null safety migration, it’s important to repeat that (as stated in our [null safety principles](https://dart.dev/null-safety#null-safety-principles)) you’re in control of when to begin null safety adoption. Apps and packages will only run with null safety if their minimum [Dart SDK constraint](https://dart.dev/null-safety#enable-null-safety) is at least a Dart 2.12 prerelease:

```yaml
environment:
  sdk: ">=2.12.0-0 <3.0.0"
```


To experience this, try to create a small null-safe hello app (for example, using `dart create`) containing code like shown below. You can then try to run the app both before and after changing the SDK constraint and running `dart pub get`, and experience how the program behavior changes. (Make sure to use an SDK that reports 2.12 in `dart --version`.)

```plaintext
bin/hello.dart:
...
void main() {
  var hello = 'Hello Dart developers';
  if (someCondition) {
    hello = null;
  }
  print(hello);
}

Before changing the SDK constraint:
$ dart run

null

After changing the SDK constraint (and running dart pub get):
$ dart run

bin/hello.dart:6:13: Error: Null can't be assigned to a variable of type 'String' because 'String' is not nullable.

hello = null;
            ^
```


## Migrating to null safety

To migrate a package (or simple app) to null safety, follow these five steps, which are fully documented in the [migration guide](https://dart.dev/null-safety/migration-guide) on dart.dev.

### Step 1: Check if your dependencies are ready

We strongly recommend migrating code in order, with the leaves of the dependency graph being migrated first. For example, if C depends on B which depends on A, migrate A to null safety first, then B, then C. This order applies whether A, B, and C are libraries, packages, or apps.

<DashImage figure src="images/0fM8TG0L56zVeJVlG.webp" />


Why is the order important? Although you can make some progress migrating code before your dependencies migrate, you risk having to do a second migration pass if your dependencies change their APIs during their migration. If a few of your dependencies aren’t null safe, consider reaching out to the package publishers using the contact details listed for each package on pub.dev.

### Verifying that dependencies are ready

To verify whether your app or package is ready to begin migration, you can use `dart pub outdated` in null-safety mode. The example below shows that this app is ready to migrate if it upgrades its dependencies to the prerelease versions of `path`, `process`, and `pedantic` as listed in the **Resolvable** column.

<DashImage figure src="images/0zrUdYSzsjWZGr7Or.webp" />


If null safety support is available in minor new versions, you’ll see those in the **Upgradable** column. Often null safety support will be available in major new versions; in that case you’ll see the versions listed under **Resolvable** in the outdated output. To upgrade to those, edit your `pubspec.yaml` file to allow those major versions. For example, you might change
`process: ^3.0.13` to `process: ^4.0.0-nullsafety`.

You can also find packages with null safety support on pub.dev using the new **Null safety** tags on package pages (for example [collection 1.15](https://pub.dev/packages/collection/versions/1.15.0-nullsafety.5)) and a new **Advanced** **search** [null safety search option](https://pub.dev/packages?q=&prerelease-null-safe=1).

<DashImage figure src="images/1P2ufPitLRaJRAD__KUfbvg.webp" />


### Step 2: Migrate using the migration tool

If your dependencies are ready, you can proceed to migrating your app or package using the migration tool, `dart migrate`.

The migration tool is interactive, so you can review the nullability properties that the tool has inferred. If you disagree with any of the tool’s conclusions, you can add nullability hints to change the inference. Adding a few migration hints can have a huge impact on migration quality.

<DashImage figure src="images/0dPlSded52Mt6P5tY.webp" />


We’ve had a small number of Dart package authors test-drive migration using early preview builds of null safety, and their feedback has been encouraging. The migration guide has additional tips on how to use the migration tool.

### Step 3: Statically analyze your migrated code

Update your packages using `pub get` in your IDE or on the command line. Then use your IDE or the command line to perform static analysis on your Dart code:

```bash
$ dart pub get
$ dart analyze
```


Or on your Flutter code:

```bash
$ flutter pub get
$ flutter analyze
```


### Step 4: Ensure tests pass

Run your tests and make sure that they pass. You might need to update tests that expect null values, in case you changed your package code to no longer allow nulls.

### Step 5: Publish your null-safe package

When the migration is complete and tests are passing, you can publish your package as a prerelease. Here’s a brief summary of best practices:

* Increment your version number to the next major version (for example, `2.3.x` to `3.0.0`). This best practice ensures that users of your package don’t upgrade to it before they’re ready to use null safety themselves, and it gives you the freedom to refactor your APIs to best leverage null safety.

* Version and publish your package as a [prerelease version on pub.dev](https://dart.dev/tools/pub/publishing#publishing-prereleases). (For example, use `3.0.0-nullsafety.0`, not `3.0.0`.)

For full details on migration and versioning, see the [migration guide](https://dart.dev/null-safety/migration-guide).

## The benefits of sound null safety

Our previous blog posts for the technical previews of null safety [in Dart](https://medium.com/dartlang/announcing-sound-null-safety-defd2216a6f3) and [in Flutter](https://medium.com/flutter/null-safety-flutter-tech-preview-cb5c98aba187) have discussed the benefits of null safety via a number of examples. Now that null safety is nearing completion, we’re seeing several real-world examples of this benefit.

### Safer code

Just recently, we [discovered a bug](https://github.com/flutter/flutter/issues/69863) in the Flutter master channel where various `flutter` tool commands would crash on certain machine configurations with a null error: `The method '>=' was called on null`. The underlying issue was a recent pull request to add support for detecting Android Studio 4.1. That PR added code like this:

```dart
final int major = version?.major;
final int minor = version?.minor;
if (globals.platform.isMacOS) {
  /// plugin path of Android Studio changed after version 4.1.
  if (major >= 4 && minor >= 1) {
    ...
```


Can you spot the error? Because the version may be null, both major and minor may be null also. This bug may seem easy to spot here in isolation, but in practice code like this slips through all the time, even with a rigorous code review process like the one used in the Flutter repo. With null safety, static analysis [catches this issue immediately](https://dartpad.dev/0e9797be7488d8ec6c3fca92b7f2740f):

<DashImage figure src="images/0AwqXx58arqVt6PhL.webp" />


That was a pretty simple error. During our early use of null safety in code internally at Google, we’ve seen much more intricate errors be caught and then resolved via null safety. Here are a few examples:

* An internal team found that they were often checking for null values in code that null safety knew could never be null. This problem was most frequently seen in code using [protobuf](https://developers.google.com/protocol-buffers), where optional fields return a default value when unset, and never null. This caused code to incorrectly check for the default condition, by confusing default values and null values.

* The Google Pay team found bugs in their Flutter code where they would fail when trying to access Flutter `State` objects outside of the context of a `Widget`. Before null safety, those would return null and mask the error; with null safety, the sound analysis determined that those properties could never be null, and threw an analysis error.

* The Flutter team found a bug where the Flutter engine could potentially crash if null was passed to the `scene` parameter in `Window.render()`. During null safety migration, they added a hint to [mark Scene as non-nullable](https://github.com/cbracken/engine/blob/bad869e229a8a02cad6e63d12e80807b33b5c12f/lib/ui/window.dart#L1069), and were then able to easily prevent potential app crashes that null would have triggered if passed.

### Leveraging sound null safety during compilation

The soundness of Dart’s null safety has another welcome implication: it means the Dart compilers can leverage the nullability information. This can potentially make your programs smaller and faster. We don’t have a lot of real-world apps fully migrated to sound null safety yet (as we’re just now kicking off the ecosystem migration of packages that these apps depend on for soundness), but we’re seeing very encouraging results from the core framework.

We recently did a test recompilation of the [hello_world](https://github.com/flutter/flutter/blob/master/examples/hello_world/lib/main.dart) sample to measure the impact of null safety on app size.This is a minimal example that simply displays “hello world”. In [comparing](https://gist.github.com/mit-mit/64e160f9dc3bf6c69c7ef2f81384594a) the overall size of the compiled code, the uncompressed (installed on device) code size shrank by 3.5% without doing anything but recompiling with sound null safety. This was possible, despite this app being just 10 lines of code, because the code size of all included libraries shrank; for example the Flutter framework itself (`package:flutter`) shrank by 3.9%.

As for code speed, having to enforce a sound type system potentially adds overhead. However, having fewer null checks also potentially makes the code faster. Our initial analysis of benchmarks shows that performance is on par with previous releases, and that the new additional type information creates the potential for us to do new kinds of performance improvements in the future. We plan on writing more about our performance work in future blog posts.

In some cases we’ve already seen null safety lead to performance gains, typically when migration to null safety has uncovered a flaw in the code logic. For example, we found an issue in the Flutter web text layout cache. This cache was using a key that was nullable, and then some logic to use `TextAlign.start` when null. This logic caused a flaw in the cache where elements would look like they had changed even though they still had a default value. As a result, there were frequent cache misses. Adding a non-nullable `textAlign` getter helped fix the caching flaw, resulting in a **14x increase** of text rendering performance in cases where the text is cached.

## Get started today!

Beta versions of Dart and Flutter that contain null safety are ready today. If you develop with Flutter, you can switch to beta with `flutter channel beta` followed by `flutter upgrade`. Otherwise, you can get the standalone Dart SDK from the [Dart SDK archive](https://dart.dev/tools/sdk/archive#beta-channel).

If you develop packages, we encourage you to read our [migration guide](https://dart.dev/null-safety/migration-guide) and plan your migration. Please [let us know](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here) about any issues or suggestions you have.

If you’re an app developer, you may prefer to delay migration until the feature is in our stable channels. We plan on addressing the feedback from beta quickly, fixing any remaining issues. It’s hard to state a concrete timeline for when null safety will be in a stable release, but we’re thinking early next year.

Thanks for your support and feedback as we work to make Dart a more robust language, and Flutter a stronger framework!
