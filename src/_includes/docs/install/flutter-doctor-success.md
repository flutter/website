Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, {{site.appnow.flutter}}, on {{os}} A.B chipset, locale en)
{% if os=='Windows' -%}
[✓] Windows version (Installed version of Windows is version 10 or higher)
{% endif -%}
{% case target -%}
{% when 'mobile','mobile-android' -%}
[✓] Android toolchain - develop for Android devices (Android SDK version {{site.appnow.android_sdk}})
{% else -%}
[!] Android toolchain - develop for Android devices
{% endcase -%}
{% if target=='web' -%}[✓]{% else -%}[!]{% endif %} Chrome - develop for the web
{%- if os=='macOS' -%}
{% case target %}
{%- when 'desktop', 'mobile-ios' %}
[✓] Xcode - develop for iOS and macOS (Xcode {{site.appnow.xcode}})
{%- else %}
[!] Xcode - develop for iOS and macOS (Xcode not installed)
{%- endcase %}
{% endif -%}
{% if os=='Windows' %}
{% if target=='desktop' -%}
[✓] Visual Studio - develop Windows apps (version 2022)
{% else -%}
[!] Visual Studio - develop Windows apps
{% endif -%}
{% endif -%}
{% if target=='mobile' or target=='mobile-android' -%}
[✓] Android Studio (version {{site.appnow.android_studio}})
{% else -%}
[!] Android Studio (not installed)
{% endif -%}
[✓] VS Code (version {{site.appnow.vscode}})
[✓] Connected device (1 available)
[✓] Network resources

{% case target %}
{% when 'desktop','mobile-ios' -%}
! Doctor found issues in 3 categories.
{% when 'mobile', 'mobile-android' -%}
! Doctor found issues in 2 categories.
{% when 'web' -%}
! Doctor found issues in 4 categories.
{% endcase -%}
