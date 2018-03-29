---
layout: page
title: JSON and serialization
permalink: /json/
---

It is hard to think of a mobile app that doesn't need to communicate with a web
server or easily store structured data at some point. When making
network-connected apps, the chances are that we need to consume some good old
JSON, sooner or later.

In this tutorial, we look into ways of using JSON with Flutter. We go over what
JSON solution to use in different scenarios and why.

* TOC Placeholder
{:toc}

## Which JSON serialization method is right for me?

This article covers two general strategies for working with JSON:

* Manual serialization and deserialization
* Automated serialization and deserialization via code generation

Different projects come with different complexities and use cases. For smaller
proof-of-concept projects or quick prototypes, using code generators might be
overkill. For apps with several JSON models with more complexity, doing
serialization by hand can quickly become tedious, repetitive and lend itself to
lots of small errors.

### Use manual serialization for smaller projects

Manual JSON serialization refers to using the built-in JSON decoder in
`dart:convert`. It involves passing the raw JSON string to the `json.decode()`
method, and then looking up the values you need in the `Map<String, dynamic>`
the method returns. It has no external dependencies or particular setup process,
and it is good for quick proof of concepts.

Where the manual serialization does not perform well is when your project
becomes bigger. Writing the serialization logic by hand can become hard to
manage and error-prone. If you have a typo when accessing an unexisting JSON
field, your code throws an error during runtime.

