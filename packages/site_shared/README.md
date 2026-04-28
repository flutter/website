# site_shared

This package is the core library containing shared logic, UI components, and the design system for Dart and Flutter documentation sites.

It provides a centralized location for APIs, user interface elements, and logic intended for use by both the `dart.dev` and `docs.flutter.dev` websites. Using a shared package ensures a consistent design language and feature set across Dart and Flutter web documentation platforms.

## What's included

The `site_shared` package provides several key features to build documentation websites using Jaspr:

- **UI Components** (`lib/components`): Reusable, modular components built for use across documentation pages.
  - **Common components** (`lib/components/common`): Everyday UI elements such as breadcrumbs, buttons, cards, chips, tooltips, tabs, dropdowns, embedded YouTube videos, search bars, and wrapped code blocks.
  - **Layout components** (`lib/components/layout`): Structural layout elements like theme switchers, site switchers, banners, and menu toggles.
  - **Interactive components**: Integrations such as Dartpad (`lib/components/dartpad`), tutorials, and user client-side feedback tools.
- **Markdown Extensions & Processors** (`lib/extensions`): Custom processors that hook into the Dart markdown parser to extend its default syntax and behavior, such as `attribute_processor.dart`, `code_block_processor.dart`, `header_processor.dart`, and `table_processor.dart`.
- **Core Styles** (`lib/_sass`): The shared base styles and component-specific SCSS styling. These resources define the unified visual identity used by both websites.
- **Utilities and Builders** (`lib/src`): Reusable logic for code syntax highlighting (`lib/src/highlight`), analytics integrations (`lib/src/analytics`), builders (`lib/src/builders`), and various helper utilities.

## Goals

The primary aims of this shared package are to:
1. Streamline styling and standardize UI component implementation across our primary web documentation.
2. Prevent code duplication between the `dart.dev` and `docs.flutter.dev` repositories.
3. Establish a robust codebase that can be updated, maintained, and improved in a unified way.
