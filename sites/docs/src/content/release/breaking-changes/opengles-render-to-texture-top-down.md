---
title: OpenGL ES render-to-texture content is stored top-down
description: >-
  Impeller's OpenGL ES backend now stores render-to-texture content
  top-down, matching Metal and Vulkan, which can affect fragment shaders
  and Flutter GPU apps that compensated for the previous bottom-up
  orientation.
---

{% render "docs/breaking-changes.md" %}

## Summary

Impeller's OpenGL ES backend now stores render-to-texture content
top-down, the same as the Metal and Vulkan backends.
A fragment shader or Flutter GPU app that sampled a render-target texture
on OpenGL ES and added a vertical flip to compensate for the old
bottom-up orientation now renders that content upside down.

## Background

The OpenGL ES backend previously stored render-to-texture content
bottom-up, unlike the Metal and Vulkan backends.
The renderer carried that orientation difference through every texture
sample as a per-sampler Y-coordinate scale.
Impeller now absorbs the difference once, at the vertex stage, so
render-target textures are stored top-down on every backend.

This change is invisible to the framework and to Flutter's 2D rendering.
Application code can only observe the old orientation through the
`FragmentShader` API and through Flutter GPU, the experimental
`flutter_gpu` package, where a shader samples a render-target texture
directly.

## Migration guide

Shaders written for OpenGL ES often flipped the Y coordinate inside an
`IMPELLER_TARGET_OPENGLES` block to make render-target textures match the
other backends.
Render-target textures are now top-down on every backend, so that flip is
no longer needed.

Code before migration:

```glsl
void main() {
  vec2 uv = FlutterFragCoord().xy / u_size;
#ifdef IMPELLER_TARGET_OPENGLES
  uv.y = 1.0 - uv.y;
#endif
  fragColor = texture(u_texture, uv);
}
```

If the shader only needs to run on a Flutter release that includes this
change, remove the flip.

Code after migration:

```glsl
void main() {
  vec2 uv = FlutterFragCoord().xy / u_size;
  fragColor = texture(u_texture, uv);
}
```

To keep one source working across releases, guard the flip with the
`IMPELLER_OPENGLES_UNFLIPPED_DEPRECATED` macro.
That macro is only defined on releases that store render-target textures
top-down, so the flip still runs on older releases that need it.

```glsl
void main() {
  vec2 uv = FlutterFragCoord().xy / u_size;
#if defined(IMPELLER_TARGET_OPENGLES) && !defined(IMPELLER_OPENGLES_UNFLIPPED_DEPRECATED)
  uv.y = 1.0 - uv.y;
#endif
  fragColor = texture(u_texture, uv);
}
```

## Timeline

Landed in version: not yet released<br>
In stable release: the next stable release after 3.44.0

## References

GitHub issue:

* [Issue 186554][]

Relevant PRs:

* [PR 186556][]
* [PR 187316][]

[Issue 186554]: {{site.repo.flutter}}/issues/186554
[PR 186556]: {{site.repo.flutter}}/pull/186556
[PR 187316]: {{site.repo.flutter}}/pull/187316
