---
title: GenUI SDK main components and concepts
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

`GenUiConversation`
: The primary facade and entry point for the package.
  It includes the `A2uiMessageProcessor` and `ContentGenerator` classes,
  manages the conversation history,
  and orchestrates the entire generative UI process.

`Catalog`
: A collection of `CatalogItem` objects that defines
  the set of widgets that the AI is allowed to use.
  The `A2uiMessageProcessor` supports multiple catalogs,
  allowing you to organize your widgets into logical groups.
  Each `CatalogItem` specifies a widget's name (for the AI
  to reference), a data schema for its properties, and a
  builder function to render the Flutter widget.

`DataModel`
: A centralized, observable store for all dynamic UI state.
  Widgets are _bound_ to data in this model. When data changes,
  only the widgets that depend on that specific piece of data are rebuilt.

`ContentGenerator`
: An interface for communicating with a generative AI model.
  This interface uses streams to send `A2uiMessage` commands,
  text responses, and errors back to the `GenUiConversation`.

`A2uiMessage`
: A message sent from the AI
  (through the `ContentGenerator`) to the UI,
  instructing it to perform actions like `beginRendering`,
  `surfaceUpdate`, `dataModelUpdate`, or `deleteSurface`.

`A2uiMessageProcessor`
: Handles the processing of `A2uiMessage`s,
  manages the `DataModel`, and maintains the state of UI surfaces.

## How it works

The `GenUiConversation` manages the interaction cycle:

 1. **User input**

    The user provides a prompt (for example, through a text field).
    The app calls `genUiConversation.sendRequest()`.

 2. **AI invocation**

    The `GenUiConversation` adds the user's message to its
    internal conversation history and calls `contentGenerator.sendRequest()`.

 3. **AI response**

    The `ContentGenerator` interacts with the AI model.
    The AI, guided by the widget schemas, sends back responses.

 4. **Stream handling**

    The `ContentGenerator` emits A2uiMessages,
    text responses, or errors on its streams.

 5. **UI state update**

    `GenUiConversation` listens to these streams.
    `A2uiMessages` are passed to `A2uiMessageProcessor.handleMessage()`,
    which updates the UI state and `DataModel`.

 6. **UI rendering**

    The `A2uiMessageProcessor` broadcasts an update,
    and any `GenUiSurface` widgets listening for that surface ID will rebuild.
    Widgets are bound to the `DataModel`, so they update automatically
    when their data changes.

 7. **Callbacks**

    Text responses and errors trigger the `onTextResponse`
    and `onError` callbacks on `GenUiConversation`.

 8. **User interaction**

    The user interacts with the newly generated UI
    (for example, by typing in a text field). This interaction directly
    updates the `DataModel`. If the interaction is an action (like a button click),
    the `GenUiSurface` captures the event and forwards it to the
    `GenUiConversation`'s `A2uiMessageProcessor`, which automatically creates
    a new `UserMessage` containing the current state of the data model
    and restarts the cycle.

{:.steps}

For more detailed information on the implementation of GenUI SDK for Flutter,
check out the [design doc][].

The next section walks you through adding `genui` to your app.

[design doc]: {{site.repo.organization}}/genui/blob/main/packages/genui/DESIGN.md
[`genui`]: {{site.pub-pkg}}/genui
