---
title: Firebase
description: >-
  Connect your Flutter app to Firebase for authentication, Cloud Firestore,
  Firebase SQL Connect, cloud storage, AI features, and serverless Dart
  functions.
---

Firebase is Google's app development platform that provides managed
backend services for Flutter apps across Android, iOS, web, and macOS.
Using the official FlutterFire plugins, you can add authentication,
cloud databases, file storage, generative AI features, and crash
reporting without provisioning or managing servers.

Here's a quick look at the most common Firebase services for Flutter:

| Service | Use case | Package |
|---|---|---|
| [Cloud Firestore][] | NoSQL document database with realtime sync and built-in offline cache | [`cloud_firestore`][] |
| [Firebase SQL Connect][] | Managed PostgreSQL database with generated, type-safe Dart SDKs | [`firebase_data_connect`][] |
| [Firebase Authentication][firebase-auth] | User sign-in with email, phone, and providers like Google or Apple | [`firebase_auth`][] |
| [Cloud Storage for Firebase][firebase-storage] | File uploads and downloads for user photos, videos, and documents | [`firebase_storage`][] |
| [Firebase AI Logic][firebase-ai] | Direct client access to Gemini and Imagen models | [`firebase_ai`][] |
| [Cloud Functions for Firebase][firebase-functions-dart] | Serverless backend logic written in Dart, TypeScript, Python, or Go | [`cloud_functions`][] (client), [`firebase_functions`][] (server) |
| [Firebase Crashlytics][crashlytics] | Realtime crash reporting and diagnostics | [`firebase_crashlytics`][] |

{:.table .table-striped}

For a complete list of supported packages and platform availability,
check out [Available Firebase Flutter plugins][Firebase plugins].

## Connect a Flutter app to Firebase

To register your Flutter app with a Firebase project and generate
platform configuration files, use the Firebase CLI and FlutterFire CLI:

1. Install the [Firebase CLI][] and sign in to your Google Account:

   ```console
   $ firebase login
   ```

2. Install the FlutterFire CLI globally:

   ```console
   $ dart pub global activate flutterfire_cli
   ```

3. From the root of your Flutter project, add the core plugin and run
   the configuration workflow:

   ```console
   $ flutter pub add firebase_core
   $ flutterfire configure
   ```

   This command registers your per-platform apps in your Firebase
   project and generates `lib/firebase_options.dart`.

4. Initialize Firebase in `lib/main.dart` before calling `runApp()`:

   ```dart
   import 'package:firebase_core/firebase_core.dart';
   import 'package:flutter/material.dart';
   import 'firebase_options.dart';

   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
     );
     runApp(const MyApp());
   }
   ```

For detailed platform setup instructions, refer to
[Add Firebase to your Flutter app][started].

## Authenticate users with Firebase Authentication

[Firebase Authentication][firebase-auth] supports sign-in with email
and password, phone numbers, anonymous sessions, and federated
identity providers such as Google, Apple, and GitHub.

To add Firebase Authentication to your app, install [`firebase_auth`][]:

```console
$ flutter pub add firebase_auth
```

You can listen to `FirebaseAuth.instance.authStateChanges()` with a
`StreamBuilder` to react whenever a user signs in or out:

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return HomeScreen(user: snapshot.data!);
        }
        return const SignInScreen();
      },
    );
  }
}

Future<UserCredential> signInWithEmail(String email, String password) {
  return FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}
```

To learn more, check out
[Get started with Firebase Authentication on Flutter][firebase-auth] or
the [FirebaseUI authentication codelab][auth-codelab].

## Store and sync NoSQL data with Cloud Firestore

[Cloud Firestore][] is the recommended default when your app needs a
scalable NoSQL database that syncs data across devices in realtime and
works offline—such as in chat apps, collaborative tools, or
offline-first field service apps. To compare Cloud Firestore with
relational and local storage options, check out
[Choose a database for your Flutter app][choose-db].

To add Cloud Firestore to your project, run:

```console
$ flutter pub add cloud_firestore
```

The following example adds a task document to a `tasks` collection and
streams live query results into a `ListView`:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addTask(String title) {
  return FirebaseFirestore.instance.collection('tasks').add({
    'title': title,
    'completed': false,
    'createdAt': FieldValue.serverTimestamp(),
  });
}

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksStream = FirebaseFirestore.instance
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: tasksStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong.'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data();
            return ListTile(
              title: Text(data['title'] as String? ?? ''),
            );
          },
        );
      },
    );
  }
}
```

Offline persistence is enabled by default on Android and Apple
platforms (and can be enabled on the web), so your app can read and
write cached documents without a network connection and automatically
sync changes when connectivity returns. To get started, follow the
[Cloud Firestore quickstart][firestore-quickstart].

