---
title: Supported deployment platforms
short-title: Supported platforms
description: The platforms that Flutter supports by platform version.
---

As of Flutter {{site.appnow.flutter}},
Flutter supports the following hardware architectures and platform versions
to run Flutter code.

## Supported hardware architectures

Flutter supports running apps on the following hardware architectures.

{% assign chips = site.data.chipsets %}
{% assign yes = '<span class="material-symbols" style="color: #158477;">verified</span>' %}
{% assign no = '<span class="material-symbols" style="color: #D43324">dangerous</span>' %}
{% assign beta = '<span class="material-symbols" style="color: #13C2AD">gpp_maybe</span>' %}
{% assign na = '<span class="material-symbols" style="color:
#DADCE0">do_not_disturb_on</span>' %}

| Platform |   x86   |   x64   |  ARM32  |   ARM64   | RISC-V   |
|---|:---:|:---:|:---:|:---:|:---:|
{%- for chip in chips %}
  | {{chip.platform}} | {{chip.x86}} | {{chip.x64}} | {{chip.arm32}} | {{chip.arm64}} | {{chip.risc-v}} |
{%- endfor %}
{:.table.table-striped}

{{yes}} Supported in all channels.  
{{no}} Unsupported in all channels.  
{{beta}} Supported in Dev, Beta channels only.  
{{na}} No version exists.

## Supported operating systems

Flutter offers three tiers of support for deploying apps to target platforms.

* **Supported**: Google tests these platforms on every commit.
* **Best effort**: Google intends to support these platforms
  through coding practices. Google tests these platforms on an ad-hoc basis.
* **Unsupported**: Google doesn't test or support these platforms.

Based on these tiers, Flutter supports the following platforms.

{% assign opsys = site.data.platforms %}

<div class="table-wrapper" markdown="1">

| Platform | Supported | Best effort | Unsupported |
|---|:---:|:---:|:---:|
{%- for platform in opsys %}
  | {{platform.platform}} | {{platform.supported}} | {{platform.besteffort}} | {{platform.unsupported}} |
{%- endfor %}
{:.table.table-striped}

</div>
