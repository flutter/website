---
title: Writing custom platform-specific code
shortTitle: Platform-specific code
description: Learn how about the options to call platform specific code in your app.
---

## Overview

You have a number of options to use platform-specific code 
in your Dart and Flutter apps from low level options that 
require a deep knowledge of Dart and the host language to
high level options that allow you to use a high level API 
to abstract some of the native bits away. They are:

* Direct native interop using FFI or JNI

This method involves an additional step to generate code
bindings from the host platform language into Dart. 

* Self-managed platform channels

This method involves using a plugin that hosts native code
which is executed asynchronously through message passing 
from Dart to iOS/Android and back.

* Type-safe platform channels via Pigeon

With regular method channels, one must manage type safety 
and object serialization on their own. With Pigeon, the 
message contents are managed as well as giving the developer
a level of control over the generated Dart API. It is best
seen as a superset of regular platform channels. 

* Or some combination of the above.


## Which should I use?

There are a lot of considerations that may determine which to 
use including familiarity with the language the native OS is
written in, comfort with low-level considerations like memory 
management, and the breadth of the underlying API surface you 
would like to implement.

*I need to access a few native-code functions.*

Use `ffi/jnigen`. Making a discrete plugin for a single function
on a single class would be overkill.

*I need to implement the same interface on iOS and Android.*

Use `pigeon`. 

*I need to re-implement a full native API in Dart.*

Consider `pigeon` augmented by `ffi/jnigen`.
