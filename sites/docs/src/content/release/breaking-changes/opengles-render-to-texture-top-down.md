---
title: OpenGL ES render-to-texture content is stored top-down
description: >-
  Impeller's OpenGL ES backend now stores render-to-texture content
  top-down, matching Metal and Vulkan, which can affect Flutter GPU
  apps that compensated for the previous bottom-up orientation.
---

{% render "docs/breaking-changes.md" %}

## Summary

Impeller's OpenGL ES backend now stores render-to-texture content
top-down, the same as the Metal and Vulkan backends.
A Flutter GPU app that sampled a render-target texture on OpenGL ES and
added a vertical flip to compensate for the old bottom-up orientation
now renders that content upside down.

## Background

The OpenGL ES backend previously stored render-to-texture content
bottom-up, unlike the Metal and Vulkan backends.
The renderer carried that orientation difference through every texture
sample as a per-sampler Y-coordinate scale.
Impeller now absorbs the difference once, at the vertex stage, so
render-target textures are stored top-down on every backend.

This change is invisible to the framework and to Flutter's 2D rendering.
The only surface where application code could observe the old
orientation is Flutter GPU, the experimental `flutter_gpu` package,
where an app drives render passes and samples render-target textures
directly.

## Migration guide

If a Flutter GPU shader flipped the Y coordinate when sampling a
render-target texture solely to make OpenGL ES match the other backends,
remove that flip.
Render-target textures are now top-down on every backend.

Code before migration:

```glsl
// The flip only compensated for OpenGL ES's bottom-up render targets.
uv.y = 1.0 - uv.y;
frag_color = texture(u_texture, uv);
```

Code after migration:

```glsl
frag_color = texture(u_texture, uv);
```

## Timeline

Landed in version: not yet released<br>
In stable release: Not yet

## References

GitHub issue:

* [Issue 186554][]

Relevant PR:

* [PR 186556][]

[Issue 186554]: {{site.repo.flutter}}/issues/186554
[PR 186556]: {{site.repo.flutter}}/pull/186556
