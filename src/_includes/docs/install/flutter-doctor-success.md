Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.13.2, on {{os}} A.B chipset, locale en)
{% if os=='Windows' -%}
    [✓] Windows version (Installed version of Windows is version 10 or higher)
{% endif -%}
{% if target=='mobile' -%}
    [✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
{% else -%}
    [✗] Android toolchain - develop for Android devices
        Unable to locate Android SDK.
        Install Android Studio from: https://developer.android.com/studio/index.html
        On first launch it will assist you in installing the Android SDK components.
        (or visit https://developer.android.com/studio/install#windows for detailed instructions).
        If the Android SDK has been installed to a custom location, please use
        `flutter config --android-sdk` to update to that location.
{% endif -%}
{% if target=='web' -%}
    [✓] Chrome - develop for the web
{% endif -%}
{% if os=='macOS' -%}
    [✓] Xcode - develop for iOS and macOS (Xcode 14.3.1)
{% endif -%}
{% if os=='Windows' -%}
    {% if target=='desktop' -%}
        [✓] Visual Studio - develop Windows apps (version 2022)
    {% else -%}
        [✗] Visual Studio - develop Windows apps
            Visual Studio not installed; this is necessary to develop Windows apps.
            Download at https://visualstudio.microsoft.com/downloads/.
            Please install the Desktop development with C++ workload, including all of its default components
    {% endif -%}
{% endif -%}
{% if target=='mobile' -%}
    [✓] Android Studio (version 2022.1)
{% else -%}
    [✗] Android toolchain - develop for Android devices
        Android Studio not found; download from https://developer.android.com/studio/index.html
        (or visit https://developer.android.com/studio/install#windows for detailed instructions).
{% endif -%}
[✓] VS Code (version 1.81.1)
[✓] Connected device (1 available)
[✓] Network resources

• No issues found!