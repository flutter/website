---
layout: page
title: Tab Testing
permalink: /tabs/
---

This is a tab testing page; let's give js tabs shot:

## Thar be Tab here

Tabs below

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-sdk-install-windows">Windows</li>
    <li class="tab-link" data-tab="tab-sdk-install-linux">Linux</li>
    <li class="tab-link" data-tab="tab-sdk-install-mac">Mac</li>
</ul>

<div id="tab-sdk-install-windows" class="tabs__content current" markdown="1">
This is where Windows install instructions live
</div>

<div id="tab-sdk-install-linux" class="tabs__content" markdown="1">
This is where Linux install instructions live
</div>

<div id="tab-sdk-install-mac" class="tabs__content" markdown="1">
This is where Mac install instructions live
</div>

End of tabs


## Which JSON serialization method is right for me?

This article covers two general strategies for working with JSON:

* Manual serialization and deserialization
* Automated serialization and deserialization via code generation

Different projects come with different complexities and use cases. For smaller
proof-of-concept projects or quick prototypes, using code generators might be
overkill. For apps with several JSON models with more complexity, doing
serialization by hand can quickly become tedious, repetitive and lend itself to
lots of small errors.
