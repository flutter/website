Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, {{site.appnow.flutter}}, on {{os}} A.B chipset, locale en)
{% if os=='Windows' -%}
[✓] Windows version (Installed version of Windows is version 10 or higher)
{% endif -%}
{% if target=='mobile' -%}
[✓] Android toolchain - develop for Android devices (Android SDK version {{site.appnow.android_sdk}})
{% else -%}
[!] Android toolchain - develop for Android devices
{% endif -%}
{% if target=='web' -%}
[✓] Chrome - develop for the web
{% else -%}
[!] Chrome - develop for the web
{% endif -%}
{% if os=='macOS' -%}
[✓] Xcode - develop for iOS and macOS (Xcode {{site.appnow.xcode}})
{% endif -%}
{% if os=='Windows' -%}
{% if target=='desktop' -%}
[✓] Visual Studio - develop Windows apps (version 2022)
{% else -%}
[!] Visual Studio - develop Windows apps
{% endif -%}
{% endif -%}
{% if target=='mobile' -%}
[✓] Android Studio (version {{site.appnow.android_studio}})
{% else -%}
[!] Android Studio (not installed)
[!] IntelliJ IDEA Community Edition (version {{site.appnow.intellij}})
{% endif -%}
[✓] VS Code (version {{site.appnow.vscode}})
[✓] Connected device (1 available)
[✓] Network resources

{% if target=='desktop' -%}
! Doctor found issues in 4 categories.
{% elsif target=='mobile' -%}
! Doctor found issues in 3 categories.
{% elsif target=='web' -%}
! Doctor found issues in 4 categories.
{% endif -%}
