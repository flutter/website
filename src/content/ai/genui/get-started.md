--- 
title: Get started with the GenUI SDK for Flutter
shortTitle: Get started with the GenUI SDK
breadcrumb: Get started
description: >-
  Learn how to use GenUI SDK for Flutter and add it
  to your existing Flutter app.
next:
  title: Input and events
  path: /ai/genui/input-events
prev:
  title: GenUI SDK main components & concepts
  path: /ai/genui/components
---

This guide explains how to get started with
GenUI SDK for Flutter and its series of packages.
The SDK's key components
are described in the [main components][] page.

:::experimental
The `genui` package is in
alpha and is likely to change.
:::

Use the following instructions to add [`genui`][] to your Flutter app.
The code examples show how to perform the instructions on a brand new
app created by running [`flutter create`][], but you can follow the same
steps for your existing Flutter app.

[`genui`]: {{site.pub-pkg}}/genui
[main components]: /ai/genui/components
[`flutter create`]: /reference/create-new-app

## Configure your agent provider

The `genui` package can connect to a variety of agent providers.
Available providers include the following:

**Google Gemini AI**
: The fastest way to get started!
  Use this package for experimentation and local testing as
  you're mapping out your experience.

**Firebase AI Logic**
: Useful for production apps where interactions with the LLM are
  all in your Flutter client, without requiring a server.
  Firebase also makes it easier to ship your
  AI features securely since Firebase handles the
  management of your Gemini API key.

**GenUI A2UI**
: Useful for client/server architectures where your
  agent is running on the server.

**Build your own**
: You can also build your own adapter
  to connect to your preferred LLM provider.
  Expect more from us and the community soon.

<Tabs key="agent-provider" wrapped="true">

<Tab name="Google Gemini AI">

The easiest way to start using GenUI is to use the
[`genui_google_generative_ai`][] package,
which only requires a `GEMINI_API_KEY`.

This package provides the integration between `genui` and the
Google Cloud Generative Language API.
It allows you to use the power of Google's Gemini models to generate
dynamic user interfaces in your Flutter applications.

This API is meant for quick explorations and local testing or prototyping,
not for production or deployment.
Flutter apps built for production should use Firebase AI.
For mobile and web applications that need client-side access,
consider using Firebase AI Logic instead.

 1. Create an instance of `GoogleGenerativeAiContentGenerator` and
    pass it to your `GenUiConversation`:

    ```dart
    import 'package:genui/genui.dart';
    import 'package:genui_google_generative_ai/genui_google_generative_ai.dart';

    final catalog = Catalog(components: [
      // ...
    ]);

    final messageProcessor = A2uiMessageProcessor(catalogs: [catalog]);

    final contentGenerator = GoogleGenerativeAiContentGenerator(
      catalog: catalog,
      systemInstruction: 'You are a helpful assistant.',
      modelName: 'models/gemini-2.5-flash',
      apiKey: 'YOUR_API_KEY', // Or set GEMINI_API_KEY environment variable.
    );

    final conversation = GenUiConversation(
      contentGenerator: contentGenerator,
      a2uiMessageProcessor: messageProcessor,
    );
    ```

 2. To use this package, you need a Gemini API key.
    If you don't already have one,
    you can get it for free in [Google AI Studio][].

    Enable the `GEMINI_API_KEY` in one of two ways:

    - **Environment variable** _(recommended)_

      Set the `GEMINI_API_KEY` or `GOOGLE_API_KEY` environment variable.

    - **Constructor parameter**

      Pass the API key directly to the constructor.

    If neither approach is provided, the package will attempt to
    use the default environment variable.

[`genui_google_generative_ai`]: {{site.pub-pkg}}/genui_google_generative_ai
[Google AI Studio]: https://ai.google.dev/aistudio

</Tab>

<Tab name="Firebase AI Logic">

