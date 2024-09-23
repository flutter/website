---
title: Flutter on iOS
description: >-
  Learn about Flutter's support for and compatibility with
  the latest releases of iOS.
---

You can develop Flutter on the iOS platform, even on
the latest release of iOS. The latest Flutter SDK
already supports a number of the features in the
latest release of iOS.

Of course, if you find a bug on Flutter,
please [file an issue][].

[file an issue]: {{site.github}}/flutter/flutter/issues

## iOS 18 release

| Feature                                         | Status                                                                                                    |  
|-------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| Apple Intelligence (AI)                         | Not yet tested. On Flutter roadmap.                                                                       |
| Control Center (CC) widgets                     | Tested. Info added to [extension page][]. Requires writing some Swift code to create a toggle for the CC. |
| Light/dark/tinted icon colors                   | Tested. Info added to [deployment page][].                                                                | 
| Locked and hidden apps                          | Tested and works.                                                                                         |
| iOS formatting menu                             | On Flutter roadmap. Not yet available.                                                                    |
| **Translate** support for the context edit menu | On Flutter roadmap. Not yet available.                                                                    |
| Target and build for iOS 18                     | Tested. Monitoring issues and feedback.                                                                   |
| iOS-style zoom page transition                  | Not available yet.                                                                                        |
| iPad-style tap bar                              | Not available yet.                                                                                        |
| New writing tools (AI) in text input            | On Flutter roadmap, not available yet.                                                                    |
| iPhone mirroring (on viewing a Flutter app)     | Tested but doesn't work yet. On Flutter roadmap.                                                          |
| Passwords app integrates/works with Flutter     | Tested and works.                                                                                         |
| Eye tracking of a Flutter app                   | Tested but doesn't work yet. On Flutter roadmap.                                                          |
| Hover typing feature                            | Not yet tested.                                                                                           |
| Virtual trackpad feature                        | Not yet tested.                                                                                           |
| Large content viewer                            | Not yet tested.                                                                                           |

{:.table .table-striped}

[deployment page]: /deployment/ios#add-an-app-icon
[extension page]: /platform-integration/ios/app-extensions

