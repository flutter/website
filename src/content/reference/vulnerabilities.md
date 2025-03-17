---
title: Platform Vulnerabilities
description: Known vulnerabilities and important considerations for Flutter developers on different platforms and versions.
---

**Important**: The list of supported platforms and versions below is not
exhaustive and may change over time with new platform updates. Developers
should always refer to the most up-to-date official documentation for the
specific platform they are targeting.

## Android

* **StrandHogg Attack / Task Affinity Vulnerability**
    * **Description**: On Android SDK versions less than 30
     (Android 11), a vulnerability related to "taskAffinity" allowed
     malicious applications to potentially intercept user interactions
     and data from legitimate applications running in the foreground.
     This attack, known as StrandHogg, could occur when a malicious app
     with a carefully crafted taskAffinity was launched and then brought
     to the foreground, potentially masking itself as the legitimate app.
    * **Affected Versions**: Android SDK versions < 30 (Android 10 and below).
    * **Impact**: Potential interception of sensitive data (e.g., login
    credentials, personal information), unauthorized actions performed on
    behalf of the user.
    * **Mitigation**:
        * **Target SDK Version 30 or higher**: Setting `minSdkVersion` to 30
        or higher on Android projects applies restrictions that mitigate this
        vulnerability. Android 11 introduced changes to how tasks are managed,
        limiting the ability of apps to manipulate task affinity in this way.
    * **References**:
        * <https://developer.android.com/privacy-and-security/risks/strandhogg>