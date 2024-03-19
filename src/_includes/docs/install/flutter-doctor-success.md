{% assign doctor = site.data.doctor %}
{% assign config = site.data.doctor[include.config] %}

```terminal
Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, {{site.appnow.flutter}}, on {{os}} A.B chipset, locale en)
{%- if config.windows == 'Y' %}
[✓] Windows version (Installed version of Windows is version 10 or higher)
{%- endif %}
{% case config.android-toolchain %}
{%- when 'Y' %}[✓] Android toolchain - develop for Android devices (Android SDK version {{site.appnow.android_sdk}})
{%- when 'N' %}[!] Android toolchain - develop for Android devices
{%- endcase %}
{% case config.chrome %}
{%- when 'Y' %}[✓] Chrome - develop for the web
{%- when 'N' %}[!] Chrome - develop for the web
{%- endcase %}
{% case config.xcode %}
{%- when 'Y' %}[✓] Xcode - develop for iOS and macOS (Xcode {{site.appnow.xcode}})
{%- when 'N' %}[!] Xcode - develop for iOS and macOS (Xcode not installed)
{%- endcase -%}
{% case config.visual-studio %}
{%- when 'Y' %}[✓] Visual Studio - develop Windows apps (version 2022)
{%- when 'N' %}[!] Visual Studio - develop Windows apps
{%- endcase %}
{% case config.android-studio %}
{%- when 'Y' %}[✓] Android Studio (version {{site.appnow.android_studio}})
{%- when 'N' %}[!] Android Studio (not installed)
{%- endcase %}
{% case config.linux %}
{%- when 'Y' %}[✓] Linux toolchain - develop for Linux desktop
{%- when 'N' %}[!] Linux toolchain - develop for Linux desktop
{%- endcase -%}
[✓] VS Code (version {{site.appnow.vscode}})
[✓] Connected device (1 available)
[✓] Network resources

! Doctor found issues in {{config.errors}} categories.
```
