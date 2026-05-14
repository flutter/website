# Site deployment image

This directory contains a Dockerfile that provides access to
Dart and Firebase CLI tools.
This image is used to deploy various Dart/Flutter websites to
Firebase in both production and staging and
to comment staged site links on GitHub PRs.

## Installed tools

* Dart SDK Beta
* Firebase Tools

## Updating image

When the `Dockerfile` file or `cloudbuild.yaml` template in this directory
are changed in a PR, the cloud build template is triggered.
Then a new version of the image is deployed as the latest version in
Container Registry under the `flutter-dev-230821` project on Google Cloud.
