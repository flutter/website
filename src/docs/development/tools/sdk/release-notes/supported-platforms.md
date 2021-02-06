---
title: Supported platforms
short-title: Supported platforms
description: The platforms that Flutter supports by platform version.
---

## How we define a supported platform

As of Flutter 1.20, we define three tiers of support for the 
platforms on which Flutter runs:
1. Supported Google-tested platforms, which are platforms the Flutter team at 
Google tests in continuous integration at every commit. 
For these platforms, we also run post-commit  tests before 
rolling from the master channel to the dev channel. 
1. Best effort platforms, supported community testing, which are 
platforms we believe we support through coding practices 
and ad-hoc testing, but rely on the community for testing.
1. Unsupported platforms, which are platforms that may work,
but that the development team does not directly test or support.


### Supported Google-tested platforms

|Platform|Version              |
|-------|----------------------|
|Android|Android SDK 30        |
|Android|Android SDK 29        |
|Android|Android SDK 28        |
|Android|Android SDK 27        |
|Android|Android SDK 26        |
|Android|Android SDK 25        |
|Android|Android SDK 24        |
|Android|Android SDK 23        |
|Android|Android SDK 22        |
|Android|Android SDK 21        |
|Android|Android SDK 19        |
|iOS    | 14 (all)             |
|iOS    | 13.3-13.7            |
|iOS    | 13.0                 |
|iOS    | 12.4 & 12.4.1        |
|iOS    | 9.3.6                |
|Web    | Chrome 84            |
|Web    | Firefox 72.0         |
|Web    | Safari / Catalina    |
|Web    | Edge 1.2.0           |
|Windows| Windows 10           |
|macOS  | El Capitan & greater |
|Linux  | Debian 10            |

Note that Android SDK 20 is covered by testing Android SDK 19, 
as the differences between the two platform versions are
minimal.

### Best effort platforms tested by the community

|Platform|Version       |
|-------|---------------|
|Android|Android SDK 22 |
|Android|Android SDK 20 |
|Android|Android SDK 18 |
|Android|Android SDK 17 |
|Android|Android SDK 16 |
|iOS    |iOS 13.1       |
|iOS    |iOS 12.1-12.3  |
|iOS    |iOS 10 (all)   |
|iOS    |iOS 9.0        |
|iOS    |iOS 8 (all)    |
|Windows|Windows 8      |
|Windows|Windows 7      |
|Linux  | Debian & below |

### Unsupported platforms

|Platform|Version              |
|--------|---------------------|
|Android|Android SDK 15 & below|
|iOS    |iOS 7 & below         |
|Windows|Windows Vista & below |
|Windows|Any 32-bit platform   |   
|macOS  | Yosemite & below     |
