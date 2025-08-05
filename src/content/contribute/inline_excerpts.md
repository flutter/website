---
title: Using Inline Excerpts
description: How to use the inline excerpts tool to automatically create and test code samples.
---

To add a new code sample to a markdown file, you can use the `inline-excerpts` tool. This tool will automatically create a new file in the `examples` directory and replace your code block with a `<?code-excerpt?>` tag.

## 1. Add a magic code block to your markdown file

To use the tool, add a ````dart magic` code block to your markdown file. For example:

````
```dart magic
void main() {
  print('Hello, world!');
}
```
````

## 2. Run the inline-excerpts tool

Next, run the `inline-excerpts` tool and pass it the path to your markdown file:

```bash
dart tool/flutter_site/bin/flutter_site.dart inline-excerpts --file path/to/your/file.md
```

The tool will create a new file in the `examples` directory and replace your code block with a `<?code-excerpt?>` tag.

## 3. Run the refresh-excerpts tool

Finally, run the `refresh-excerpts` tool to test your new code sample:

```bash
dart tool/flutter_site/bin/flutter_site.dart refresh-excerpts
```

This will ensure that your code sample is correctly formatted and that it doesn't contain any errors.
