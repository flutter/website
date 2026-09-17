---
title: "How I converted GenLatte to fullstack Dart"
description: >-
  The journey of creating a Mission Critical app for generating latte art
publishDate: 2026-09-21
author: craiglabenz
image: images/xxx
socialImage: images/xxx
category: deep-dive
layout: blog
---

If you've followed the
[winding saga of the Flutter team's venture into running pop-up coffee stands](/blog/how-we-built-a-flutter-powered-ai-coffee-shop),
you know that we combined Flutter, Firebase, and Gemini to serve whimsical coffees.
You also know that, by not charging anything, we failed to make a profit.

Further, if you looked at
[the code](https://github.com/flutter/demos/blob/main/genlatte),
you mimght also have noticed that our Flutter front-end was complemented
by Firebase functions written in Node.js.
This is a somewhat surprising historical artifact,
given that Firebase's support for Dart functions entered public preview
at almost the exact same time as GenLatte's first appearance at Google Cloud Next.

<YoutubeEmbed id="-NLK4gpT0m4" title="Flutter built a coffee shop at Cloud Next" fullwidth="true"/>

But that's just the thing—with Firebase's Dart support coming in hot
at the very last second, we simply couldn't commit to using it for a
production app with the-show-must-go-on time pressure.
If Firebase's support for Dart had been delayed for any reason,
we might not have been able to deploy in time for Cloud Next.
And so, when GenLatte appeared in the months of April, May, or June;
it did so with a Node.js backend.

*And I took that personally.*

## Fully leaning in to fullstack Dart

Dart and JavaScript are different languages with different strengths.
In some senses, this is a bit of a *No duh* statement,
but it also has deeper implications for a server-side migration,
so a 1-to-1 rewrite is probably not worth doing. After all,
Dart on the server can enjoy end-to-end type safety with Dart
on the client and it would be a real shame to stick with untyped Maps.

With this in mind, and with eyes arguably bigger than my stomach,
I set out to *dramatically* rewrite GenLatte. Amongst my many goals:

* Share models across the full stack (which was a small lift given
  my original decision to place all data classes in a separate
  `genlatte_data` package)  
* Reduce our Firebase Functions footprint to a single deployable function  
* Remove all client-side writes; instead focusing on calling server-side functions  
* Remove all server-side triggers and, instead,
  explicitly perform any data mutations in server-side functions called
  from the client  
* Persist all role-based ACL checks  
* Finally have end-to-end tests!

These goals were lofty and not exactly on my 2026 roadmap, so, naturally, I kept my plans a secret and got typing!

## Executing the migration

Unlike my work on the original GenLatte, which was largely developed
without the use of AI, I knew my crunched timeline necessitated bringing
in a *Zoom zoom* typing assistant. My model of choice was Gemini 3.6 Flash
and its combination of low latency and general know-how really came through for me.

From a high level, I still read every line that Gemini wrote in order
to maintain cognitive ownership of the project.
This was made much easier by starting from a position of deep knowledge,
and, without this commitment, I don't think the rewrite would have succeeded
in the few days I had available. Coding assistants, for all their wonder,
still greatly benefit from human guidance.

### Sharing models

Fullstack type safety means shared code across the client and server.
As previously mentioned, this means breaking out any code that must run
on the server into its own package that, critically,
*must not* depend on the Flutter SDK. This is largely straightforward,
but did require additions to my own data management package,
[`pkg:data_layer`](https://pub.dev/packages/data_layer).
One of its complementary packages,
[`pkg:data_layer_firestore`](https://pub.dev/packages/data_layer_firestore),
depends on the client-side Firebase SDK (which depends on Flutter),
so I was forced to add
[`pkg:data_layer_firestore_admin`](https://pub.dev/packages/data_layer_firestore_admin),
which is pure-Dart and thus server-friendly.

### Using a single Firebase function

By default, each Firebase function you deploy is turned into its own
Cloud Run service. (If you're a Firebase Functions user and this is news to you,
navigate to Cloud Run in the Google Cloud console and check out how the Firebase
sausage is made!)

However, after leaning on over separate 15 Cloud Run services for
GenLatte's Node.js era, I knew that I wanted a leaner setup for multiple reasons.
First, deployments would be significantly faster, but even more importantly,
*it would dramatically reduce GenLatte's server bill*.

"But Craig!" you say, "Cloud Run spins down to zero while not in use,
so is this actually important?"

Great question. I'm glad you're paying attention.

And yes, it is very important! While GenLatte was in use, various data writes and asynchronous tasks spun up all 15 of those services, and while each one would turn off while idle, that still had predictable effects on our server bill. But, to make matters worse, we set each service's minimum node count to 1 while GenLatte was in use to avoid cold starts, which of course unplugged this spin-down-to-zero functionality. The end result was that GenLatte was surprisingly expensive to turn on.

#### How to shove everything in to one Firebase service

To save money, I decided to take inspiration from
[Serverpod](https://serverpod.dev) and introduce a `BackendMessage`
[DTO](https://en.wikipedia.org/wiki/Data_transfer_object)
to tell my singular Firebase function which inner function I wanted it to
actually call. With some clever `pkg:freezed` trickery that Gemini helped me write,
I was even able to get typed responses.

The final class setup is a little convoluted, but is worth understanding
if you like type-safety and saving money.

**`BackendMessage`**

This is the parent DTO class which I use in my actual function signatures.

```dart
abstract interface class BackendMessage<R extends MessageResponse> {
  /// Json serializer.
  Json toJson();
}
```

**`MessageParameters`**

This implements `BackendMessage` and uses `pkg:freezed` to bind
individual message types with expected response classes.

The `@Implements.fromString` trick generates classes that satisfy
the parent’s requirement to bind a `MessageResponse` type.
And while the source class's use of raw strings feels type-dangerous,
any typos lead to errors in the generated classes,
meaning it functionally *is* type-safe.

```dart
@freezed
sealed class MessageParameters with _$MessageParameters {
  /// Creates a new latte order.
  @Implements.fromString('BackendMessage<SaveOrderResponse>')
  const factory MessageParameters.saveOrder({
    @LatteOrderConverter() required LatteOrder order,
  }) = SaveOrderParameters;

  /// Marks a latte order as completed.
  @Implements.fromString('BackendMessage<EmptyResponse>')
  const factory MessageParameters.completeOrder({
    required String orderId,
    required String baristaId,
  }) = CompleteOrderParameters;

  // Many more message types...
}
```

**`MessageResponse`**

This closes the loop, declaring the response classes each method call expects.
It offers a mix of individual response types for methods that want
immediate feedback and empty responses to represent a sort of
`202 Accepted` or  `204 No Content` HTTP response.

```dart
@freezed
sealed class MessageResponse with _$MessageResponse {
  /// Return data for [SaveOrderParameters].
  const factory MessageResponse.saveOrder({required LatteOrder? latteOrder}) =
      SaveOrderResponse;

  // Many more response types...

  /// Placeholder for method calls which require no return value.
  ///
  /// This is typically because the client will pick up any state changes via
  /// watched Firestore collections.
  const factory MessageResponse.empty() = EmptyResponse;
}
```

With my DTOs in order, I needed a singular server-side function to receive
and route each incoming `BackendMessage` accordingly.

```dart
firebase.https.onCallWithData<MessageParameters, Object>(
  (request, response) {
    final MessageResponse response = switch (request.data) {
      SaveOrderParameters msg => saveOrder(msg),
      CompleteOrderParameters msg => completeOrder(msg),
      ...
    }
    return response.toJson();
  },
  ...
}
```

Lastly, I needed `saveOrder` and `completeOrder` methods that
satisfied their contract.

```dart
// Other Dart files

Future<SaveOrderResponse> saveOrder(SaveOrderParameters message) {}
Future<EmptyResponse> completeOrder(CompleteOrderParameters message) {}
// Many more functions...
```

With these systems in place, I was able to shove arbitrarily many
server-side operations into a single Dart function. *Helloooooooo savings!*

### Refactoring all writes

The above `BackendMessage` system set the stage to immediately achieve
three more of my sub-goals:

1. I removed all client-side writes by blocking them in my `firestore.rules` file.
   I also refactored my data management layers to call the singular
   backend function instead of ever calling direct Firestore functions
   like `docRef.set()`.  
2. I similarly removed all Firestore triggers, but reinstantiated the missing
   functionality into functions I could explicitly call from the client.  
3. I maintained GenLatte's strict permissions model by introducing ACL checks
   in Dart code, which, as a testable system, helped me sleep at night.

### Adding end-to-end tests

For my final trick, I was able to bark orders at Gemini to write both
server-side tests and, very excitingly, mock backend behavior in
client-side tests that suddenly became end-to-end tests.
Given my type-safe return values,
this led to stability and app reliability that I was happy with!

## The joy of a full-stack language

Whether you like relational data and thus use something like
[Serverpod](https://serverpod.dev), or a non-relational solution like Cloud Firestore,
writing in the same language across your entire stack is a dream.
And the wins just keep on coming if that language is Dart and you find yourself
basking in the glow of fully sound null-safe type-safety.
It truly creates the illusion that computers are actually there to be your friend!

I enjoyed converting GenLatte to use Dart everywhere, and in doing so,
sliced its server-bill to a tiny fraction of what it was with Node,
and increased reliability *and* performance.
The money I spent on Gemini tokens executing the change was easily recouped
after only a few minutes of operation. Now GenLatte can keep serving
personalized coffees to event attendees long into the future,
or until we get fed up running it.
