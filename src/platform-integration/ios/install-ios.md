---
title: Add iOS tooling for Flutter
description: Configure your system to develop Flutter mobile apps on iOS.
short-title: Add iOS to Flutter SDK install
---

## Prerequisites


## Add iOS to your Flutter configuration

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="add-ios" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="macos-tab" href="#macos" role="tab" aria-controls="macos" aria-selected="true">Add to macOS install</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="web-tab" href="#web" role="tab" aria-controls="web" aria-selected="false">Add to Web install</a>
    </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="macos" role="tabpanel" aria-labelledby="macos-tab" markdown="1">

{% include docs/install/compiler/xcode.md target='mobile-ios' os='macOS' -%}

{% include docs/install/flutter-doctor.md target='mobile-ios' os='macOS'
compiler='Xcode' -%}

</div>

<div class="tab-pane" id="web" role="tabpanel" aria-labelledby="web-tab" markdown="1">

</div>
</div>
{% comment %} End: Tab panes. {% endcomment -%}
