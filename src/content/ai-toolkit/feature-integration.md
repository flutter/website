---
title: Feature integration
description: >
  How to integrate with other Flutter features.
prev:
  title: User experience
  path: /ai-toolkit/user-experience
next:
  title: Custom LLM providers
  path: /ai-toolkit/custom-llm-providers
---

In addition to the features that are provided
automatically by the [`LlmChatView`][],
a number of integration points allow your app to
blend seamlessly with other features to provide
additional functionality:

* **Welcome messages**: Display an initial greeting to users.
* **Suggested prompts**: Offer users predefined prompts to guide interactions.
* **System instructions**: Provide the LLM with specific input to influence its responses.
* **Disable attachments and audio input**: Remove optional parts of the chat UI.
* **Manage cancel or error behavior**: Change the user cancellation or LLM error behavior.
* **Manage history**: Every LLM provider allows for managing chat history,
  which is useful for clearing it,
  changing it dynamically and storing it between sessions.
* **Chat serialization/deserialization**: Store and retrieve conversations
  between app sessions.
* **Custom response widgets**: Introduce specialized UI components
  to present LLM responses.
* **Custom styling**: Define unique visual styles to match the chat
  appearance to the overall app.
* **Chat w/o UI**: Interact directly with the LLM providers without
  affecting the user's current chat session.
* **Custom LLM providers**: Build your own LLM provider for integration of chat
  with your own model backend.
* **Rerouting prompts**: Debug, log, or reroute messages meant for the provider
  to track down issues or route prompts dynamically.

[`LlmChatView`]: {{site.pub-api}}/flutter_ai_toolkit/latest/flutter_ai_toolkit/LlmChatView-class.html

## Welcome messages

The chat view allows you to provide a custom welcome message
to set context for the user:

![Example welcome message](/assets/images/docs/ai-toolkit/example-of-welcome-message.png)

You can initialize the `LlmChatView` with a welcome message
by setting the `welcomeMessage` parameter:

```dart
class ChatPage extends StatelessWidget {
 const ChatPage({super.key});

 @override
 Widget build(BuildContext context) => Scaffold(
       appBar: AppBar(title: const Text(App.title)),
       body: LlmChatView(
         welcomeMessage: 'Hello and welcome to the Flutter AI Toolkit!',
         provider: GeminiProvider(
           model: GenerativeModel(
             model: 'gemini-2.0-flash',
             apiKey: geminiApiKey,
           ),
         ),
       ),
     );
}
```

To see a complete example of setting the welcome message,
check out the [welcome example][].

[welcome example]: {{site.github}}/flutter/ai/blob/main/example/lib/welcome/welcome.dart

## Suggested prompts

You can provide a set of suggested prompts to give
the user some idea of what the chat session has been optimized for:

![Example suggested prompts](/assets/images/docs/ai-toolkit/example-of-suggested-prompts.png)

The suggestions are only shown when there is no existing
chat history. Clicking one copies the text into the
user's prompt editing area. To set the list of suggestions,
construct the `LlmChatView` with the `suggestions` parameter:

```dart
class ChatPage extends StatelessWidget {
 const ChatPage({super.key});

 @override
 Widget build(BuildContext context) => Scaffold(
       appBar: AppBar(title: const Text(App.title)),
       body: LlmChatView(
         suggestions: [
           'I\'m a Star Wars fan. What should I wear for Halloween?',
           'I\'m allergic to peanuts. What candy should I avoid at Halloween?',
           'What\'s the difference between a pumpkin and a squash?',
         ],
         provider: GeminiProvider(
           model: GenerativeModel(
             model: 'gemini-2.0-flash',
             apiKey: geminiApiKey,
           ),
         ),
       ),
     );
}
```

To see a complete example of setting up suggestions for the user,
take a look at the [suggestions example][].

[suggestions example]: {{site.github}}/flutter/ai/blob/main/example/lib/suggestions/suggestions.dart

## LLM instructions

To optimize an LLM's responses based on the needs
of your app, you'll want to give it instructions.
For example, the [recipes example app][] uses the
`systemInstructions` parameter of the `GenerativeModel`
class to tailor the LLM to focus on delivering recipes
based on the user's instructions:

