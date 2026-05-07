---
title: Impeller anti-aliasing
description: How does Impeller perform anti-aliasing?
---

Aliasing is the visual artifacts that result from drawing geometry to a grid of
pixels (rasterization). Impeller employs a couple of techniques to smooth out
the mapping to raster graphics (anti-aliasing).

## Techniques

### Multisample anti-aliasing (MSAA)

[MSAA][] is a global anti-aliasing technique that operates on the whole contents
of the screen. It is an optimization over rendering the whole screen at a larger
scale and shrinking it down ([SSAA][]). Instead of doing the fragment operation
for each fragment in a region, if it is determined they have the same coverage,
only one fragment operation is calculated. This limits smoothing to edges.
Mobile phone GPUs have special hardware to optimize this process (
[Tiled rendering][]). It comes in varying degrees of how many samples to
consider.

On desktop and mobile 4x MSAA is used for all rendering calls.

### Signed distance fields ([SDFs][])

Typically, hardware accelerated computer graphics is done by defining a series
of points and edges (a [mesh][]) and [shaders][]. SDF rendering instead renders
the shape of things in the fragment shader program using SDFs to define the
shape of the object being drawn. Since the shape is defined in the fragment
shader there is an opportunity to smooth out edges at the fragment level instead
of relying on the rasterization of a mesh.

On desktop, rendering with SDFs is enabled. On mobile platforms SDFs is an
option whose default value is false.

This technique is prioritized on desktop because SDF rendering puts more demand
on the GPU and Flutter supports older mobile phones. Also, the physical pixel
sizes on desktop computers are typically bigger than those of mobile phones. So
any imperfection will be more evident there.

### Examples

| No AA | MSAA 4x | MSAA 4x + SDF |
| --- | --- | --- |
| ![No AA](/assets/images/docs/perf/noaa.png) | ![MSAA 4x](/assets/images/docs/perf/msaa4.png) | ![MSAA 4x + SDF](/assets/images/docs/perf/msaa4sdf.png) |

## Working with anti-aliasing

### SDFs with the FragmentShader API

Standard primitive shapes in Flutter will be drawn automatically with SDFs. If
a Flutter developer wants to define their own custom graphics with SDFs they can
do so with the [FragmentShader API][]. Using the [drawPath()][] is sufficient
for most use cases without resorting to high quality SDF rendering. Not all
drawn paths are guaranteed to result in SDF rendering though.

An example of rendering SDFs with the FragmentShader API can be found at
[`simple_sdf`][].

### Enabling SDFs on iOS

SDFs can be enabled on iOS by adding a new field to the `Info.plist` for the
project.

```xml
  <key>FLTEnableSDFs</key>
  <true/>
```

[MSAA]: https://en.wikipedia.org/wiki/Multisample_anti-aliasing
[SSAA]: https://en.wikipedia.org/wiki/Supersampling
[Tiled rendering]: https://en.wikipedia.org/wiki/Tiled_rendering
[SDFs]: https://en.wikipedia.org/wiki/Signed_distance_function
[mesh]: https://en.wikipedia.org/wiki/Polygon_mesh
[shaders]: https://en.wikipedia.org/wiki/Shader
[FragmentShader API]: /ui/design/graphics/fragment-shaders
[drawPath()]: {{site.api}}/flutter/dart-ui/Canvas/drawPath.html
[`simple_sdf`]: {{site.github}}/flutter/samples/tree/main/simple_sdf
