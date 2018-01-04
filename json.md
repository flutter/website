---
layout: page
title: TODO - JSON article title
permalink: /json/
---

It is hard to think of a mobile app that doesn't need to communicate with a web server at some point. When making network-connected apps, chances are that we need to consume some good old JSON, sooner or later.

In this tutorial, we look into ways of doing JSON with Flutter. We will go over what JSON solution to use in different scenarios and why.

* TOC Placeholder
{:toc}

## Which JSON serialization method is right for me?

There isn't a one size fits all JSON solution for every project. 

Different projects come with different complexities and use cases. For smaller proof-of-concept projects or quick prototypes, using code generators might be overkill. For apps with several JSON models with more complexity, doing serialization by hand can quickly become tedious, repetitive and lend itself to lots of small errors.

### Use manual serialization for smaller projects

Manual JSON serialization refers to using the built-in JSON decoder in `dart:convert`. It involves passing the raw JSON string to the `JSON.decode()` method, and then looking up the values you need in the `Map<String, dynamic>` the method returns. It involves no external dependencies or particular setup process, and it is good for quick proof of concepts.

Where the manual serialization does not perform well is when your project becomes bigger. Writing the serialization logic by hand can become hard to manage and error-prone. If you have a typo when accessing an unexisting JSON field, your code throws an error during runtime.

If you do not have many JSON models in your project and are looking to test a concept quickly, manual serialization might be the way you want to start.

### Use code generation for medium to large projects 

