{% assign doctor = doctor %}
{% assign setup = doctor[include.config] %}
{% case include.devos %}
{% when 'macOS' %}
{% assign displayos = 'macOS 14.4.0 23E214 darwin-arm64' %}
{% when 'Windows' %}
{% assign displayos = 'Microsoft Windows 11 [Version 10.0.22621.3155]' %}
{% when 'Linux' %}
{% assign displayos = 'Ubuntu 20.04 (LTS)' %}
{% endcase %}

{% comment %}
Don't change the whitespace control dashes in this list.
It took about two hours to get exactly right. @atsansone
{% endcomment %}

```console noHighlight
Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, {{site.appnow.flutter}}, on {{displayos}}, locale en)
{%- if setup.windows == 'Y' %}
[✓] Windows version (Installed version of Windows is version 10 or higher)
{%- endif %}
{% case setup.android-toolchain %}
{% when 'Y' %}[✓] Android toolchain - develop for Android devices (Android SDK version {{site.appnow.android_sdk}})
{% when 'N' %}[!] Android toolchain - develop for Android devices
{% endcase %}
{%- case setup.chrome %}
{% when 'Y' %}[✓] Chrome - develop for the web
{% when 'N' %}[!] Chrome - develop for the web
{% endcase -%}
{% unless setup.xcode == 'X' -%}
{% case setup.xcode %}
{% when 'Y' %}[✓] Xcode - develop for iOS and macOS (Xcode {{site.appnow.xcode}})
{% when 'N' %}[!] Xcode - develop for iOS and macOS (Xcode not installed)
{% endcase %}
{%- endunless -%}
{% unless setup.visual-studio == 'X' -%}
{% case setup.visual-studio %}
{% when 'Y' %}[✓] Visual Studio - develop Windows apps (version 2022)
{% when 'N' %}[!] Visual Studio - develop Windows apps
{% endcase %}
{%- endunless %}
{%- case setup.android-studio %}
{% when 'Y' %}[✓] Android Studio (version {{site.appnow.android_studio}})
{% when 'N' %}[!] Android Studio (not installed)
{% endcase -%}
{% unless setup.linux == 'X' -%}
{% case setup.linux %}
{% when 'Y' %}[✓] Linux toolchain - develop for Linux desktop
{% when 'N' %}[!] Linux toolchain - develop for Linux desktop
{% endcase %}
{%- endunless -%}

[✓] VS Code (version {{site.appnow.vscode}})
[✓] Connected device (1 available)
[✓] Network resources

{% unless setup.errors == 0 %}
! Doctor found issues in {{setup.errors}} categories.
{% else %}
∙ No issues found!
{% endunless -%}
```