## Query relational SQL data with Firebase SQL Connect

For structured, relational data—such as in ecommerce storefronts,
appointment booking systems, or inventory trackers—[Firebase SQL Connect][]
(formerly Firebase Data Connect) provides a fully managed PostgreSQL
database on Cloud SQL.

SQL Connect generates a type-safe Dart SDK powered by the
[`firebase_data_connect`][] package directly from your backend schema
and queries. Because client models and query methods are generated from
a single schema, your Flutter app stays in sync with your PostgreSQL
database without manual model duplication or cross-language schema
drift.

To install the plugin, run:

```console
$ flutter pub add firebase_data_connect
```

To learn when to choose SQL Connect vs. Cloud Firestore or local SQLite,
check out [Choose a database for your Flutter app][choose-db], or follow
the guide to [use generated Flutter SDKs][sql-connect-flutter].

## Share Dart code with a serverless Firebase backend

When your app needs custom server-side logic, background triggers, or
administrative access to Firebase services, you can write
[Cloud Functions for Firebase in Dart][firebase-functions-dart] using
the [`firebase_functions`][] and [`firebase_admin_sdk`][] packages.

Using Dart on both your Flutter frontend and your Firebase backend lets
you share a single Dart package for data models, JSON serialization,
and validation rules across client and server. To learn how to
structure a shared-package workspace, check out
[Sharing code between Flutter apps and Dart backends][dart-server].

## Flutter and Firebase resources

To learn more about building Flutter apps with Firebase, check out the
following official and community resources.

### Documentation and codelabs

* [Add Firebase to your Flutter app][started]
* [Choose a database for your Flutter app][choose-db]
* [Get to know Firebase for Flutter codelab][codelab1]
* [Add a user authentication flow using FirebaseUI][auth-codelab]
* [Firebase AI Logic documentation][firebase-ai]
* [Use Firebase to host your Flutter app on the web][article]

### Videos

* [Get to know Firebase for Flutter video workshop][workshop]
* [Using Firestore as a backend to your Flutter app][video]
* [Live Coding Firebase Authentication with Flutter][video2]

[article]: {{site.flutter-blog}}/must-try-use-firebase-to-host-your-flutter-app-on-the-web-852ee533a469
[auth-codelab]: {{site.firebase}}/codelabs/firebase-auth-in-flutter-apps
[choose-db]: /data-and-backend/persistence/choose-a-database
[Cloud Firestore]: {{site.firebase}}/docs/firestore
[`cloud_firestore`]: {{site.pub-pkg}}/cloud_firestore
[`cloud_functions`]: {{site.pub-pkg}}/cloud_functions
[codelab1]: {{site.codelabs}}/codelabs/firebase-get-to-know-flutter
[crashlytics]: {{site.firebase}}/docs/crashlytics/get-started?platform=flutter
[dart-server]: {{site.dart-site}}/server#sharing-code-between-flutter-apps-and-dart-backends
[firebase-ai]: {{site.firebase}}/docs/ai-logic/get-started?platform=flutter
[`firebase_ai`]: {{site.pub-pkg}}/firebase_ai
[`firebase_admin_sdk`]: {{site.pub-pkg}}/firebase_admin_sdk
[firebase-auth]: {{site.firebase}}/docs/auth/flutter/start
[`firebase_auth`]: {{site.pub-pkg}}/firebase_auth
[Firebase CLI]: {{site.firebase}}/docs/cli
[`firebase_crashlytics`]: {{site.pub-pkg}}/firebase_crashlytics
[`firebase_data_connect`]: {{site.pub-pkg}}/firebase_data_connect
[firebase-functions-dart]: {{site.firebase}}/docs/functions/start-dart
[`firebase_functions`]: {{site.pub-pkg}}/firebase_functions
[Firebase plugins]: {{site.firebase}}/docs/flutter/setup#available-plugins
[Firebase SQL Connect]: {{site.firebase}}/docs/sql-connect
[firebase-storage]: {{site.firebase}}/docs/storage/flutter/start
[`firebase_storage`]: {{site.pub-pkg}}/firebase_storage
[firestore-quickstart]: {{site.firebase}}/docs/firestore/quickstart
[sql-connect-flutter]: {{site.firebase}}/docs/sql-connect/flutter-sdk
[started]: {{site.firebase}}/docs/flutter/setup
[video]: {{site.yt.watch}}/DqJ_KjFzL9I&t#38s
[video2]: {{site.yt.watch}}/OlcYP6UXlm8
[workshop]: {{site.yt.watch}}/4wunbF29Kkg
