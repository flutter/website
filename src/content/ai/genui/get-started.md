--- 
title: Get start with GenUI SDK for Flutter
description: >
  Learn how to use GenUI SDK for Flutter to add it
  to your existing Flutter app.
---

This guide explains how to get started with the
[`genui`][] package. The SDK's key components
are described in the [Key components][] page.

```Warning
The `genui` package is in alpha
and is likely to change.
```

Use the following instructions to add `genui` to your Flutter app.
The code examples show how to perform the instructions on a brand new
app created by running flutter create but you can follow the same
steps for your existing Flutter app.

## Configure your agent provider

`genui` can connect to a variety of agent providers.
Choose the section for your preferred provider.

### Configure Firebase AI logic

To use the built-in `FirebaseAiContentGenerator` to connect
to Gemini using the Firebase AI Logic, follow these instructions:

1. [Create a new Firebase project][] using the Firebase Console.

2. [Enable the Gemini API][] for that project.

3. Follow the first three steps in [Firebase's Flutter setup guide][]
   to add Firebase to your app.

4. In `pubspec.yaml`, add `genui` and `genui_firebase_ai`
   to the `dependencies` section. As of this writing,
   it's best to use pub's git dependency to refer directly to this project's source.

```yml
dependencies:
  # ...
  genui: 0.5.0
  genui_firebase_ai: 0.5.0
```

5. In your app's `main` method, ensure that the widget
   bindings are initialized and then initialize Firebase.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
```

### Configure another agent provider

To use `genui` with another agent provider,
follow that provider's instructions to configure your app,
and then create your own subclass of `ContentGenerator` to connect
to that provider. Use `FirebaseAiContentGenerator` or
`A2uiContentGenerator` (from the `genui_a2ui` package)
as examples of how to do so.

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
  These events include a _surface ID_ for each surface.

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

## [Optional] Add your own widgets to the catalog

In addition to using the catalog of widgets in `CoreCatalogItems`,
you can create custom widgets for the agent to generate.
Use the following instructions.

1. Import `json_schema_builder`

Add the `json_schema_builder` package as a dependency in `pubspec.yaml`.
Use the same commit reference as the one for `genui`.

```yml
dependencies:
  # ...
  json_schema_builder:
    git:
      url: https://github.com/flutter/genui.git
      path: packages/json_schema_builder
```

2. Create the new widget's schema

Each catalog item needs a schema that defines the data required
to populate it. Using the json_schema_builder package,
define one for the new widget.

```dart
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';

final _schema = S.object(
  properties: {
    'question': S.string(description: 'The question part of a riddle.'),
    'answer': S.string(description: 'The answer part of a riddle.'),
  },
  required: ['question', 'answer'],
);

```

3. Create a `CatalogItem`

Each `CatalogItem` represents a type of widget that the agent
is allowed to generate. To do that, combines a name,
a schema, and a builder function that produces the widgets
that compose the generated UI.

```dart
final riddleCard = CatalogItem(
  name: 'RiddleCard',
  dataSchema: _schema,
  widgetBuilder:
      ({
        required data,
        required id,
        required buildChild,
        required dispatchEvent,
        required context,
        required dataContext,
      }) {
        final json = data as Map<String, Object?>;
        final question = json['question'] as String;
        final answer = json['answer'] as String;

        return Container(
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(border: Border.all()),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8.0),
              Text(answer, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        );
      },
);
```

4. Add the `CatalogItem` to the catalog

Include your catalog items when instantiating `GenUiManager`.

```dart
_genUiManager = GenUiManager(
  catalog: CoreCatalogItems.asCatalog().copyWith([riddleCard]),
);
```

5. Update the system instruction to use the new widget

To make sure that the agent knows to use your new widget,
tell the system instruction how and when to do so.
Provide the name from the `CatalogItem` when you do.

```dart
final contentGenerator = FirebaseAiContentGenerator(
  systemInstruction: '''
      You are an expert in creating funny riddles. Every time I give you a word,
      you should generate a RiddleCard that displays one new riddle related to that word.
      Each riddle should have both a question and an answer.
      ''',
  tools: _genUiManager.getTools(),
);
```

## Data model and data binding

A core concept in `genui` is the `DataModel`, a centralized,
observable store for all dynamic UI state. Instead of each widget
managing its own state, its state is stored in the `DataModel`.

Widgets are _bound_ to data in this model.
When data in the model changes, only the widgets that depend
on that specific piece of data are rebuilt.
This is achieved through a `DataContext` object passed to each
widget's builder function.

### Binding to the data model

To bind a widget's property to the data model,
specify a special JSON object in the data sent from the AI.
This object can contain either a `literalString`
(for static values) or a `path` (to bind to a value in the data model).

For example, to display a user's name in a `Text` widget,
the AI would generate:

```dart
{
  "Text": {
    "text": {
      "literalString": "Welcome to GenUI"
    },
    "hint": "h1"
  }
}
```

### Image

```dart
{
  "Image": {
    "url": {
      "literalString": "https://example.com/image.png"
    },
    "hint": "mediumFeature"
  }
}
```

### Updating the data model

Input widgets, like `TextField`, update the DataModel directly.
When the user types in a text field that is bound to `/user/name`,
the `DataModel` updates, and any other widgets bound to that same
path will automatically rebuild to show the new value.

This reactive data flow simplifies state management and creates a powerful,
high-bandwidth interaction loop between the user, the UI, and the AI.

## Next steps

Check out the [examples][] included in the `genui` repo.
The [travel app][] shows how to define your own widget
catalog that the agent can use to generate domain-specific UI.

If something is unclear or missing, please [create an issue][].

## System instructions

The `genui` package gives the LLM a set of tools it can use to
generate UI. To get the LLM to use these tools,
the `systemInstruction` provided to `ContentGenerator` must explicitly
tell it to do so. This is why the previous example includes a
system instruction for the agent with the line
"Every time I give you a word, you should generate UI that displays one new riddle...".

## Troubleshooting/FAQ

### How can I configure logging?

To observe communication between your app and the agent,
enable logging in your `main` method.

```dart
import 'package:logging/logging.dart';
import 'package:genui/genui.dart';

final logger = configureGenUiLogging(level: Level.ALL);

void main() async {
  logger.onRecord.listen((record) {
    debugPrint('${record.loggerName}: ${record.message}');
  });

  // Additional initialization of bindings and Firebase.
}
```

### I'm getting errors about my minimum macOS/iOS version.

Firebase has a [minimum version requirement][] for Apple's platforms,
which might be higher than Flutter's default.
Check your `Podfile` (for iOS) and `CMakeLists.txt` (for macOS)
to ensure that you're targeting a version that meets or exceeds
Firebase's requirements.


[Create a new Firebase project]: https://support.google.com/appsheet/answer/10104995
[create an issue]: {{site.organization}}/genui/issues/new/choose
[Enable the Gemini API]: https://firebase.google.com/docs/gemini-in-firebase/set-up-gemini
[examples]: {{site.organization}}/genui/blob/main/examples
[Firebase's Flutter setup guide]: https://firebase.google.com/docs/flutter/setup
[Key components]: /ai/genui/components
[minimum version requirement]: https://firebase.google.com/support/release-notes/ios
[travel app]: {{site.organization}}/genui/blob/main/examples/travel_app
