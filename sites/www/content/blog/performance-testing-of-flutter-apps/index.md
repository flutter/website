---
title: "Performance Testing of Flutter apps"
description: >-
  The Flutter framework does a good job being fast by default,
  but does that mean you don’t need to think about performance at all? No.
publishDate: 2019-05-09
author: filiph
image: images/1MxtHyEfdBlANwu7ZRyX2mw.webp
category: tutorial
layout: blog
---

The Flutter framework does a good job being fast by default, but does that mean you don’t need to think about performance at all? No. It is absolutely possible to write Flutter apps that are slow. On the other hand, it is also possible to make the most of the framework, and make your apps not only fast, but also efficient, consuming less CPU time and battery.

<DashImage figure src="images/1MxtHyEfdBlANwu7ZRyX2mw.webp" alt="This is what we want: a statistically significant result comparing two versions of your app on some meaningful metric. Read on to learn how to get this." caption="This is what we want: a statistically significant result comparing two versions of your app on some meaningful metric. Read on to learn how to get this." />

There are some general guidelines for performance optimization in Flutter:

* Target as few widgets as possible when updating state.

* Only update state when you must.

* Keep computationally intensive tasks outside your build methods, and — ideally — outside the main isolate.

The hard truth is that, for many questions about performance optimization, the answer is “it depends”. Is *this particular* optimization for *this particular* widget worth the effort and the maintenance cost? Does *this particular* approach in *this particular* situation make sense?

The only useful answer to these questions comes from testing and measurement. Quantify what impact each choice has on performance, and decide based on that data.