```dart
class _HomePageState extends State<HomePage> {
  ...
  // create a new provider with the given history and the current settings
  LlmProvider _createProvider([List<ChatMessage>? history]) => GeminiProvider(
      history: history,
        ...,
        model: GenerativeModel(
          model: 'gemini-2.0-flash',
          apiKey: geminiApiKey,
          ...,
          systemInstruction: Content.system('''
You are a helpful assistant that generates recipes based on the ingredients and
instructions provided as well as my food preferences, which are as follows:
${Settings.foodPreferences.isEmpty ? 'I don\'t have any food preferences' : Settings.foodPreferences}

You should keep things casual and friendly. You may generate multiple recipes in a single response, but only if asked. ...
''',
          ),
        ),
      );
  ...
}
```

Setting system instructions is unique to each provider;
both the `GeminiProvider` and the `VertexProvider`
allow you to provide them through the `systemInstruction` parameter.

Notice that, in this case, we're bringing in user preferences
as part of the creation of the LLM provider passed to the
`LlmChatView` constructor. We set the instructions as part
of the creation process each time the user changes their preferences.
The recipes app allows the user to change their food preferences
using a drawer on the scaffold:

![Example of refining prompt](/assets/images/docs/ai-toolkit/setting-food-preferences.png)

Whenever the user changes their food preferences,
the recipes app creates a new model to use the new preferences:

```dart
class _HomePageState extends State<HomePage> {
  ...
  void _onSettingsSave() => setState(() {
        // move the history over from the old provider to the new one
        final history = _provider.history.toList();
        _provider = _createProvider(history);
      });
}
```

## Disable attachments and audio input

If you'd like to disable attachments (the **+** button) or audio input (the mic button),
you can do so with the `enableAttachments` and `enableVoiceNotes` parameters to
the `LlmChatView` constructor:

```dart
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ...

    return Scaffold(
      appBar: AppBar(title: const Text('Restricted Chat')),
      body: LlmChatView(
        // ...
        enableAttachments: false,
        enableVoiceNotes: false,
      ),
    );
  }
}
```

Both of these flags default to `true`.

## Manage cancel or error behavior

By default, when the user cancels an LLM request, the LLM's response will be
appended with the string "CANCEL" and a message will pop up that the user has
canceled the request. Likewise, in the event of an LLM error, like a dropped
network connection, the LLM's response will be appended with the
string "ERROR" and an alert dialog will pop up with the details of the error.

You can override the cancel and error behavior with the `cancelMessage`,
`errorMessage`, `onCancelCallback` and `onErrorCallback` parameters of the
`LlmChatView`. For example, the following code replaces the default cancellation
handling behavior:

```dart
class ChatPage extends StatelessWidget {
  // ...

  void _onCancel(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Chat cancelled')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text(App.title)),
    body: LlmChatView(
      // ...
      onCancelCallback: _onCancel,
      cancelMessage: 'Request cancelled',
    ),
  );
}
```

You can override any or all of these parameters and the `LlmChatView` will use
its defaults for anything you don't override.

## Manage history

The [standard interface that defines all LLM providers][providerIF]
that can plug into the chat view includes the ability to
get and set history for the provider:

```dart
abstract class LlmProvider implements Listenable {
  Stream<String> generateStream(
    String prompt, {
    Iterable<Attachment> attachments,
  });

  Stream<String> sendMessageStream(
    String prompt, {
    Iterable<Attachment> attachments,
  });

  Iterable<ChatMessage> get history;
  set history(Iterable<ChatMessage> history);
}
```

[providerIF]: {{site.pub-api}}/flutter_ai_toolkit/latest/flutter_ai_toolkit/LlmProvider-class.html

When the history for a provider changes,
it calls the `notifyListener` method exposed by the
`Listenable` base class. This means that you manually
subscribe/unsubscribe with the `add` and `remove` methods
or use it to construct an instance of the `ListenableBuilder` class.

