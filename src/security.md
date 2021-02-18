---
title: Security
---

The Flutter team takes the security of Flutter and the applications
created with it seriously. This page describes how to report any
vulnerabilities you may find, and lists best practices to minimize
the risk of introducing a vulnerability.

## Reporting vulnerabilities

In the rare event that you find a vulnerability in Flutter itself,
email us at
[product-security@google.com](mailto:product-security@google.com).
For more information about how Google handles security issues, see
[Google’s security philosophy](https://www.google.com/about/appsecurity/).

## Best practices

* **Keep current with the latest Flutter SDK releases.**
  We regularly update Flutter, and these updates may fix security
  defects discovered in previous versions. Check the Flutter
  [change log]({{site.github}}/flutter/flutter/wiki/Changelog)
  for security-related updates.

* **Keep your application’s dependencies up to date.**
  Make sure you [upgrade your package
  dependencies](/docs/development/tools/sdk/upgrading)
  to keep the dependencies up to date. Avoid pinning to specific versions
  for your dependencies and, if you do, make sure you check
  periodically to see if your dependencies have had security updates,
  and update the pin accordingly.

* **Keep your copy of Flutter up to date.** Private, customized versions
  of Flutter tend to fall behind the current version and may not
  include important security fixes and enhancements. Instead,
  routinely update your copy of Flutter. If you're making changes to
  improve Flutter, be sure to update your fork and consider sharing your
  changes with the community.

