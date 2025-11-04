---
title: AI Toolkit
description: >
  Learn how to add the AI Toolkit chatbot
  to your Flutter application.
next:
  title: User experience
  path: /ai-toolkit/user-experience
---

Hello and welcome to the Flutter AI Toolkit!

:::note
These pages are now out of date. They will be
updated soon but, in the meantime, be aware that the
`google_generative_ai` and `vertexai_firebase` packages
are deprecated and replaced with [`package:firebase_ai`][].
:::

[`package:firebase_ai`]: {{site.pub-pkg}}/firebase_ai

The AI Toolkit is a set of AI chat-related widgets that make
it easy to add an AI chat window to your Flutter app.
The AI Toolkit is organized around an abstract
LLM provider API to make it easy to swap out the
LLM provider that you'd like your chat provider to use.
Out of the box, it comes with support for two LLM provider
integrations: Google Gemini AI and Firebase Vertex AI.

## Key features

* **Multi-turn chat**: Maintains context across multiple interactions.
* **Streaming responses**: Displays AI responses in
  real-time as they are generated.
* **Rich text display**: Supports formatted text in chat messages.
* **Voice input**: Allows users to input prompts using speech.
* **Multimedia attachments**: Enables sending and
  receiving various media types.
* **Custom styling**: Offers extensive customization to
  match your app's design.
* **Chat serialization/deserialization**: Store and retrieve conversations
  between app sessions.
* **Custom response widgets**: Introduce specialized UI components
  to present LLM responses.
* **Pluggable LLM support**: Implement a simple interface to plug
  in your own LLM.
* **Cross-platform support**: Compatible with Android, iOS, web,
  and macOS platforms.

## Online Demo

Here's the online demo hosting the AI Toolkit:

<a href="https://flutter-ai-toolkit-examp-60bad.web.app/">
<img src="/assets/images/docs/ai-toolkit/ai-toolkit-app.png" alt="AI demo app">
</a>

The [source code for this demo][src-code] is available in the repo on GitHub.

Or, you can open it in [Firebase Studio][],
Google's full-stack AI workspace and IDE that runs in the cloud:

<a href="https://studio.firebase.google.com/new?template=https%3A%2F%2Fgithub.com%2Fflutter%2Fai">
  <picture>
    <source
      media="(prefers-color-scheme: dark)"
      srcset="https://cdn.firebasestudio.dev/btn/try_light_32.svg">
    <source
      media="(prefers-color-scheme: light)"
      srcset="https://cdn.firebasestudio.dev/btn/try_dark_32.svg">
    <img
      height="32"
      alt="Try in Firebase Studio"
      src="https://cdn.firebasestudio.dev/btn/try_blue_32.svg">
  </picture>
</a>

[src-code]: {{site.github}}/flutter/ai/blob/main/example/lib/demo/demo.dart
[Firebase Studio]: https://firebase.studio/

## Get started

<ol>
<li><b>Installation</b>

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_ai_toolkit: ^latest_version
  google_generative_ai: ^latest_version # you might choose to use Gemini,
  firebase_core: ^latest_version        # or Vertex AI or both
```
</li>

<li><b>Gemini AI configuration</b>

The toolkit supports both Google Gemini AI and
Firebase Vertex AI as LLM providers.
To use Google Gemini AI,
[obtain an API key][] from Gemini AI Studio.
Be careful not to check this key into your source code
repository to prevent unauthorized access.

[obtain an API key]: https://aistudio.google.com/app/apikey

You'll also need to choose a specific Gemini model name
to use in creating an instance of the Gemini model.
The following example uses `gemini-2.0-flash`,
but you can choose from an [ever-expanding set of models][models].

[models]: https://ai.google.dev/gemini-api/docs/models/gemini


```dart
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

// ... app stuff here

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(App.title)),
        body: LlmChatView(
          provider: GeminiProvider(
            model: GenerativeModel(
              model: 'gemini-2.0-flash',
              apiKey: 'GEMINI-API-KEY',
            ),
          ),
        ),
      );
}
```

The `GenerativeModel` class comes from the
`google_generative_ai` package.
The AI Toolkit builds on top of this package with
the `GeminiProvider`, which plugs Gemini AI into the
`LlmChatView`, the top-level widget that provides an
LLM-based chat conversation with your users.

For a complete example, check out [`gemini.dart`][] on GitHub.

[`gemini.dart`]: {{site.github}}/flutter/ai/blob/main/example/lib/gemini/gemini.dart
</li>

<li><b>Vertex AI configuration</b>

While Gemini AI is useful for quick prototyping,
the recommended solution for production apps is
Vertex AI in Firebase. This eliminates the need
for an API key in your client app and replaces it
with a more secure Firebase project.
To use Vertex AI in your project,
follow the steps described in the
[Get started with the Gemini API using the Vertex AI in Firebase SDKs][vertex] docs.

[vertex]: https://firebase.google.com/docs/vertex-ai/get-started?platform=flutter

Once that's complete, integrate the new Firebase project
into your Flutter app using the `flutterfire CLI` tool,
as described in the [Add Firebase to your Flutter app][firebase] docs.

[firebase]: https://firebase.google.com/docs/flutter/setup

After following these instructions,
you're ready to use Firebase Vertex AI in your Flutter app.
Start by initializing Firebase:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

// ... other imports

import 'firebase_options.dart'; // from `flutterfire config`

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

// ...app stuff here
```

