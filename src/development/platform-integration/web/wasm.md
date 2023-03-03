---
title: Support for WebAssembly (Wasm)
description: Current status of Flutter's experimental support for WebAssembly (Wasm).
short-title: Wasm
---

The Flutter and Dart teams are excited to add
[WebAssembly](https://webassembly.org/) as a compilation target when building
applications for the web.

Compiling Dart to this new target requires
[WebAssembly Garbage Collection (WasmGC)](https://github.com/WebAssembly/gc/tree/main/proposals/gc),
an upcoming addition to the WebAssembly standard.

Chrome is actively
[working on WasmGC](https://chromestatus.com/feature/6062715726462976). We hope
to have the feature ready to try out later in 2023.
