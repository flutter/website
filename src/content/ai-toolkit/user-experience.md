---
title: User experience
description: >
  How the user will experience the AI Toolkit in your app.
prev:
  title: AI Toolkit overview
  path: /ai-toolkit/
next:
  title: Feature integration
  path: /ai-toolkit/feature-integration
---

The [`LlmChatView`][] widget is the entry point for the
interactive chat experience that AI Toolkit provides.
Hosting an instance of the `LlmChatView` enables a
number of user experience features that don't require
any additional code to use:

* **Multi-line text input**: Allows users to paste long text
  input or insert new lines into their text as they enter it.
* **Voice input**: Allows users to input prompts using speech
  for ease of use.
* **Multimedia input**: Enables users to take pictures and
  send images and other file types.
* **Image zoom**: Enables users to zoom into image thumbnails.
* **Copy to clipboard**: Allows the  user to copy the text of
  a message or a LLM response to the clipboard.
* **Message editing**: Allows the user to edit the most recent
  message for resubmission to the LLM.
* **Material and Cupertino**: Adapts to the best practices of
  both design languages.

[`LlmChatView`]: {{site.pub-api}}/flutter_ai_toolkit/latest/flutter_ai_toolkit/LlmChatView-class.html

## Multi-line text input

The user has  options when it comes to submitting
their prompt once they've finished composing it,
which again differs depending on their platform:

* **Mobile**: Tap the **Submit** button
* **Web**: Press **Enter** or tap the **Submit** button
* **Desktop**: Press **Enter** or tap the **Submit** button

In addition, the chat view supports text prompts
with embedded newlines in them. If the user has existing
text with newlines, they can paste them into the
prompt text field as normal.

If they'd like to embed newlines into their prompt
manually as they enter it, they can do so.
The gesture for that activity differs based on the
platform they're using:

* **Mobile**: Tap Return key on the virtual keyboard
* **Web**: Unsupported
* **Desktop**: Press `Ctrl+Enter` or `Opt/Alt+Enter`

These options look like the following:

**Desktop**:

![Screenshot of entering text on desktop](/assets/images/docs/ai-toolkit/desktop-enter-text.png)

**Mobile**:

![Screenshot of entering text on mobile](/assets/images/docs/ai-toolkit/mobile-enter-text.png)

## Voice input

In addition to text input the chat view can take an
audio recording as input by tapping the Mic button,
which is visible when no text has yet been entered.

Tapping the **Mic** button starts the recording:

![Screenshot of entering text](/assets/images/docs/ai-toolkit/enter-textfield.png)

Pressing the **Stop** button translates the user's voice input into text:

This text can then be edited, augmented and submitted as normal.

![Screenshot of entered voice](/assets/images/docs/ai-toolkit/enter-voice-into-textfield.png)

## Multi-media Input

![Textfield containing "Testing, testing, one, two, three"](/assets/images/docs/ai-toolkit/multi-media-testing-testing.png)

The chat view can also take images and files as input to pass along
to the underlying LLM. The user can press the **Plus** button to the
left of the text input and choose from the **Take Photo**, **Image Gallery**,
and **Attach File** icons:

![Screenshot of the 4 icons](/assets/images/docs/ai-toolkit/multi-media-icons.png)

The **Take Photo** button allows the user to use their device's camera to take a photo:

![Selfie image](/assets/images/docs/ai-toolkit/selfie.png)

Pressing the **Image Gallery** button lets the user upload
from their device's image gallery:

![Download image from gallery](/assets/images/docs/ai-toolkit/download-from-gallery.png)

Pressing the **Attach File** button lets the user select
a file of any type available on their device, like a PDF or TXT file.

Once a photo, image, or file has been selected, it becomes an attachment and shows up as a thumbnail associated with the currently active prompt:

![Thumbnails of images](/assets/images/docs/ai-toolkit/image-thumbnails.png)

The user can remove an attachment by clicking the
**X** button on the thumbnail.

## Image zoom

The user can zoom into an image thumbnail by tapping it:

![Zoomed image](/assets/images/docs/ai-toolkit/image-zoom.png)

Pressing the **ESC** key or tapping anywhere outside the
image dismisses the zoomed image.

## Copy to clipboard

The user can copy any text prompt or LLM response
in their current chat in a variety of ways.
On the desktop or the web, the user can mouse
to select the text on their screen and
copy it to the clipboard as normal:

![Copy to clipboard](/assets/images/docs/ai-toolkit/copy-to-clipboard.png)

In addition, at the bottom of each prompt or response,
the user can press the **Copy** button that pops up
when they hover their mouse:

![Press the copy button](/assets/images/docs/ai-toolkit/chatbot-prompt.png)

On mobile platforms, the user can long-tap a prompt or response and choose the Copy option:

![Long tap to see the copy button](/assets/images/docs/ai-toolkit/long-tap-choose-copy.png)

## Message editing

If the user would like to edit their last prompt
and cause the LLM to take another run at it,
they can do so. On the desktop,
the user can tap the **Edit** button alongside the
**Copy** button for their most recent prompt:

![How to edit prompt](/assets/images/docs/ai-toolkit/how-to-edit-prompt.png)

On a mobile device, the user can long-tap and get access
to the **Edit** option on their most recent prompt:

![How to access edit menu](/assets/images/docs/ai-toolkit/accessing-edit-menu.png)

Once the user taps the **Edit** button, they enter Editing mode,
which removes both the user's last prompt and the LLM's
last response from the chat history,
puts the text of the prompt into the text field, and
provides an Editing indicator:

![How to exit editing mode](/assets/images/docs/ai-toolkit/how-to-exit-editing-mode.png)

In Editing mode, the user can edit the prompt as they choose
and submit it to have the LLM produce a response as normal.
Or, if they change their mind, they can tap the **X**
near the Editing indicator to cancel their edit and restore
their previous LLM response.

## Material and Cupertino

When the `LlmChatView` widget is hosted in a [Material app][],
it uses facilities provided by the Material design language,
such as Material's [`TextField`][].
Likewise, when hosted in a [Cupertino app][],
it uses those facilities, such as [`CupertinoTextField`][].

![Cupertino example app](/assets/images/docs/ai-toolkit/cupertino-chat-app.png)

However, while the chat view supports both the Material and
Cupertino app types, it doesn't automatically adopt the associated themes.
Instead, that's set by the `style` property of the `LlmChatView`
as described in the [Custom styling][] documentation.

[Cupertino app]: {{site.api}}/flutter/cupertino/CupertinoApp-class.html
[`CupertinoTextField`]: {{site.api}}/flutter/cupertino/CupertinoTextField-class.html
[Custom styling]: /ai-toolkit/feature-integration#custom-styling
[Material app]: {{site.api}}/flutter/material/MaterialApp-class.html
[`TextField`]: {{site.api}}/flutter/material/TextField-class.html
