---
title: "How we built it: Ask Dash — A generative AI Flutter application"
description: "As part of the Google Cloud Applied AI Summit, the Flutter and Vertex AI teams collaborated with Very Good Ventures to create an…"
publishDate: 2023-12-13
author: VeryGoodOpenSource
image: images/092qfA1AlxG0HMJCE.gif
category: spotlight
layout: blog
---

## How we built it: Ask Dash — A generative AI Flutter application

As part of the [Google Cloud Applied AI Summit](https://cloudonair.withgoogle.com/events/summit-applied-ml-summit-23?talk=t1_s5_vertexaisearchandconversation), the Flutter and Vertex AI teams collaborated with [Very Good Ventures](https://verygood.ventures/) to create an AI-powered Flutter demo app, [Ask Dash](https://github.com/VeryGoodOpenSource/dash_ai_search), using [Vertex AI Search and Conversation](https://cloud.google.com/vertex-ai-search-and-conversation) by Google Cloud. Vertex AI Search and Conversation empowers you to build and deploy search and conversational applications quickly with little to no experience in AI. Flutter was a great way to build a beautiful, customized search experience to show how both products can be used to build powerful applications in only a few short weeks!

Vertex AI Search and Conversation allows you to create applications that interact with your data with personalized responses demonstrating the power of generative AI. Most importantly, it gives you full control over what data your application accesses and indexes so you can control what information is surfaced to which user. All application data and user interactions are stored in your own cloud instance and are never used to train Google’s underlying machine learning models.

Since we used Flutter to build the demo app, we decided to use Flutter documentation as training data. We worked with the Google Cloud team to train the model specifically on the Flutter and Dart developer documentation to provide generative AI responses to questions like: What is Flutter? What platforms does it support? And what is hot reload? While much of this data is readily available in public AI models, this demo showcases how you can train a model on just your own data to create powerful AI experiences.

This article takes you through how our partner, Very Good Ventures, built a Flutter web application and how we connected the app in the Cloud console.

### How we built the Flutter web app

The idea of creating a search application trained on the Flutter docs was straightforward. In fact, the [official Flutter documentation](https://docs.flutter.dev/) already provides a simple search experience that delivers relevant page results for questions on Flutter. However, when conceptualizing what to build, we wanted to demonstrate how Flutter can be used to create visually appealing interactive experiences that are fun and engaging.

<DashImage figure src="images/092qfA1AlxG0HMJCE.gif" />


**Creating interactive animations in Flutter**

Flutter empowered the team to implement a wide array of animations seamlessly. Its rich set of animations, coupled with the flexibility of widgets, allowed us to create transitions, engaging motion effects, and fluid user interactions. From creating animated loading states while generating the results, to a Dash sprite that waves when the answers appear, Flutter provided flexibility to turn what could be a basic text response into something fun for users to interact with.

<DashImage figure src="images/00gsPB_1VlYop9DPL.gif" />


**Visualizing natural language search results**

Unlike a traditional search experience, Vertex AI Search provides a natural language response to the question asked. The answer is generated with AI sourced from various pages within the Flutter documentation and presented as a summarized response alongside cards that display the relevant pages used by the AI. Each card provides the title to the page and a description so that the user can flip through the cards to get more context on the AI response.

<DashImage figure src="images/0FapWwJ2wFpi8l9ZZ.gif" />


Additionally, within the natural language response, Vertex AI Search provides a link to the source of each sentence in the response — giving the user a more granular understanding of where each part of the response originated. In the demo, clicking on the number next to each sentence flips the cards to the relevant source page.

**More engaging in less time**

Going into the project, we had a tight deadline to launch the demo at the [Google Cloud Applied AI Summit](https://cloudonair.withgoogle.com/events/summit-applied-ml-summit-23?talk=t1_s5_vertexaisearchandconversation). Flutter’s efficient development and ease-of-use, significantly expedited the development process for the team of two working on the application. It provided the necessary tools and framework to build complex animations efficiently, enabling our team to build and launch this demo in just under the two weeks leading up to the event.

### Connecting the Flutter app to the Vertex API

Integrating our front end web application with the Vertex AI Search API was achieved with a simple request using the [`http` package](https://pub.dev/packages/http). Without requiring any previous experience in building AI, Vertex AI Search provided answers to user-generated questions as JSON responses that were parsed and displayed within animated widgets. This allowed the team to focus on Flutter development to create an engaging experience out of the generated data.

### Setting up generative AI search in your application

Setting up Vertex AI and hosting the API for our Flutter app was also straightforward.. In our case, we used [https://docs.flutter.dev/](https://docs.flutter.dev/) as our data source and set it up directly in the Google Cloud console. As a Google Cloud customer, getting started with Vertex AI requires just three steps:

1. **Create a data store**

This is your website’s digital library, holding all the information you need to generate the AI model based on just the root URL. Google Cloud crawls your website for relevant data and creates a data source for you to query. To set this up in the Google Cloud Console,select **Search and Conversation**. Choose **Data Stores** and then **New Data Store**. Opt for **Website URL** as the source and provide your website’s URL.

2. **Access your data**

Next, create an app in Cloud Console to navigate the data indexed by the model and link it to the data store you created earlier. Under **Search and Conversation**, choose **Apps** and then **New App**. Select **Search** as the type and give your app a name that reflects its purpose, like Ask Dash.

3. **Craft a Cloud Function**

Finally, create a Cloud Function. This is the API wrapper that exposes your Vertex AI data to other applications. In the Console, go to **Cloud Functions** and select **Create Function**.

That’s it!

From there, use the API in your front-end application as you would any API to send requests and receive formatted responses that your application can display. To test it out, head to the **Function** page and select **Testing**. Enter a JSON object with a “search_term” key for your question (such as “hot reload”), and see a detailed response containing a natural language summary, relevant citations, and concise summaries of the referenced pages.

Learn more about how to get started with [Vertex AI Search](https://cloud.google.com/generative-ai-app-builder/docs/try-enterprise-search) in Google Cloud’s documentation.

### Generative AI applications built in Flutter

To see Ask Dash in action and learn more about how we built it, check out the video session from the [Google Cloud Applied AI Summit](https://cloudonair.withgoogle.com/events/summit-applied-ml-summit-23?talk=t1_s5_vertexaisearchandconversation), where Alan Blount, a Product Manager for Google Cloud, breaks down the build process to show the potential of Vertex AI Search in a Flutter application. Check out the [open source Flutter code](https://github.com/VeryGoodOpenSource/dash_ai_search) for the demo and get started with your own AI search experience in Google Cloud Console.

Ask Dash is just the start for how Flutter can power interactive Generative AI experiences in applications. We can’t wait to see what you build!