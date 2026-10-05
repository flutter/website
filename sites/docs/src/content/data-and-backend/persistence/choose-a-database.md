---
title: Choose a database for your Flutter app
shortTitle: Choose a database
description: >-
  Compare Cloud Firestore, Firebase SQL Connect, SQLite, and key-value
  storage to pick the right database for your Flutter app.
---

Flutter doesn't include a built-in database, so you can choose one
based on the shape of your data and where it needs to live.
For most Flutter apps, start with one of these options:

* **Cloud Firestore** for scalable NoSQL data that
  syncs across devices in realtime.
* **Firebase SQL Connect** for relational data that
  needs a structured SQL schema.
* **On-device SQLite** or **key-value storage** for local data
  that doesn't need a cloud backend by default.

## Compare database options

Here's a quick look at how each option stores and syncs data:

| Option | Data model | Data location | Realtime updates | Offline access |
|---|---|---|---|---|
| [Cloud Firestore][] | NoSQL documents and collections | Cloud, with a local cache | Yes | Built in (reads and writes) |
| [Firebase SQL Connect][] | Relational (PostgreSQL) | Cloud | Yes | Optional query cache |
| [On-device SQLite][sqlite-recipe] | Relational | Device by default | Local streams (with `drift`) | Always local |
| [Key-value storage][key-value-recipe] | Key-value pairs | Device only | No | Always local |

{:.table .table-striped}

## Choose Cloud Firestore for NoSQL data

[Cloud Firestore][] is the recommended default when your app needs
a scalable cloud database that keeps data in sync across users and
devices—such as in chat apps, collaborative tools, live multiplayer
games, or offline-first field service and inspection apps.
It stores data as documents organized into collections, and the
[`cloud_firestore`][] package lets your Flutter app read and write
data directly from client code, secured with
[Cloud Firestore Security Rules][firestore-rules].

Cloud Firestore is a good fit when your app needs:

* **Realtime sync:** listen to a document or query and
  rebuild your UI whenever the data changes,
  for example, with a `StreamBuilder` widget.
* **Offline support:** read and write cached data while the device is
  offline, and automatically sync changes when the connection returns,
  without building a custom offline queue. Offline persistence is
  enabled by default on Android and Apple platforms, and can be
  enabled on the web.
* **Flexible, evolving data:** store nested or semi-structured data
  without defining a schema up front.
* **Automatic scaling:** handle growing traffic without
  provisioning or managing servers.

To add Cloud Firestore to your project, run:

```console
$ flutter pub add cloud_firestore
```

Then follow the [Cloud Firestore quickstart][firestore-quickstart]
to set up your database.

:::note
Cloud Firestore is Firebase's recommended NoSQL database for new apps
instead of [Firebase Realtime Database][realtime-db], unless your app
only needs low-latency synchronization for small, frequent state
updates like presence indicators.
:::

## Choose Firebase SQL Connect for SQL data

For structured, relational data—such as in an ecommerce storefront,
appointment booking system, personal finance tracker, or inventory
system—[Firebase SQL Connect][] (formerly Firebase Data Connect) is
the recommended default. SQL Connect is backed by a fully managed
PostgreSQL database on Cloud SQL. You define your schema, queries,
and mutations in GraphQL, deploy them to the server, and call them
from your Flutter app using a generated, type-safe Dart SDK powered
by the [`firebase_data_connect`][] package.

Key capabilities include:

* **Relational data:** model entities with relationships,
  such as users, orders, and products, and query across them.
* **A strict schema:** enforce data types, relational constraints,
  and foreign keys in the database.
* **Type-safe generated SDKs:** call generated Dart methods for each
  predefined server query and mutation instead of writing raw queries
  or duplicating data models by hand. Because SQL Connect generates
  client SDKs directly from your backend schema, your Flutter app
  stays in sync with your database without cross-language schema drift.
* **Realtime updates:** subscribe to queries for automatic or
  configured refresh updates when data changes.
* **Optional query caching:** cache query responses on the client to
  reduce network requests and read cached results while offline.
* **Vector search:** build AI-powered features, such as
  semantic search, on top of your relational data.

To add the SQL Connect plugin to your project, run:

```console
$ flutter pub add firebase_data_connect
```

Next, follow the guide to
[use generated Flutter SDKs][sql-connect-flutter] with SQL Connect.

## Use SQLite or key-value storage locally

If your data doesn't need to leave the device,
you can store it locally without a cloud backend:

