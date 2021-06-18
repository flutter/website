---
title: Security
---

The Flutter team takes the security of Flutter and the applications
created with it seriously. This page describes how to report any
vulnerabilities you may find, and lists best practices to minimize
the risk of introducing a vulnerability.

## Reporting vulnerabilities

To report a vulnerability, please e-mail `security@flutter.dev` with a description of the issue,
the steps you took to create the issue, affected versions, and if known, mitigations for the issue.

We should reply within three working days, probably much sooner.

We use GitHub's security advisory feature to track open security issues. You should expect
a close collaboration as we work to resolve the issue you have reported. Please reach out to
`security@flutter.dev` again if you do not receive prompt attention and regular updates.

You may also reach out to the team via our public [Discord](https://github.com/flutter/flutter/wiki/Chat) chat channels; however, please make
sure to e-mail `security@flutter.dev` when reporting an issue, and avoid revealing information about
vulnerabilities in public if that could put users at risk.

For more details on how we handle security vulnerabilities, please see our [internal processes](https://github.com/flutter/flutter/blob/master/SECURITY.md).

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

