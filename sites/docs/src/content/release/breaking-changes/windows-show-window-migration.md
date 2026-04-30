---
title: Migrate a Windows project to ensure the window is shown
description: How to update a Windows project to ensure the window is shown
---

{% render "docs/breaking-changes.md" %}

Flutter 3.13 fixed a [bug][] that could result in the window not being shown.
Windows projects created using Flutter 3.7 or Flutter 3.10 need to be migrated
to fix this issue.

[bug]: {{site.repo.flutter}}/issues/119415

## Migration steps

Verify you are on Flutter version 3.13 or newer using `flutter --version`.
If needed, use `flutter upgrade` to update to the latest version of the
Flutter SDK.

Projects that have not modified their `windows/runner/flutter_window.cpp` file
will be migrated automatically by `flutter run` or `flutter build windows`.

Projects that have modified their `windows/runner/flutter_window.cpp` file might
need to migrate manually.

Code before migration:

```cpp
flutter_controller_->engine()->SetNextFrameCallback([&]() {
  this->Show();
});
```

Code after migration:

```cpp
flutter_controller_->engine()->SetNextFrameCallback([&]() {
  this->Show();
});

// Flutter can complete the first frame before the "show window" callback is
// registered. The following call ensures a frame is pending to ensure the
// window is shown. It is a no-op if the first frame hasn't completed yet.
flutter_controller_->ForceRedraw();
```

## Example

[PR 995][] shows the migration work for the
[Flutter Gallery][] app.

[PR 995]: {{site.repo.gallery-archive}}/pull/995/files
[Flutter Gallery]: {{site.gallery-archive}}
