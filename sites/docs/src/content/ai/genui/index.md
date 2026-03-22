---
title: GenUI SDK for Flutter
shortTitle: GenUI SDK
description: >-
  Learn how to use GenUI SDK for Flutter to build more
  interactive experiences for applications and chatbots.
next:
  title: GenUI SDK main components & concepts
  path: /ai/genui/components
---

## What is GenUI?

At its core, the GenUI SDK for Flutter is an orchestration layer.
This suite of packages coordinates the flow of information between your user,
your Flutter widgets, and an AI agent,
transforming text-based conversations into rich, interactive experiences.

Imagine that, instead of presenting your user with a wall of text,
they are presented with a graphical UI consisting of (for example),
a row of labeled buttons and a date picker.

The GenUI SDK for Flutter uses a JSON-based format to
compose a UI from your existing
widget catalog. As a user interacts with the UI,
state changes are fed back to the agent,
creating a high-bandwidth loop and turning
an agent interaction into a rich, intuitive experience.

The GenUI SDK for Flutter is designed to easily integrate
into your Flutter application.

## When would you use it?

Use GenUI SDK for Flutter to incorporate graphical UI
into your app.  For example:

* Instead of describing a list of products in text,
  use it to render a clickable carousel of product widgets.
* When a user asks to plan a trip, use it to generate a
  complete form with sliders, date pickers, and text fields.

For more context about GenUI SDK for Flutter,
check out the [Getting started with GenUI video][]:

<YouTubeEmbed id="nWr6eZKM6no" title="Getting started with GenUI"></YouTubeEmbed>

:::experimental
The `genui` package is in
alpha and is likely to change.
:::

[Getting started with GenUI video]: https://www.youtube.com/watch?v=nWr6eZKM6no
