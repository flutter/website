---
title: Custom LLM providers
description: >
  How to integrate with other Flutter features.
prev:
  title: Feature integration
  path: /ai/ai-toolkit/feature-integration
next:
  title: Chat client sample
  path: /ai/ai-toolkit/chat-client-sample
---

The protocol connecting an LLM and the `LlmChatView` is expressed in the
[`LlmProvider` interface][]:

```dart
abstract class LlmProvider implements Listenable {
  Stream<String> generateStream(String prompt, {Iterable<Attachment> attachments});
  Stream<String> sendMessageStream(String prompt, {Iterable<Attachment> attachments});
  Iterable<ChatMessage> get history;
  set history(Iterable<ChatMessage> history);
}
```

The LLM could be in the cloud or local,
it could be hosted in the Google Cloud Platform
or on some other cloud provider,
it could be a proprietary LLM or open source.
Any LLM or LLM-like endpoint that can be used
to implement this interface can be plugged into
the chat view as an LLM provider. The AI Toolkit
comes with two providers out of the box,
both of which implement the `LlmProvider` interface
that is required to plug the provider into the following:

* The [Firebase AI Logic provider][],
  which wraps the `firebase_ai` package
* The [Echo provider][],
  which is useful as a minimal provider example

[Echo provider]: {{site.pub-api}}/flutter_ai_toolkit/latest/flutter_ai_toolkit/EchoProvider-class.html
[`LlmProvider` interface]: {{site.pub-api}}/flutter_ai_toolkit/latest/flutter_ai_toolkit/LlmProvider-class.html
[Firebase AI Logic provider]: {{site.pub-api}}/flutter_ai_toolkit/latest/flutter_ai_toolkit/FirebaseProvider-class.html

## Implementation

To build your own provider, you need to implement the `LlmProvider` interface
with these things in mind:

1. Providing for full configuration support
1. Handling history
1. Translating messages and attachments to the underlying LLM
1. Calling the underlying LLM

1. Configuration
   To support full configurability in your custom provider,
   you should allow the user to create the underlying model
   and pass that in as a parameter, as the Firebase provider does:

```dart
class FirebaseProvider extends LlmProvider ... {
  @immutable
  FirebaseProvider({
    required GenerativeModel model,
    ...
  })  : _model = model,
        ...

  final GenerativeModel _model;
  ...
}
```

In this way, no matter what changes come to the underlying model in the future,
the configuration knobs will all be available to the user of your custom
provider.

2. History
History is a big part of any provider—not only does the provider need
to allow history to be manipulated directly, but it has to notify listeners as
it changes. In addition, to support serialization and changing provider
parameters, it must also support saving history as part of the construction
process.

The Firebase provider handles this as shown:

```dart
class FirebaseProvider extends LlmProvider with ChangeNotifier {
  @immutable
  FirebaseProvider({
    required GenerativeModel model,
    Iterable<ChatMessage>? history,
    ...
  })  : _model = model,
        _history = history?.toList() ?? [],
        ... { ... }

  final GenerativeModel _model;
  final List<ChatMessage> _history;
  ...

  @override
  Stream<String> sendMessageStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) async* {
    final userMessage = ChatMessage.user(prompt, attachments);
    final llmMessage = ChatMessage.llm();
    _history.addAll([userMessage, llmMessage]);

    final response = _generateStream(
      prompt: prompt,
      attachments: attachments,
      contentStreamGenerator: _chat!.sendMessageStream,
    );

    yield* response.map((chunk) {
      llmMessage.append(chunk);
      return chunk;
    });

    notifyListeners();
  }

  @override
  Iterable<ChatMessage> get history => _history;

  @override
  set history(Iterable<ChatMessage> history) {
    _history.clear();
    _history.addAll(history);
    _chat = _startChat(history);
    notifyListeners();
  }

  ...
}
```

You'll notice several things in this code:
* The use of `ChangeNotifier` to implement the `Listenable` method requirements
  from the `LlmProvider` interface
