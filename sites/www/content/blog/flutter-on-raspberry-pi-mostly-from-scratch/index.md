---
title: "Flutter on Raspberry Pi (mostly) from Scratch"
description: "This document describes an experiment in porting the Flutter engine to a target that is currently not supported. That fact that I used  a…"
publishDate: 2018-11-30
author: chinmaygarde
image: images/1K1lyX_AOOILKyv3stAtlQg.jpeg
category: tutorial
layout: blog
---

## Flutter on Raspberry Pi (mostly) from scratch

*This document describes an experiment in porting the Flutter engine to a target that is currently not supported. The fact that I used a Raspberry Pi is purely incidental. I have deliberately made no assumptions about the target. It is entirely possible that you already have a toolchain ready to use with your specific board. If so, large parts of this document can be skipped. This document also assumes that you are familiar with setting up your own toolchains and build environments.*

<DashImage figure src="images/1K1lyX_AOOILKyv3stAtlQg.jpeg" alt="Flutter on Raspberry Pi" caption="Flutter on Raspberry Pi" />


Bringing Flutter to a new platform requires porting the [Flutter Engine](https://github.com/flutter/engine) to the target, as well as implementing an embedder. The Flutter engine is inherently cross platform and can work with a variety of client rendering APIs (OpenGL, Vulkan and Software rendering). It includes the Dart runtime VM.

The engine is typically packaged as a dynamic library and consumed by thin embedders that are platform specific. It has a small C API. Engine developers guarantee that this API is backwards compatible and has a stable [ABI](https://en.wikipedia.org/wiki/Application_binary_interface) moving forward. The API consists of a [single C header](https://github.com/flutter/engine/blob/436f9707b94774d1d049c04b8cda9d81d85aa4a8/shell/platform/embedder/embedder.h) file with no platform specific dependencies.

It is the job of the embedder to set up the rendering surface, wire up input events, and provide access to Dart application snapshots. For reference, the [Flutter Desktop Embedding](https://github.com/google/flutter-desktop-embedding) project uses this approach to set up Flutter on Mac, Linux, and Windows Desktop environments.

So, to port Flutter to the Raspberry Pi, you will need the following items:

* The Flutter engine built for ARMv7.

* A Raspberry Pi specific embedder that sets up the rendering surface and wires up input events.

* A snapshot of the Flutter Dart application. You’ll be using the Flutter engine with a JIT mode VM.

### Constraints

To demonstrate all the steps necessary in porting Flutter to a new platform, some constraints were placed on the porting process:

* The Raspberry Pi is capable of running a full desktop environment with fairly heavyweight dependencies like X11. But, instead of depending on a heavyweight desktop environment (where [Flutter Desktop Embedding’s](https://github.com/chinmaygarde/flutter-desktop-embedding) embedder can be used), you will use Broadcom APIs directly. This allows booting directly to Flutter in a lightweight environment with no dependencies you don’t need.

* You won’t use existing toolchains for building any artifacts. The Raspberry Pi is a fairly popular platform with well supported toolchains, but this process follows the same steps required when porting for a more esoteric platform without good toolchain support.

* You should be able to perform all builds on a powerful workstation. Building native artifacts on the Raspberry Pi is possible, but prohibitively time consuming.

## Building the Flutter Engine

### The Toolchain

To build the Flutter engine for the Raspberry Pi, you need a toolchain capable of compiling engine code to ARMv7. The target toolchain is ***`arm-linux-gnueabihf`***. The engine developers rely on a toolchain that is very close to Tip-of-Tree of [Clang/LLVM](https://clang.llvm.org) for their development. While using a modern version of GCC is certainly possible, the engine developers are unlikely to accept patches that are GCC specific without an ongoing investment in the requisite build and test infrastructure for that compiler. So, do as the engine developers do on supported platforms, and set up a Clang/LLVM toolchain that is at Tip-of-Tree.

Preparing a Clang toolchain for ***`arm-linux-gnueabihf`*** is fairly straightforward. It involves downloading the source code as described on the [getting started page for Clang/LLVM](https://clang.llvm.org/get_started.html). It is important to not check out ***`libcxx`*** and ***`libcxxabi`*** as described in the “optional” sections of that document. These libraries will not be built for the target platform. Instead, they will install host artifacts at the location specified by the installation prefix.

Once the sources are checked out, build the toolchain with the following flags:

```shell
cmake ../llvm                                        \
    -DCMAKE_BUILD_TYPE=Release                       \
    -DCMAKE_INSTALL_PREFIX=/sdk/toolchain             \
    -DLLVM_DEFAULT_TARGET_TRIPLE=arm-linux-gnueabihf \
    -DLLVM_TARGETS_TO_BUILD=ARM
```

Once, you have the Clang/LLVM toolchain, you need Binutils built for ***`arm-linux-gnueabihf`***. The engine developers use Gold as the linker on Linux, so do the same. The Binutils source code can be downloaded from [the Git repository mentioned on the homepage for Binutils](https://www.gnu.org/software/binutils/). Configure the build with the following flags:

```shell
./configure --prefix="/sdk/toolchain" \
    --enable-gold                     \
    --enable-ld                       \
    --target=arm-linux-gnueabihf
```

You now have a toolchain capable of building for (and only for) ***arm`-linux-gnueabihf`***. If you already have a toolchain that is fairly close to Tip-of-Tree Clang that is also capable of targeting this platform, you can use that. But, this toolchain gives you a better chance of avoiding compiler specific issues due to subtle version mismatches.

### **libcxx** and libcxxabi

You can take the brand new toolchain for a spin by using it to build ***`libcxx`*** and ***`libcxxabi`***. The [Raspberry Pi Rasbian](https://www.raspberrypi.org/downloads/raspbian/) image has ***`libstdc++`*** that is rather old and not fully suitable for use by the engine. Besides, you want the engine to be self contained and not depend on a C++ library implementation on the target. You are going to use a ***`libcxx`*** and link it statically into the engine. That way, the engine has everything it needs to run with minimal dependencies on the underlying platform. Since you are building ***`libcxx`*** for use only by the engine, you can disable support for ***exceptions*** and ***RTTI***, which the engine doesn’t need.

Download the source code for ***`libcxx`*** and ***`libcxxabi`*** as [described on the “Building Libcxx” page from the LLVM team](https://libcxx.llvm.org/docs/BuildingLibcxx.html). Given the specific features of ***`libcxx`*** described above, run the following commands.

**Note**: If you want more help with any CMake variable, the following commands are extremely useful:

```shell
cmake --help-variable CMAKE_SYSROOT_COMPILE
cmake --help-variable-list
```

Build ***`libcxxabi`*** first, as ***`libcxx`*** depends on artifacts generated by the ***`libcxxabi`*** target:

```shell
cmake ../llvm/projects/libcxxabi                    \
    -DCMAKE_CROSSCOMPILING=True                     \
    -DCMAKE_SYSROOT=/sdk/sysroot                    \
    -DLIBCXX_ENABLE_SHARED=False                    \
    -DCMAKE_INSTALL_PREFIX=/sdk/toolchain           \
    -DCMAKE_BUILD_TYPE=Release                      \
    -DCMAKE_SYSTEM_NAME=Linux                       \
    -DCMAKE_SYSTEM_PROCESSOR=ARM                    \
    -DCMAKE_C_COMPILER=/sdk/toolchain/bin/clang     \
    -DCMAKE_CXX_COMPILER=/sdk/toolchain/bin/clang++ \
    -DLLVM_TARGETS_TO_BUILD=ARM                     \
    -DLIBCXXABI_ENABLE_EXCEPTIONS=False
```

Then, build ***libcxx***. Notice that it is configured for static linking:

```shell
cmake ../llvm/projects/libcxx                                    \
    -DCMAKE_CROSSCOMPILING=True                                  \
    -DCMAKE_SYSROOT=/sdk/sysroot                                 \
    -DLIBCXX_ENABLE_SHARED=False                                 \
    -DCMAKE_INSTALL_PREFIX=/sdk/toolchain                        \
    -DCMAKE_BUILD_TYPE=Release                                   \
    -DCMAKE_SYSTEM_NAME=Linux                                    \
    -DCMAKE_SYSTEM_PROCESSOR=ARM                                 \
    -DCMAKE_C_COMPILER=/sdk/toolchain/bin/clang                  \
    -DCMAKE_CXX_COMPILER=/sdk/toolchain/bin/clang++              \
    -DLLVM_TARGETS_TO_BUILD=ARM                                  \
    -DLIBCXX_ENABLE_EXCEPTIONS=False                             \
    -DLIBCXX_ENABLE_RTTI=False                                   \
    -DLIBCXX_CXX_ABI=libcxxabi                                   \
    -DLIBCXX_CXX_ABI_INCLUDE_PATHS=/sdk/toolchain/include/c++/v1 \
    -DLIBCXX_CXX_ABI_LIBRARY_PATH=/sdk/toolchain/lib             \
    -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=True
```

Once the install step is done for both libraries, look inside the path specified in the install prefix to ensure that no dynamic libraries for ***`libcxx`*** or ***`libcxxabi`*** ended up there. You want to be absolutely sure you don’t create artifacts that depend on these dynamic libraries (because they won’t actually be present on the target). If you find any, remove them.

Copy the ***`cxxabi.h`*** and ***`__cxxabi_config.h`*** headers to ***c++/v1*** in the install prefix folder. These aren’t placed there by default.

### The Sysroot

From a fresh headless Raspbian installation, ***`rsync`*** the ***`lib`***, ***`opt`***, and ***`usr`*** directories to a single directory on your host. We refer to this directory as the **`sysroot`** and use it to build artifacts on the host that link with system libraries on the target (the Raspberry Pi). Feel free to trim the contents of these directories to exclude dependencies you won’t need in the embedder itself.

To build the engine, you only need ***`libdl`***, ***`libpthread`***, ***`librt`***, ***`libm`*** and ***`libc`***, and their headers. The embedder implementation will also likely need to link against the Broadcom libraries (these are in ***`opt`***).

### The Flutter Engine

Set up your host environment for the Flutter engine using the instructions in [the contributing guide](https://github.com/flutter/engine/blob/master/CONTRIBUTING.md). Make sure you are on a Linux desktop host as you are building for a Linux target (the Raspberry Pi) but with a custom toolchain (the one you just built), and ***`sysroot`*** (the one you just pulled via ***`rsync`***).

After your build root is prepared, build using the following GN flags:

```shell
./flutter/tools/gn                      \
    --target-sysroot /sdk/sysroot       \
    --target-toolchain /sdk/toolchain   \
    --target-triple arm-linux-gnueabihf \
    --linux-cpu arm                     \
    --runtime-mode debug                \
    --embedder-for-target               \
    --no-lto                            \
    --target-os linux                   \
    --arm-float-abi hard                \
```

You’ve generated ***`libflutter_engine.so`***. Grab ***`icudtl.dat`*** and the ***`flutter_embedder.h`*** header. You need these artifacts to build the embedder in the next step.

## Building the Embedder

You may build the embedder using whatever build system you are most comfortable with. To accompany this document, a sample embedder was built with the GN build system based on the [Raspberry Pi Cross Compilation SDK](https://github.com/chinmaygarde/raspberrypi_cross_compilation_sdk) (a generic build root and toolchain capable of cross-compiling C/C++ applications for the Raspberry Pi). This embedder implements rendering using Broadcom APIs. You can find the embedder at [this GitHub repository](https://github.com/chinmaygarde/flutter_from_scratch). It looks very similar to desktop embedder implementations but is much simpler. It could serve as an unopinionated started off point for your own implementations.

Push the build artifacts to the target Raspberry Pi device.

## Building the Flutter Application Snapshot

On the host, check out the application you want to run on the Raspberry Pi, and build the application bundle using the Flutter tools. This can be done with the following command:

```bash
flutter build bundle
```


Push this bundle to the Raspberry Pi.

## Run the Application on the Raspberry Pi

In the specific case of the Raspberry Pi Embedder, run the application using the following invocation:

```bash
flutter /path/to/flutter_assets/
```


Automate this process to your desired workflow.

**Congratulations! You’ve ported Flutter to a Raspberry Pi! Now comes the hard bit of making the port production ready.**
