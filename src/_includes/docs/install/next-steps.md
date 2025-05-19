## Manage your Flutter SDK

To learn more about managing your Flutter SDK installation,
consult the following resources.

* [Upgrade Flutter][upgrade]
{%- if include.target != 'Web' %}
* [Add web as a build target](/platform-integration/web/setup)
{%- endif %}
{%- if include.target != 'Android' %}
* [Add Android compilation tools](/platform-integration/android/setup)
{%- endif %}
{%- if include.devos == 'macOS' %}
{%- if include.target != 'iOS' %}
* [Add iOS compilation tools](/platform-integration/ios/setup)
{%- endif %}
{%- if include.target != 'desktop' %}
* [Add macOS compilation tools](/platform-integration/macos/setup)
{%- endif %}
{%- endif %}
{%- if include.devos == 'Windows' and include.target != 'desktop' %}
* [Add Windows desktop compilation tools](/platform-integration/windows/setup)
{%- endif %}
{%- if include.devos == 'Linux' and include.target != 'desktop' %}
* [Add Linux compilation tools](/platform-integration/linux/setup)
{%- endif %}
* [Uninstall Flutter][uninstall]

[upgrade]: /install/upgrade
[uninstall]: /install/uninstall?tab-save-dev-os={{include.devos}}