The good news is that Flutter provides great performance profiling tools, such as the [Dart DevTools](https://flutter.github.io/devtools/) (currently in preview release) that includes the Flutter Inspector, or you can use [Flutter Inspector](https://flutter.github.io/devtools/inspector) directly from Android Studio (with the Flutter plugin installed). You have Flutter Driver for exercising your app, and Profile mode for saving performance information.

The bad news is that modern smartphones are — well — smart.

## The problem with governors

Quantification of Flutter app performance is made particularly hard by iOS and Android governors. These system-level daemons tweak the speed of CPU and GPU units according to load. This is mostly a good thing, of course, because it ensures smooth performance while consuming as little battery as possible.

The downside is that you can make your app significantly *faster* by making it work *more*.

Below, you can see how adding a loop with nonsensical print statements to an app made the governor switch into higher gear, making the app much faster and its performance more predictable.

<DashImage figure src="images/0vJSgoS61dEqAK7kf.webp" alt="The problem with governors: by default, is that you can’t trust your numbers. In this boxplot, we have individual runs on the x axis (labeled by the exact time they started), and build times on the y axis. As you can see, when we introduce some completely unnecessary print statements, it makes build times go down, not up." caption="The problem with governors: by default, is that you can’t trust your numbers. In this boxplot, we have individual runs on the x axis (labeled by the exact time they started), and build times on the y axis. As you can see, when we introduce some completely unnecessary print statements, it makes build times go down, not up." />

In this experiment, worse code resulted in faster build times (above), faster rasterization times, and higher frame rate. When objectively worse code results in better performance metrics, you can’t depend on those metrics for guidance.

This is just one example of how performance benchmarking of mobile apps can be unintuitive and hard.

Below, I share some tips I gathered while working on Flutter’s Google I/O app, [Developer Quest](https://github.com/2d-inc/developer_quest).

## Basic advice

* Do not measure performance when in DEBUG mode. Only measure performance in profile mode.

* Measure on a real device, not in the iOS Simulator or Android Emulator. The software emulators are great for development, but they have very different performance characteristics from the real thing. Flutter won’t allow you to run in profile mode on a simulated device, because it doesn’t make any sense. The data you gather this way is not applicable to real world performance.

* Ideally, use the same exact physical device. Make it your dedicated perf testing device and never use it for anything else.

* Learn the Flutter [performance profiling tools](https://flutter.dev/docs/testing/ui-performance).

## CPU/GPU governors

As discussed above, modern operating systems change the frequency of each CPU and GPU at their disposal according to load and some other heuristics. (For example, touching the screen typically puts an Android phone into a much higher gear.)

On Android, you can turn these governors off. We call this process “scale locking.”

* Build a script that scale-locks your performance-test device. You can use [Skia’s recipe](https://github.com/google/skia/blob/e25b4472cdd9f09cd393c9c34651218507c9847b/infra/bots/recipe_modules/flavor/android.py) for inspiration. You can also check out [Unix CPU API](https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-system-cpu).

* You probably want something less generic and more lightweight unless you’re running a large benchmarking operation like Skia. Have a look at Developer Quest’s [shell script](https://github.com/2d-inc/developer_quest/blob/master/tool/lock_android_scaling.sh) for some pointers. For example, the following excerpt sets a CPU to the `userspace` governor (the only governor that doesn’t change CPU frequencies on its own).

```bash
#!/usr/bin/env bash

GOV="userspace"
echo "Setting CPU governor to: ${GOV}"
adb shell "echo ${GOV} > /sys/devices/system/cpu/cpu${CPU_NO}/cpufreq/scaling_governor"
ACTUAL_GOV=`adb shell "cat /sys/devices/system/cpu/cpu${CPU_NO}/cpufreq/scaling_governor"`
echo "- result: ${ACTUAL_GOV}"
```

* Your goal here is not to simulate real-world performance (no user scale-locks their device), but to have comparable performance metrics between runs.

* In the end, you need to experiment, and tailor the shell script to the device you’ll be using. It’s work, but until you do this, your performance data will lie to you.

<DashImage figure src="images/0PVigpdSw-WlNfJHI.webp" alt="An early version of Developer Quest being exercised by Flutter Driver on my desk." caption="An early version of Developer Quest being exercised by Flutter Driver on my desk." />

## Flutter Driver

Flutter Driver lets you exercise your app automatically. Read the [Performance profiling](https://flutter.dev/docs/cookbook/testing/integration/profiling) section of flutter.dev for a concrete recipe on how to use it when profiling your app.

* Don’t exercise your app manually when performance testing. Always use Flutter Driver to ensure that you’re comparing apples to apples.

* Write your Flutter Driver code so that it exercises what you really want to measure. If you’re after general app performance, try to walk through all parts of your app and do the things a user would.

* If your app has an element of chance (`Random`, network events, etc.), mock these out. The walk throughs should be as similar to each other as possible.

* If you want, add custom timeline events by using [Timeline](https://api.dartlang.org/stable/2.2.0/dart-developer/Timeline-class.html)’s `startSync()` and `finishSync()` methods. This is useful, for example, when you are interested in the performance of a particular function. Put `startSync()` at the beginning of it and `finishSync()` at its end.

* Save both the summary ([writeSummaryToFile](https://docs.flutter.io/flutter/flutter_driver/TimelineSummary/writeSummaryToFile.html)) and, more importantly, the raw timeline ([writeTimelineToFile](https://docs.flutter.io/flutter/flutter_driver/TimelineSummary/writeTimelineToFile.html)).

* For each version of your app, exercise it many times. For Developer Quest, I converged to 100 runs. (When you measure things that are noisier, like 99th percentile, you might need a lot more runs.) For POSIX-based systems, that just means running something like the following: `for i in {1..100}; do flutter drive --target=test_driver/perf.dart --profile; done`.

<DashImage figure src="images/1Y7-lpotj3tTjqJyobYyKHw.webp" alt="Using Chrome’s timeline tool to inspect Flutter’s profile output." caption="Using Chrome’s timeline tool to inspect Flutter’s profile output." />

## Timeline

Timeline is the raw output of your profile run. Flutter dumps this information in a JSON file that can be loaded into `chrome://tracing`.

* Learn to open the full timeline in Chrome’s tracing timeline. You just open `chrome://tracing` in the Chrome browser, click “Load”, and select the JSON file. You can read more in [this short tutorial](https://aras-p.info/blog/2017/01/23/Chrome-Tracing-as-Profiler-Frontend/). (There is also [Flutter’s timeline tooling](https://flutter.github.io/devtools/timeline), currently in tech preview. I haven’t used that one because the Developer Quest project started before Flutter’s timeline tooling was ready.)

* Use the WSAD keys to move around the timeline in `chrome://tracing`, and 1234 to change modes of operation.

* When first setting up your performance testing, consider running Flutter Driver with full Android systrace. This gives you more insight on what’s actually happening in the device, including CPU scaling information. Don’t measure your app with systrace fully on, though, as it makes everything slower and less predictable.

* How to run full Android systrace with Flutter Driver? First, start Android systrace with `/path/to/your/android/sdk/platform-tools/systrace/systrace.py --atrace-categories=gfx,input,view,webview,wm,am,sm,audio,video,camera,hal,app,res,dalvik,rs,bionic,power,pm,ss,database,network,adb,pdx,sched,irq,freq,idle,disk,load,workq,memreclaim,regulators,binder_driver,binder_lock`. Then, start the app with `flutter run test_driver/perf.dart --profile --trace-systrace`. Lastly, start the Flutter Driver with `flutter drive --driver=test_driver/perf_test.dart --use-existing-app=http://127.0.0.1:NNNNN/` (where NNNNN is the port that `flutter run` above gives you).

## Metrics

It’s better to look at as many metrics as possible, but I’ve found some more useful than others.

* Build times and rasterization times (the metrics that are provided by default by `TimelineSummary`) are only useful for really tight performance tests that don’t include much besides building UI.

* Don’t look at `TimelineSummary.frameCount` as a way to compute frames per second (FPS). Flutter’s profile tooling does not give you real frame rate information. `TimelineSummary` provides the `countFrames()` method, but it only counts the number of completed frame builds. A well optimized app that limits unnecessary rebuilds will have less frames per second than an unoptimized app that rebuilds often.

* I personally get the most useful data by measuring the total CPU time spent running Dart code. This counts code executed both in your build methods and outside of them. Assuming you run your profile tests on a scale-locked device, total CPU time is a good approximation of how much more/less battery your app will consume.

<DashImage figure src="images/00S0itDkQHzRjcY1N.webp" />

* The easiest way to find out the total CPU time spent running Dart code is to measure the extent of `MessageLoop:FlushTasks` events in the timeline. For Developer Quest, I have written [a Dart tool](https://github.com/2d-inc/developer_quest/blob/master/test_driver/parse_timeline.dart#L82) to extract these.

* To detect jank (i.e. skipped frames), look for extremes. For example, for the particular case of Developer Quest and the device we have for testing, it was helpful to look at 95th percentile build times. (The 90th percentile build times were too similar even when comparing code with vastly different levels of efficiency, and 99th percentile numbers tend to be noisy. Your mileage may vary.)

<DashImage figure src="images/0ewPiWp1FMME8HDnV.webp" />

* As mentioned above, exercise each version of your app several (perhaps 100) times. Then use average or percentile data with margins of error. Even better, use boxplots.

## Results

Once this is set up, you will be able to compare commits and experiments with confidence. Below, you can see an answer to a common dilemma: “is this optimization worth the maintenance overhead?”

<DashImage figure src="images/1ynM53tboJVQFcpmxRuuu4A.webp" />

I think that in *this particular* case, the answer is yes. With only a few more lines of code, each automated walkthrough of our app takes, on average, 12% less CPU time.

But—and that is the main message of this article—another optimization’s measurements might show something very different. It is tempting, but wrong, to try to extrapolate a performance measurement too broadly.

In other words: “it depends”. And we should embrace that sentence.
