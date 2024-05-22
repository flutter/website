## Manage your Flutter SDK

To learn more about managing your Flutter SDK install,
consult the following resources.

{% assign choice = include.config %}
{% assign next-step = doctor[include.config] %}
{% assign mod-target = include.target | remove: 'mobile-' | downcase %}
{% if mod-target == 'desktop' %}
  {% assign webtarget = include.devos | append: '-desktop' | downcase %}
  {% assign andtarget = include.devos | downcase %}
  {% assign mod-target = include.devos | downcase %}
{% elsif mod-target == 'web' %}
  {% assign andtarget = 'web-on-' | append: include.devos | downcase %}
{% else %}
  {% assign webtarget = mod-target | append: '-on-' | append: include.devos | downcase %}
  {% assign andtarget = include.devos | downcase %}
{% endif %}

* [Upgrade Flutter][upgrade]
{%- case next-step.add-android %}
{%- when 'Y' %}
* [Add Android compilation tools](/platform-integration/android/install-android/install-android-from-{{andtarget}})
{%- endcase %}
{%- case next-step.add-chrome %}
{%- when 'Y' %}
* [Add Web debugging
  tools](/platform-integration/web/install-web/install-web-from-{{webtarget}})
{%- endcase %}
{%- case next-step.add-simulator %}
{%- when 'Y' %}
* [Add iOS simulator or device](/platform-integration/ios/install-ios/install-ios-from-{{mod-target}})
{%- endcase %}
{%- case next-step.add-xcode %}
{%- when 'Y' %}
* [Add macOS compilation tools](/platform-integration/macos/install-macos/install-macos-from-{{mod-target}})
{%- endcase %}
{%- case next-step.add-linux-tools %}
{%- when 'Y' %}
* [Add Linux compilation tools](/platform-integration/linux/install-linux/install-linux-from-{{mod-target}})
{%- endcase %}
{%- case next-step.add-visual-studio %}
{%- when 'Y' %}
* [Add Windows desktop compilation tools](/platform-integration/windows/install-windows/install-windows-from-{{mod-target}})
{%- endcase %}
* [Uninstall Flutter][uninstall]

[upgrade]: /release/upgrade
[uninstall]: /get-started/uninstall?tab={{include.devos}}
