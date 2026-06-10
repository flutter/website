# Site deployment image

This directory contains a Dockerfile that provides access to
Dart, Firebase CLI tools, and the GitHub CLI.
This image is used to deploy various Dart/Flutter websites to
Firebase in both production and staging and
to comment staged site links on GitHub PRs.

## Installed tools

* Dart SDK
* GitHub CLI
* Firebase Tools

## Updating image

When the `Dockerfile` file or `cloudbuild.yaml` template in this directory
are changed in a PR, the cloud build template is triggered.
Then a new version of the image is deployed as the latest version in
Container Registry under the `flutter-dev-230821` project on Google Cloud.

## Updating the Dart SDK version

The base Dart image in `Dockerfile` is pinned by both tag and digest:

```dockerfile
FROM dart:<version>@<digest>
```

When updating the Dart SDK version, update both the tag and the digest.
Use the multi-platform image index digest for the tag.
Don't use a platform-specific digest, such as
the digest for only `linux/amd64` or only `linux/arm64/v8`.

### Using `crane`

If you have the `crane` CLI from [`google/go-containerregistry`][], run:

```bash
crane digest docker.io/library/dart:<STABLE_DART_SDK_VERSION>
```

For example, the following command retrieves the digest for
the `3.12.1` stable release of the SDK:

```bash
crane digest docker.io/library/dart:3.12.1
```

Copy the returned `sha256:...` digest.
Then update the `FROM` line in the `Dockerfile` with
the new tag (version) and copied index digest.

```dockerfile
FROM dart:3.12.1@<digest from crane>
```

Don't pass `--platform` when getting the digest for the `Dockerfile`.
Passing a platform returns the digest for that platform's child manifest
instead of the architecture-agnostic index digest.

[`google/go-containerregistry`]: https://github.com/google/go-containerregistry

### Using Docker Hub

If you don't have `crane`, use the
[Dart image tags page on Docker Hub](https://hub.docker.com/_/dart/tags):

1.  Search for the new Dart SDK version tag, such as `3.12.1`.
1.  Open the tag detail page by selecting the tag name or digest.
1.  Ensure the opened tag page has a `MULTI-PLATFORM` badge.
1.  Copy the specified `INDEX DIGEST` value.
    It should start with `sha256:`.
1.  Update the `FROM` line in the `Dockerfile` with
    the new tag (SDK version) and index digest.

<img
  width="688"
  height="248"
  alt="Screenshot of the index digest on Docker Hub, outlined with a red box."
  src="https://github.com/user-attachments/assets/909bd713-580f-41f5-882b-9afb3b9bbfaf" />
