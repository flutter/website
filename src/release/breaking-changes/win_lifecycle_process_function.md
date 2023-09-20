---
title: Introduction of FlutterEngine::ProcessExternalWindowMessage
description: External windows should call ProcessExternalWindowMessage to be considered for application lifecycle events
---

## Summary

When you add any external windows to your Flutter app,
you need to include them in the Window's app lifecycle logic.
To include the window, its `WndProc` function should invoke
`FlutterEngine::ProcessExternalWindowMessage`.

## Who is affected

Windows applications built against Flutter version > 3.13 that open non-Flutter windows.

## Description of change

Implementing application lifecycle on Windows involves listening for Window
messages in order to update the lifecycle state. In order for additional
non-Flutter windows to affect the lifecycle state, they must forward their
window messages to `FlutterEngine::ProcessExternalWindowMessage` from their
`WndProc` functions. This function returns an `std::optional<LRESULT>`, which
is `std::nullopt` when the message is received, but not consumed. When the
returned result has a value, the message has been consumed, and further
processing in `WndProc` should cease.

## Migration guide

The following example `WndProc` procedure invokes
`FlutterEngine::ProcessExternalWindowMessage`:

```
LRESULT Window::Messagehandler(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam) {
    std::optional<LRESULT> result = flutter_controller_->engine()->ProcessExternalWindowMessage(hwnd, msg, wparam, lparam);
    if (result.has_value()) {
        return *result;
    }
    // Original contents of WndProc...
}
```

## References

Relevant PRs:

* [Reintroduce Windows lifecycle with guard for posthumous OnWindowStateEvent](https://github.com/flutter/engine/pull/44344)
