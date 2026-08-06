## Test plaster feature

### Single plaster

<?code-excerpt "plaster.dart (single)"?>
```dart
void single() {
  // ...
}
```

### Multiple plaster

<?code-excerpt "plaster.dart (multiple)"?>
```dart
void multiple() {
  // ...
  print('Showing up!');
  // ...
}
```

### Remove plaster

<?code-excerpt "plaster.dart (remove)" plaster="none"?>
```dart
void remove() {
}
```

### Custom template

<?code-excerpt "plaster.dart (custom)" plaster="/*...*/"?>
```dart
void custom() {
  /*...*/
}
```

<?code-excerpt "plaster.dart (template)" plaster="/* $defaultPlaster */"?>
```dart
void template() {
  /* ... */
}
```
