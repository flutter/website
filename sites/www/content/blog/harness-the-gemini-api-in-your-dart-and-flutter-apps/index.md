---
title: "Harness the Gemini API in your Dart and Flutter Apps"
description: "Introducing the Google AI Dart SDK"
publishDate: 2024-02-15
author: anderdobo
image: images/1-KkJmzvv3jNhh88TWxIBJg.webp
category: tutorial
layout: blog
---

We’re thrilled to announce the launch of the Google AI Dart SDK for the Gemini API. The new pub.dev package, [`google_generative_ai`,](https://pub.dev/packages/google_generative_ai) and [supporting resources](https://ai.google.dev/tutorials/dart_quickstart) enable you to build your own generative AI-based features into Dart and Flutter apps through an idiomatic Dart integration with the Gemini API. It opens the door to a vast range of possibilities for building intelligent, performant applications for Android, iOS, web, macOS, Windows, and Linux from a single code base.

With the Google AI Dart SDK, you can:

* **Easily integrate generative AI features:** Add advanced text generation, summarization, chat, and more to your Dart or Flutter apps with minimal setup.

* **Tap into Google’s most capable and general model yet:** The Gemini model draws on Google’s extensive research and development in machine learning, giving you access to generative AI capabilities that will continue to improve.

* **Accelerate your AI-powered app development:** Focus on your app logic and user experience, while the SDK handles the intricacies of interacting with AI models.

* **Build cross-platform AI-powered apps:** Easily create generative AI features across desktop, web, and mobile applications using Flutter.

* **Use the Gemini API in more than 180+ countries and territories:** Check the [available regions](https://ai.google.dev/available_regions#available_regions) for the most current list of countries and regions where the Gemini API and Google AI Studio (described further below) are available.

<DashImage figure src="images/1-KkJmzvv3jNhh88TWxIBJg.webp" />


**What can you build?**

We believe generative AI holds immense potential to help you achieve your app and business goals. And since the Gemini model is multimodal (it’s capable of processing information from multiple modalities, including images and text), it empowers you to be extremely creative. However, the first question we often get from app developers — and even from within our own team — is “What can I actually do with the Gemini API?” Here are a few examples of features you might create for your Dart or Flutter app:

* **Text summarization:** Generate concise summaries of long articles, research papers, or website content from textual input.

* **Smart chatbots:** Build more engaging and human-like conversational interfaces, enhancing user experience in your applications.

* **Visual search engine:** Users can upload an image, and the app uses the Gemini API to return descriptions of what’s in the image, the style, and perhaps even how to make what’s in the image.

* **Image descriptions for accessibility:** Generate detailed text descriptions of uploaded images to aid users who are visually impaired.

* **Diagram & chart interpretation:** Users can upload images of diagrams, charts, or graphs, and the Gemini API delivers a text-based analysis and explanation of the data.

This list could go on because the possibilities are nearly endless!

<DashImage figure src="images/07Zvr0YiN7O22wTOy.webp" alt="A screenshot of the Flutter sample app that uses the Google AI Dart SDK" caption="A screenshot of the Flutter sample app that uses the Google AI Dart SDK" />


**Getting Started**

Check out the [Dart quickstart](https://ai.google.dev/tutorials/dart_quickstart) for a detailed step-by-step guide on how to get set up. At a high level, here’s what you’ll do:

1. Get a Gemini API key from Google AI Studio. Keep this key secure. We strongly recommend that you do not include the key directly in your code, or check files that contain the key into version control systems. While developing, we recommend using `flutter run -d [DEVICE NAME] — dart-define=API_KEY=[YOUR API KEY]` to run the app in an emulator/simulator, using your API key as an environment variable.

1. Add the Google AI Dart SDK to your Dart or Flutter app by running `dart pub add google_generative_ai` or `flutter pub add google_generative_ai`, respectively. This adds `google_generative_ai` as a dependency to your `pubspec.yaml` file.

1. Initialize the generative model in your code:

```dart
import 'package:google_generative_ai/google_generative_ai.dart';

// Access your API key as an environment variable (see first step above)
final apiKey = Platform.environment['API_KEY'];
if (apiKey == null) {
  print('No \$API_KEY environment variable');
  exit(1);
}

final model = GenerativeModel(model: 'MODEL_NAME', apiKey: apiKey);
```


4. You can now start to explore using the Gemini API to implement different use cases. For example, when the prompt input includes both text and images, use the `gemini-pro-vision` model and the `generateContent` method to generate text output:

```dart
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  // Access your API key as an environment variable (see first step above)
  final apiKey = Platform.environment['API_KEY'];
  if (apiKey == null) {
    print('No \$API_KEY environment variable');
    exit(1);
  }
  // For text-and-image input (multimodal), use the gemini-pro-vision model
  final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
  final (firstImage, secondImage) = await (
    File('image0.jpg').readAsBytes(),
    File('image1.jpg').readAsBytes()
  ).wait;
  final prompt = TextPart("What's different between these pictures?");
  final imageParts = [
    DataPart('image/jpeg', firstImage),
    DataPart('image/jpeg', secondImage),
  ];
  final response = await model.generateContent([
    Content.multi([prompt, ...imageParts])
  ]);
  print(response.text);
}
```


Explore the [Gemini API documentation](https://ai.google.dev/docs) and check out the [Dart and Flutter sample apps](https://github.com/google/generative-ai-dart/tree/main/samples) in the GitHub repo for detailed guides and examples on how to use the SDK for various use cases, or in [this sample app](https://dartpad.dev/?id=341bc46b2ed1d2055d357ab987ed5fc2) in DartPad, which is a free, open-source online editor for Dart and Flutter snippets, now built with Flutter. Please report any issues or tell us about feature requests in the [generative-ai-dart GitHub repo](https://github.com/google/generative-ai-dart/issues/new/choose).

**Google AI Studio**

Alongside the SDK, [Google AI Studio](https://aistudio.google.com/?utm_source=flutter&utm_medium=referral&utm_campaign=blog_gaidartsdk_announcment&utm_content=) is a browser-based IDE for prototyping with generative models. It enables you to quickly iterate to develop prompts for your use case, and then get an API key to use in your app development. You can sign into Google AI Studio with your Google account and take advantage of the free quota, which allows 60 requests per minute. To help us improve product quality, when you use the free quota, your Google AI Studio input and output might be accessible to trained reviewers. This data is de-identified from your Google account and API key.

We will add Dart to Google AI Studio soon, so keep a lookout for the announcement! This will enable you to simply click on “Get code”, select a new Dart tab (which will be alongside the existing supported languages), and then “Copy” the Dart code to transfer your work to your IDE of choice.

<DashImage figure src="images/0xhBJ20OLOQDtQ2xi.webp" alt="Google AI Studio" caption="Google AI Studio" />


**Share what you build!**

We look forward to seeing what you’ll build with Gemini, like the team at LeanCode who have used the Gemini API to build [arb_translate](https://leancode.co/arb_translate). It’s a package that helps developers to perform language translation automatically, streamlining localization in Flutter apps.

Use the hashtag #BuildWithGemini on Twitter/X to let us know what you’re building!