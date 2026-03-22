---
title: Flutter AI Toolkit
shortTitle: AI Toolkit
description: >
  Learn how to add the AI Toolkit chatbot
  to your Flutter application.
next:
  title: User experience
  path: /ai/ai-toolkit/user-experience
---

Hello and welcome to the Flutter AI Toolkit!

The AI Toolkit is a set of AI chat-related widgets that make it easy to add an
AI chat window to your Flutter app. The AI Toolkit is organized around an
abstract LLM provider API to make it easy to swap out the LLM provider that
you'd like your chat provider to use. Out of the box, it comes with support for
[Firebase AI Logic][].

[Firebase AI Logic]: https://firebase.google.com/docs/ai-logic

## Key features

* **Multiturn chat**: Maintains context across multiple interactions.
* **Streaming responses**: Displays AI responses in real-time as they are
  generated.
* **Rich text display**: Supports formatted text in chat messages.
* **Voice input**: Allows users to input prompts using speech.
* **Multimedia attachments**: Enables sending and receiving various media types.
* **Function calling**: Supports tool calls to the LLM provider.
* **Custom styling**: Offers extensive customization to match your app's design.
* **Chat serialization/deserialization**: Store and retrieve conversations
  between app sessions.
* **Custom response widgets**: Introduce specialized UI components to present
  LLM responses.
* **Pluggable LLM support**: Implement a simple interface to plug in your own
  LLM.
* **Cross-platform support**: Compatible with Android, iOS, web, and macOS
  platforms.

## Demo

Here's what the demo example looks like hosting the AI Toolkit:

<img src="/assets/images/docs/ai-toolkit/ai-toolkit-app.png" alt="AI demo app">

The [source code for this demo][src-code] is available in the repo on GitHub.

Or, you can open it in [Firebase Studio][], Google's full-stack AI workspace and
IDE that runs in the cloud:

<a
  href="https://studio.firebase.google.com/new?template=https%3A%2F%2Fgithub.com%2Fflutter%2Fai">
    <picture> <source media="(prefers-color-scheme: dark)"
      srcset="https://cdn.firebasestudio.dev/btn/try_light_32.svg"> <source
      media="(prefers-color-scheme: light)"
    srcset="https://cdn.firebasestudio.dev/btn/try_dark_32.svg"> <img
      height="32" alt="Try in Firebase Studio"
      src="https://cdn.firebasestudio.dev/btn/try_blue_32.svg"> </picture> </a>

[src-code]: {{site.github}}/flutter/ai/blob/main/example/lib/demo/demo.dart
[Firebase Studio]: https://firebase.studio/

## Get started

<ol>
<li><b>Installation</b>

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_ai_toolkit: ^latest_version
  firebase_ai: ^latest_version
  firebase_core: ^latest_version
```
</li>

<li><b>Configuration</b>

The AI Toolkit supports both the Gemini endpoint (for prototyping) and the
Vertex endpoint (for production). Both require a Firebase project and the
`firebase_core` package to be initialized, as described in the [Get started with
the Gemini API using the Firebase AI Logic SDKs][firebase_ai] docs.

[firebase_ai]:
    https://firebase.google.com/docs/ai-logic/get-started?platform=flutter

Once that's complete, integrate the new Firebase project into your Flutter app
using the `flutterfire CLI` tool, as described in the [Add Firebase to your
Flutter app][firebase] docs.

[firebase]: https://firebase.google.com/docs/flutter/setup

After following these instructions, you're ready to use Firebase to integrate AI
in your Flutter app. Start by initializing Firebase:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ai/firebase_ai.dart';
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

With Firebase properly initialized in your Flutter app, you're now ready to
create an instance of the Firebase provider. You can do this in two ways. For
prototyping, consider the Gemini AI endpoint:

```dart
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