To use the built-in `FirebaseAiContentGenerator` to connect
to Gemini using the Firebase AI Logic SDK, follow these instructions:

 1. [Create a new Firebase project][] using the Firebase Console.

 2. [Enable the Gemini API][] for that project.

 3. Follow the first three steps in [Firebase's Flutter setup guide][]
    to add Firebase to your app.

 4. Use `dart pub add` to add `genui` and [`genui_firebase_ai`][] as
    dependencies in your `pubspec.yaml` file.

    ```console
    $ dart pub add genui genui_firebase_ai
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

[Create a new Firebase project]: https://support.google.com/appsheet/answer/10104995
[Enable the Gemini API]: https://firebase.google.com/docs/gemini-in-firebase/set-up-gemini
[Firebase's Flutter setup guide]: https://firebase.google.com/docs/flutter/setup
[`genui_firebase_ai`]: {{site.pub-pkg}}/genui_firebase_ai

</Tab>

<Tab name="GenUI A2UI">

An integration package for [`genui`][] and the 
[A2UI Streaming UI Protocol][]. This package allows
Flutter applications to connect to an Agent-to-Agent (A2UI)
server and render dynamic user interfaces generated by an
AI agent using the `genui` framework.

The main components in this package include:

* `A2uiContentGenerator`:
  Implements the `ContentGenerator` that manages the connection
  to the A2A server and processes incoming A2UI messages,
  updating the `A2uiMessageProcessor`.
* `A2uiAgentConnector`:
  Handles the low-level web socket communication with the
  A2A server, including sending messages and parsing stream events.
* `AgentCard`:
  A data class that holds metadata about the connected AI agent.

Follow these instructions:

 1. Set up dependencies:
    Use `dart pub add` to add `genui`, `genui_a2ui`, and `a2a` as
    dependencies in your `pubspec.yaml` file.

    ```console
    $ dart pub add genui genui_a2ui a2a
    ```

 2. Initialize `A2uiMessageProcessor`:
    Set up `A2uiMessageProcessor` with your widget `Catalog`s.

 3. Create `A2uiContentGenerator`:
    Instantiate `A2uiContentGenerator`, providing the A2A server URI.

 4. Create `GenUiConversation`:
    Pass the `A2uiContentGenerator` to the `GenUiConversation`.

 5. Render with `GenUiSurface`:
    Use `GenUiSurface` widgets in your UI to display
    the agent-generated content.

 6. Send Messages:
    Use `GenUiConversation.sendRequest` to send user input
    to the agent-generated content.

    ```dart
    import 'package:flutter/material.dart';
    import 'package:genui/genui.dart';
    import 'package:genui_a2ui/genui_a2ui.dart';
    import 'package:logging/logging.dart';

    void main() {
      // Setup logging.
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((record) {
        print('${record.level.name}: ${record.time}: ${record.message}');
        if (record.error != null) {
          print(record.error);
        }
        if (record.stackTrace != null) {
          print(record.stackTrace);
        }
      });

      runApp(const GenUIExampleApp());
    }

    class GenUIExampleApp extends StatelessWidget {
      const GenUIExampleApp({super.key});

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'A2UI Example',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ChatScreen(),
        );
      }
    }

    class ChatScreen extends StatefulWidget {
      const ChatScreen({super.key});

      @override
      State<ChatScreen> createState() => _ChatScreenState();
    }

    class _ChatScreenState extends State<ChatScreen> {
      final TextEditingController _textController = TextEditingController();
      final A2uiMessageProcessor _a2uiMessageProcessor =
          A2uiMessageProcessor(catalogs: [CoreCatalogItems.asCatalog()]);
      late final A2uiContentGenerator _contentGenerator;
      late final GenUiConversation _uiAgent;
      final List<ChatMessage> _messages = [];

      @override
      void initState() {
        super.initState();
        _contentGenerator = A2uiContentGenerator(
          // TODO: Replace with your A2A server URL.
          serverUrl: Uri.parse('http://localhost:8080'),
        );
        _uiAgent = GenUiConversation(
          contentGenerator: _contentGenerator,
          a2uiMessageProcessor: _a2uiMessageProcessor,
        );

        // Listen for text responses from the agent.
        _contentGenerator.textResponseStream.listen((String text) {
          setState(() {
            _messages.insert(0, AgentMessage.text(text));
          });
        });

        // Listen for errors.
        _contentGenerator.errorStream.listen((ContentGeneratorError error) {
          print('Error from ContentGenerator: ${error.error}');
          // Optionally show the error to the user.
        });
      }

      @override
      void dispose() {
        _textController.dispose();
        _uiAgent.dispose();
        _a2uiMessageProcessor.dispose();
        _contentGenerator.dispose();
        super.dispose();
      }

      void _handleSubmitted(String text) {
        if (text.isEmpty) return;
        _textController.clear();
        final message = UserMessage.text(text);
        setState(() {
          _messages.insert(0, message);
        });
        _uiAgent.sendRequest(message);
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('A2UI Example'),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) =>
                      _buildMessage(_messages[index]),
                  itemCount: _messages.length,
                ),
              ),
              const Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
              // Surface for the main AI-generated UI:
              SizedBox(
                height: 300,
                child: GenUiSurface(
                  host: _a2uiMessageProcessor,
                  surfaceId: 'main_surface',
                ),
              ),
            ],
          ),
        );
      }

      Widget _buildMessage(ChatMessage message) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(child: Text(message is UserMessage ? 'U' : 'A')),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(message is UserMessage ? 'User' : 'Agent',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(message.parts.whereType<TextPart>().map((e) => e.text).join('\n')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      Widget _buildTextComposer() {
        return IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration:
                        const InputDecoration.collapsed(hintText: 'Send a message'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    ```

The [example][] directory on pub.dev contains a
complete application demonstrating how to use this package.

[example]: {{site.pub-pkg}}/genui_a2ui/example
[A2UI Streaming UI Protocol]: https://a2ui.org/

</Tab>

<Tab name="Build your own">

To use `genui` with another agent provider,
follow that provider's instructions to configure your app,
and then create your own subclass of `ContentGenerator` to connect
to that provider.

For examples on how to do so,
reference `FirebaseAiContentGenerator` (from the [`genui_firebase_ai`][] package)
and `A2uiContentGenerator` (from the [`genui_a2ui`][] package).

[`genui_firebase_ai`]: {{site.pub-pkg}}/genui_firebase_ai
[`genui_a2ui`]: {{site.pub-pkg}}/genui_a2ui

</Tab>

</Tabs>

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

 1. Create a `A2uiMessageProcessor`, and provide it with the catalogs
    of widgets that you want to make available to the agent.

 2. Create a `ContentGenerator`, and provide it with a
    system instruction and a set of tools (functions
    you want the agent to be able to invoke).
    You should always include those provided by `A2uiMessageProcessor`,
    but feel free to include others.

 3. Create a `GenUiConversation` using the instances of
    `ContentGenerator` and `A2uiMessageProcessor`. Your app will
    primarily interact with this object to get things done.

    For example:

    ```dart
    class _MyHomePageState extends State<MyHomePage> {
      late final A2uiMessageProcessor _a2uiMessageProcessor;
      late final GenUiConversation _genUiConversation;

      @override
      void initState() {
        super.initState();

        // Create a A2uiMessageProcessor with a widget catalog.
        // The CoreCatalogItems contain basic widgets for text, markdown, and images.
        _a2uiMessageProcessor = A2uiMessageProcessor(catalogs: [CoreCatalogItems.asCatalog()]);

        // Create a ContentGenerator to communicate with the LLM.
        // Provide system instructions and the tools from the A2uiMessageProcessor.
        final contentGenerator = FirebaseAiContentGenerator(
          systemInstruction: '''
            You are an expert in creating funny riddles. Every time I give you a word,
            you should generate UI that displays one new riddle related to that word.
            Each riddle should have both a question and an answer.
            ''',
          additionalTools: _a2uiMessageProcessor.getTools(),
        );

        // Create the GenUiConversation to orchestrate everything.
        _genUiConversation = GenUiConversation(
          a2uiMessageProcessor: _a2uiMessageProcessor,
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

      // Send a message containing the user's [text] to the agent.
      void _sendMessage(String text) {
        if (text.trim().isEmpty) return;
        _genUiConversation.sendRequest(UserMessage.text(text));
      }

      // A callback invoked by the [GenUiConversation] when a new
      // UI surface is generated. Here, the ID is stored so the
      // build method can create a GenUiSurface to display it.
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

## Add your own widgets to the catalog {:#custom-widgets}

For your convenience, you can use the provided core catalog of widgets.
However, most production apps will want to define a custom
catalog of widgets.

To add your own widgets, use the following instructions.

 1. Depend on the `json_schema_builder` package

    Use `dart pub add` to add `json_schema_builder` as
    a dependency in your `pubspec.yaml` file:
   
    ```console
    $ dart pub add json_schema_builder
    ```

 2. Create the new widget's schema

    Each catalog item needs a schema that defines the data required
    to populate it. Using the `json_schema_builder` package,
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
    is allowed to generate. To do that, it combines a name,
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

     Include your catalog items when instantiating `A2uiMessageProcessor`.

    ```dart
    _a2uiMessageProcessor = A2uiMessageProcessor(
      catalogs: [CoreCatalogItems.asCatalog().copyWith([riddleCard])],
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
          generate a RiddleCard that displays one new riddle related to that word.
          Each riddle should have both a question and an answer.
          ''',
      additionalTools: _a2uiMessageProcessor.getTools(),
    );
    ```

{:.steps}

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

```json
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

```json
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

[examples]: {{site.repo.organization}}/genui/blob/main/examples
[travel app]: {{site.repo.organization}}/genui/blob/main/examples/travel_app
[create an issue]: {{site.repo.organization}}/genui/issues/new/choose

## System instructions

The `genui` package gives the LLM a set of tools it can use to generate UI.
To get the LLM to use these tools,
the `systemInstruction` provided to `ContentGenerator` must
explicitly tell it to do so.

This is why the [earlier example][instruction-example] includes
a system instruction for the agent with the line
"Every time I give you a word, you should generate UI that...":

```dart highlightLines=4-5
final contentGenerator = FirebaseAiContentGenerator(
  systemInstruction: '''
    You are an expert in creating funny riddles.
    Every time I give you a word, you should generate UI that
    displays one new riddle related to that word.
    Each riddle should have both a question and an answer.
    ''',
  additionalTools: _a2uiMessageProcessor.getTools(),
);
```

[instruction-example]: /ai/genui/get-started#create-the-connection-to-an-agent

## Troubleshooting/FAQ {:#troubleshoot}

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
[create an issue]: {{site.repo.organization}}/genui/issues/new/choose
[Enable the Gemini API]: https://firebase.google.com/docs/gemini-in-firebase/set-up-gemini
[examples]: {{site.repo.organization}}/genui/blob/main/examples
[Firebase's Flutter setup guide]: https://firebase.google.com/docs/flutter/setup
[`genui`]: {{site.pub-pkg}}/genui
[Key components]: /ai/genui/components
[minimum version requirement]: https://firebase.google.com/support/release-notes/ios