* **SQLite:** store and query larger amounts of structured relational
  data on the device. Use [`sqflite`][] for direct SQL queries, or
  [`drift`][] for type-safe Dart queries, reactive data streams, and
  schema migrations across mobile, desktop, and web. For a
  step-by-step example, check out
  [Persist data with SQLite][sqlite-recipe], or read
  [Persistent storage architecture: SQL][sql-architecture] to learn
  how to structure a local database layer in a larger app.
* **Key-value storage:** save small amounts of simple data,
  such as user preferences and settings, with the
  [`shared_preferences`][] package. Get started with the
  [Store key-value data on disk][key-value-recipe] recipe, or check out
  [Persistent storage architecture: Key-value data][key-value-architecture].
  To store sensitive data like authentication tokens or encrypted
  records, use [`flutter_secure_storage`][] instead.

By default, on-device SQLite and key-value packages store data only
on the local device, so data isn't synced across devices or preserved
if a user uninstalls your app without a backup or sync service.
If users expect automatic access to their data across devices or
after switching phones, use a cloud database like Cloud Firestore or
Firebase SQL Connect instead.

## Combine cloud and local storage

You don't have to pick just one option.
For example, your app might use Cloud Firestore or Firebase SQL Connect
for shared, synced data, alongside `shared_preferences` for
device-specific settings like a dark mode toggle.
To learn how to combine local and remote data sources so your app
keeps working without a network connection, check out
[Offline-first support][offline-first].

Both Cloud Firestore and Firebase SQL Connect also work alongside
other Firebase services, including
[Firebase Authentication][firebase-auth] ([`firebase_auth`][]),
[Cloud Storage for Firebase][firebase-storage] ([`firebase_storage`][]),
and [Firebase AI Logic][firebase-ai] ([`firebase_ai`][]).
For example, your app can capture receipt or inspection photos,
upload them to Cloud Storage, extract structured fields with
Firebase AI Logic, and sync the resulting records in Cloud Firestore
or SQL Connect—all within a single project.

If your app needs custom backend logic, you can also write
[Cloud Functions for Firebase or backend servers in Dart][dart-server]
and share a single Dart package for your data models, serialization,
and validation logic across both your Flutter client and backend.

## Next steps

To start building with a cloud database, check out the following resources:

* [Add Firebase to your Flutter app][firebase-setup]
* [Firebase for Flutter][firebase-page]
* [Get started with Cloud Firestore][firestore-quickstart]
* [Firebase SQL Connect for Flutter][sql-connect-flutter]

[Cloud Firestore]: {{site.firebase}}/docs/firestore
[`cloud_firestore`]: {{site.pub-pkg}}/cloud_firestore
[dart-server]: {{site.dart-site}}/server#sharing-code-between-flutter-apps-and-dart-backends
[`drift`]: {{site.pub-pkg}}/drift
[firebase-ai]: {{site.firebase}}/docs/ai-logic/get-started
[`firebase_ai`]: {{site.pub-pkg}}/firebase_ai
[firebase-auth]: {{site.firebase}}/docs/auth/flutter/start
[`firebase_auth`]: {{site.pub-pkg}}/firebase_auth
[`firebase_data_connect`]: {{site.pub-pkg}}/firebase_data_connect
[firebase-page]: /data-and-backend/firebase
[firebase-setup]: {{site.firebase}}/docs/flutter/setup
[Firebase SQL Connect]: {{site.firebase}}/docs/sql-connect
[firebase-storage]: {{site.firebase}}/docs/storage/flutter/start
[`firebase_storage`]: {{site.pub-pkg}}/firebase_storage
[firestore-quickstart]: {{site.firebase}}/docs/firestore/quickstart
[firestore-rules]: {{site.firebase}}/docs/firestore/security/get-started
[`flutter_secure_storage`]: {{site.pub-pkg}}/flutter_secure_storage
[key-value-architecture]: /app-architecture/design-patterns/key-value-data
[key-value-recipe]: /cookbook/persistence/key-value
[offline-first]: /app-architecture/design-patterns/offline-first
[realtime-db]: {{site.firebase}}/docs/database/flutter/start
[`shared_preferences`]: {{site.pub-pkg}}/shared_preferences
[`sqflite`]: {{site.pub-pkg}}/sqflite
[sql-architecture]: /app-architecture/design-patterns/sql
[sql-connect-flutter]: {{site.firebase}}/docs/sql-connect/flutter-sdk
[sqlite-recipe]: /cookbook/persistence/sqlite
