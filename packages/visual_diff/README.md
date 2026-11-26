# Visual Diff

A visual regression diffing engine, snapshot runner, and Argos-inspired
interactive review UI built with Dart and Jaspr.

This package powers local and CI visual regression testing for Flutter and Dart
documentation and marketing sites (`docs.flutter.dev` and `flutter.dev`).

## Overview

- **Pixel-precise comparison**:
  Detects visual changes across desktop (`1280px`) and mobile (`390px`)
  viewports with pure Dart image diffing and bounding box highlighting.
- **Smart caching & route pruning**:
  Skips unchanged routes when HTML files and global assets (CSS/JS) match the
  baseline, and prunes repetitive routes via `visual_diff.yaml`.
- **Interactive review UI**:
  Argos-style Jaspr web interface to inspect side-by-side visual diffs,
  toggle masks, compare HTML metadata, and accept or reject baseline updates.
- **Switchable browser backends**:
  Supports standard Chrome/Chromium and the lightweight headless Obscura engine.

## Usage

Visual diffing is integrated into the `dash_site` CLI.

```bash
# Compare working branch against main:
dart run dash_site --site=docs visual-diff
dart run dash_site --site=www visual-diff

# Generate or update baseline snapshots from the current working tree:
dart run dash_site --site=docs visual-diff --update-baseline --current

# Snapshot a specific route:
dart run dash_site --site=docs visual-diff --route=/get-started

# Snapshot all routes, ignoring visual_diff.yaml limits:
dart run dash_site --site=docs visual-diff --all-routes

# Open the review UI without re-running snapshots:
dart run dash_site --site=docs visual-diff --serve
```

## Renderers

### Chrome (Default)

Chrome runs via Puppeteer in headless mode with request interception and
hardware-accelerated rasterization.

- **Requirements**:
  Google Chrome or Chromium installed on your system.
  No extra setup required.
- **Custom path**:
  Pass `--chrome-path=<path>` if Chrome is installed in a non-standard location.

### Obscura

[Obscura](https://obscura.sh) is a lightweight headless browser and scraper
written in Rust with pure CPU software rendering (`tiny_skia`).
It runs as a persistent background daemon communicating over Chrome DevTools
Protocol (CDP) WebSocket sessions.

- **To use Obscura**:
  Pass `--renderer=obscura`:

  ```bash
  dart run dash_site --site=docs visual-diff --renderer=obscura
  ```

- **Installation**:
  - **macOS (Homebrew)**:
    ```bash
    brew install obscura
    ```
  - **Linux**:
    Download the render-enabled release archive from
    [GitHub releases](https://github.com/h4ckf0r0day/obscura/releases)
    and place both `obscura` and `obscura-worker` on your `PATH`:
    ```bash
    curl -sL https://github.com/h4ckf0r0day/obscura/releases/latest/download/obscura-x86_64-linux.tar.gz | tar -xz
    sudo mv obscura obscura-worker /usr/local/bin/
    ```
- **Custom path**:
  Pass `--renderer-path=<path>` or `--obscura-path=<path>` to specify a custom
  binary.
- **Font handling**:
  TrueType icon fonts (`MaterialSymbolsOutlined.ttf` and
  `MaterialSymbolsRounded.ttf`) are automatically downloaded and cached in
  `.visual-diff/.font-cache/ttf/` and supplied to Obscura via `--font-dir`.

## Configuration (`visual_diff.yaml`)

Each site can define a `visual_diff.yaml` file in its site root
(for example, `sites/docs/visual_diff.yaml`):

```yaml
# Maximum snapshot height before clipping (prevents runaway tall pages).
max_height: 4500

# Concurrency for parallel worker pages.
concurrency: 4

# Minimum number of differing pixels required to flag a snapshot as changed.
min_diff_pixels: 50

# Route pruning: limit high-volume repetitive paths while ensuring modified
# pages are always snapshotted.
routes:
  max_per_collection: 5
  collections:
    - prefix: /release/breaking-changes/
      limit: 5
    - prefix: /cookbook/
      limit: 10
```

Any route whose compiled HTML file changed relative to the baseline is
unconditionally snapshotted, regardless of collection limits.

## Common CLI Options

| Flag | Description | Default |
| --- | --- | --- |
| `--renderer` | Browser backend (`chrome`, `obscura`) | `chrome` |
| `--current` | Use current branch as baseline instead of checking out git `main` | `false` |
| `--update-baseline` | Update baseline snapshots from current results | `false` |
| `--all-routes` | Snapshot all routes, bypassing `visual_diff.yaml` limits | `false` |
| `--route` | Snapshot specific route(s), e.g. `--route=/cookbook` | all |
| `--concurrency` | Number of concurrent browser workers | `4` |
| `--max-height` | Maximum snapshot height in pixels (`0` for unlimited) | `4500` |
| `--no-build` | Skip building the static site before snapshotting | `false` |
| `--no-open` | Skip automatically opening the browser review UI | `false` |
| `--serve` | Start the review server without capturing new snapshots | `false` |
