---
name: data-model
description: >-
  Add or update a dart_mappable data model in lib/src/models/content/,
  including adding format validation, regenerating code, and adding tests.
  Use when adding a new content type or modifying an existing model's fields.
argument-hint: [data-model-description or existing-data-model]
---

# Data model skill

Add or update a typed content model in this project.
Follow the established conventions below as much as possible.

## Before starting

1. If updating an existing model, read the model file,
   its source YAML or JSON file(s), and its test group first.
2. If adding a new model, identify which page will use it and
   the structure of the YAML file it will load from and map to.
   If the YAML file doesn't exist, ask the user to create and reference it
   or provide information about its expected structure.

## Model file conventions

All data models live in the `lib/src/models/content` directory and
should roughly follow this general structure:

```dart
import 'package:dart_mappable/dart_mappable.dart';

import 'content_validation.dart';

part '<filename>.mapper.dart';

/// Doc comment: What this model represents and where it's loaded from.
///
/// Expected data format:
/// - `field_name`: Description and constraints of the expected value.
@MappableClass()
class ModelName with ModelNameMappable {
  ModelName({
    required this.fieldOne,
    required this.fieldTwo,
    this.optionalField,
  }) {
    // Validate all fields beyond their Dart type.
    checkFormat(isNotBlank(fieldOne), 'field_one must be a non-empty string.');
    // For optional fields, only validate when present:
    if (optionalField case final optionalField?) {
      checkFormat(isNotBlank(optionalField), 'optional_field must be a non-empty string.');
    }
  }

  /// Each field should have a doc comment that follows Effective Dart.
  final String fieldOne;

  // Use `@MappableField` when the YAML key differs from the Dart field name.
  @MappableField(key: 'field_two')
  final String fieldTwo;

  // Optional fields are nullable and not marked `required` in the constructor.
  final String? optionalField;

  // Every model must have this static factory. Use the generated mapper.
  static ModelName fromJson(Map<String, Object?> json) => ModelNameMapper.fromMap(json);
}
```

When adding a new data model,
consider checking the format of one or more existing models
in the `lib/src/models/content/` directory.

### Key guidelines

- The Dart code you write for the models should follow
  Effective Dart and other Dart best practices and standards.
- Import the `content_validation.dart` library and
  use its helper functions to validate the contents of each field.
- The `part` directive must point to `<filename>.mapper.dart`.
  That part file is generated when running `build_runner`.
- The mixed-in mixin's name is always `<ClassName>Mappable`.
  That mixin is generated when running `build_runner`.
- The `fromJson` factory delegates to `<ClassName>Mapper.fromMap(json)`.
- Use `@MappableField(key: 'yaml_key')` when the YAML key uses
  snake_case or otherwise differs from the `camelCase` Dart field name.
- When a field is limited to a set of allowed values,
  create and use a new enum for the Dart type.
  To be serialized and deserialized, annotate the enum with `@MappableEnum`.
- For fields that need custom deserialization from YAML strings,
  create a private `MappingHook` subclass in the same file.
- All fields on the class should be statically typed and marked `final`.
- Add documentation comments on the class and on every field,
  following Effective Dart guidelines for doc comments.
- The class doc comment must include an "Expected data format" section
  listing each field, its brief meaning, and its constraints.

## Validation rules

When users might make a mistake or a specific format is needed,
fields should be validated in the constructor body,
not just by Dart's type system.

Validation helpers are defined in
the `lib/src/models/content/content_validation.dart` library.
Some common validations include:

| Field type       | Validation                                                           |
|------------------|----------------------------------------------------------------------|
| Required string  | `checkFormat(isNotBlank(field), '...')`                              |
| Optional string  | `if (field case final field?) checkFormat(isNotBlank(field), '...')` |
| Absolute URL     | `checkFormat(isAbsoluteHttpUrl(field), '...')`                       |
| Image asset path | `checkFormat(looksLikeImageAssetPath(field), '...')`                 |
| Hex color        | `checkFormat(isHexColor(field), '...')`                              |
| Non-empty list   | `checkFormat(field.isNotEmpty, '...')`                               |

As appropriate, multiple validations can be completed.
Complete the less specific ones first, such as not being blank.

If you think any other validation is needed or might be helpful:

1. Ensure it doesn't already exist in the `content_validation.dart` library.
2. Add a reusable function to the `content_validation.dart` library.
3. Provide a useful doc comment, following Effective Dart best practices.
4. If it might be commonly useful, add it to this skill's table.
5. Make use of the new validation in the constructor body.

## After creating or modifying the model file

1. **Run code generation** to produce or update the `.mapper.dart` file:

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

2. **Add or update tests** in `test/models/content/content_models_test.dart`.

   Read the file to understand the existing testing patterns,
   import the new model, and add a test group following a similar pattern.

   The test file already defines a few custom matchers.
   If needed, reuse them, don't unnecessarily redefine them.

   - `_throwsMapperException`:
     For fields that are missing or have the wrong type.
   - `_throwsValidationError`:
     For fields that exist but fail validation.

3. **Run tests** to verify:

   ```bash
   dart test test/models/content/content_models_test.dart
   ```

4. **Run analysis** to catch any lint issues:

   ```bash
   dart analyze lib/src/models/content/
   ```

## Use the data model from a page

If you already are or want to use the data in a page, access the data using
the `decodeJsonList` and `decodeJsonObject` extension methods on `BuildContext`.
At the beginning of a page component's `build` method,
use the extension methods and store the data in a variable for reuse.

```dart
// For a list of items:
final items = context.decodeJsonList('page_name.data_key', ModelName.fromJson);

// For a single object:
final item = context.decodeJsonObject('page_name.data_key', ModelName.fromJson);
```

The dot-notation path maps to the content directory structure. For example,
`page_name.data_key` resolves to `content/page_name/data_key.yaml`.