* The ability to pass initial history in as a constructor parameter
* Notifying listeners when there's a new user prompt/LLM response pair
* Notifying listeners when the history is changed manually
* Creating a new chat when the history changes, using the new history

Essentially, a custom provider manages the history
for a single chat session with the underlying LLM.
As the history changes, the underlying chat either
needs to be kept up to date automatically
(as the Firebase provider does when you call
the underlying chat-specific methods) or manually recreated
(as the Firebase provider does whenever the history is set manually).

3. Messages and attachments

Attachments must be mapped from the standard
`ChatMessage` class exposed by the `LlmProvider`
type to whatever is handled by the underlying LLM.
For example, the Firebase provider maps from the
`ChatMessage` class from the AI Toolkit to the
`Content` type provided by the Firebase Logic AI SDK,
as shown in the following example:

```dart
import 'package:firebase_ai/firebase_ai.dart';
...

class FirebaseProvider extends LlmProvider with ChangeNotifier {
  ...
  static Part _partFrom(Attachment attachment) => switch (attachment) {
        (final FileAttachment a) => DataPart(a.mimeType, a.bytes),
        (final LinkAttachment a) => FilePart(a.url),
      };

  static Content _contentFrom(ChatMessage message) => Content(
        message.origin.isUser ? 'user' : 'model',
        [
          TextPart(message.text ?? ''),
          ...message.attachments.map(_partFrom),
        ],
      );
}
```

The `_contentFrom` method is called whenever a user prompt needs to be sent to
the underlying LLM. Every provider needs to provide for its own mapping.

4. Calling the LLM

How you call the underlying LLM to implement
`generateStream` and `sendMessageStream` methods
depends on the protocol it exposes.
The Firebase provider in the AI Toolkit
handles configuration and history but calls to
`generateStream` and `sendMessageStream` each
end up in a call to an API from the Firebase Logic AI SDK:

```dart
class FirebaseProvider extends LlmProvider with ChangeNotifier {
  ...

  @override
  Stream<String> generateStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) =>
      _generateStream(
        prompt: prompt,
        attachments: attachments,
        contentStreamGenerator: (c) => _model.generateContentStream([c]),
      );

  @override
  Stream<String> sendMessageStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) async* {
    final userMessage = ChatMessage.user(prompt, attachments);
    final llmMessage = ChatMessage.llm();
    _history.addAll([userMessage, llmMessage]);

    final response = _generateStream(
      prompt: prompt,
      attachments: attachments,
      contentStreamGenerator: _chat!.sendMessageStream,
    );

    yield* response.map((chunk) {
      llmMessage.append(chunk);
      return chunk;
    });

    notifyListeners();
  }

  Stream<String> _generateStream({
    required String prompt,
    required Iterable<Attachment> attachments,
    required Stream<GenerateContentResponse> Function(Content)
        contentStreamGenerator,
  }) async* {
    final content = Content('user', [
      TextPart(prompt),
      ...attachments.map(_partFrom),
    ]);

    final response = contentStreamGenerator(content);
    yield* response
        .map((chunk) => chunk.text)
        .where((text) => text != null)
        .cast<String>();
  }

  @override
  Iterable<ChatMessage> get history => _history;

  @override
  set history(Iterable<ChatMessage> history) {
    _history.clear();
    _history.addAll(history);
    _chat = _startChat(history);
    notifyListeners();
  }
}
```

## Examples

The [Firebase provider][] 
implementation provides
a good starting point for your own custom provider.
If you'd like to see an example provider implementation with
all of the calls to the underlying LLM stripped away,
check out the [Echo example app][], which simply formats
the user's prompt and attachments as Markdown
to send back to the user as its response.

[Echo example app]:
    {{site.github}}/flutter/ai/blob/main/lib/src/providers/implementations/echo_provider.dart
[Firebase provider]:
    {{site.pub-api}}/flutter_ai_toolkit/latest/flutter_ai_toolkit/FirebaseProvider-class.html
