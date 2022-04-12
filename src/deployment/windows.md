---
title: Build and release a Windows desktop app
description: How to release a Flutter app to the Microsoft Store.
short-title: windows
---

This guide provides a step-by-step walkthrough of releasing a
Flutter app to the [Microsoft Store][microsoftstore].

## Preliminaries

Before beginning the process of releasing 
a Flutter Windows Desktop app, it is necessary
to confirm that it satisfies [Microsoft Store Policies][storepolicies].

Joining the [Microsoft Partner Network][microsoftpartner] is also required.

## Set up your application in the Partner Center

Manage an application's life cycle in the [Microsoft Partner Center][microsoftpartner].

First off, it is necessary to reserve the application name and ensure that the 
required rights to the name exist. Once the name is reserved, the application 
will be provisioned for services such as push notifications, and it is possible
to start adding add-ons.

Options such as pricing, availability, age ratings, and category have to be 
configured together with the first submission and are automatically retained 
for the subsequent submissions.

## Packaging and deployment

In order to publish an application to Microsoft Store,
it first has to be packaged. The valid formats are **.msix**, **.msixbundle**,
**.msixupload**, **.appx**, **.appxbundle**, **.appxupload**, and **.xap**.

### Manual packaging and deployment

Check out [MSIX packaging][msix packaging] to learn about packaging 
Flutter Windows Desktop applications.

Note that each product has a unique identity, which the Store assigns.

If the package is being built manually, it is necessary to include its 
identity details manually during the packaging. The essential information
can be retrieved from the Partner Center:

1. Navigate to the application in the Partner Center.
2. Select **Product management**.
3. Retrieve the package identity name, publisher, 
and publisher display name by clicking on **Product identity**.

After manually packaging the application, it will also have to be 
manually submitted to the [Microsoft Partner Center][microsoftpartner].
This can be done by creating a new submission, navigating to **Packages**, 
and uploading the created application package.

### Continuous deployment

In addition to manually creating and deploying the package, 
it is possible to automate the build, package, versioning, 
and deployment process using CI/CD tooling after having submitted
the application to the Microsoft Store for the first time.

#### Codemagic CI/CD

[Codemagic CI/CD][codemagic] uses the [`msix` pub package][msix package] to package 
Flutter Windows Desktop applications. 

For Flutter applications, either the [Codemagic Workflow Editor][cmworkfloweditor] or [codemagic.yaml][cmyaml] 
can be used to package the application and deploy to Microsoft Partner Center.
Additional options (such as the list of capabilites and language resources 
contained in the package) can be configured using the aforementioned package.

For publishing, Codemagic uses the [Partner Center submission API][partnercenterapi]; thus,
Codemagic requires [associating the Azure Active Directory and Partner Center accounts][azureadassociation].

## Updating the app's version number

With Flutter Windows Desktop, the version number must be set during the 
packaging process and can not be set via the `pubspec.yaml` 
or command line arguments. 

The default version number of the app is `1.0.0.0`.

Note that applications are not allowed to have a Version with a revision number
other than zero. Thus, the last number of the version must remain zero for all
releases. Take note to follow Microsoft's [versioning guidelines][windowspackageversioning].

## Add app icons

To update the icon of a Flutter Windows Desktop application before packaging:

1. Navigate to **windows\runner\resources** in the Flutter project.
2. Replace the **app_icon.ico** with the wanted icon.
3. If the name of the icon is other than **app_icon.ico**, proceed to
change the **IDI_APP_ICON** value in the **windows\runner\Runner.rc** file to
point to the new path.

When packaging with the [`msix` pub package][msix package], the logo path can
also be configured inside the `pubspec.yaml` file.

To update the application image in the Store listing, navigate to 
the Store listing step of the submission and select Store logos. 
There it is possible to upload the logo with the size of 300 x 300 pixels.

All uploaded images are retained for subsequent submissions.

## Validating the application package

Before publication to the Microsoft Store, validating the application
package locally first is recommended. 

[Windows App Certification Kit][windowsappcertification] is a tool that is 
included in the Windows Software Development Kit (SDK).

To validate the application:

1. Launch Windows App Cert Kit.
2. Select the Flutter Windows Desktop package (**.msix**, **.msixbundle** etc).
3. Choose a destination for the test report.

The report may contain important warnings and information, 
even if the certification passes. 

[azureadassociation]: https://docs.microsoft.com/windows/uwp/publish/associate-azure-ad-with-partner-center
[cmworkfloweditor]: https://docs.codemagic.io/flutter-publishing/publishing-to-microsoft-store/
[cmyaml]: https://docs.codemagic.io/yaml-publishing/microsoft-store/
[codemagic]: https://codemagic.io/start/
[microsoftstore]: https://www.microsoft.com/store/apps/windows
[microsoftpartner]: https://partner.microsoft.com/
[msix package]: {{site.pub}}/packages/msix
[msix packaging]: {{site.url}}/desktop#msix-packaging
[partnercenterapi]: https://docs.microsoft.com/azure/marketplace/azure-app-apis
[storepolicies]: https://docs.microsoft.com/windows/uwp/publish/store-policies/
[visualstudiopackaging]: https://docs.microsoft.com/windows/msix/package/packaging-uwp-apps
[visualstudiosubmission]: https://docs.microsoft.com/windows/msix/package/packaging-uwp-apps#automate-store-submissions
[windowspackageversioning]: https://docs.microsoft.com/windows/uwp/publish/package-version-numbering
[windowsappcertification]: https://docs.microsoft.com/windows/uwp/debug-test-perf/windows-app-certification-kit
