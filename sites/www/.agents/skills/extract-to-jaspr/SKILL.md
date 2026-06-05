---
name: extract-to-jaspr
description: Extracts a part of a website and converts it to a Jaspr component. Use when you need to migrate a part of a website to Jaspr.
---

# Jaspr Migration Skill

This document outlines the process and key learnings from extracting a complex HTML component from a live website to a Jaspr component using Dart.

## When to use this skill

Use this skill when you need to extract a part of a website and migrate it to Jaspr.

## How to use it

The migration process follows a strict "Structure Only" approach:

1.  **Fetch & Extract**:
    - Use `curl` to fetch the raw HTML. This ensures you get the initial server-rendered markup without client-side modifications.
    - If needed, use browser dev tools to identify the correct DOM node, but rely on `curl` for the source extraction.
    - Note any dynamic classes or attributes controlled by JavaScript.

2.  **Markup Translation (Exact Match)**:
    - Create a single `StatelessComponent` for the extracted HTML.
    - Translate HTML tags 1:1 to Jaspr components (`div`, `nav`, `ul`, `li`, `img`, etc.).
    - **Maintain strict fidelity**: Keep original CSS classes, IDs and all attributes exactly as they are. This ensures existing stylesheets work without modification.
    - Specifically keep any logic-based attributes (e.g. `x-` attributes from alpine.js) as is and DO NOT ATTEMPT TO RE-IMPLEMENT LOGIC in Dart.

### Asset Handling

When encountering assets (images, videos, etc.), look for them in `/assets/src/img` or `/assets/src/video`.
**Note**: The production site appends hashes to asset names, but the source files do not have them.

Use the `asset()` function imported from `lib/constants/asset_loader.dart` with the non-hashed filename. It returns the correct path after bundling.

```dart
img(src: asset('my-image.png'), alt: 'My Image')
```

### Data-Driven Components

For components with repetitive or dynamic content (like carousels, event grids, or country lists), separate the data from the structure:

1.  **Extract Data to YAML**: Identify repetitive sections and extract their content into a YAML file in `content/_data/` (e.g., `my_data_file.yaml`).
2.  **Access Data via Context**: Use `package:jaspr_content/jaspr_content.dart` to access the data in your component.
3.  **Dynamic Rendering**: Use Dart collection-for to render the items, keeping the HTML structure inside the loop consistent with the original.

```dart
import 'package:jaspr_content/jaspr_content.dart';

// Inside build method
final items = context.page.data['my_data_file'] as List? ?? [];

div(classes: 'grid', [
  for (final item in items)
    _buildItem(item as Map<String, dynamic>),
])
```

### Reusing Sections

When possible, reuse existing sections from `lib/components/sections` like the `CtaSection` or `NewsletterSection`.

Do not add new sections yourself.

## Desired Outcome

The desired outcome is 1-to-1 translation of the HTML to Jaspr. The component should be as close to the original HTML as possible.

**Fidelity is King**: When porting, trust that the original CSS/HTML structure is correct. Don't refactor the *structure* while migrating the *technology*. Data-driven patterns should enhance maintainability without changing the rendered HTML.