The `generateStream` method calls into the underlying LLM
without affecting the history. Calling the `sendMessageStream`
method changes the history by adding two new messages to the
provider's history—one for the user message and one for the LLM
response—when the response is completed. The chat view uses
`sendMessageStream` when it processes a user's chat prompt and
`generateStream` when it's processing the user's voice input.

To see or set the history, you can access the `history` property:

```dart
void _clearHistory() => _provider.history = [];
```

The ability to access a provider's history is also useful
when it comes to recreating a provider while maintaining the history:

```dart
class _HomePageState extends State<HomePage> {
  ...
  void _onSettingsSave() => setState(() {
        // move the history over from the old provider to the new one
        final history = _provider.history.toList();
        _provider = _createProvider(history);
      });
}
```

The `_createProvider` method
creates a new provider with the history from
the previous provider _and_ the new user
preferences.
It's seamless for the user; they can keep chatting away
but now the LLM gives them responses taking their
new food preferences into account.
For example:


```dart
class _HomePageState extends State<HomePage> {
  ...
  // create a new provider with the given history and the current settings
  LlmProvider _createProvider([List<ChatMessage>? history]) =>
    GeminiProvider(
      history: history,
      ...
    );
  ...
}
```

To see history in action,
check out the [recipes example app][] and the [history example app][].

[history example app]: {{site.github}}/flutter/ai/blob/main/example/lib/history/history.dart
[recipes example app]: {{site.github}}/flutter/ai/tree/main/example/lib/recipes

## Chat serialization/deserialization

To save and restore chat history between sessions
of an app requires the ability to serialize and
deserialize each user prompt, including the attachments,
and each LLM response. Both kinds of messages
(the user prompts and LLM responses),
are exposed in the `ChatMessage` class.
Serialization can be accomplished by using the `toJson`
method of each `ChatMessage` instance.

```dart
Future<void> _saveHistory() async {
  // get the latest history
  final history = _provider.history.toList();

  // write the new messages
  for (var i = 0; i != history.length; ++i) {
    // skip if the file already exists
    final file = await _messageFile(i);
    if (file.existsSync()) continue;

    // write the new message to disk
    final map = history[i].toJson();
    final json = JsonEncoder.withIndent('  ').convert(map);
    await file.writeAsString(json);
  }
}
```

Likewise, to deserialize, use the static `fromJson`
method of the `ChatMessage` class:

```dart
Future<void> _loadHistory() async {
  // read the history from disk
  final history = <ChatMessage>[];
  for (var i = 0;; ++i) {
    final file = await _messageFile(i);
    if (!file.existsSync()) break;

    final map = jsonDecode(await file.readAsString());
    history.add(ChatMessage.fromJson(map));
  }

  // set the history on the controller
  _provider.history = history;
}
```

To ensure fast turnaround when serializing,
we recommend only writing each user message once.
Otherwise, the user must wait for your app to
write every message every time and,
in the face of binary attachments,
that could take a while.

To see this in action, check out the [history example app][].

[history example app]: {{site.github}}/flutter/ai/blob/main/example/lib/history/history.dart

## Custom response widgets

By default, the LLM response shown by the chat view is
formatted Markdown. However, in some cases,
you want to create a custom widget to show the
LLM response that's specific to and integrated with your app.
For example, when the user requests a recipe in the
[recipes example app][], the LLM response is used
to create a widget that's specific to showing recipes
just like the rest of the app does and to provide for an
**Add** button in case the user would like to add
the recipe to their database:

![Add recipe button](/assets/images/docs/ai-toolkit/add-recipe-button.png)

This is accomplished by setting the `responseBuilder`
parameter of the `LlmChatView` constructor:

```dart
LlmChatView(
  provider: _provider,
  welcomeMessage: _welcomeMessage,
  responseBuilder: (context, response) => RecipeResponseView(
    response,
  ),
),
```

In this particular example, the `RecipeReponseView`
widget is constructed with the LLM provider's response text
and uses that to implement its `build` method:

