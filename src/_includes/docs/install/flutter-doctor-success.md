Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.13.0, on {{os}} A.B chipset, locale en)
{% if os=='Windows' -%}
    [✓] Windows version (Installed version of Windows is version 10 or higher)
{% endif -%}
{% if target=='mobile' -%}
    [✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
{% endif -%}
{% if target=='web' -%}
    [✓] Chrome - develop for the web
{% endif -%}
{% if os=='macOS' -%}
    [✓] Xcode - develop for iOS and macOS (Xcode 14.3.1)
{% endif -%}
{% if os=='Windows' -%}
    [✓] Visual Studio - develop Windows apps (version 2022)
{% endif -%}
{% if target=='mobile' -%}
    [✓] Android Studio (version 2022.1)
{% endif -%}
[✓] VS Code (version 1.81.1)
[✓] Connected device (1 available)
[✓] Network resources

• No issues found!