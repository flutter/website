---
title: "Dart sound null safety: technical preview 2"
description: "Announcing null-safe support for the Flutter framework"
publishDate: 2020-10-22
author: mit-mit
image: images/0FE-q5RdXwPgtRVE5.webp
category: announcements
layout: blog
---

Dart serves a special role in Flutter, powering developer features such as hot reload, and enabling multi-platform apps for mobile, desktop, and web via Dart’s flexible compiler technology. We strive to make the Dart language the most productive for Flutter app developers; for example, we added [UI-as-code language constructs](https://medium.com/dartlang/announcing-dart-2-3-optimized-for-building-user-interfaces-e84919ca1dff) to optimize the Dart syntax for coding Flutter widget trees.

In June we offered a [first tech preview](https://medium.com/dartlang/announcing-sound-null-safety-defd2216a6f3) of null safety for Dart. Today is another major milestone, which we’ve [looked forward to](https://medium.com/dartlang/announcing-dart-2-10-350823952bd5) for a while: We’re announcing a second tech preview of **sound null safety**, including support for the Flutter framework.

Null safety is a major new productivity feature that helps you avoid null exceptions, a class of bugs that are often hard to spot. As an added bonus, this feature also enables a range of performance improvements. We’re really looking forward to your feedback.

## Why null safety?

Dart is a type-safe language. This means that when you get a variable of some type, the compiler can guarantee that it is of that type. But type safety by itself doesn’t guarantee that the variable is not null.

Null errors are very common. A search on GitHub leads to thousands of issues caused by unexpected nulls in Dart code, and even more thousands of commits trying to fix those issues. Try to see if you can spot the nullability problems in the following Flutter app, imagining that `Config` and `WeatherService` are backend services used by the app:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get data from services. Note: in a real application,
    // these would be async calls, but we're using sync calls
    // for simplicity.
    final localizedAppName = Config.getAppName();
    final temperatures = WeatherService.getTemperatures();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(localizedAppName)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Temperature next 3 days:'),
              for (final t in temperatures) 
                  Text(t.round().toString()),
            ],
          ),
        ),
      ),
    );
  }
}
class Config {
  static String getAppName() { ... }
}
class WeatherService {
  static List<double> getTemperatures() { ...}
}
```

This app will certainly fail if `getAppName()` returns a null; in that case we’ll pass a null to the `Text` widget used in the title of `AppBar`.

But there are more subtle cases to consider: `getTemperatures()` could also return null. In that case the for-loop will fail. Or `getTemperatures()` could return a list as expected, but that list might contain null values, in which case we’ll call `round()` on null, and the app will fail.

The null safety feature makes these problems go away by [validating your code](https://nullsafety.dartpad.dev/28f1db5ef4401d9e063375e5c58f0f86) as you’re typing:

<DashImage figure src="images/0FE-q5RdXwPgtRVE5.webp" alt="With null safety, Dart finds potential null errors in your code." caption="With null safety, Dart finds potential null errors in your code." />


With null safety, you can reason about your code with more confidence. No more pesky runtime null dereferencing errors in deployed apps. Instead, you get static errors as you code.

## Null safety principles

Dart null safety support is based on the following three core design principles:

1. **Non-nullable by default**. Unless you explicitly tell Dart that a variable can be null, it will be considered non-nullable. We chose this as the default because we found that non-null was by far the most common choice in APIs.

1. **Incrementally adoptable**. There’s a lot of Dart code out there. It will be possible to migrate to null safety at a time when you choose to, and then incrementally, part by part. It will be possible to have null-safe and non-null-safe code in the same project. We’ll also provide tools to help you with the migration.

1. **Fully sound**. Dart’s null safety is *sound*. This means that we can trust the type system: if it determines that something isn’t null, then it can *never* be null. This enables compiler optimizations. Once you migrate your whole project and your dependencies to null safety, you reap the full benefits of soundness — not only fewer bugs, but smaller binaries and faster execution.

Let’s review these design principles in more detail.

## 1. Non-nullable by default

The core syntax is simple enough. Here are some non-nullable variables, declared in different ways. Remember, non-nullable is the default, so these declarations look like they do today, but their meaning changes.

```dart
// In null-safe Dart, none of these can ever be null.
var widget = Text('Hello');
final status = GetStatus();
String m = '';
```

Dart will make sure that you never assign null to any of the above variables. If you try to do `widget = null` a thousand lines later, you’ll get a static analysis error and red squiggly lines, and your program will refuse to compile.

### Nullable variables

If you want your variable to be nullable, you can use `?`, like this:

```dart
// These are all nullable variables.
Text? t = Text('Hello');  // Can be null later.
final Status? s = getStatus();  // Maybe the function returns null.
String? n;  // Is null at first. Can be null at any later time, too.
```

You can use the `?` syntax in function parameters and return values, too:

```dart
// In function parameters.
void initialize(int? count) {
  // It's possible that count is null.
}
// In function return values.
static List<double?>? getTemperatures() {
  // Can return null instead of a List, and the list can contain nulls.
}
```

But, once again, the dream is that you’ll rarely have to use `?`. The majority of your types will be non-nullable.

### Being productive with null safety

Null safety isn’t just about safety. We also want you to be productive when using the feature, which means that the feature must be easy to use. For example, look at this code, which uses `if` to check for a null value:

```dart
void honk(int? loudness) {
  if (loudness == null) {
    // No loudness specified, notify the developer
    // with maximum loudness.
    _playSound('error.wav', volume: 11);
    return;
  }
  // Loudness is non-null, let's just clamp it to acceptable levels.
  _playSound('honk.wav', volume: loudness.clamp(0, 11));
}
```

Note how the Dart tools can detect that by the time we pass that if-statement, the `loudness` variable cannot be null. And so Dart lets us call the `clamp()` method without jumping through hoops. This convenience is enabled by something called flow analysis: the Dart analyzer goes through your code as if it was executing it, figuring out additional information about your code automatically.

Here’s another example, which shows a case where Dart can be sure that a variable is non-null because we always assign a non-null value to it:

```dart
class StatusLine extends StatelessWidget {
  final Status status;
  StatusLine({this.status: Status.failed});
  @override
  Widget build(BuildContext context) {
    // This local variable is non-nullable, but not initialized.
    String statusText;
    if (status == Status.ok) {
      statusText = 'Update succeeded';
    } else {
      statusText = 'Update failed';
    }
    // By this point, Dart knows statusText isn't null, as we've
    // assigned a value in both the if- and else-statements. Thus
    // we can pass it to the Text widget -- which doesn't accept
    // nullable Strings -- without getting an error.
    return Text(statusText);
  }
```

If you remove any of the assignments above (for example, by deleting the line `statusText = 'Update failed';`), Dart cannot guarantee that `statusText` will be non-null: you’ll get a static error and your code won’t compile. You can [give this a try in DartPad](https://nullsafety.dartpad.dev/ecc0f87fa5af5cc7ff30d8bd3e3b12e2).

## 2. Incrementally adoptable

Because null safety is such a fundamental change to our typing system, it would be extremely disruptive if we insisted on forced adoption. We want to let you decide when the time is right, so null safety is an opt-in feature: you’ll be able to use the latest Dart and Flutter releases without being forced to enable null safety before you’re ready to do so. You can even depend on packages that have already enabled null safety from an app or package that hasn’t yet.

Once you choose to adopt, we strongly recommend migrating code in order, with the leaves of the dependency graph being migrated first. For example, if C depends on B which depends on A, migrate A to null safety first, then B, then C. This order applies whether A, B, and C are libraries, packages, or apps.

Why is the order important? Although you can make some progress migrating code before your dependencies migrate, you risk having to do a second migration pass if your dependencies change their APIs during their migration. When we get to the beta release, we’ll provide tools to help you find out which of your dependencies have migrated. If you’re a package author, then to avoid the risk of breaking your APIs, wait until all of your dependencies have migrated before you publish a null-safe version.

When your dependencies are ready, you can use our migration tool. The tool works by analyzing all of your existing code. The migration tool is interactive, so you can review the nullability properties that the tool has inferred. If you disagree with any of the tool’s conclusions, you can add nullability hints to change the inference. Adding a few migration hints can have a huge impact on migration quality.

<DashImage figure src="images/0vRDfouqMsEojq6t9.webp" alt="The migration tool helps you interactively migrate your code to null safety." caption="The migration tool helps you interactively migrate your code to null safety." />


## 3. Fully sound

Once you’ve fully migrated, Dart’s null safety is **sound**. This means that Dart is 100% sure that in the above examples, the return variables, lists, and elements cannot be null. When Dart analyzes your code and determines that a variable is non-nullable, that variable is **always** non-nullable: if you inspect your running code in the debugger, you’ll see that non-nullability is retained at runtime. By contrast, some other implementations are unsound, and in many cases still need to perform runtime null checks. Dart shares ***sound* null safety** with Swift, but not very many other programming languages.

The soundness of Dart’s null safety has another welcome implication: it means your programs can be smaller and faster. Because Dart is really sure that non-nullable variables are never null, Dart can optimize. For example, the Dart ahead-of-time (AOT) compiler can produce smaller and faster native code, because it doesn’t need to add checks for nulls when it knows that a variable isn’t null.

Note that to get sound null safety, you’ll need to migrate your whole project and all of your dependencies to null safety. If part of your app or dependencies haven’t been migrated you’ll get partial null safety, which retains most of the checks but isn’t fully optimized and doesn’t guarantee that the app is fully safe.

## The null safety roadmap

When might null safety be ready for production use? Here is the current timeline:

1. **Flutter experimentation with *technical preview 2***: This is today. Because we’ve successfully migrated the core Flutter framework to null safety, you’re able to try null safety to learn the new language feature and experiment with a [small Flutter sample](https://github.com/flutter/samples/tree/master/experimental/null_safety). If you’re a package author, you may also be able to do a trial migration, if you have a small dependency set that’s already been migrated by us. You need to pass an [experiment flag](https://dart.dev/tools/experiment-flags), shouldn’t use it in production, and shouldn’t publish any migrated packages.

1. **Early package migration with *beta***: Later this year, we’ll complete performance tuning and have sufficient test coverage to give us confidence that the feature works as intended, and that backwards compatibility is solid. At that time we’ll publish a beta version of the feature, and you won’t need to pass the experiment flag. We hope to see package owners begin migration of their packages to null safety, which will give us one last round of validation that the feature is ready for a stable release.

1. **Production use with *stable***: Next, we’ll address feedback from beta, fix any remaining issues, and then publish to stable. It’s hard to state a concrete timeline for this, but we’re thinking early next year. Once the feature is stable, we hope to see lots of adoption of null safety, with null-safe apps published to stores and many null-safe packages published to pub.dev in stable versions.

## Try it now

You can start experimenting with null safety today! To get started quickly, check out this special version of [DartPad with null safety](https://nullsafety.dartpad.dev/).

If you’d like to try null safety in VS Code, Android Studio, or the terminal, check out the [Flutter null safety sample app](https://github.com/flutter/samples/tree/master/experimental/null_safety). This app contains execution instructions and two versions of a small weather app: one that doesn’t use null safety and has a few sporadic null errors in it, and one that uses null safety to ensure that these issues are handled. If you prefer experimenting with a new Flutter app, you can run `flutter create` and then follow the [experiment instructions](https://github.com/flutter/flutter/wiki/Experimenting-with-null-safety-in-Flutter) to enable null safety. Note that you will need a dev-channel Flutter SDK (version `1.24.0–3.0.pre` or later), as the current stable and beta versions of Flutter don’t support null safety.

To learn more about the feature design, read our new [Understanding null safety](https://dart.dev/null-safety/understanding-null-safety) documentation. If you prefer a short video, check out [the null safety video](https://www.youtube.com/watch?v=ZxSyZHq8gUg&feature=youtu.be&list=PLjxrf2q8roU1rBlI9vz01K2324nzIhYgp&t=322) from the [Flutter Day event](https://events.withgoogle.com/flutter-day/#content) a few months ago.

We’re very happy to bring sound null safety to Dart. Sound null safety is a distinctive feature of Dart that helps you write less error-prone code and get better performance. We hope you’ll [experiment](https://github.com/flutter/flutter/wiki/Experimenting-with-null-safety-in-Flutter) with the feature in tech preview, and [give us feedback](https://github.com/dart-lang/sdk/issues/new?title=Null%20safety%20feedback:%20[issue%20summary]&labels=NNBD&body=Describe%20the%20issue%20or%20potential%20improvement%20in%20detail%20here) through our issue tracker. Happy coding!