```dart
class RecipeResponseView extends StatelessWidget {
  const RecipeResponseView(this.response, {super.key});
  final String response;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    String? finalText;

    // created with the response from the LLM as the response streams in, so
    // many not be a complete response yet
    try {
      final map = jsonDecode(response);
      final recipesWithText = map['recipes'] as List<dynamic>;
      finalText = map['text'] as String?;

      for (final recipeWithText in recipesWithText) {
        // extract the text before the recipe
        final text = recipeWithText['text'] as String?;
        if (text != null && text.isNotEmpty) {
          children.add(MarkdownBody(data: text));
        }

        // extract the recipe
        final json = recipeWithText['recipe'] as Map<String, dynamic>;
        final recipe = Recipe.fromJson(json);
        children.add(const Gap(16));
        children.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipe.title, style: Theme.of(context).textTheme.titleLarge),
            Text(recipe.description),
            RecipeContentView(recipe: recipe),
          ],
        ));

        // add a button to add the recipe to the list
        children.add(const Gap(16));
        children.add(OutlinedButton(
          onPressed: () => RecipeRepository.addNewRecipe(recipe),
          child: const Text('Add Recipe'),
        ));
        children.add(const Gap(16));
      }
    } catch (e) {
      debugPrint('Error parsing response: $e');
    }

    ...

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
```

This code parses the text to extract introductory text
and the recipe from the LLM, bundling them together
with an **Add Recipe** button to show in place of the Markdown.

Notice that we're parsing the LLM response as JSON.
It's common to set the provider into JSON mode and
to provide a schema to restrict the format of its responses
to ensure that we've got something we can parse.
Each provider exposes this functionality in its own way,
but both the `GeminiProvider` and `VertexProvider` classes
enable this with a `GenerationConfig` object that the
recipes example uses as follows:

```dart
class _HomePageState extends State<HomePage> {
  ...

  // create a new provider with the given history and the current settings
  LlmProvider _createProvider([List<ChatMessage>? history]) => GeminiProvider(
        ...
        model: GenerativeModel(
          ...
          generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
            responseSchema: Schema(...),
          systemInstruction: Content.system('''
...
Generate each response in JSON format
with the following schema, including one or more "text" and "recipe" pairs as
well as any trailing text commentary you care to provide:

{
  "recipes": [
    {
      "text": "Any commentary you care to provide about the recipe.",
      "recipe":
      {
        "title": "Recipe Title",
        "description": "Recipe Description",
        "ingredients": ["Ingredient 1", "Ingredient 2", "Ingredient 3"],
        "instructions": ["Instruction 1", "Instruction 2", "Instruction 3"]
      }
    }
  ],
  "text": "any final commentary you care to provide",
}
''',
          ),
        ),
      );
  ...
}
```

This code initializes the `GenerationConfig` object
by setting the `responseMimeType` parameter to `'application/json'`
and the `responseSchema` parameter to an instance of the
`Schema` class that defines the structure of the JSON
that you're prepared to parse. In addition,
it's good practice to also ask for JSON and to provide
a description of that JSON schema in the system instructions,
which we've done here.

To see this in action, check out the [recipes example app][].

## Custom styling

The chat view comes out of the box with a set of default styles
for the background, the text field, the buttons, the icons,
the suggestions, and so on. You can fully customize those
styles by setting your own by using the `style` parameter to the
`LlmChatView` constructor:

```dart
LlmChatView(
  provider: GeminiProvider(...),
  style: LlmChatViewStyle(...),
),
```

For example, the [custom styles example app][custom-ex]
uses this feature to implement an app with a Halloween theme:

![Halloween-themed demo app](/assets/images/docs/ai-toolkit/demo-app.png)

For a complete list of the styles available in the
`LlmChatViewStyle` class, check out the [reference documentation][].
To see custom styles in action,
in addition to the [custom styles example][custom-ex],
check out the [dark mode example][] and the [demo app][].

[custom-ex]: {{site.github}}/flutter/ai/blob/main/example/lib/custom_styles/custom_styles.dart
[dark mode example]: {{site.github}}/flutter/ai/blob/main/example/lib/dark_mode/dark_mode.dart
[demo app]: {{site.github}}/flutter/ai#online-demo
[reference documentation]: {{site.pub-api}}/flutter_ai_toolkit/latest/flutter_ai_toolkit/LlmChatViewStyle-class.html

