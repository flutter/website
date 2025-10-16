// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../models/learning_resource_model.dart';

final List<LearningResource> allLearningResources = [
  ..._codelabs,
  ..._cookbookRecipes,
  ..._demos,
  ..._videos,
  ..._quickStartsForDart,
  ..._quickStartsForFlutter,
];

final List<LearningResource> _videos = [
  LearningResource(
    name: 'Your first Flutter app workshop',
    description:
        'An instructor-led version of our very popular '
        '\'Write your first Flutter app\' codelab.',
    type: LearningResourceType.workshop,
    tags: [
      LearningResourceTag.goodForBeginners,
    ],
    link: (
      url: 'https://www.youtube.com/watch?v=8sAyPDLorek',
      source: LearningResourceSource.youTube,
    ),
  ),
];

final List<LearningResource> _codelabs = [
  LearningResource(
    name: 'Your first Flutter app',
    description:
        'Create a simple random-name generator app. '
        'This app is responsive and runs on mobile, desktop, and web.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.goodForBeginners,
    ],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-codelab-first',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Records and Patterns in Dart',
    description:
        'Discover Dart 3\'s new records and patterns features. '
        'Learn how you can use them in a Flutter app to help you '
        'write more readable and maintainable Dart code.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.dart,
    ],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/dart-patterns-records',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Scrolling experiences in Flutter',
    description:
        'Start with an app that performs '
        'simple, straightforward scrolling and enhance it to '
        'create fancy and custom scrolling effects by using slivers.',
    type: LearningResourceType.tutorial,
    tags: [],
    link: (
      url: 'https://www.youtube.com/watch?v=YY-_yrZdjGc',
      source: LearningResourceSource.youTube,
    ),
  ),
  LearningResource(
    name: 'Take your Flutter app from boring to beautiful',
    description:
        'Learn how to use some of the features in Material 3 to '
        'make your app beautiful and responsive.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.design,
      LearningResourceTag.material,
    ],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-boring-to-beautiful',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Building next generation UIs in Flutter',
    description:
        'Learn how to build a Flutter app that uses the '
        'power of `flutter_animate`, fragment shaders, and particle fields.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.animation,
      LearningResourceTag.design,
    ],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-next-gen-uis',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Adaptive Apps in Flutter',
    description:
        'Learn how to build a Flutter app that adapts to '
        'the platform that it\'s running on, be that '
        'Android, iOS, the web, Windows, macOS, or Linux.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.desktop,
      LearningResourceTag.ios,
      LearningResourceTag.web,
    ],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-adaptive-app',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Animations in Flutter',
    description:
        'Learn how to build animated effects in Flutter. '
        'You\'ll learn how to build implicit and explicit animations, '
        'and customize navigation transition animations using '
        'the animations package and predictive back on Android.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.animation,
    ],
    link: (
      url: 'https://codelabs.developers.google.com/advanced-flutter-animations',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Building Beautiful Transitions with Material Motion for Flutter',
    description:
        'Learn how to use the Material animations package to '
        'add pre-built transitions to a Material app called Reply.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.animation,
      LearningResourceTag.material,
    ],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/material-motion-flutter',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'How to debug layout issues with the Flutter Inspector',
    description:
        'Step-by-step instructions on how to debug common layout problems '
        'using the Flutter Inspector and Layout Explorer.',
    type: LearningResourceType.tutorial,
    tags: [],
    link: (
      url:
          'https://blog.flutter.dev/how-to-debug-layout-issues-with-the-flutter-inspector-87460a7b9db',
      source: LearningResourceSource.medium,
    ),
  ),
  LearningResource(
    name: 'Implicit animations',
    description:
        'Use DartPad (no downloads required!) to learn how '
        'to use implicit animations to add motion and '
        'create visual effects for the widgets in your UI.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.animation,
    ],
    link: (
      url: '/codelabs/implicit-animations',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'MDC-101 - Material Components (MDC) Basics',
    description:
        'Learn the basics of using Material Components by '
        'building a simple app with core components.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.material,
      LearningResourceTag.design,
    ],
    link: (
      url: 'https://codelabs.developers.google.com/codelabs/mdc-101-flutter',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'MDC-102 - Material Structure and Layout',
    description:
        'Learn how to use Material for structure and layout in Flutter. '
        'Continue building the e-commerce app, introduced in MDC-101, '
        'by adding navigation, structure, and data.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.material,
      LearningResourceTag.design,
    ],
    link: (
      url: 'https://codelabs.developers.google.com/codelabs/mdc-102-flutter',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'MDC-103 - Material Theming with Color, Shape, Elevation, and Type',
    description:
        'Discover how Material Components for Flutter make it easy to '
        'differentiate your product, and express your brand through design.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.material,
      LearningResourceTag.design,
    ],
    link: (
      url: 'https://codelabs.developers.google.com/codelabs/mdc-103-flutter',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'MDC-104 - Material Advanced Components',
    description:
        'Improve your design and learn to use our advanced backdrop menu.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.material,
      LearningResourceTag.design,
    ],
    link: (
      url: 'https://codelabs.developers.google.com/codelabs/mdc-104-flutter',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Adding AdMob Ads to a Flutter app',
    description:
        'Learn how to add an AdMob banner, an interstitial ad, and '
        'a rewarded ad to an app called Awesome Drawing Quiz, '
        'a game that lets players guess the name of the drawing.',
    type: LearningResourceType.tutorial,
    tags: [],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/admob-ads-in-flutter',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Adding an AdMob banner and native inline ads to a Flutter app',
    description:
        'Learn how to implement inline banner and native ads to a '
        'travel booking app that lists possible flight destinations.',
    type: LearningResourceType.tutorial,
    tags: [],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/admob-inline-ads-in-flutter',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Adding in-app purchases to your Flutter app',
    description:
        'Extend a simple gaming app that uses the Dash mascot as '
        'currency to offer three types of in-app purchases: '
        'consumable, non-consumable, and subscription.',
    type: LearningResourceType.tutorial,
    tags: [],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-in-app-purchases',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Add a user authentication flow using FirebaseUI',
    description:
        'Learn how to add Firebase authentication to a Flutter app with '
        'only a few lines of code.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.firebase,
    ],
    link: (
      url: 'https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Get to know Firebase for Flutter',
    description:
        'Build an event RSVP and guestbook chat app on '
        'both Android and iOS using Flutter, authenticating users with '
        'Firebase Authentication, and sync data using Cloud Firestore.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.firebase,
      LearningResourceTag.ios,
    ],
    link: (
      url: 'https://firebase.google.com/codelabs/firebase-get-to-know-flutter',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Notifications with Firebase Cloud Messaging',
    description:
        'Learn how to develop a multi-platform app with '
        'Flutter and Firebase Cloud Messaging, integrating FCM to '
        'send and receive messages on Android, iOS, and web.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.firebase,
      LearningResourceTag.web,
      LearningResourceTag.ios,
    ],
    link: (
      url: 'https://firebase.google.com/codelabs/firebase-fcm-flutter',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Add sound and music to your Flutter game with SoLoud',
    description:
        'The SoLoud package, a free and portable engine, '
        'delivers the low-latency and high-performance sound '
        'that\'s essential for many games.',
    type: LearningResourceType.tutorial,
    tags: [],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-codelab-soloud',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Build a 2D physics game with Flutter and Flame',
    description:
        'This codelab guides you through crafting game mechanics in a '
        'Flutter and Flame game using a 2D physics simulation called Forge2D.',
    type: LearningResourceType.tutorial,
    tags: [],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-flame-forge2d',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Build a word puzzle with Flutter',
    description:
        'This codelab focuses on building word puzzle games, and '
        'dives into using Flutter\'s background processing to '
        'generate expansive crossword-style grids of interlocking words.',
    type: LearningResourceType.tutorial,
    tags: [],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-word-puzzle',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Introduction to Flame with Flutter',
    description:
        'Build a Breakout clone using the Flame 2D game engine and '
        'embed it in a Flutter wrapper.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.goodForBeginners,
    ],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-flame-brick-breaker',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Adding Google Maps to a Flutter app',
    description:
        'Display a Google map in an app, retrieve data from a web service, '
        'and display the data as markers on the map.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.googleApis,
    ],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/google-maps-in-flutter',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Adding WebView to your Flutter app',
    description:
        'With the WebView Flutter plugin you can add a WebView widget to '
        'your Android or iOS Flutter app.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.ios,
    ],
    link: (
      url: 'https://codelabs.developers.google.com/codelabs/flutter-webview',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Using FFI in a Flutter plugin',
    description:
        'Learn how to use Dart\'s FFI (foreign function interface) library, '
        'ffigen, allowing you to leverage existing native libraries that '
        'provide a C interface.',
    type: LearningResourceType.tutorial,
    tags: [],
    link: (
      url: 'https://codelabs.developers.google.com/codelabs/flutter-ffigen',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'How to test a Flutter app',
    description:
        'Start with a simple app that manages state with the Provider package. '
        'Unit test the provider package. '
        'Write widget tests for two of the widgets. '
        'Use Flutter Driver to create an integration test.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-app-testing/',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Adding a Home Screen widget to your Flutter app',
    description:
        'Learn how to add a Home Screen widget to your Flutter app on iOS. '
        'This applies to your home screen, lock screen, or the today view.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.ios,
    ],
    link: (
      url: 'https://codelabs.developers.google.com/flutter-home-screen-widgets',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
  LearningResource(
    name: 'Write a Flutter desktop application',
    description:
        'Build a Flutter desktop app (Windows, Linux, or macOS) that '
        'accesses GitHub APIs, and create and use plugins to '
        'interact with native APIs and desktop applications.',
    type: LearningResourceType.tutorial,
    tags: [
      LearningResourceTag.desktop,
    ],
    link: (
      url:
          'https://codelabs.developers.google.com/codelabs/flutter-github-client',
      source: LearningResourceSource.googleCodelab,
    ),
  ),
];

final List<LearningResource> _cookbookRecipes = [
  LearningResource(
    name: 'Animate a page route transition',
    description:
        'Transition between routes by animating the new route '
        'into view from the bottom of the screen.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.animation,
    ],
    link: (
      url: '/cookbook/animation/page-route-animation',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Animate a widget using a physics simulation',
    description:
        'Learn how to move a widget from a dragged point back to '
        'the center using a spring simulation.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.animation,
    ],
    link: (
      url: '/cookbook/animation/physics-simulation',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Animate the properties of a container',
    description:
        'Use AnimatedContainer to animate the '
        'size, background color, and border radius of a Container.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.animation,
    ],
    link: (
      url: '/cookbook/animation/animated-container',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Fade a widget in and out',
    description:
        'The AnimatedOpacity widget makes it easy to '
        'perform opacity animations.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.animation,
    ],
    link: (
      url: '/cookbook/animation/opacity-animation',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Add a drawer to a screen',
    description:
        'Use the Drawer widget in combination with a Scaffold to '
        'create a layout with a Material Design drawer.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.widgets,
      LearningResourceTag.material,
      LearningResourceTag.layout,
    ],
    link: (
      url: '/cookbook/design/drawer',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Display a snackbar',
    description: 'Use the Snackbar widget to display messages to your users.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/design/snackbars',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Export fonts from a package',
    description: 'Use a font across multiple apps.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/design/package-fonts',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Update the UI based on orientation',
    description:
        'Build a list that displays two columns in portrait mode and '
        'three columns in landscape mode.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/design/orientation',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Use a custom font',
    description: 'Apply fonts to your entire app or individual widgets.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/design/fonts',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Use themes to share colors and font styles',
    description: 'To share styles across your app, use Themes.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/design/themes',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Work with tabs',
    description:
        'Working with tabs is a common pattern in mobile apps that '
        'follow the Material Design or Cupertino guidelines.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/design/tabs',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Create a download button',
    description:
        'Build a download button that transitions through '
        'multiple visual states, based on the status of an app download.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.design,
      LearningResourceTag.animation,
    ],
    link: (
      url: '/cookbook/effects/download-button',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Create a nested navigation flow',
    description:
        'Create top level routes, and routes nested below specific widgets.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.routingAndNavigation,
    ],
    link: (
      url: '/cookbook/effects/nested-nav',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Create a scrolling parallax effect',
    description:
        'Create the parallax effect by building a '
        'list of cards with images that \'move\'.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.design,
    ],
    link: (
      url: '/cookbook/effects/parallax-scrolling',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Create a shimmer loading effect',
    description:
        'Communicate that data is loading with a '
        'chrome color shimmer on the screen.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.animation,
    ],
    link: (
      url: '/cookbook/effects/shimmer-loading',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Create a staggered menu animation',
    description:
        'Build a drawer menu with animated content that '
        'is staggered and has a button that pops in at the bottom',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.animation,
      LearningResourceTag.design,
    ],
    link: (
      url: '/cookbook/effects/staggered-menu-animation',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Create a typing indicator',
    description:
        'Build a speech bubble typing indicator that '
        'animates in and out of view.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/effects/typing-indicator',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Create an expandable FAB',
    description:
        'Create a floating action button that spawns other action buttons.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.design,
    ],
    link: (
      url: '/cookbook/effects/expandable-fab',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Drag a UI element',
    description:
        'Build a drag-and-drop interaction when the user long presses.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.design,
    ],
    link: (
      url: '/cookbook/effects/drag-a-widget',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Build a form with validation',
    description: 'Learn how to add validation to a form.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/forms/validation',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Create and style a text field',
    description: 'In this recipe, explore how to create and style text fields.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/forms/text-input',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Focus and text fields',
    description: 'Shift focus to a text field programmatically.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/forms/focus',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Handle changes to a text field',
    description: 'Listen for changes to a TextField using a callback.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/forms/text-field-changes',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Retrieve the value of a text field',
    description:
        'Learn how to retrieve the text a user has entered into a text field.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/forms/retrieve-input',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Add achievements and leaderboards to your game',
    description:
        'Use the games_services package to '
        'add leaderboard functionality to your mobile game.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/games/achievements-leaderboard',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Add multiplayer support to your Flutter game',
    description:
        'Use the cloud_firestore package to '
        'implement multiplayer capabilities in your game.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.firebase,
    ],
    link: (
      url: '/cookbook/games/firestore-multiplayer',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Add ads to your Flutter game',
    description:
        'Use the google_mobile_ads package to '
        'add a banner ad to your app or game.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/plugins/google-mobile-ads',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Add Material touch ripples',
    description: 'Use the Inkwell widget to display a ripple animation.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.material,
    ],
    link: (
      url: '/cookbook/gestures/ripples',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Handle taps',
    description:
        'Use the GestureDetector widget to respond to '
        'fundamental actions, such as tapping and dragging.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/gestures/handling-taps',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Implement swipe to dismiss',
    description: 'Learn how to use the Dismissible widget.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/gestures/dismissible',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Display images from the internet',
    description:
        'To work with images from a URL, use the Image.network() constructor.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.goodForBeginners,
    ],
    link: (
      url: '/cookbook/images/network-image',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Fade in images with a placeholder',
    description:
        'Use the FadeInImage widget to '
        'show a visual placeholder before an image loads.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/images/fading-in-images',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Grid lists',
    description: 'Learn to use a GridView widget.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.layout,
    ],
    link: (
      url: '/cookbook/lists/grid-lists',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Horizontal lists',
    description: 'Learn to display items horizontally in a scrollable list.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.layout,
    ],
    link: (
      url: '/cookbook/lists/horizontal-list',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Lists with different types of items',
    description: 'Create a list with headers followed by a few list items.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.layout,
    ],
    link: (
      url: '/cookbook/lists/mixed-list',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Lists and floating app bars',
    description: 'Place a floating app bar or navigation bar above a list.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.layout,
    ],
    link: (
      url: '/cookbook/lists/floating-app-bar',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Basic lists',
    description: 'Learn to display items with the ListView widget.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.layout,
    ],
    link: (
      url: '/cookbook/lists/basic-list',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Long lists',
    description:
        'Work with longer lists with the Listview.builder constructor.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.layout,
    ],
    link: (
      url: '/cookbook/lists/long-lists',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Lists with spaced items',
    description: 'Create a list with padding between items.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.layout,
    ],
    link: (
      url: '/cookbook/lists/spaced-items',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Animate a widget across screens',
    description:
        'Use the Hero widget to animate a widget from one screen to the next.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.routingAndNavigation,
      LearningResourceTag.animation,
    ],
    link: (
      url: '/cookbook/navigation/hero-animations',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Navigate to a new screen and back',
    description: 'This recipe uses the Navigator to navigate to a new route.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.routingAndNavigation,
    ],
    link: (
      url: '/cookbook/navigation/navigation-basics',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Named routes',
    description: 'Create named routes and navigate to them.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.routingAndNavigation,
    ],
    link: (
      url: '/cookbook/navigation/named-routes',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Arguments and named routes',
    description:
        'Pass arguments to a named route and read the arguments on that route.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.routingAndNavigation,
    ],
    link: (
      url: '/cookbook/navigation/navigate-with-arguments',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Android app links',
    description: 'Set up deep linking on Android',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.routingAndNavigation,
    ],
    link: (
      url: '/cookbook/navigation/set-up-app-links',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'iOS universal links',
    description: 'Set up universal links for iOS',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.routingAndNavigation,
      LearningResourceTag.ios,
    ],
    link: (
      url: '/cookbook/navigation/set-up-universal-links',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Return data from a screen',
    description:
        'Return data from one screen to another with the Navigator.pop method.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.routingAndNavigation,
    ],
    link: (
      url: '/cookbook/navigation/returning-data',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Send data to a new screen',
    description: 'Send data from one screen to new one.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.routingAndNavigation,
    ],
    link: (
      url: '/cookbook/navigation/passing-data',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Fetch data from the internet',
    description: 'Learn to use HTTP in your app.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/networking/fetch-data',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Make authenticated requests',
    description: 'Authorization headers in HTTP',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/networking/authenticated-requests',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Send data to the internet',
    description: 'Send HTTP POST requests in your app.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/networking/send-data',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Update data over the internet',
    description: 'Send an HTTP put request.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/networking/update-data',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Delete data on the internet',
    description: 'Send an HTTP delete request.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/networking/delete-data',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'WebSockets',
    description: 'Connect to and communicate with a websocket.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/networking/web-sockets',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Parse JSON in the background',
    description: 'Learn to use Dart\'s Isolate objects',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/networking/background-parsing',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Persist data with SQLite',
    description: 'Use the sqflite package.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/persistence/sqlite',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Read and write files',
    description:
        'Use the dart:io library and path_provider plugin to '
        'save files to disk.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/persistence/reading-writing-files',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Store key-value data on disk',
    description: 'Persist data with shared_preferences',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/persistence/key-value',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Play and pause a video',
    description:
        'Play videos stored on the file system, as an asset, '
        'or from the internet.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/plugins/play-video',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Use the camera',
    description: 'Learn to use a devices camera.',
    type: LearningResourceType.recipe,
    tags: [],
    link: (
      url: '/cookbook/plugins/picture-using-camera',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Report errors to a service',
    description: 'Report errors to Sentry crash reporting.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url: '/cookbook/maintenance/error-reporting',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Performance profiling',
    description: 'Write a test that records a performance timeline.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url: '/cookbook/testing/integration/profiling',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Write unit tests',
    description: 'An introduction to writing unit tests.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url: '/cookbook/testing/unit/introduction',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Write widget tests',
    description: 'An introduction to writing widget tests.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url: '/cookbook/testing/widget/introduction',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Mock dependencies in tests',
    description: 'The basics of mocking with the Mockito package.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url: '/cookbook/testing/unit/mocking',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Find widgets in tests',
    description:
        'This recipe looks at the \'find\' constant '
        'provided by the flutter_test package.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url: '/cookbook/testing/widget/finders',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Handle scrolling',
    description: 'Learn how to scroll in widget tests.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url: '/cookbook/testing/widget/scrolling',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'App orientation',
    description: 'Learn how to check app orientation in widget tests.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url: '/cookbook/testing/widget/orientation',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Tap, drag, and enter text',
    description: 'Interact with widgets in widget tests.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url: '/cookbook/testing/widget/tap-drag',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Persistent storage architecture - SQL',
    description: 'Save complex application data to a user\'s device with SQL.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.architecture,
    ],
    link: (
      url: '/app-architecture/design-patterns/sql',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Error handling with Result objects',
    description: 'Improve error handling across classes with Result objects.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.testing,
      LearningResourceTag.architecture,
    ],
    link: (
      url: '/app-architecture/design-patterns/result',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Optimistic state',
    description:
        'Improve the perception of responsiveness of an application by '
        'implementing optimistic state.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.architecture,
    ],
    link: (
      url: '/app-architecture/design-patterns/optimistic-state',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Offline First',
    description:
        'Implement offline-first support for one feature in an application.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.architecture,
    ],
    link: (
      url: '/app-architecture/design-patterns/offline-first',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Persistent storage architecture - Key-value data',
    description:
        'Save application data to a user\'s on-device key-value store.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.architecture,
    ],
    link: (
      url: '/app-architecture/design-patterns/key-value-data',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
  LearningResource(
    name: 'Command pattern',
    description: 'Simplify view model logic by implementing a Command class.',
    type: LearningResourceType.recipe,
    tags: [
      LearningResourceTag.architecture,
    ],
    link: (
      url: '/app-architecture/design-patterns/command',
      source: LearningResourceSource.flutterDocs,
    ),
  ),
];

final List<LearningResource> _demos = [
  LearningResource(
    name: 'Add-to-app',
    description: 'Recommended approaches for adding Flutter to existing apps.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.ios,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/add_to_app',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Android splash screen',
    description:
        'A Flutter sample app that exemplifies how to '
        'implement an animated splash screen for Android devices.',
    type: LearningResourceType.sample,
    tags: [],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/android_splash_screen',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'iOS app clip',
    description:
        'A sample project demonstrating integration with iOS App Clip.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.ios,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/ios_app_clip',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Swift platform view',
    description:
        'A Flutter sample app that combines a iOS-native '
        'UIViewController with a full-screen Flutter view.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.ios,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/platform_view_swift',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Simplistic editor',
    description:
        'This sample text editor showcases the use of TextEditingDeltas and '
        'a DeltaTextInputClient to expand and contract styled ranges of text.',
    type: LearningResourceType.sample,
    tags: [],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/simplistic_editor',
      source: LearningResourceSource.gitHub,
    ),
  ),
];

final List<LearningResource> _quickStartsForDart = [
  LearningResource(
    name: 'Command-line app',
    description:
        'A command line app that parses command-line options and '
        'fetches data from GitHub.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.dart,
    ],
    link: (
      url: 'https://github.com/dart-lang/samples/tree/main/command_line',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Extension methods',
    description: 'Demonstrates Dart\'s extensions method syntax.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.dart,
    ],
    link: (
      url: 'https://github.com/dart-lang/samples/tree/main/extension_methods',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'FFI',
    description:
        'A series of simple examples demonstrating how to '
        'call C libraries from Dart.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.dart,
    ],
    link: (
      url: 'https://github.com/dart-lang/samples/tree/main/ffi',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Isolates (in a CLI)',
    description:
        'Command line applications that demonstrate how to '
        'work with Concurrency in Dart using isolates.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.dart,
    ],
    link: (
      url: 'https://github.com/dart-lang/samples/tree/main/ffi',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Native Dart app',
    description:
        'A command line application that can be compiled to '
        'native code using `dart compile exe`.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.dart,
    ],
    link: (
      url: 'https://github.com/dart-lang/samples/tree/main/native_app',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Server side Dart',
    description: 'Examples of running Dart on the server.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.dart,
    ],
    link: (
      url: 'https://github.com/dart-lang/samples/tree/main/server',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Package constraint solver',
    description:
        'Demonstrates best-practices for publishing packages on pub.dev.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.dart,
    ],
    link: (
      url: 'https://github.com/dart-lang/samples/tree/main/server',
      source: LearningResourceSource.gitHub,
    ),
  ),
];

final List<LearningResource> _quickStartsForFlutter = [
  LearningResource(
    name: 'Asset transformation',
    description:
        'Demonstrates how to transform images\' color scales and formats.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.design,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/asset_transformation',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Background isolate channels',
    description: 'Demonstrates how to use long-lived isolates.',
    type: LearningResourceType.sample,
    tags: [],
    link: (
      url:
          'https://github.com/flutter/samples/tree/main/background_isolate_channels',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Code sharing',
    description:
        'Demonstrates how to share business logic between '
        'a Flutter client and Dart server using `package:shelf`.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.dart,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/code_sharing',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Context menus',
    description:
        'This sample shows how to create and customize '
        'cross-platform context menus, such as the '
        'text selection toolbar on mobile or the right click menu on desktop.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.desktop,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/context_menus',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Desktop UI',
    description:
        'Demonstrates desktop features in both '
        'Material and FluentUI design systems.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.material,
      LearningResourceTag.desktop,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/desktop_photo_search',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'AI generated dynamic theme',
    description:
        'Demonstrates how to call on-device Flutter APIs '
        'based on output from the Gemini API.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.ai,
      LearningResourceTag.googleApis,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/dynamic_theme',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Form app',
    description:
        'A sample demonstrating different types of forms and best practices.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.layout,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/form_app',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'AI todo list',
    description:
        'A developer sample written in Flutter demonstrating how to '
        'interact with a to-do list in natural language using the Gemini API.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.ai,
      LearningResourceTag.googleApis,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/gemini_tasks',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Google Maps plugin',
    description: 'Demonstrates the Google Maps for Flutter plugin.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.googleApis,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/google_maps',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Infinite list',
    description:
        'A Flutter sample app that shows an implementation of '
        'the \'infinite list\' UX pattern.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.layout,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/infinite_list',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Isolates',
    description:
        'A sample application that demonstrates '
        'best practices when using isolates.',
    type: LearningResourceType.sample,
    tags: [],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/isolate_example',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Navigation and routing',
    description:
        'A sample that shows how to use `go_router` API to '
        'handle common navigation scenarios.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.routingAndNavigation,
    ],
    link: (
      url:
          'https://github.com/flutter/samples/tree/main/navigation_and_routing',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Google Maps Flutter plugin',
    description:
        'A sample place tracking app that uses the google_apps_flutter plugin.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.googleApis,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/place_tracker',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Platform adaptive design',
    description:
        'This sample project shows a Flutter app that '
        'maximizes application code reuse while adhering to '
        'different design patterns on Android and iOS.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.design,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/platform_design',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Counter app with Provider',
    description:
        'The starter Flutter application, but '
        'using the Provider package to manage state.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.stateManagement,
      LearningResourceTag.architecture,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/provider_counter',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Shopping app with Provider',
    description:
        'A Flutter sample app that shows a '
        'state management approach using the Provider package.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.stateManagement,
      LearningResourceTag.architecture,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/provider_shopper',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Simple shaders',
    description: 'A simple Flutter fragment shaders project.',
    type: LearningResourceType.sample,
    tags: [],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/simple_shader',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Desktop calculator',
    description:
        'A calculator sample to demonstrate a '
        'simple start for a desktop Flutter app.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.desktop,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/simplistic_calculator',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Testing app',
    description:
        'A sample app that shows different types of testing in Flutter.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.testing,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/testing_app',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Web element embedding',
    description:
        'Modifies the index.html of a Flutter app so '
        'it is launched in a custom hostElement.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.web,
    ],
    link: (
      url:
          'https://github.com/flutter/samples/tree/main/web_embedding/element_embedding_demo',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'ng-flutter',
    description:
        'A simple Angular app (and component) that '
        'replicates the element embedding example, but in an Angular app.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.web,
      LearningResourceTag.googleApis,
    ],
    link: (
      url:
          'https://github.com/flutter/samples/tree/main/web_embedding/ng-flutter',
      source: LearningResourceSource.gitHub,
    ),
  ),
  LearningResource(
    name: 'Platform channels',
    description:
        'A sample Flutter app which demonstrates how to '
        'use `MethodChannel`, `EventChannel`, '
        '`BasicMessageChannel` and `MessageCodec`.',
    type: LearningResourceType.sample,
    tags: [
      LearningResourceTag.ios,
    ],
    link: (
      url: 'https://github.com/flutter/samples/tree/main/platform_channels',
      source: LearningResourceSource.gitHub,
    ),
  ),
];