If you do not have many JSON models in your project and are looking to test a
concept quickly, manual serialization might be the way you want to start. For an
example of manual serialization, [see here](#manual-serialization).

### Use code generation for medium to large projects 

JSON serialization with code generation means having an external library
generate the serialization boilerplate for you. They involve some initial setup
and running a file watcher that generates the code from your model classes. For
example,
[json_serializable](https://pub.dartlang.org/packages/json_serializable) and
[built_value](https://pub.dartlang.org/packages/built_value) are these kinds of
libraries.

This approach scales well for a larger project. There is no hand-written
boilerplate needed, and typos when accessing JSON fields are caught at
compile-time. The downside with code generation is that it involves some initial
setup. Also, the generated source files may produce visual clutter in your
project navigator

You might want to use generated code for JSON serialization when you have a
medium or a larger project. To see an example of code generation based JSON
serialization, [see here](#code-generation).

## Is there a GSON/Jackson/Moshi equivalent in Flutter?

The simple answer is no. 

Such a library would require using runtime reflection, which is disabled in
Flutter. Runtime reflection interferes with _tree shaking_, which Dart has
supported for quite a long time. With tree shaking, we can “shake off” unused
code from our release builds. This allows us to optimize the size of our
applications significantly.

Since reflection makes all code implicitly used by default, it makes tree
shaking difficult. The tools cannot know what parts are unused at runtime, so
the redundant code is hard to strip away. App sizes cannot be easily optimized
when using reflection.

<aside class="alert alert-info" markdown="1">
**What about dartson?**

The [dartson](https://pub.dartlang.org/packages/dartson) library uses runtime
reflection, which makes it not compatible with Flutter.
</aside>

Although we cannot use runtime reflection with Flutter, some libraries give us
similarly easy to use APIs but are based on code generation instead. This
approach is covered in more detail in the [code generation
libraries](#code-generation) section.

<a name="manual-serialization"></a>
## Serializing JSON manually using dart:convert

Basic JSON serialization in Flutter is very simple. Flutter has a built-in
`dart:convert` library, which includes a straightforward JSON encoder and
decoder.

Here is an example JSON for a simple user model.

```json
{
  "name": "John Smith",
  "email": "john@example.com"
}
```

With `dart:convert`, we can serialize this JSON model in two ways. Let's have a
look at both.

### Serializing JSON inline

By looking at [the dart:convert JSON
documentation](https://api.dartlang.org/stable/1.24.3/dart-convert/JsonCodec-class.html),
we see that we can decode the JSON by calling the `json.decode` method, with our
JSON string as the method argument.

<!-- skip -->
```dart
Map<String, dynamic> user = json.decode(json);

print('Howdy, ${user['name']}!');
print('We sent the verification link to ${user['email']}.');
```

Unfortunately, `json.decode()` merely returns a `Map<String, dynamic>`, meaning
that we do not know the types of the values until runtime. With this approach,
we lose most of the statically typed language features: type safety,
autocompletion and most importantly, compile-time exceptions. Our code can
become instantly more error-prone.

For example, whenever we access the `name` or `email` fields, we could quickly
introduce a typo. A typo which our compiler does not know of since our entire
JSON merely lives in a map structure.

### Serializing JSON inside model classes

We can combat the previously mentioned problems by introducing a plain model
class, which we call `User`. Inside the `User` class, we have:

* a `User.fromJson` constructor, for constructing a new `User` instance from a
  map structure
* a `toJson` method, which converts a `User` instance into a map.

This way, the _calling code_ can now have type safety, autocompletion for the
`name` and `email` fields and compile-time exceptions. If we make typos or treat
the fields as `int`s instead of `String`s, our app will not even compile,
instead of crashing on runtime.

**user.dart**

<!-- skip -->
```dart
class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'email': email,
    };
}
```

Now the responsibility of the serialization logic is moved inside the model
itself. With this new approach, we can deserialize a user quite easily.

<!-- skip -->
```dart
Map userMap = json.decode(json);
var user = new User.fromJson(userMap);

print('Howdy, ${user.name}!');
print('We sent the verification link to ${user.email}.');
```

To serialize a user, we just pass the `User` object to the `json.encode` method.
We don't need to call the `toJson` method here, since `json.encode` already does
it for us.

<!-- skip -->
```dart
String json = json.encode(user);
```

This way, the calling code does not have to worry about JSON serialization at
all. However, the model class still definitely has to. In a production app, we
would want to be sure that the serialization works properly. In practice, the
`User.fromJson` and `User.toJson` methods both need to have unit tests in place
to verify correct behavior.

Also, real-world scenarios are not usually that simple. It is unlikely that we
can get by with such small JSON responses. Nested JSON objects are not that
uncommon either.

It would be nice if there were something that handled the JSON serialization for
us. Luckily, there is!

<a name="code-generation"></a>
## Serializing JSON using code generation libraries

Although there are other libraries available, in this tutorial, we use the
[json_serializable package](https://pub.dartlang.org/packages/json_serializable). It
is an automated source code generator that can generate the JSON serialization
boilerplate for us.

Since the serialization code is not handwritten and maintained by us anymore, we
minimize the risk of having JSON serialization exceptions at runtime.

### Setting up json_serializable in a project

To include `json_serializable` in our project, we need one regular and two _dev
dependencies_. In short, _dev dependencies_ are dependencies that are not
included in our app source code.

The latest versions of these required dependencies can be seen by following
[this link](https://github.com/dart-lang/json_serializable/blob/master/example/pubspec.yaml).

**pubspec.yaml**

```yaml
dependencies:
  # Your other regular dependencies here
  json_annotation: ^0.2.2

dev_dependencies:
  # Your other dev_dependencies here
  build_runner: ^0.7.6
  json_serializable: ^0.3.2
```

Run `flutter packages get` inside your project root folder (or click "Packages
Get" in your editor) to make these new dependencies available in your project.

### Creating model classes the json_serializable way

Let's see how to convert our `User` class to a `json_serializable` one. For the
sake of simplicity, we use the dumbed-down JSON model from the previous samples.

**user.dart**

<!-- skip -->
{% prettify dart %} 
import 'package:json_annotation/json_annotation.dart';

/// This allows our `User` class to access private members in 
/// the generated file. The value for this is *.g.dart, where 
/// the star denotes the source file name.
part '[[highlight]]user[[/highlight]].g.dart';

/// An annotation for the code generator to know that this class needs the 
/// JSON serialization logic to be generated.
[[highlight]]@JsonSerializable()[[/highlight]]

/// Every json_serializable class must have the serializer mixin. 
/// It makes the generated toJson() method to be usable for the class. 
/// The mixin's name follows the source class, in this case, User.
class User extends Object with _$[[highlight]]User[[/highlight]]SerializerMixin {
  User(this.name, this.email);

  String name;
  String email;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. We pass the map to the generated _$UserFromJson constructor. 
  /// The constructor is named after the source class, in this case User.
  factory User.fromJson(Map<String, dynamic> json) => _$[[highlight]]User[[/highlight]]FromJson(json);
}
{% endprettify %}

With this setup, the source code generator will generate code for serializing
the `name` and `email` fields from JSON and back.

If needed, it is also easy to customize the naming strategy. For example, if the
API we are working with returns objects with _snake\_case_, and we want to use
_lowerCamelCase_ in our models, we can use the `@JsonKey` annotation with a name
parameter:

<!-- skip -->
```dart
/// Tell json_serializable that "registration_date_millis" should be
/// mapped to this property.
@JsonKey(name: 'registration_date_millis')
final int registrationDateMillis;
```

### Running the code generation utility

When creating `json_serializable` classes the first time, you will get errors
similar to the image below.

![IDE warning when the generated code for a model class does not exist
yet.](/images/json/ide_warning.png)

These errors are entirely normal and are simply because the generated code for
the model class does not exist yet. To resolve this, we must run the code
generator that generates the serialization boilerplate for us.

There are two ways of running the code generator.

#### One-time code generation

By running `flutter packages pub run build_runner build` in our project root, we
can generate json serialization code for our models whenever needed. This
triggers a one-time build which goes through our source files, picks the
relevant ones and generates the necessary serialization code for them.

While this is pretty convenient, it would nice if we did not have to run the
build manually every time we make changes in our model classes.

#### Generating code continuously

A _watcher_ can make our source code generation process more convenient. It
watches changes in our project files and automatically builds the necessary
files when needed. We can start the watcher by running `flutter packages pub run
build_runner watch` in our project root.

It is safe to start the watcher once and leave it running in the background.

### Consuming json_serializable models

To deserialize a JSON string `json_serializable` way, we do not have actually to
make any changes to our previous code.

<!-- skip -->
```dart
Map userMap = json.decode(json);
var user = new User.fromJson(userMap);
```

Same goes for serialization. The calling API is the same as before.

<!-- skip -->
```dart
String json = json.encode(user);
```

With `json_serializable`, we can forget any manual JSON serialization in the
`User` class. The source code generator creates a file called `user.g.dart`,
which has all the necessary serialization logic. Now we do not necessarily have
to write automated tests to be sure that the serialization works - it is now
_the library's responsibility_ to make sure the serialization works
appropriately.

## Further references

* [JsonCodec documentation](https://api.dartlang.org/stable/1.24.3/dart-convert/JsonCodec-class.html)
* [The json_serializable package in Pub](https://pub.dartlang.org/packages/json_serializable)
* [json_serializable examples in GitHub](https://github.com/dart-lang/json_serializable/blob/master/example/lib/example.dart)
* [Discussion about dart:mirrors in Flutter](https://github.com/flutter/flutter/issues/1150)