## Chat without UI

You don't have to use the chat view to access the
functionality of the underlying provider.
In addition to being able to simply call it with
whatever proprietary interface it provides,
you can also use it with the [LlmProvider interface][].

[LlmProvider interface]: {{site.pub-api}}/flutter_ai_toolkit/latest/flutter_ai_toolkit/LlmProvider-class.html

As an example, the recipes example app provides a
Magic button on the page for editing recipes.
The purpose of that button is to update an existing recipe
in your database with your current food preferences.
Pressing the button allows you to preview the recommended changes and
decide whether you'd like to apply them or not:

![User decides whether to update recipe in database](/assets/images/docs/ai-toolkit/apply-changes-decision.png)

Instead of using the same provider that the chat portion
of the app uses, which would insert spurious user messages
and LLM responses into the user's chat history,
the Edit Recipe page instead creates its own provider
and uses it directly:

```dart
class _EditRecipePageState extends State<EditRecipePage> {
  ...
  final _provider = GeminiProvider(...);
  ...
  Future<void> _onMagic() async {
    final stream = _provider.sendMessageStream(
      'Generate a modified version of this recipe based on my food preferences: '
      '${_ingredientsController.text}\n\n${_instructionsController.text}',
    );
    var response = await stream.join();
    final json = jsonDecode(response);

    try {
      final modifications = json['modifications'];
      final recipe = Recipe.fromJson(json['recipe']);

      if (!context.mounted) return;
      final accept = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(recipe.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Modifications:'),
              const Gap(16),
              Text(_wrapText(modifications)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(true),
              child: const Text('Accept'),
            ),
            TextButton(
              onPressed: () => context.pop(false),
              child: const Text('Reject'),
            ),
          ],
        ),
      );
      ...
    } catch (ex) {
      ...
      }
    }
  }
}
```

The call to `sendMessageStream` creates entries in the
provider's history, but since it's not associated with a chat view,
they won't be shown. If it's convenient,
you can also accomplish the same thing by calling `generateStream`,
which allows you to reuse an existing provider without affecting
the chat history.

To see this in action,
check out the [Edit Recipe page][] of the recipes example.

[Edit Recipe page]: {{site.github}}/flutter/ai/blob/main/example/lib/recipes/pages/edit_recipe_page.dart

## Rerouting prompts

If you'd like to debug, log, or manipulate the connection
between the chat view and the underlying provider,
you can do so with an implementation of an [`LlmStreamGenerator`][] function.
You then pass that function to the `LlmChatView` in the
`messageSender` parameter:

[`LlmStreamGenerator`]: {{site.pub-api}}/flutter_ai_toolkit/latest/flutter_ai_toolkit/LlmStreamGenerator.html

```dart
class ChatPage extends StatelessWidget {
  final _provider = GeminiProvider(...);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text(App.title)),
      body: LlmChatView(
        provider: _provider,
        messageSender: _logMessage,
      ),
    );

  Stream<String> _logMessage(
    String prompt, {
    required Iterable<Attachment> attachments,
  }) async* {
    // log the message and attachments
    debugPrint('# Sending Message');
    debugPrint('## Prompt\n$prompt');
    debugPrint('## Attachments\n${attachments.map((a) => a.toString())}');

    // forward the message on to the provider
    final response = _provider.sendMessageStream(
      prompt,
      attachments: attachments,
    );

    // log the response
    final text = await response.join();
    debugPrint('## Response\n$text');

    // return it
    yield text;
  }
}
```

This example logs the user prompts and LLM responses
as they go back and forth. When providing a function
as a `messageSender`, it's your responsibility to call
the underlying provider. If you don't, it won't get the message.
This capability allows you to do advanced things like routing to
a provider dynamically or Retrieval Augmented Generation (RAG).

To see this in action, check out the [logging example app][].

[logging example app]: {{site.github}}/flutter/ai/blob/main/example/lib/logging/logging.dart
