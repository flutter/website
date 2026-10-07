# dash_media_convert

Tools for optimizing website media before it's committed.
Currently, this converts PNG and JPEG images to WebP with a pinned,
checksum-verified build of Google's [`cwebp`][] encoder.

In this repository, contributors can
use the `dart run dash_site optimize-images` command
to convert specified images to WebP, replacing the originals.
For an example of using the package's `ImageOptimizer` API,
check out the command's implementation in [`optimize_images.dart`][].

[`cwebp`]: https://developers.google.com/speed/webp/docs/cwebp
[`optimize_images.dart`]: ../../tool/dash_site/lib/src/commands/optimize_images.dart

## Encoding defaults

All conversions use compression method 6 (`-m 6`).

PNG images use lossless WebP encoding by default (`-lossless -q 85`)
to preserve text and fine details in screenshots and diagrams.
For lossless encoding, the quality value controls compression effort,
not visual quality.

Pass `--lossy-png` to encode PNG photos or artwork lossily at quality 85
with sharp YUV conversion (`-q 85 -sharp_yuv`).
This can reduce file sizes further at the cost of image detail.

JPEG images use lossy WebP encoding at quality 85 (`-q 85`).
Images keep their original format if the WebP output wouldn't be smaller.

The CLI resizes images wider than 2400 pixels by default.
Resizing can change image details even with lossless encoding.
Pass `--max-width=0` to preserve the original dimensions.

## The `cwebp` binary

The pinned `cwebp` binary for your platform is
downloaded the first time it's needed to
the `dash_media_convert/cwebp/` directory of the [Dart data home][],
so repositories and worktrees on your computer share it.
Previously downloaded versions aren't deleted automatically,
but you can delete the directory at any time.

Both the downloaded archive and the extracted binary are verified
against the SHA-256 checksums in [`lib/src/cwebp_pins.dart`][],
and the binary is verified again every time it's used.

To use a different `cwebp` executable,
such as on a platform without a prebuilt binary,
set the `CWEBP_PATH` environment variable to its path.

[Dart data home]: https://pub.dev/packages/dart_data_home
[`lib/src/cwebp_pins.dart`]: lib/src/cwebp_pins.dart

### Updating `cwebp`

Update the pinned version when libwebp publishes a release,
especially one with security fixes.

1.  Make sure `gpg` is installed and has the WebP release signing key:

    ```bash
    gpg --keyserver keyserver.ubuntu.com --recv-keys 6B0E6B70976DE303EDF2F601F9C3D6BDB8232B5D
    ```

1.  From this package's directory,
    run the pinning script with the new version:

    ```bash
    dart run tool/pin_cwebp.dart 1.6.0
    ```

1.  Run this package's tests, then commit the changes and open a pull request.
