---
title: Security
---

The Flutter team takes the security of Flutter and the applications
created with it seriously. This page describes how to report any
vulnerabilities you may find, and lists best practices to minimize
the risk of introducing a vulnerability.

## Security philosophy
Flutter security strategy is based on five key pillars

* **Identify**: Track & prioritize key security risks by identifying core assets, key threats and vulnerabilities. 
* **Detect**: Detect and identify vulnerabilities using techniques and tools like vulnerability scanning,
  static application security testing and fuzzing.
* **Protect**: Eliminate risks by mitigating known vulnerabilities and protect critical assets against source threats.
* **Respond**: Define processes to report, triage and respond to vulnerabilities or attacks.
* **Recover**: Build capabilities to contain and recover from an incident with minimal impact.

## Reporting vulnerabilities

To report a vulnerability, please email `security@flutter.dev` with a description of the issue,
the steps you took to create the issue, affected versions, and if known, mitigations for the issue.

We should reply within three working days.

We use GitHub’s security advisory feature to track open security issues. You should expect a close collaboration as we work to resolve the issue you have reported. 

Please reach out to `security@flutter.dev` again if you do not receive prompt attention and regular updates. You may also reach out to the team via our public [Discord](https://github.com/flutter/flutter/wiki/Chat) chat channels; however, when reporting an issue, please e-mail `security@flutter.dev` instead of Discord or filing a github issue to avoid revealing information about vulnerabilities in public that could put users at risk.

For more details on how we handle security vulnerabilities, please see our [internal processes]({{site.repo.flutter}}/security/policy).

##  Flagging existing issues as security-related
If you believe that an existing issue is security-related, we ask that you send an email to `security@flutter.dev`. 
The email should include the issue ID and a short description of why it should be handled according to this security policy.

## Supported versions

We commit to publishing security updates for the version of Flutter currently
on the `stable` branch.

## Expectations

We treat security issues equivalent to a P0 priority level and release a beta or hotfix for any major security issues found in the most recent stable version of our SDK. 

Any vulnerability reported for flutter websites like flutter.dev does not require a release and will be fixed in the website itself.

Flutter does not have a bug bounty program.

## Receiving security updates

The best way to receive security updates is to subscribe to the 
[flutter-announce](https://groups.google.com/forum/#!forum/flutter-announce) mailing list or updates to the Discord [channel](https://discord.gg/BS8KZyg).
We will also announce security updates in the technical release blog post.

## Best practices

* **Keep current with the latest Flutter SDK releases.**
  We regularly update Flutter, and these updates may fix security
  defects discovered in previous versions. Check the Flutter
  [change log]({{site.repo.flutter}}/wiki/Changelog)
  for security-related updates.

* **Keep your application’s dependencies up to date.**
  Make sure you [upgrade your package
  dependencies]({{site.url}}/development/tools/sdk/upgrading)
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
