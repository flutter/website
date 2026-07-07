---
title: "How we built it: Creating the I/O Crossword puzzle, powered by AI"
description: "Adding a fun, helpful twist to a classic word game with Flutter, Firebase Genkit, and the Gemini API"
publishDate: 2024-06-26
author: verygoodopensource
image: images/04ylubp836_tc4Nni.png
category: spotlight
layout: blog
---

<DashImage figure src="images/04ylubp836_tc4Nni.png" />


For this year’s I/O, Very Good Ventures partnered with the Flutter and Firebase teams at Google to create a unique, digital experience to showcase the power of the Gemini API.

The fun (and challenge) of crossword puzzles is solving the clues to complete the board. A natural place to start for words and clues was everything we’ve talked about at I/O this year. To generate the game content, we gave videos of the keynotes to [Gemini Advanced](https://gemini.google.com/) and asked it to create a list of topical technology-related words and clues to make playing the game a fun way to learn about everything announced this year at I/O.

Keep reading to learn how we built the UI with Flutter and check out the open-source code for the game, which you can access on [GitHub](https://github.com/VGVentures/io_crossword).

**How to play**

When you log in to the puzzle, you are prompted to choose your team. As you correctly answer a clue, the word fills in and the cells change to your team color. Your team earns points for every word you solve and you earn a bonus for a streak of solving words without asking for hints.

Need a hint? Click the **Hint** button, then ask up to ten yes-or-no questions about the concealed word. The [Gemini API](https://ai.google.dev/) privately responds to your questions so you can fill in more words and help your team claim Victory!

<DashImage figure src="images/01aAyHb71XpChgH6R.png" />


The design of the *hint* feature is a great example of how different technologies can work together to solve a problem. Hints are powered by [Firebase Genkit](https://firebase.google.com/docs/genkit), a new framework for AI development announced at I/O, and are deployed as a Firebase Function.

The network request to the API includes the answer to the clue, so to keep the response hidden from the client in the message data, we built a simple Dart backend using the [Dart Frog package](https://pub.dev/packages/dart_frog) to make the experience more robust. The Frog backend calls Genkit to get the hint and retrieves the answer from the database. That way players can’t simply inspect the network call to figure out the answers to the game.

You can read more about how the Genkit flow was built in the [Firebase deep dive blog](https://firebase.blog/posts/2024/06/ai-powered-crossword-genkit).

<DashImage figure src="images/05i_oBZnXJonFcLc5.png" />


**Rendering a performant crossword board with Flutter**

The board is one of the core pieces of the game. We optimized player movement on the puzzle to ensure good performance and make the best user experience for players.

We considered two options to build the board: straight Flutter or leverage the [Flame](https://flame-engine.org/) game engine. The most compelling feature of Flame for this game is its camera API, which allows the mascots to easily move and supports zoom controls. However, since that was really the only feature of Flame we would be using, we ultimately decided that using a full game engine like Flame would be overkill for this scenario.

Looking for an alternative solution, we explored the [`InteractiveViewer`](https://api.flutter.dev/flutter/widgets/InteractiveViewer-class.html) widget, which allows rendering the words in a canvas of a custom size, and moving the mascots around freely with matrix transformations. `InteractiveViewer` was a simpler solution for our needs with less dependencies and load, which better allowed us to showcase the flexibility and performance of Flutter.

**The power and flexibility of the InteractiveViewer**

The `InteractiveViewer` has built-in zoom gestures, but we wanted to add more intuitive buttons for the desktop experience. Leveraging the matrix transformations, we implemented zoom controls by first calculating the change in scale and updating the new viewport with the center as a constant reference point:

<DashImage figure src="images/0D0vBnIvT4TKXnRnG.png" />


Once we have the new tentative viewport, we have to ensure that it fits within the boundaries of the board. We have two scenarios that we must allow for: when the viewport is bigger than the board, or when it’s positioned out of bounds. We update both the change in scale and the translation of the viewport to ensure it fits within the boundaries by tweaking the zoom level or the location of the viewport, as shown in the following code:

<DashImage figure src="images/0wpfH-WuFnd984LEW.png" />


Finally, calculate the transformation and apply it to the `InteractiveViewer` controller:

<DashImage figure src="images/0Sf93caUyyPq4OKKa.png" />


With this code, we’ve extended the zoom controls of the `InteractiveViewer` and transformed the viewport according to our needs.

**Boosting performance with WebAssembly in Flutter**

WebAssembly support for Flutter web apps was one of the major announcements for the Flutter community this year at IO. With players across the world playing the game at the same time, performance was a critical factor. We leveraged [WebAssembly (Wasm)](https://docs.flutter.dev/platform-integration/web/wasm), built into Flutter, to reduce performance bottlenecks and maintain a smooth frame rate, particularly when it comes to the character and board animations in the game.

<DashImage figure src="images/0Nyoq1GrKd0eFce-M.gif" />


**Dart Backend and Cloud Run: Seamless code sharing between backend and frontend**

To ensure a smooth gaming experience for all users, our Dart backend is built with the [Dart Frog package](https://pub.dev/packages/dart_frog) and is hosted on [Google Cloud Run,](https://dartfrog.vgv.dev/docs/deploy/google-cloud-run) to leverage the auto scaling capabilities. This helps to maintain optimal performance regardless of the active number of players as the game makes multiple calls, such as every time a user is created, or when a player submits a word or asks for a hint.

Using a backend to confirm the answers to each clue also allowed us to safeguard the crossword puzzle and prevent cheating. Specifically, the app reads information with the Flutter Firestore SDK but the database *only* allows changes from the Dart back end. This also allowed for faster development since we could use the same language (Dart) between the front end and the back end.

We can see this pattern in action in the Player data model, for example, which creates a player using the Dart Frog API.

<DashImage figure src="images/0s1G59HNBAWqoq0xt.png" />


The app directly accesses the players leaderboard, reusing the same model and avoiding duplication and desynchronization:

<DashImage figure src="images/0538Moipv7JTPricT.png" />


**Start playing: Solve the I/O Crossword puzzle!**

Start playing the [crossword](https://crossword.withgoogle.com/) on your own in all its across-and-down glory. For those who want to dig into the details, check out its [open-source code](https://github.com/VGVentures/io_crossword) and the [Developer Learning Pathway](https://developers.google.com/learn/pathways/solution-crossword) to showcase how we built it. Catch the [recap of Google I/O](https://www.youtube.com/watch?v=xKmEOXZsU_0) to learn more about everything announced this year!