JSON serialization with code generation means having an external library generate the serialization boilerplate for you. They involve some initial setup and running a file watcher that generates the code from your model classes. For example, [json_serializable](https://pub.dartlang.org/packages/json_serializable) and [built_value](https://pub.dartlang.org/packages/built_value) are these kind of libraries.

This approach scales well for a larger project. There are no hand-written boilerplate needed, and typos when accessing JSON fields are caught at compile-time. The downside with code generation is that it involves some initial setup. Also, the generated source files may produce visual clutter in your project navigator

You might want to use generated code for JSON serialization when you have a medium or a larger project.

## Is there a GSON/Jackson/Moshi equivalent in Flutter?

Dart has supported _tree shaking_ for quite a long time. With tree shaking, we can “shake off” unused code from our release builds. Tree shaking allows us to optimize the size of our applications significantly.

While Dart users might have gotten used to [dartson](https://pub.dartlang.org/packages/dartson) to (de)serialize their JSON, it does not work with Flutter. The reason behind this is that `dartson`, like [GSON](https://github.com/google/gson) in Java, uses _runtime reflection_. In Flutter, reflection (also known as `dart:mirrors`) is disabled.

Since reflection makes all code implicitly used by default, it interferes with tree shaking. The tools cannot know what parts are unused at runtime; the redundant code is impossible to strip away. App sizes cannot be optimized when using reflection.

Although we cannot use dartson, there’s a library that gives us a simple to use API, without using reflection. That library is called [json_serializable](https://pub.dartlang.org/packages/json_serializable).

## Serializing JSON manually using dart:convert

Basic JSON serialization in Flutter is very simple. Dart comes with the `dart:convert` library built in, and using the JSON decoder API is straightforward.

Let's say we need to deserialize a JSON representing a user object. For sample purposes, we have a real simple JSON model.

```json
{
  "name": "John Smith",
  "email": "john@example.com"
}
```

With `dart:convert`, we can serialize this JSON model in two ways. Let's have a look at both.

### Serializing JSON inline

By looking at [the dart:convert JSON documentation](https://api.dartlang.org/stable/1.24.3/dart-convert/JsonCodec-class.html), we see that we can parse the JSON by calling the `JSON.decode` method, with our JSON string as the method argument.

```dart
Map<String, dynamic> user = JSON.decode(json);

print('Howdy, ${user['name']}!');
print('We sent the verification link to ${user['email']}.');
```

Unfortunately, `JSON.decode()` merely returns a `Map<String, dynamic>`, meaning that we do not know the types of the values until runtime. With this approach, we lose most of the statically typed language features: type safety, autocompletion and most importantly, compile-time exceptions. Our code can become instantly more error-prone. 

For example, whenever we access the `name` or `email` fields, we could quickly introduce a typo. A typo which our compiler does not know of since our entire JSON merely lives in a map structure.

### Serializing JSON inside model classes

We can combat the previously mentioned problems by introducing a plain model class, which we call `User`. Inside the `User` class, we have:

* a `User.fromJson` constructor, for constructing a new `User` instance from a map structure
* a `toJson` method, which converts a `User` instance into a map.

This way, the calling code can now have type safety, autocompletion for the `name` and `email` fields and compile-time exceptions. If we make typos or treat the fields as `int`s instead of `String`s, instead of crashing on runtime, our app will not even compile.

**user.dart**

```dart
class User {
  User(this.name, this.email);

  String name;
  String email;

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
```

Now the calling code does not have to care about the serialization logic. With this new approach, we can deserialize a user quite easily.

```dart
Map map = JSON.decode(json);
User user = new User.fromJson(map);

print('Howdy, ${user.name}!');
print('We sent the verification link to ${user.email}.');
```

To serialize a user, we just call the `toJson` method in the `User` class.

```dart
String json = JSON.encode(user.toJson());
```

While with this new approach the calling code does not have to worry about JSON serialization at all, the model class still definitely has. In a production app, we would want to be sure that the serialization works. In practice, this means that the `User.fromJson` and `User.toJson` both need to have unit tests in place to verify correct behavior.

Also, real-world scenarios are not usually that simple. It is unlikely that we can get by with such small JSON responses. Nested JSON objects are not that uncommon either.

It would be nice if there were something that handled the JSON serialization for us. Luckily, there is!

## Serializing JSON using json_serializable

The `json_serializable` package is an automated source code generator that can generate the JSON serializing boilerplate for us. 

Since the serialization code is not handwritten and maintained by us anymore, we minimize the risk of having JSON serialization exceptions at runtime. If the sources are generated, and the app compiles, we should be fine.

### How does a json_serializable class look?

Let's see how to convert our `User` class to a `json_serializable` one. For the sake of simplicity, we use the dumbed-down JSON model from the previous samples.

**user.dart**

{% prettify dart %} 
/// This allows the generated code access our class members. 
/// The value for this is the same as the source file name, 
/// in this case, user.dart without the .dart file extension.
library [[highlight]]user[[/highlight]];

import 'package:json_annotation/json_annotation.dart';

/// This allows our `User` class to access private members in 
/// the generated file. The value for this is *.g.dart, where 
/// the star denotes the source file name.
part '[[highlight]]user[[/highlight]].g.dart';

/// An annotation for the code generator to know that this class needs the 
/// source generator to generate JSON serialization logic.
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

To deserialize a JSON string `json_serializable` way, we do not have actually to make any changes to our previous code.

```dart
Map map = JSON.decode(json);
User user = new User.fromJson(map);
```

Same goes for serialization. The calling API is the same as before.

```dart
String json = JSON.encode(user.toJson());
```

With `json_serializable`, we can forget any manual JSON serialization in the `User` class. The source code generator creates a file called `user.g.dart`, which has all the necessary serialization logic. Now we do not necessarily have to write automated tests to be sure that the serialization works - it is now _the library's responsibility_ to make sure the serialization works appropriately.

Now that we have learned how the model classes look, let's go through the required steps to introduce `json_serializable` to our project.

### Setting up json_serializable in a project

To have `json_serializable` up and running, we have to go through some steps first. We need to do this only ** once per project**. After the initial setup, creating JSON model classes is trivial. 

#### Setting up the pubspec dependencies

To include `json_serializable` in our project, we need one regular and two _dev\ dependencies_. In short, _dev dependencies_ are dependencies that are not included in our app source code.

The latest versions of these required dependencies can be seen by following [this link](https://github.com/dart-lang/json_serializable/blob/master/example/pubspec.yaml).

**pubspec.yaml**

```yaml
dependencies:
  # Your other regular dependencies here
  json_annotation: ^0.2.2

dev_dependencies:
  # Your other dev_dependencies here
  build_runner: ^0.6.1
  json_serializable: ^0.3.0
```

After declaring the needed dependencies, synchronize your packages. In IntelliJ IDEA, click the _Packages get_ link on the top of an opened `pubspec.yaml` file. Alternatively, you can do synchronize packages by running `flutter packages get` from the command line in your projects' root folder.

Next,  define some build actions.

#### Defining the build actions

_Build actions_ are a way of running _builders_ in our project's source files.

Our build action has the following parameters:

* **builder**, which in our case is a `jsonPartBuilder`
* **package name** which is the specific package this build action will be performed on
* **inputs**, which are files the build action is performed on.

We'll create our build action file in `<project_root>/tool/build_actions.dart`.

**tool/build_actions.dart**

{% prettify dart %} 
import 'package:build_runner/build_runner.dart';
import 'package:json_serializable/json_serializable.dart';

List<BuildAction> get buildActions => [
      new BuildAction(
        // The builder to run on our source files.
        jsonPartBuilder(),

        // The name of the current package, usually the same as the name 
        // for your Flutter project. For example, if you created a new
        // project with "flutter run hello", your package name here would
        // be 'hello'.
        '[[highlight]]<your_package_name_here>[[/highlight]]',

        // All of the files this `BuildAction` should target when run.
        inputs: const [
          'lib/*.dart',
        ],
      ),
    ];
{% endprettify %}

We are declaring a top-level variable called `buildActions`, which returns a `List` containing all build actions in our project. In this case, we only have one build action, which generates JSON serialization logic for files in the _lib_ folder. 

It is good practice to define build actions in the same file, as they are used by the _build_ and the _watcher_ files.

Which brings us to the next topic, the build file.

#### Creating the build file

Our build file runs the actions responsible for generating JSON serialization logic for our classes. When run, it triggers the build actions, searches for all the relevant files, generates the necessary code and then complete.

We'll create the build file in `<project_root>/tool/build.dart`.

**tool/build.dart**

```dart
import 'dart:io';
import 'package:build_runner/build_runner.dart';
import 'build_actions.dart';

main() async {
  var result = await build(buildActions, deleteFilesByDefault: true);
  if (result.status == BuildStatus.failure) {
    exitCode = 1;
  }
}
```

Now we can generate all the necessary JSON serialization source files by running `dart tool/build.dart` in our project's root folder. While the build file is all we need for one-time source code generation, it would be nice if we did not have to run it manually every time we make changes.

#### Creating the watcher file

A _watcher_ makes our source code generation progress more convenient. It watches changes in our project and automatically builds the necessary files when needed.

The watcher file also lives in the tool folder, so we create it in `<project_root>/tool/watch.dart`.

**tool/watch.dart**

```dart
import 'package:build_runner/build_runner.dart';
import 'build_actions.dart';

main() {
  watch(buildActions, deleteFilesByDefault: true);
}
```

We can run the watcher by doing `dart tool/watch.dart` in our project's root folder. It is safe to start the watcher once and leave it running in the background.