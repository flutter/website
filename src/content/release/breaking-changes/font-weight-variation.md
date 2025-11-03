---
title: FontWeight also controls the weight attribute of variable fonts
description: >
  FontWeight values applied to text styles will now set the weight attribute of variable fonts.
---

{% render "docs/breaking-changes.md" %}

## Summary

A `FontWeight` in a text style will also set the weight attribute of variable
fonts. It is no longer necessary to separately use `FontVariation` to control
the weight of these fonts.

## Context

Text styles can specify a `FontWeight` value that configures the thickness of
the strokes used to paint the text. `FontWeight` will select the closest
weight among a set of font files belonging to the same family.

However, some fonts are distributed as [variable fonts](https://fonts.google.com/knowledge/introducing_type/introducing_variable_fonts)
where a single font file allows adjustment of attributes such as weight. For
variable fonts, applications also had to use the `FontVariation` API to set
the value of the weight variation axis within the selected font file.

Flutter has now changed the behavior of `FontWeight` so that it will both
select the closest matching font file and set the weight attribute of variable
fonts.

## Description of change

Setting the `fontWeight` property of objects such as `TextStyle` will now also
set the value of the `wght` variation axis of fonts that support it. Flutter
will internally apply the equivalent of adding a `FontVariation('wght')`
attribute to the style whose value is the same as the `FontWeight`.

`FontWeight` instances can now be constructed using arbitrary integer values
ranging from 1 to 1000. This allows usage of weights beyond the
`FontWeight.w100` through `FontWeight.w900` range with values that are not
multiples of 100. This also means that linear interpolation of fonts using
`FontWeight.lerp` can yield values other than `FontWeight.w100` through `w900`.

The `FontWeight.index` property is now deprecated because it only identifies
the `FontWeight.w100` through `w900` weights. Applications should use
`FontWeight.value` to obtain the thickness level of a font.

## Migration guide

Applications may see changes in text rendering if they used variable fonts and
were specifying `FontWeight` in text styles without a matching
`FontVariation('wght')` value.

If these changes are undesirable, then the application should change the
`FontWeight` to a value that achieves the intended rendering. For example,
to restore the font's default weight, set `fontWeight` to `FontWeight.normal`.

## Timeline

Landed in version: 3.39.0-0.0.pre<br>
In stable release: Not yet

## References

API documentation:

* [`FontWeight`][]

Relevant issue:

* [Issue 148026][]

Relevant PR:

* [PR 175771][]

[`FontWeight`]: {{site.api}}/flutter/dart-ui/FontWeight-class.html
[Issue 148026]: {{site.repo.flutter}}/issues/148026
[PR 175771]: {{site.repo.flutter}}/pull/175771
