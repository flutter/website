---
title: "Improving Platform Channel Performance in Flutter"
description: >-
  Over the past couple of years,
  I’ve been interested in the problem of
  “How do we make communication between Flutter and
  its host platform faster and easier?"
publishDate: 2021-06-14
author: gaaclarke
image: images/10lyQIh8t-STSy1o2Yjj1tQ.webp
category: engineering
layout: blog
---

<DashImage figure src="images/10lyQIh8t-STSy1o2Yjj1tQ.webp" />

Over the past couple of years, I’ve been interested in the problem of “How do we make communication between Flutter and its host platform faster and easier?” This is a question of particular interest to Flutter plugin developers and add-to-app developers.

Communication between Flutter and the host platform is typically done with [platform channels](https://flutter.dev/docs/development/platform-integration/platform-channels), so my energy has been focused there. In late 2019, to remedy the amount of boilerplate and [stringly typed](https://wiki.c2.com/?StringlyTyped) code required to use platform channels, I designed a `codegen` package, [Pigeon](https://pub.dev/packages/pigeon), that makes platform channels type-safe, and the team continues to improve it. In spring 2020, I performed an [audit of platform channel and foreign function interface (FFI) performance](https://docs.google.com/document/d/1bD_tiN987fWEPtw7tjXHzqZVg_g9H95IS32Cm609VZ8/edit). Now, I’ve set my sights on [improving the performance](https://docs.google.com/document/d/1oNLxJr_ZqjENVhF94-PqxsGPx0qGXx-pRJxXL6LSagc/edit?usp=sharing) of platform channels. Because Pigeon is built on top of platform channels, and I plan to build a [data synchronization solution](https://flutter.dev/go/data-sync) for multiple Flutter instances on top of Pigeon, this is a good opportunity to help with the many different needs of developers and with my initiatives.

After some investigation, I was able to identify superfluous copies of the data being sent over platform channels and was able to remove them. Below you’ll find the results of that change and an overview of the work that lead to identifying and removing the copies.

## Results

After removing the superfluous copies when sending 1 MB of binary data from Flutter to the host platform with a 1 MB response, we saw an approximately [42% increase in performance on iOS](https://flutter-flutter-perf.skia.org/e/?begin=1620764044&end=1621044607&queries=sub_result%3Dplatform_channel_basic_binary_2host_1MB%26test%3Dmac_ios_platform_channels_benchmarks_ios&requestType=0). On Android, the results were a bit more nuanced. Our automated performance tests [improved approximately 15%](https://flutter-flutter-perf.skia.org/e/?begin=1621972627&end=1622677144&queries=sub_result%3Dplatform_channel_basic_binary_2host_1MB%26test%3Dlinux_platform_channels_benchmarks&requestType=0) while local testing saw an approximately [52% increase](https://github.com/flutter/engine/pull/26331#issuecomment-854071096) when migrating to the new [`BinaryCodec.INSTANCE_DIRECT`](https://github.com/flutter/engine/blob/b3ebb6dd62cefe3c30a7bd15ed73c578030140e2/shell/platform/android/io/flutter/plugin/common/BinaryCodec.java#L27) codec. This discrepancy might be because the automated performance tests are running on an older device, but the discrepancy could be an artifact of how the microbenchmarks, in particular, perform on an older device (for example, hammering the garbage collector). You can find the automated performance test’s source code at [platform_channels_benchmarks/lib/main.dart](https://github.com/flutter/flutter/blob/00bfe9061369bb6fdfe4a74fb27086b77df107bf/dev/benchmarks/platform_channels_benchmarks/lib/main.dart#L165).

For platform channels that use the `StandardMessageCodec`, I saw less of a performance gain (approximately [5% with a 14k payload](https://flutter-flutter-perf.skia.org/e/?begin=1620764044&end=1621044607&queries=sub_result%3Dplatform_channel_basic_standard_2host_large%26test%3Dmac_ios_platform_channels_benchmarks_ios&requestType=0)). I tested it with a large array of supported types to stress test the encoding and decoding. What I found was that the encoding and decoding time of `MessageCodec`s dwarfed the time spent copying the messages between platforms. Most of this encoding time is because of the cost of recursing through a data structure and using reflection to figure out what its contents are.

So, your mileage might vary depending on how you use platform channels and your device. If you want the fastest communication with platform channels, then you should use `BasicMessageChannel`s with the [`FlutterBinaryCodec`](https://github.com/flutter/engine/blob/b3ebb6dd62cefe3c30a7bd15ed73c578030140e2/shell/platform/darwin/common/framework/Headers/FlutterCodecs.h#L52) on iOS and [`BinaryCodec.INSTANCE_DIRECT`](https://github.com/flutter/engine/blob/b3ebb6dd62cefe3c30a7bd15ed73c578030140e2/shell/platform/android/io/flutter/plugin/common/BinaryCodec.java#L27) on Android, and develop your own protocol for encoding and decoding messages that doesn’t rely on reflection. (Implementing a new `MessageCodec` might be cleaner.)

If you want to play with the new faster platform channels, they’re now available on the [*master* channel](https://flutter.dev/docs/development/tools/sdk/upgrading#switching-flutter-channels).

## Copy removal in detail

If you aren’t interested in a deep dive of how I achieved these results, and the issues I had to overcome, stop reading now. If you enjoy understanding the details, read on.

The platform channels API hasn’t changed much since 2017. Because the platform channels are fundamental to engine and plugin operation, they aren’t easy to change. While I had a general idea about how platform channels operate, they are somewhat intricate. So, the first step to improving their performance was to understand exactly what they do.

The following diagram outlines the original process the framework followed when a platform channel was used to communicate with iOS from Flutter:

<DashImage figure src="images/02fUEEmUdocImYO4x.webp" />

Some takeaways from the diagram:

* The message hops from the UI thread to the platform thread and back to the UI thread. (In Flutter engine parlance, the UI thread is where Dart is executed, and the platform thread is the main thread of the host platform.)

* The message and its response use C++ as the intermediate layer for communicating between Flutter and the host platform’s target language.

* The message’s information was copied 4 times before reaching the Objective-C (Obj-C) handler (steps 3, 5, 7, 8). Steps 3 and 8 perform a translation, while steps 5 and 8 perform a copy, to transfer ownership of the data to a new memory layout. The same process is repeated in reverse for the reply.

* Steps 1, 9, and 16 are code written by developer who use Flutter.

Sending a message from Flutter to Java/Kotlin is similar, except there is a Java Native Interface (JNI) layer between C++ and the Java Virtual Machine (JVM).

After having established how platform channels work, it became clear that eliminating the copies made when transferring data between these layers (such as from C++ to Obj-C) is an obvious method to improve performance. To achieve this, the Flutter engine would have to place the data in memory in a way that is directly accessible from Java/Obj-C and has memory management semantics which are compatible with the host platform.

The platform channel messages are ultimately consumed by the `decodeMessage` method of the host platform’s `MessageCodec`. On Android, that means a [`ByteBuffer`](https://github.com/flutter/engine/blob/58459a5e342f84c755919f2ad5029b22bcddd548/shell/platform/android/io/flutter/plugin/common/MessageCodec.java#L38), and on iOS, that means [`NSData`](https://github.com/flutter/engine/blob/58459a5e342f84c755919f2ad5029b22bcddd548/shell/platform/darwin/common/framework/Headers/FlutterCodecs.h#L38). The data in C++ needs to conform to those interfaces. When approaching this problem, I discovered that the information of the message resided in C++ memory as a [`std::vector`](https://github.com/flutter/engine/blob/70ebfc3610c38c463469ffedea85578f35ccc0a0/lib/ui/window/platform_message.h#L39) inside a `PlatformMessage` object that was maintained by a [shared pointer](https://en.wikipedia.org/wiki/Smart_pointer). This means that developers couldn’t safely remove the copy when sending the data from C++ to the host platform because they didn’t have a guarantee that the data wouldn’t be mutated by C++ after it was handed over to the host platform. Furthermore, I had to be careful because the `BinaryCodec` implementations treated `encodeMessage` and `decodeMessage` as a no-op, which could lead to code using `BinaryCodec` unwittingly receiving a direct `ByteBuffer`. While it’s unlikely that someone would be surprised by changes to `MessageCodec`, rarely does anyone implement their own codec. Using `BinaryCodec`s, on the other hand, is very common.

After reading through the code, I discovered that, while the `PlatformMessage` was managed by a shared pointer, it was semantically a unique pointer. The intent was that only one client had access to it at a time (that wasn’t quite the case because momentarily multiple copies existed when passing the `PlatformMessage` between threads, but that was just for convenience and not actually intended). That meant we could migrate from shared pointers to unique pointers, allowing us to pass the data to the host platform safely.

After [migrating to unique pointers](https://github.com/flutter/engine/commit/7424400f07be684bd87633bbe2d263821181345a#diff-d5a1c9b29bed0d80dc68f228550643925a216e65173364e1ae5a03067b60160d), I had to find a way to pass ownership of the information from C++ to Obj-C. (I implemented Obj-C first, and I’ll discuss Java in more detail later.) The information was stored in an `std::vector` which has no way to release ownership of the underlying buffer. Your only options are to copy out the data, provide an adapter that has the `std::vector`, or eliminate the use of the `std::vector`.

My first attempt was to subclass `NSData` that would `std::move` the `std::vector` and read its data from there, thus eliminating the copy. This attempt didn’t work well because it turns out that `NSData` is a [class cluster](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/ClassClusters/ClassClusters.html) in [Foundation](https://developer.apple.com/documentation/foundation?language=objc). That means you can’t just subclass `NSData`. After reading through many of Apple’s documents, it appears that their recommendation is to use composition and message forwarding to make an object behave and look like an `NSData`. That would fool those who use the proxy object, except for those who call `-[NSObject isKindOfClass:]`. While that is unlikely, I couldn’t rule out the possibility. Although I think there might have been some fiddling with the Obj-C runtime that could have made the object behave the way I wanted, it was getting complicated. I instead opted to move the memory out of `std::vector` and into [our own buffer class](https://github.com/flutter/engine/commit/b0bb8eab1d2f7e58230298c28a28ddfeddedeb64#diff-d5a1c9b29bed0d80dc68f228550643925a216e65173364e1ae5a03067b60160d) that allows releasing ownership of the data. That way, I could use `-[NSData dataWithBytesNoCopy:length:]` to transfer ownership of the data to Obj-C.

Duplicating this process on Android proved a bit more difficult. On Android, platform channels conform to `ByteBuffer` that has the concept of [direct `ByteBuffer`s](https://docs.oracle.com/javase/7/docs/api/java/nio/ByteBuffer.html), which allow Java code to interface directly with memory that is laid out in C/C++ style. In a short time, I implemented the move to direct `ByteBuffer`s, but I didn’t see the improvement that I expected. I spent a lot of time learning Android profiling tools, and I eventually opted for trace statements when those failed or returned things I couldn’t believe. It turned out that scheduling the reply to the platform channel message on the UI thread from the platform thread was massively slow, and it seemed to be slow in such a way that the slowdown scaled with the payload of the message. Long story short, I was compiling the Dart VM with the incorrect compilation flags, thinking — no-optimization meant no [link-time optimization](https://en.wikipedia.org/wiki/Interprocedural_optimization), but the flag was actually for runtime optimization.

In my excitement at having found my blunder, I forgot about the ramifications of using a direct `ByteBuffer` when sending the data into Flutter client code, specifically through custom `MessageCodec`s or clients of `BinaryCodec`. Sending a direct `ByteBuffer` means you have a Java object that is communicating with C/C++ memory, so if you delete the C/C++ memory, then Java interacts with random garbage and will probably crash with an access violation from the operating system.

Following the example of iOS, I attempted to pass ownership of the C/C++ memory to Java, such that it deletes the C/C++ memory when the Java object is garbage collected. It turns out that doing this isn’t possible when the direct `ByteBuffer` is created from the JNI through [`NewDirectByteBuffer`](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/spec/functions.html#NewDirectByteBuffer). JNI provides no hook to know when a Java object is deleted. You can’t subclass `ByteBuffer` so that it calls the JNI when it’s finalized. The only hope would be to allocate the direct `ByteBuffer` from the Java API at step 5 in the preceding diagram. Direct `ByteBuffer`s that are allocated through Java don’t have this limitation. Introducing a new entry-point into Java however would have been a massive change, and anyone who has worked with JNI knows that it’s perilous.

Instead, I opted to petition the team to accept direct `ByteBuffer`s in `decodeMessage` calls. At first, I introduced a new method to `MessageCodec`*,* `bool wantsDirectByteBufferForDecoding()`, to make sure no one got a direct `ByteBuffer` unless they asked for it and knew the semantics of them (that is, when the underlying C/C++ memory is still valid). That proved to be complicated, and the worry was that developers might still subscribe and not know the semantics of the direct `ByteBuffer`s because they operate contrary to typical `ByteBuffer`s, and might have had their C memory backing deleted underneath them. Storing the encoded buffers was atypical usage on top of unlikely usage, but the team couldn’t rule it out. After many discussions and negotiations, we decided that every `MessageCodec` gets a direct `ByteBuffer` that is cleared out after `decodeMessage` is called. That way, if someone caches encoded messages, then they’ll get a deterministic and apropos error in Java if they try to use the `ByteBuffer` after the underlying C memory is cleaned up.

Giving everyone access to the performance gains of direct `ByteBuffers` worked great, but was a breaking change to `BinaryCodec` whose `encodeMessage` and `decodeMessage` implementations are no-ops, they just forward their input as their return value. To keep the same memory semantics for `BinaryCodec`, I introduced a [new instance variable](https://github.com/flutter/engine/blob/01d1ed459a313f19e2e01cf8d62331d19b907637/shell/platform/android/io/flutter/plugin/common/BinaryCodec.java#L29) that controls whether the decoded message is a direct `ByteBuffer` (new, faster code) or a standard `ByteBuffer` (old, slower code). We couldn’t create a way to give the performance speed up to all clients of `BinaryCodec`.

## Future work

Now that eliminating the copies is done, my next efforts to improve communication between Flutter and the host platform will be:

1. Implement a custom `MessageCodec` for Pigeon that doesn’t rely on reflection for faster encoding and decoding.

1. Implement FFI platform channels that allow you to call from Dart to the host platform without hopping between the UI and the platform thread.

I hope you enjoyed this deep dive into the details of this performance improvement!
