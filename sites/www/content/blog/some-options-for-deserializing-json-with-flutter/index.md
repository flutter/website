---
title: "Some Options for Deserializing JSON with Flutter"
description: "At some point, most apps need to reach out and grab data from an online endpoint. Making an HTTPS get request to pull down a weather report…"
publishDate: 2018-08-02
author: redbrogdon
category: tutorial
layout: blog
---

At some point, most apps need to reach out and grab data from an online endpoint. Making an HTTPS `get` request to pull down a weather report or the World Cup final score is fairly straightforward, thanks to Dart’s `http` package:

```dart
import 'dart:async';
import 'package:http/http.dart' as http;

final response = await http.get(myEndpointUrl);
if (response.statusCode == 200) {
  // use the data in response.body
} else {
  // handle a failed request
}

```

The data in `response.body` is likely a JSON string, and there’s some work to be done before it’s ready for a widget. First, you need to parse the string into a more manageable representation of JSON. Then you must convert that representation into a model or some other strongly typed variable, so you can use it effectively.

Fortunately, the Dart team and community have been slinging JSON around for a while, and can offer solutions. I’ll cover three, in ascending order of complexity: handwritten constructors, `json_serializable`, and `built_value`.

The calls to deserialize data with all three approaches are very similar. Handwritten constructors and `json_serializable` result in lines like this one:

```dart
final myObject = SimpleObject.fromJson(json.decode(aJsonString));
```

And a deserialization call for `built_value` looks like this:

```dart
final myObject = serializers.deserializeWith(
    SimpleObject.serializer, json.decode(aJsonString));
```

The real difference is in how much code within that `SimpleObject` class is generated on your behalf, and what it’s doing.

**Handwritten constructors**

* Least complicated approach — no code is generated for you.

* You can do whatever you want, but you’re on the hook for maintaining it.

**`json_serializable`**

* Generates a `fromJson` constructor and a `toJson` method for you.

* You need to include several packages in your project and use `source_gen` to generate partial files prior to building your app.

* Generated source can be tricky to customize.

**`built_value`**

* Generates code for serialization, immutability, `toString` methods, `hashCode` properties, and more. It’s a heavyweight solution with a lot of functionality.

* Like `json_serializable`, you need to import a number of packages and use `source_gen`.

* Has an extensible, plugin-based serialization architecture.

* Has opinions about things like instance creation and mutability.

As you’ll see, which library is right for you really depends on the details of your project, in particular its size and method of state management. A hobby project with one maintainer can go far with handwritten constructors, while an app built by a big, distributed team that needs immutable models to keep their logic clean can really benefit from `built_value`.

For now, though, let’s start at the beginning: parsing JSON from a string into a more convenient in-memory representation. This step in the process is the same regardless of which way you decide to go later on.

## Parsing JSON

Converting a JSON string into an intermediate format can be done with the `dart:convert` library:

```dart
import 'dart:convert';

try {
  final parsed = json.decode(aJsonStr); 
} on FormatException catch (e) {
  print("That string didn't look like Json.");
} on NoSuchMethodError catch (e) {
  print('That string was null!');
}

```

If the string contains valid JSON, you’ll get back a `dynamic` reference to either a `List<dynamic>` or a `Map<String, dynamic>` depending on whether the JSON string held an array or a single object. For simple things like a list of integers, you’re pretty much done at this point. You’ll probably want to create a second, strongly typed reference to the data, though, before you use it:

```dart
final dynamicListOfInts = json.decode(aJsonArrayOfInts);

// Create a strongly typed list with references to the data that are casted
// immediately. This is probably the better approach for data model classes.
final strongListOfInts = List<int>.from(dynamicListOfInts);

// Or create a strongly typed list with references that will be lazy-casted
// when used.
final anotherStrongListOfInts = List<int>.from(dynamicListOfInts);
```

More sophisticated payloads are where things get interesting. Converting a `Map<String, dynamic>` into an actual model object can involve casting, default values, nulls, and nested objects. There are many ways things can go wrong, and many annoying details that need to be updated if you later decide to rename or add/remove a property.

## Handwritten constructors

