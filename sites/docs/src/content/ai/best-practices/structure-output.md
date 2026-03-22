---
title: Structure & output
description: >
  Learn how to use structured input and output schemas to receive reliable, 
  parsable JSON data from an LLM.
prev:
  title: Prompting
  path: /ai/best-practices/prompting
next:
  title: Tool calls (aka function calls)
  path: /ai/best-practices/tool-calls
---


When you're writing programs against an LLM, you want to provide unambiguous
input and get unambiguous output.

### Structured input

As input, an LLM can take pretty much anything you can render as text. That
includes free form text and semi-structured text like Markdown, but also
includes structured formats like CSV, JSON, and XML. If you have data with
structure, format the data with that structure and the LLM is going to give you
better results.

In addition to structured text input, you can also pass binary data, like images
or PDFs. In the sample, the app passes the crossword puzzle screenshot images to
Gemini for it to infer the grid data:

```dart
final imageParts = <Part>[];
for (final image in images) {
  final imageBytes = await image.readAsBytes();
  final mimeType = lookupMimeType(image.path, headerBytes: imageBytes)!;
  imageParts.add(InlineDataPart(mimeType, imageBytes));
}

final content = [
  Content.multi([
    TextPart(_crosswordPrompt),
    ...imageParts,
  ]),
];

final response = await _crosswordModel.generateContent(content);
...
```

This code passes the prompt and the images to Gemini as part of the same
request.

### Structured output

An LLM can have a harder time with structured output than with structured input.
You want to be clear and thorough when asking the model for JSON output to
ensure you get something that you can reliably parse in your apps. 

Start by initializing the model instance with your expected output format:

```dart
// the schema for the clue solver output
static final _crosswordSchema = Schema(
  SchemaType.object,
  properties: {
    'width': Schema(SchemaType.integer),
    'height': Schema(SchemaType.integer),
    'grid': Schema(
      SchemaType.array,
      items: Schema(
        SchemaType.array,
        items: Schema(
          SchemaType.object,
          properties: {
            'color': Schema(SchemaType.string),
            'clueNumber': Schema(SchemaType.integer, nullable: true),
          },
        ),
      ),
    ),
    'clues': Schema(
      SchemaType.object,
      properties: {
        'across': Schema(
          SchemaType.array,
          items: Schema(
            SchemaType.object,
            properties: {
              'number': Schema(SchemaType.integer),
              'text': Schema(SchemaType.string),
            },
          ),
        ),
        'down': Schema(
          SchemaType.array,
          items: Schema(
            SchemaType.object,
            properties: {
              'number': Schema(SchemaType.integer),
              'text': Schema(SchemaType.string),
            },
          ),
        ),
      },
    ),
  },
);

// The model for inferring crossword data from images.
_crosswordModel = FirebaseAI.googleAI().generativeModel(
  model: 'gemini-2.5-pro',
  generationConfig: GenerationConfig(
    responseMimeType: 'application/json',
    responseSchema: _crosswordSchema,
  ),
);
```

And while this might be enough, the most reliable results come when you also
specify the output schema in the system instruction:

```dart
final _crosswordPrompt =
'''
Analyze the following crossword puzzle images and return a JSON object
representing the grid size, contents, and clues. The images may contain
different parts of the same puzzle (e.g., the grid the across clues, the down
clues). Combine them to form a complete puzzle.

The JSON schema is as follows: ${jsonEncode(_crosswordSchema.toJson())}
'''
```

Now you can parse the model's text response as JSON:

```dart
final response = await _crosswordModel.generateContent(content);

final json = jsonDecode(response.text!);
final width = json['width'] as int;
final height = json['height'] as int;
final gridData = json['grid'] as List;
final cluesData = json['clues'] as Map<String, dynamic>;
...
```

Reliable JSON output from the model is what makes it possible to integrate AI
into your app. The data might or might not be correct, but it will be in a
format your app can work with.
