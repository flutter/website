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
{% capture yes %}
 <span class="material-symbols" 
       style="color: #158477"
       aria-label="The Flutter SDK supports the specified architecture on the specified target platform"
       role="img">verified</span>
{% endcapture %}
{% capture no %}
 <span class="material-symbols"
       style="color: #D43324"
       aria-label="The Flutter SDK does not support the specified
                   architecture on the specified target platform"
       role="img">dangerous</span>
{% endcapture %}
{% capture beta %}
 <span class="material-symbols"
       style="color: #13C2AD"
       aria-label="The Flutter SDK supports ARM64 architecture
                   in the beta and main channels only on the specified target platform"
       role="img">gpp_maybe</span>
{% endcapture %}
{% capture na %}
 <span class="material-symbols"
       style="color: #DADCE0"
       aria-label="No version of the Flutter SDK exists for the
                   specified architecture on the specified target platform"
       role="img">do_not_disturb_on</span>
{% endcapture %}

| Platform | IA32 (x86) | x64 | Arm32 | Arm64 | RV64GC |
|---|:---:|:---:|:---:|:---:|:---:|
{%- for chip in chips %}
  | {{chip.platform}} | {{chip.x86}} | {{chip.x64}} | {{chip.arm32}} | {{chip.arm64}} | {{chip.risc}} |
{%- endfor %}
{:.table.table-striped}

<div aria-hidden="true" markdown="1">

{{yes}} Supported on all channels.  
{{no}} Unsupported on all channels.  
{{beta}} Supported on `beta` and `main` channels only.  
{{na}} No version exists.  

</div>

## Supported operating systems

Flutter offers three tiers of support for deploying apps to target platforms.

* **Supported**: The Flutter team tests these platforms on every commit.
* **Best effort**: The Flutter team intends to support these platforms
  through coding practices. The team tests these platforms on an ad-hoc basis.
* **Unsupported**: The Flutter team doesn't test or support these platforms.

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