// ... app stuff here

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(App.title)),
        // create the chat view, passing in the Firebase provider
        body: LlmChatView(
          provider: FirebaseProvider(
            // Use the Google AI endpoint
            model: FirebaseAI.googleAI().generativeModel(
              model: 'gemini-2.5-flash',
            ),
          ),
        ),
      );
}
```

The `FirebaseProvider` class exposes the Firebase AI Logic SDK to the
`LlmChatView`. Note that you provide a model name ([you have several
options][options] from which to choose), but you do not provide an API key. All
of that is handled as part of the Firebase project.

For production workloads, it's easy to swap in the Firebase Logic AI endpoint:

```dart
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(App.title)),
        body: LlmChatView(
          provider: FirebaseProvider(
            // Use the Vertex AI endpoint
            model: FirebaseAI.vertexAI().generativeModel(
              model: 'gemini-2.5-flash',
            ),
          ),
        ),
      );
}
```


For a complete example, check out the [gemini.dart] and [vertex.dart][]
examples.

[options]:
    https://firebase.google.com/docs/vertex-ai/gemini-models#available-model-names
[gemini.dart]:
    {{site.github}}/flutter/ai/blob/main/example/lib/gemini/gemini.dart
[vertex.dart]:
    {{site.github}}/flutter/ai/blob/main/example/lib/vertex/vertex.dart
</li>

<li><b>Set up device permissions</b>

To enable your users to take advantage of features like voice input and media
attachments, ensure that your app has the necessary permissions:

* **Network access:** To enable network access on macOS, add the following to
  your `*.entitlements` files:

  ```xml
  <plist version="1.0">
    <dict>
      ...
      <key>com.apple.security.network.client</key>
      <true/>
    </dict>
  </plist>
  ```

  To enable network access on Android, ensure that your `AndroidManifest.xml`
  file contains the following:

  ```xml
  <manifest xmlns:android="http://schemas.android.com/apk/res/android">
      ...
      <uses-permission android:name="android.permission.INTERNET"/>
  </manifest>
  ```

* **Microphone access**: Configure according to the [record package's permission
  setup instructions][record].
* **File selection**: Follow the [file_selector plugin's instructions][file].
* **Image selection**: To take a picture on _or_ select a picture from their
  device, refer to the [image_picker plugin's installation
  instructions][image_picker].
* **Web photo**: To take a picture on the web, configure the app according to
  the [camera plugin's setup instructions][camera].

[camera]: {{site.pub-pkg}}/camera#setup
[file]: {{site.pub-pkg}}/file_selector#usage
[image_picker]: {{site.pub-pkg}}/image_picker#installation
[record]: {{site.pub-pkg}}/record#setup-permissions-and-others
</li>
</ol>

## Examples

**firebase_options.dart**

To use the [Vertex AI example app][vertex-ex], place your Firebase configuration
details into the `example/lib/firebase_options.dart` file. You can do this with
the `flutterfire CLI` tool as described in the [Add Firebase to your Flutter
app][add-fb] docs **from within the `example` directory**.

:::note Security considerations for `firebase_options.dart`

If your Flutter app calls Gemini or Vertex AI directly from the client, do not
commit `firebase_options.dart` to a public repository. Anyone could reuse your
app configuration to send requests to your AI endpoint, consuming quota and
potentially causing billing costs.

While this guide shows direct client-side calls for simplicity, for production
apps, you should route AI requests through a backend service (for example [Cloud
Functions for Firebase](https://firebase.google.com/docs/functions), [Cloud
Run](https://cloud.google.com/run), or your own server). In that setup, the
backend — not the client — controls access, and including
`firebase_options.dart` in your repository is safe.

You should also review and follow the [Firebase security checklist](https://firebase.google.com/support/guides/security-checklist).
:::

## Feedback

Along the way, as you use this package, please [log issues and feature
requests][file-issues] as well as submit any [code you'd like to
contribute][submit]. We want your feedback and your contributions to ensure that
the AI Toolkit is just as robust and useful as it can be for your real-world
apps.

[add-fb]: https://firebase.google.com/docs/flutter/setup
[example apps]: {{site.github}}/flutter/ai/tree/main/example/lib
[file-issues]: {{site.github}}/flutter/ai/issues
[submit]: {{site.github}}/flutter/ai/pulls
[vertex-ex]: {{site.github}}/flutter/ai/blob/main/example/lib/vertex/vertex.dart