One has to start somewhere, right? If you have a small app and the data is not that complicated, you can go a long way by writing your own [factory constructors](https://www.dartlang.org/guides/language/language-tour#factory-constructors) that take a `Map<String, dynamic>` parameter. For example, if you’re fetching that looks like this:

```json
{
  "aString": "Blah, blah, blah.",
  "anInt": 1,
  "aDouble": 1.0,
  "aListOfStrings": ["one", "two", "three"],
  "aListOfInts": [1, 2, 3],
  "aListOfDoubles": [1.0, 2.0, 3.0]
}

```

The code for a matching class might look like this:

```dart
class SimpleObject {
  const SimpleObject({
    this.aString,
    this.anInt,
    this.aDouble,
    this.aListOfStrings,
    this.aListOfInts,
    this.aListOfDoubles,
  });

  final String aString;
  final int anInt;
  final double aDouble;
  final List<String> aListOfStrings;
  final List<int> aListOfInts;
  final List<double> aListOfDoubles;

  factory SimpleObject.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw FormatException("Null JSON provided to SimpleObject");
    }
    
    return SimpleObject(
        aString: json['aString'],
        anInt: json['anInt'],
        aDouble: json['aDouble'],
        aListOfStrings: json['aListOfStrings'] != null
            ? List<String>.from(json['aListOfStrings'])
            : null,
        aListOfInts: json['aListOfInts'] != null
            ? List<int>.from(json['aListOfInts'])
            : null,
        aListOfDoubles: json['aListOfDoubles'] != null
            ? List<double>.from(json['aListOfDoubles'])
            : null,
    );
  }
}

```

The named `fromJson` factory constructor is then used like this:

```dart
final myObject = SimpleObject.fromJson(json.decode(aJsonString));
```

On the downside, you had to write ~20 lines of constructor code by hand, and you’re now on the hook for maintaining it. As your app grows and your data classes start to number in the dozens, you might find yourself thinking, “Man, coding these JSON constructors is getting tedious — I wish they could just be auto-generated from the properties in the class.”

As it turns out, with the `json_serializable` library, they can.

## Using json_serializable

Before getting into `json_serializable`, we need to take a brief detour to talk about another package.

Flutter doesn’t currently offer support for reflection, so some techniques available in other contexts (such as the ability of an Android JSON library to inspect classes for annotations at runtime) won’t work for Flutter devs. What they *can* use, however, is a Dart package called [`source_gen`](https://github.com/dart-lang/source_gen). It provides utilities and a basic framework for automated source code generation.

Rather than updating your code directly, `source_gen` creates new, separate files alongside them. By convention, they’re given a “g” in their filenames, so if your class resides in `model.dart`, `source_gen` creates `model.g.dart`. You can reference that file in the original using the `part` keyword, and the compiler inlines it.

The [`json_serializable`](https://pub.dartlang.org/packages/json_serializable) package uses the `source_gen` API to generate serialization code. It writes the `fromJson` constructor (as well as a `toJson` method) for you.

The basic process for putting it to work in an app looks like this:

1. [Import into your project](https://github.com/dart-lang/json_serializable/tree/master/example) the `json_serializable` and `json_annotation` packages.

1. Define a data class as you normally would.

1. Add the `@JsonSerializable` annotation to the class definition.

1. Add some extra bits to link that class with the code `json_serializable` creates for it.

1. Run `source_gen` to generate code.

I’ll tackle these one at a time.

### Import the `json_serializable` package into your project

You can find `json_serializable` in the [Dart package catalog](https://pub.dartlang.org/packages/json_serializable). Just [update your `pubspec.yaml`](https://flutter.io/using-packages/#adding-a-package-dependency-to-an-app) as directed, and you’re good to go.

### Define a data class

No surprises here. Make a data class with basic properties and a constructor. The properties you plan to serialize should either be value types or other classes made to work with `json_serializable`.

```dart
class SimpleObject {
  SimpleObject({
    this.aString,
    this.anInt,
    this.aDouble,
    this.aListOfStrings,
    this.aListOfInts,
    this.aListOfDoubles,
  });

  final String aString;
  final int anInt;
  final double aDouble;
  final List<String> aListOfStrings;
  final List<int> aListOfInts;
  final List<double> aListOfDoubles;
}

```

### Add the @JsonSerializable annotation

The `json_serializable` package only generates code for classes that have been tagged with the `@JsonSerializable` annotation:

```dart
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable
class SimpleObject {
  ...
}

```

### Link the generated code with yours

Next up are three changes that wire the class definition to its corresponding part file:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'simple_object.g.dart';

@JsonSerializable()
class SimpleObject extends Object with _$SimpleObjectSerializerMixin {
  SimpleObject({
    this.aString,
    this.anInt,
    this.aDouble,
    this.aListOfStrings,
    this.aListOfInts,
    this.aListOfDoubles,
  });

  final String aString;
  final int anInt;
  final double aDouble;
  final List<String> aListOfStrings;
  final List<int> aListOfInts;
  final List<double> aListOfDoubles;

  factory SimpleObject.fromJson(Map<String, dynamic> json) =>
      _$SimpleObjectFromJson(json);
}

```

The first of these is the `part` declaration, which tells the compiler to inline `simple_object.g.dart` (more on that in a minute). Then there’s an update to the class definition to use a mixin. Finally, update the class to use the `fromJson` constructor. The last two changes each reference code in the generated file.

### Run source_gen

Kick off code generation from your project folder with this command:

```bash
flutter packages pub run build_runner build
```


When finished, you’ll have a new file called `simple_object.g.dart` sitting alongside the original. The contents look like this:

```dart
part of 'simple_object.dart';

SimpleObject _$SimpleObjectFromJson(
        Map<String, dynamic> json) =>
    new SimpleObject(
        aString: json['aString'] as String,
        anInt: json['anInt'] as int,
        aDouble: (json['aDouble'] as num)?.toDouble(),
        aListOfStrings:
            (json['aListOfStrings'] as List)?.map((e) => e as String)?.toList(),
        aListOfInts:
            (json['aListOfInts'] as List)?.map((e) => e as int)?.toList(),
        aListOfDoubles: (json['aListOfDoubles'] as List)
            ?.map((e) => (e as num)?.toDouble())
            ?.toList());

abstract class _$SimpleObjectSerializerMixin {
  String get aString;
  int get anInt;
  double get aDouble;
  List<String> get aListOfStrings;
  List<int> get aListOfInts;
  List<double> get aListOfDoubles;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'aString': aString,
        'anInt': anInt,
        'aDouble': aDouble,
        'aListOfStrings': aListOfStrings,
        'aListOfInts': aListOfInts,
        'aListOfDoubles': aListOfDoubles
      };
}

```

That first method is called by the `fromJson` constructor in `SimpleObject` and the mixin class provides the new `toJson` method to `SimpleObject`. Both are straightforward to use:

```dart
final myObject = SimpleObject.fromJson(json.decode(jsonString));
final myJsonStr = json.encode(myObject.toJson());
```

In terms of numbers, adding three lines of code to `simple_object.dart` for `json_serializable` saves about 20 lines of constructor code that you’d otherwise have to write. You’re also able to regenerate it anytime you want to rename or otherwise adjust the properties, and you get a `toJson` method thrown in for free. Not too shabby.

What if you’d like to serialize to more than one format, though? Or to more than just JSON? And what if you need other things, like immutable model objects? For those use cases, there’s `built_value`.

## Using `built_value`

Much more than just a solution for automating serialization logic, `built_value` (along with its partner package, `built_collection`) is designed to help you create classes that function as value types. For this reason, instances of classes created with `built_value` are immutable. You can create new instances (including copies of existing ones), but once they’re built, their properties can’t be changed.

To accomplish this, `built_value` uses the same source generation approach found in `json_serializable`, but creates a lot more code. In the generated file for a `built_value` class, you’ll find:

* An equality (`==`) operator

* A `hashCode` property

* A `toString` method

* A serializer class, if you want one — more on that below

* A “builder” class used to make new instances

This adds up to several hundred lines, even for a small class like SimpleObject, so I’ll avoid showing it here. The actual class file (what you’d write as a dev) looks like this:

```dart
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'simple_object.g.dart';

abstract class SimpleObject
    implements Built<SimpleObject, SimpleObjectBuilder> {
  static Serializer<SimpleObject> get serializer =>
      _$SimpleObjectSerializer;

  @nullable
  String get aString;

  @nullable
  int get anInt;

  @nullable
  double get aDouble;

  @nullable
  BuiltList<String> get aListOfStrings;

  @nullable
  BuiltList<int> get aListOfInts;

  @nullable
  BuiltList<double> get aListOfDoubles;

  SimpleObject._();

  factory SimpleObject([updates(SimpleObjectBuilder b)]) =
      _$SimpleObject;
}

```

The differences between this and the version of `SimpleObject` we started with are:

* A part file is declared, just like `json_serializable`.

* An interface, `Built<SimpleObject, SimpleObjectBuilder>`, is being implemented.

* A static getter for a serializer object has been added.

* Nullability annotations are on all the fields. These are optional, but to make this example match the others in functionality, I’ve added them.

* Two constructors (one private, one factory) have been added, and the original one was removed.

* SimpleObject is now an abstract class!

The differences between this and the version of `SimpleObject` we started with are:

Let’s start with the last point: `SimpleObject` has become an abstract class. In its generated file, `built_value` defines a subclass of `SimpleObject` called `_$SimpleObject`, and that’s where it provides a lot of the new functionality. It’s where you’ll find the new `hashCode` property, new methods relating to immutability, and so on. Each time you create an instance of `SimpleObject`, you’re actually getting `_$SimpleObject` under the hood. You’ll never need to reference it by the derived type, though, so your app code still uses `SimpleObject` to declare and use references.

This is possible because instantiation of a brand-new `SimpleObject` is done through a generated factory constructor, which you can see referenced in the last line of the file above. To use it, you pass in a method that sets properties on a `SimpleObjectBuilder` (it’s the “b” parameter below), which builds the immutable object instance for you:

```dart
final SimpleObject myObject = SimpleObject((b) => b
  ..aString = 'Blah, blah, blah'
  ..anInt = 1
  ..aDouble = 1.0
  ..aListOfStrings = ListBuilder<String>(['one', 'two', 'three'])
  ..aListOfInts = ListBuilder<int>([1, 2, 3])
  ..aListOfDoubles = ListBuilder<double>([1.0, 2.0, 3.0])
);

```

You can also `rebuild` to get a modified bopy of an existing instance:

```dart
final SimpleObject anotherObject = myObject.rebuild((b) => b
  ..aString = "An updated value"
);

```

As you can see, the constructor in `SimpleObject` has been made private through the use of an underscore:

```dart
SimpleObject._();
```

That guarantees that your app’s code can’t directly instantiate an instance of `SimpleObject`. In order to get one, you have to use the factory constructor, which uses `SimpleObjectBuilder` and always produces an instance of the `_$SimpleObject` subclass.

### That’s great, but I thought we were talking about deserialization?

I’m getting to that! To serialize and deserialize instances, you’ll need to add a little code somewhere in the app (creating a file called `serializers.dart`, for example, is a good approach):

```dart
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'simple_object.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  SimpleObject,
])

final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
```

This file does two things. First, it uses the `@SerializersFor` annotation to instruct `built_value` to create serializers for a list of classes. In this case, there’s only one class, so it’s a short list. Second, it creates a global variable called `serializers` that references the `Serializers` object that handles serialization of `built_value` classes. It’s used like this:

```dart
final myObject = serializers.deserializeWith(
    SimpleObject.serializer, json.decode(aJsonString));

final String myJsonString = json.encode(serializers.serialize(myObject));
```

As with `json_serializable`, transforming an object into and out of JSON is still mostly a one line affair, with the generated code doing the heavy lifting for you. One important thing to note, though, is this bit from `serializers.dart`:

```dart
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
```

`built_value` is designed to be as extensible as possible, and it includes a plugin system for defining custom serialization formats (you could, for example, write one to translate to and from XML or your own binary format). I’m using it in this example to add a plugin called `StandardJsonPlugin` because, by default, `built_value` *doesn’t use the map-based JSON format that you’re probably used to*.

Instead, it uses a list-based format. For example, a simple object with `String`, `int`, and `double` members would be serialized like this:

```json
[
  "SimpleObject",
  "aString",
  "Blah, blah, blah",
  "anInt",
  1,
  "aDouble",
  2.0
]

```

Rather than this:

```json
{
  "$": "SimpleObject",
  "aString": "Blah, blah, blah",
  "anInt": 1,
  "aDouble": 2.0
}

```

There are a few reasons why `built_value` prefers the list-based format, which for sake of space I’ll leave to the [package documentation](https://github.com/google/built_value.dart). For this example, though, just know that you can easily make use of map-based JSON serialization through the `StandardJsonPlugin`, which ships as part of the `built_value` package.

## Conclusion

So those are the high points of all three techniques. As I mentioned back at the beginning of this article, choosing the right one is mostly about considering the scope of your project, how many people are working on it, and what other needs you have for your model objects.

The next step is to start coding, so come see us at the [Flutter Dev Google Group](https://groups.google.com/forum/#!forum/flutter-dev), [StackOverflow](https://stackoverflow.com/questions/tagged/flutter), or [The Boring Show](https://www.youtube.com/watch?v=TiCA0CEePyE&list=PLOU2XLYxmsIK0r_D-zWcmJ1plIcDNnRkK&index=2), and let us know how it goes!
