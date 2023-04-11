---
title: Support for WebAssembly (Wasm)
description: Current status of Flutter's experimental support for WebAssembly (Wasm).
short-title: Wasm
---

_WebAssembly support for Dart and Flutter is under active development,
and is currently considered experimental.
We hope to have the feature ready to try out later in 2023._

The Flutter and Dart teams are excited to add
[WebAssembly](https://webassembly.org/) as a compilation target when building
applications for the web.

Compiling Dart to this new target requires
[WebAssembly Garbage Collection (WasmGC)](https://github.com/WebAssembly/gc/tree/main/proposals/gc),
an upcoming addition to the WebAssembly standard. The Chrome team is actively
[working on WasmGC](https://chromestatus.com/feature/6062715726462976). You can
see the status of the Garbage Collection proposal—and all other Wasm 
proposals—on the [WebAssembly roadmap](https://webassembly.org/roadmap/).

In the mean time, check out Flutter's
[existing support for the web]({{site.main-url}}/multi-platform/web). We are
optimistic that existing Flutter web applications will have to do little or no
work to support WebAssembly once work is complete.

You might also be interested in this talk, from March 2023, by a member of our team:
[Flutter, Dart, and WasmGC: A new model for web applications](https://youtu.be/Nkjc9r0WDNo).

For the latest updates on this effort, 
check out [flutter.dev/wasm]({{site.main-url}}/wasm).
