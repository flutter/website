---
title: GenUI SDK main components and concepts
sidenav: ai
breadcrumb: Main components & concepts
description: >-
  Familiarize yourself with the main components and concepts of the
  Flutter for GenUI SDK.
prev:
  title: GenUI SDK overview
  path: /ai/genui
next:
  title: Get started with the GenUI SDK
  path: /ai/genui/get-started
---

:::experimental
The `genui` package is in
alpha and is likely to change.
:::

## Main components

The [`genui`][] package is built around the following main components:

`Conversation`
: The primary facade and entry point for the package.
  It includes the `SurfaceController` class,
  manages the conversation history,
  and orchestrates the entire generative UI process.

`Catalog`
: A collection of `CatalogItem` objects that defines
  the set of widgets that the AI is allowed to use.
  The `SurfaceController` supports multiple catalogs,
  allowing you to organize your widgets into logical groups.
  Each `CatalogItem` specifies a widget's name (for the AI
  to reference), a data schema for its properties, and a
  builder function to render the Flutter widget.

`DataModel`
: A centralized, observable store for all dynamic UI state.
  Widgets are _bound_ to data in this model. When data changes,
  only the widgets that depend on that specific piece of data are rebuilt.

`A2uiTransportAdapter`
: A bridge that parses raw text streams coming from your LLM into
  `A2uiMessage` commands for the `SurfaceController`.

`A2uiMessage`
: A message sent from the AI
  (parsed by the `A2uiTransportAdapter`) to the UI,
  instructing it to perform actions like `createSurface`,
  `surfaceUpdate`, `dataModelUpdate`, or `deleteSurface`.

`SurfaceController`
: Handles the processing of `A2uiMessage`s,
  manages the `DataModel`, and maintains the state of UI surfaces.


## How it works

The `Conversation` manages the interaction cycle:

 1. **User input**

    The user provides a prompt (for example, through a text field).
    The app calls `conversation.sendMessage()`.

 2. **AI invocation**

    The `Conversation` sends the user's message to the LLM SDK.

 3. **AI response**

    The LLM, guided by the widget schemas provided in its system prompt,
    sends back responses.

 4. **Stream handling**

    The text stream from the LLM SDK is fed into the `A2uiTransportAdapter`.

 5. **UI state update**

    `A2uiMessages` parsed by the adapter are passed to
    `SurfaceController.handleMessage()`, which updates
    the UI state and `DataModel`.

 6. **UI rendering**

    The `SurfaceController` broadcasts an update,
    and any `Surface` widgets listening for that surface ID will rebuild.
    Widgets are bound to the `DataModel`, so they update automatically
    when their data changes.

 7. **Callbacks**

    Text responses and errors trigger callbacks on the `Conversation` or
    are handled by your specific LLM integration flow.

 8. **User interaction**

    The user interacts with the newly generated UI
    (for example, by typing in a text field). This interaction directly
    updates the `DataModel`. If the interaction is an action (like a button click),
    the `Surface` captures the event and forwards it to the
    `SurfaceController`, which automatically creates
    a new `UserMessage` containing the current state of the data model
    and restarts the cycle.

{:.steps}

For more detailed information on the implementation of GenUI SDK for Flutter,
check out the [design doc][].

The next section walks you through adding `genui` to your app.

[design doc]: {{site.repo.organization}}/genui/blob/main/packages/genui/DESIGN.md
[`genui`]: {{site.pub-pkg}}/genui
