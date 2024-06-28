---
title: Swift Package Manager for plugin authors
description: How to add Swift Package Manager compatibility to iOS and macOS plugins
---

Flutter is migrating to Swift Package Manager to manage iOS and macOS native
dependencies.
This is an experimental feature that may change in the future.
It is currently only available on the [`master` channel][].
Flutter will continue to support CocoaPods until further notice.

Swift Package Manager adoption will be gradual.

Flutter recommends that Flutter plugins support _both_ Swift Package Manager
and CocoaPods until further notice.

:::tip
If you find a bug in Flutter's Swift Package Manager feature,
please [open an issue][].
:::

[`master` channel]: /release/upgrade#switching-flutter-channels
[open an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml

{% include docs/swift-package-manager/how-to-enable-disable.md %}

## Adding Swift Package Manager support to an existing Flutter plugin

{% tabs %}
{% tab "Swift" %}

{% include docs/swift-package-manager/migrate-swift-plugin.md %}

{% endtab %}
{% tab "Objective-C" %}

{% include docs/swift-package-manager/migrate-objective-c-plugin.md %}

{% endtab %}
{% endtabs %}