With Firebase properly initialized in your Flutter app,
you're now ready to create an instance of the Vertex provider:

```dart
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(App.title)),
        // create the chat view, passing in the Vertex provider
        body: LlmChatView(
          provider: VertexProvider(
            chatModel: FirebaseVertexAI.instance.generativeModel(
              model: 'gemini-2.0-flash',
            ),
          ),
        ),
      );
}
```


The `FirebaseVertexAI` class comes from the
`firebase_vertexai` package. The AI Toolkit
builds the `VertexProvider` class to expose
Vertex AI to the `LlmChatView`.
Note that you provide a model name
([you have several options][options] from which to choose),
but you do not provide an API key.
All of that is handled as part of the Firebase project.

For a complete example, check out [vertex.dart][] on GitHub.

[options]: https://firebase.google.com/docs/vertex-ai/gemini-models#available-model-names
[vertex.dart]: {{site.github}}/flutter/ai/blob/main/example/lib/vertex/vertex.dart
</li>

<li><b>Set up device permissions</b>

To enable your users to take advantage of features like voice input and media
attachments, ensure that your app has the necessary permissions:

* **Network access:**
  To enable network access on macOS,
  add the following to your `*.entitlements` files:

  ```xml
  <plist version="1.0">
    <dict>
      ...
      <key>com.apple.security.network.client</key>
      <true/>
    </dict>
  </plist>
  ```

  To enable network access on Android,
  ensure that your `AndroidManifest.xml` file contains the following:

  ```xml
  <manifest xmlns:android="http://schemas.android.com/apk/res/android">
      ...
      <uses-permission android:name="android.permission.INTERNET"/>
  </manifest>
  ```

* **Microphone access**: Configure according to the
  [record package's permission setup instructions][record].
* **File selection**: Follow the [file_selector plugin's instructions][file].
* **Image selection**: To take a picture on _or_ select a picture from their
  device, refer to the
  [image_picker plugin's installation instructions][image_picker].
* **Web photo**: To take a picture on the web, configure the app
  according to the [camera plugin's setup instructions][camera].

[camera]: {{site.pub-pkg}}/camera#setup
[file]: {{site.pub-pkg}}/file_selector#usage
[image_picker]: {{site.pub-pkg}}/image_picker#installation
[record]: {{site.pub-pkg}}/record#setup-permissions-and-others
</li>
</ol>

## Examples

To execute the [example apps][] in the repo,
you'll need to replace the `example/lib/gemini_api_key.dart`
and `example/lib/firebase_options.dart` files,
both of which are just placeholders. They're needed
to enable the example projects in the `example/lib` folder.

**gemini_api_key.dart**

Most of the example apps rely on a Gemini API key,
so for those to work, you'll need to plug your API key
in the `example/lib/gemini_api_key.dart` file.
You can get an API key in [Gemini AI Studio][].

:::note
**Be careful not to check the `gemini_api_key.dart` file into your git repo.**
:::

**firebase_options.dart**

To use the [Vertex AI example app][vertex-ex],
place your Firebase configuration details
into the `example/lib/firebase_options.dart` file.
You can do this with the `flutterfire CLI` tool as described
in the [Add Firebase to your Flutter app][add-fb] docs
**from within the `example` directory**.

:::note
**Be careful not to check the `firebase_options.dart`
file into your git repo.**
:::

## Feedback!

Along the way, as you use this package,
please [log issues and feature requests][file-issues] as well as
submit any [code you'd like to contribute][submit].
We want your feedback and your contributions
to ensure that the AI Toolkit is just as robust and useful
as it can be for your real-world apps.

[add-fb]: https://firebase.google.com/docs/flutter/setup
[example apps]: {{site.github}}/flutter/ai/tree/main/example/lib
[file-issues]: {{site.github}}/flutter/ai/issues
[Gemini AI Studio]: https://aistudio.google.com/app/apikey
[submit]: {{site.github}}/flutter/ai/pulls
[vertex-ex]: {{site.github}}/flutter/ai/blob/main/example/lib/vertex/vertex.dart
