---
title: Choose a database for your Flutter app
shortTitle: Choose a database
description: >-
  Compare Cloud Firestore, Firebase SQL Connect, SQLite, and key-value
  storage to pick the right database for your Flutter app.
---

Flutter doesn't include a built-in database, so you choose one
based on the shape of your data and where it needs to live.
Most apps store data in the cloud, on the device, or both.

This page compares common database options for Flutter apps and
recommends a default for each type of data:

* **Cloud Firestore** for scalable NoSQL data that
  syncs across devices in realtime.
* **Firebase SQL Connect** for relational data that
  needs a structured SQL schema.
* **SQLite** or **key-value storage** for data that
  stays on a single device.

## Compare database options for Flutter

The following table summarizes how each option stores and syncs data.

| Option | Data model | Data location | Realtime updates | Offline access |
|---|---|---|---|---|
| [Cloud Firestore][] | NoSQL documents and collections | Cloud, with a local cache | Yes | Built in |
| [Firebase SQL Connect][] | Relational (PostgreSQL) | Cloud | Yes | Optional client cache |
| [SQLite][sqlite-recipe] | Relational | Device only | No | Always local |
| [Key-value storage][key-value-recipe] | Key-value pairs | Device only | No | Always local |

{:.table .table-striped}

## Choose Cloud Firestore for NoSQL data

[Cloud Firestore][] is the recommended default when your app needs
a scalable cloud database that keeps data in sync
across users and devices.
Cloud Firestore stores data as documents organized into collections,
and the [`cloud_firestore`][] package gives your Flutter app
direct, secure access from client code.

Choose Cloud Firestore if your app needs:

* **Realtime sync:** listen to a document or query and
  rebuild your UI whenever the data changes,
  for example, with a `StreamBuilder` widget.
* **Offline support:** read and write cached data while the device is
  offline, and sync changes when the connection returns.
  Offline persistence is supported on Android, Apple platforms, and the web.
* **Flexible, evolving data:** store nested or semi-structured data
  without defining a schema up front.
* **Automatic scaling:** serve many users without
  provisioning or managing servers.

Common use cases include chat, social feeds, collaborative editing,
and user-generated content.

To add Cloud Firestore to your app, run the following command
from the root of your Flutter project:

```console
$ flutter pub add cloud_firestore
```

Then follow the [Cloud Firestore quickstart][firestore-quickstart]
to set up your database.

## Choose Firebase SQL Connect for SQL data

[Firebase SQL Connect][] is the recommended default when your data is
relational and benefits from a structured schema.
SQL Connect is backed by a fully managed PostgreSQL database
on Cloud SQL. You define your schema, queries, and mutations in GraphQL,
and SQL Connect generates a type-safe Dart SDK for your Flutter app.

Choose Firebase SQL Connect if your app needs:

* **Relational data:** model entities with relationships,
  such as users, orders, and products, and query across them.
* **A strict schema:** enforce data types and constraints
  in the database instead of in client code.
* **Type-safe Dart code:** call generated Dart methods for each query
  and mutation instead of building requests by hand.
* **Realtime updates:** subscribe to a query to get
  new results when the underlying data changes.
* **Vector search:** build AI-powered features, such as
  semantic search, on top of your relational data.

Common use cases include ecommerce, booking and scheduling,
inventory management, and apps with reporting needs.

To get started, follow the guide to
[use generated Flutter SDKs][sql-connect-flutter] with SQL Connect.

## Use SQLite or key-value storage locally

If your data doesn't need to leave the device,
you can store it locally without a cloud backend:

* **SQLite:** store and query large amounts of structured data
  on the device. To learn how, check out
  [Persist data with SQLite][sqlite-recipe] and
  [Persistent storage architecture: SQL][sql-architecture].
* **Key-value storage:** save small amounts of simple data,
  such as user preferences and settings, with the
  [`shared_preferences`][] package. To learn how, check out
  [Store key-value data on disk][key-value-recipe] and
  [Persistent storage architecture: Key-value data][key-value-architecture].

Local-only data isn't backed up or synced across devices.
If users expect to access their data after reinstalling your app or
on another device, use a cloud database instead.

## Combine cloud and local storage

Many apps use more than one storage option.
For example, an app might use Cloud Firestore or Firebase SQL Connect
for shared, synced data, and `shared_preferences` for
device-specific settings, such as a theme preference.

To design an app that keeps working without a network connection,
check out [Offline-first support][offline-first].

## Next steps

To start building with a cloud database, check out the following resources:

* [Add Firebase to your Flutter app][firebase-setup]
* [Firebase for Flutter][firebase-page]
* [Get started with Cloud Firestore][firestore-quickstart]
* [Firebase SQL Connect for Flutter][sql-connect-flutter]

[Cloud Firestore]: {{site.firebase}}/docs/firestore
[`cloud_firestore`]: {{site.pub-pkg}}/cloud_firestore
[firebase-page]: /data-and-backend/firebase
[firebase-setup]: {{site.firebase}}/docs/flutter/setup
[Firebase SQL Connect]: {{site.firebase}}/docs/sql-connect
[firestore-quickstart]: {{site.firebase}}/docs/firestore/quickstart
[key-value-architecture]: /app-architecture/design-patterns/key-value-data
[key-value-recipe]: /cookbook/persistence/key-value
[offline-first]: /app-architecture/design-patterns/offline-first
[`shared_preferences`]: {{site.pub-pkg}}/shared_preferences
[sql-architecture]: /app-architecture/design-patterns/sql
[sql-connect-flutter]: {{site.firebase}}/docs/sql-connect/flutter-sdk
[sqlite-recipe]: /cookbook/persistence/sqlite
