---
title: Supported deployment platforms
shortTitle: Supported platforms
description: The platforms that Flutter supports by platform version.
showBreadcrumbs: false
---

As of Flutter {{site.currentFlutterVersion}},
Flutter supports deploying apps on the following combinations of
hardware architectures and operating system versions.
These combinations are called _platforms_.

Flutter categorizes platforms as follows:

* **Supported**: The platforms and versions that the Flutter team supports.
* **CI-tested**: The Flutter team tests these platforms on every commit.
* **Unsupported**: The Flutter team doesn't test or support these platforms.

Based on these categories,
Flutter supports deploying to the following platforms.

## Mobile platforms

<PlatformsGrid>
  <PlatformCard 
    name="Android" 
    icon="mobile" 
    arch="x64, Arm32, Arm64" 
    supported="24 to 36" 
    ci-tested="24 to 36" 
    unsupported="23 and earlier" 
    deploy-to-link="/deployment/android" 
  />
  <PlatformCard 
    name="iOS" 
    icon="mobile" 
    arch="Arm64" 
    supported="13 to 26" 
    ci-tested="18" 
    unsupported="12 and earlier" 
    deploy-to-link="/deployment/ios" 
  />
</PlatformsGrid>

## Desktop platforms

<PlatformsGrid>
  <PlatformCard 
    name="Windows" 
    icon="desktop_windows" 
    arch="x64, Arm64" 
    supported="10, 11" 
    ci-tested="10" 
    unsupported="8 and earlier" 
    deploy-to-link="/deployment/windows"
  />
  <PlatformCard 
    name="macOS" 
    icon="laptop_mac" 
    arch="x64, Arm64" 
    supported="Catalina (10.15) to Tahoe (26)" 
    ci-tested="Sonoma (14), Sequoia (15)" 
    unsupported="Mojave (10.14) and earlier" 
    deploy-to-link="/deployment/macos" 
  />
  <PlatformCard 
    name="Debian (Linux)" 
    icon="computer" 
    arch="x64, Arm64" 
    deploy-to="Linux"
    supported="10, 11, 12" 
    ci-tested="11, 12" 
    unsupported="9 and earlier" 
    deploy-to-link="/deployment/linux"
  />
  <PlatformCard 
    name="Ubuntu (Linux)" 
    icon="computer" 
    arch="x64, Arm64" 
    deploy-to="Linux"
    supported="20.04 LTS to 24.04 LTS" 
    ci-tested="20.04 LTS, 22.04 LTS" 
    unsupported="24.10 and earlier non-LTS" 
    deploy-to-link="/deployment/linux"
  />
</PlatformsGrid>

## Web platforms

<PlatformsGrid>
  <PlatformCard
    name="Chrome"
    icon="language"
    arch="JavaScript, WebAssembly"
    deploy-to="web"
    supported="[Latest 2](https://chromereleases.googleblog.com/search/label/Stable%20updates)"
    ci-tested="119, 125"
    unsupported="95 and earlier"
    deploy-to-link="/deployment/web"
  />
  <PlatformCard
    name="Firefox"
    icon="language"
    arch="JavaScript"
    deploy-to="web"
    supported="[Latest 2](https://www.mozilla.org/en-US/firefox/releases/)"
    ci-tested="143"
    unsupported="98 and earlier"
    deploy-to-link="/deployment/web"
  />
  <PlatformCard
    name="Safari"
    icon="language"
    arch="JavaScript"
    deploy-to="web"
    supported="15.6 and newer"
    ci-tested="15.6"
    unsupported="15.5 and earlier"
    deploy-to-link="/deployment/web"
  />
  <PlatformCard
    name="Edge"
    icon="language"
    arch="JavaScript, WebAssembly"
    deploy-to="web"
    supported="[Latest 2](https://learn.microsoft.com/en-us/deployedge/microsoft-edge-relnote-stable-channel)"
    ci-tested="119, 125"
    unsupported="95 and earlier"
    deploy-to-link="/deployment/web"
  />
</PlatformsGrid>
