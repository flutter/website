--- 
title: Get start with GenUI SDK for Flutter
description: >
  Learn how to use GenUI SDK for Flutter to add it
  to your existing Flutter app.
---

This guide explains how to get started with the
[`flutter_genui`][] package. The SDK's key components
are described in the [Key components][] page.

```Warning
The `flutter_genui` package is
experimental and is likely to change.
```

Use the following instructions to add `flutter_genui` to your Flutter app.
The code examples show how to perform the instructions on a brand new
app created by running flutter create but you can follow the same
steps for your existing Flutter app.

## Configure your agent provider

`flutter_genui` can connect to a variety of agent providers.
Choose the section for your preferred provider.

### Configure Firebase AI logic

To use the built-in `FirebaseAiContentGenerator` to connect
to Gemini via Firebase AI Logic, follow these instructions:

1. [Create a new Firebase project][] using the Firebase Console.

2. [Enable the Gemini API][] for that project.

3. Follow the first three steps in [Firebase's Flutter setup guide][]
   to add Firebase to your app.

4. In `pubspec.yaml`, add `flutter_genui` and `flutter_genui_firebase_ai`
   to the `dependencies` section. As of this writing,
   it's best to use pub's git dependency to refer directly to this project's source.

```yml
dependencies:
  # ...
  flutter_genui:
    git:
      url: https://github.com/flutter/genui.git
      path: packages/flutter_genui
      ref: main
  flutter_genui_firebase_ai:
    git:
      url: https://github.com/flutter/genui.git
      path: packages/flutter_genui_firebase_ai
      ref: main
```

5. In your app's `main` method, ensure that the widget
   bindings are initialized, and then initialize Firebase.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
```

### Configure another agent provider

To use `flutter_genui` with another agent provider,
follow that provider's instructions to configure your app,
and then create your own subclass of `ContentGenerator` to connect
to that provider. Use `FirebaseAiContentGenerator` as an example
of how to do so.

## Create the connection to an agent

If you build your Flutter project for iOS or macOS,
add this key to your `{ios,macos}/Runner/*.entitlements` file(s)
to enable outbound network requests:

```xml
<dict>
...
<key>com.apple.security.network.client</key>
<true/>
</dict>
```

Next, use the following instructions to connect your app
to your chosen agent provider.

1. Create a `GenUiManager`, and provide it with the catalog
   of widgets that you want to make available to the agent.

2. Create a `ContentGenerator`, and provide it with a
   system instruction and a set of tools (functions
   you want the agent to be able to invoke).
   You should always include those provided by `GenUiManager`,
   but feel free to include others.

3. Create a `GenUiConversation` using the instances of `ContentGenerator`
   and `GenUiManager`. Your app will primarily interact with this object
   to get things done.

   For example:

```dart
class _MyHomePageState extends State<MyHomePage> {
  late final GenUiManager _genUiManager;
  late final GenUiConversation _genUiConversation;

  @override
  void initState() {
    super.initState();

    // Create a GenUiManager with a widget catalog.
    // The CoreCatalogItems contain basic widgets for text, markdown, and images.
    _genUiManager = GenUiManager(catalog: CoreCatalogItems.asCatalog());

    // Create a ContentGenerator to communicate with the LLM.
    // Provide system instructions and the tools from the GenUiManager.
    final contentGenerator = FirebaseAiContentGenerator(
      systemInstruction: '''
        You are an expert in creating funny riddles. Every time I give you a word,
        you should generate UI that displays one new riddle related to that word.
        Each riddle should have both a question and an answer.
        ''',
      tools: _genUiManager.getTools(),
    );

    // Create the GenUiConversation to orchestrate everything.
    _genUiConversation = GenUiConversation(
      genUiManager: _genUiManager,
      contentGenerator: contentGenerator,
      onSurfaceAdded: _onSurfaceAdded, // Added in the next step.
      onSurfaceDeleted: _onSurfaceDeleted, // Added in the next step.
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _genUiConversation.dispose();

    super.dispose();
  }
}
```
   
## Send messages and display the agent's responses

Send a message to the agent using the `sendRequest` method
in the `GenUiConversation` class.

To receive and display generated UI:

1. Use the callbacks in `GenUiConversation` to track the addition
  and removal of UI surfaces as they are generated.
  These events include a "surface ID" for each surface.

2. Build a `GenUiSurface` widget for each active surface using
  the surface IDs received in the previous step.

  For example:

```dart
class _MyHomePageState extends State<MyHomePage> {

  // ...

  final _textController = TextEditingController();
  final _surfaceIds = <String>[];

  // Send a message containing the user's text to the agent.
  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _genUiConversation.sendRequest(UserMessage.text(text));
  }

  // A callback invoked by the [GenUiConversation] when a new UI surface is generated.
  // Here, the ID is stored so the build method can create a GenUiSurface to
  // display it.
  void _onSurfaceAdded(SurfaceAdded update) {
    setState(() {
      _surfaceIds.add(update.surfaceId);
    });
  }

  // A callback invoked by GenUiConversation when a UI surface is removed.
  void _onSurfaceDeleted(SurfaceRemoved update) {
    setState(() {
      _surfaceIds.remove(update.surfaceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _surfaceIds.length,
              itemBuilder: (context, index) {
                // For each surface, create a GenUiSurface to display it.
                final id = _surfaceIds[index];
                return GenUiSurface(host: _genUiConversation.host, surfaceId: id);
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter a message',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Send the user's text to the agent.
                      _sendMessage(_textController.text);
                      _textController.clear();
                    },
                    child: const Text('Send'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

[Create a new Firebase project]: https://support.google.com/appsheet/answer/10104995
[Enable the Gemini API]: https://firebase.google.com/docs/gemini-in-firebase/set-up-gemini
[Firebase's Flutter setup guide]: https://firebase.google.com/docs/flutter/setup
[Key components]: /ai/genui/components
