---
name: scss-best-practices
description: SCSS/Sassy CSS best practices and coding guidelines for maintainable, scalable stylesheets
---

# SCSS Best Practices

You are an expert in SCSS (Sassy CSS), CSS architecture, and maintainable stylesheet development.

## Key Principles

- Write modular, reusable SCSS that scales with project complexity
- Follow the DRY (Don't Repeat Yourself) principle using variables, mixins, and functions
- Maintain clear separation between structure, skin, and state styles
- Prioritize readability and maintainability over clever abstractions

## File Organization

### Architecture Pattern (7-1 Pattern)
```
scss/
├── abstracts/
│   ├── _variables.scss    # Global variables
│   ├── _functions.scss    # SCSS functions
│   ├── _mixins.scss       # Reusable mixins
│   └── _placeholders.scss # Extendable placeholders
├── base/
│   ├── _reset.scss        # CSS reset/normalize
│   ├── _typography.scss   # Typography rules
│   └── _base.scss         # Base element styles
├── components/
│   ├── _buttons.scss      # Button components
│   ├── _cards.scss        # Card components
│   └── _forms.scss        # Form components
├── layout/
│   ├── _header.scss       # Header layout
│   ├── _footer.scss       # Footer layout
│   ├── _grid.scss         # Grid system
│   └── _navigation.scss   # Navigation layout
├── pages/
│   ├── _home.scss         # Home page specific
│   └── _contact.scss      # Contact page specific
├── themes/
│   └── _default.scss      # Default theme
├── vendors/
│   └── _bootstrap.scss    # Third-party overrides
└── main.scss              # Main manifest file
```

### Import Order
```scss
// main.scss
@use 'abstracts/variables';
@use 'abstracts/functions';
@use 'abstracts/mixins';
@use 'abstracts/placeholders';

@use 'vendors/normalize';

@use 'base/reset';
@use 'base/typography';
@use 'base/base';

@use 'layout/grid';
@use 'layout/header';
@use 'layout/navigation';
@use 'layout/footer';

@use 'components/buttons';
@use 'components/cards';
@use 'components/forms';

@use 'pages/home';

@use 'themes/default';
```

## Variables

### Naming Convention
```scss
// Use semantic, descriptive names
// Format: $category-property-variant

// Colors
$color-primary: #3498db;
$color-primary-light: lighten($color-primary, 15%);
$color-primary-dark: darken($color-primary, 15%);
$color-secondary: #2ecc71;
$color-text: #333333;
$color-text-muted: #666666;
$color-background: #ffffff;
$color-border: #e0e0e0;
$color-error: #e74c3c;
$color-success: #27ae60;
$color-warning: #f39c12;

// Typography
$font-family-base: 'Helvetica Neue', Arial, sans-serif;
$font-family-heading: 'Georgia', serif;
$font-size-base: 1rem;
$font-size-small: 0.875rem;
$font-size-large: 1.25rem;
$font-weight-normal: 400;
$font-weight-bold: 700;
$line-height-base: 1.5;

// Spacing (use consistent scale)
$spacing-unit: 8px;
$spacing-xs: $spacing-unit * 0.5;  // 4px
$spacing-sm: $spacing-unit;        // 8px
$spacing-md: $spacing-unit * 2;    // 16px
$spacing-lg: $spacing-unit * 3;    // 24px
$spacing-xl: $spacing-unit * 4;    // 32px
$spacing-xxl: $spacing-unit * 6;   // 48px

// Breakpoints
$breakpoint-sm: 576px;
$breakpoint-md: 768px;
$breakpoint-lg: 992px;
$breakpoint-xl: 1200px;
$breakpoint-xxl: 1400px;

// Z-index scale
$z-index-dropdown: 1000;
$z-index-sticky: 1020;
$z-index-fixed: 1030;
$z-index-modal-backdrop: 1040;
$z-index-modal: 1050;
$z-index-popover: 1060;
$z-index-tooltip: 1070;

// Transitions
$transition-base: 0.3s ease;
$transition-fast: 0.15s ease;
$transition-slow: 0.5s ease;

// Border radius
$border-radius-sm: 2px;
$border-radius-md: 4px;
$border-radius-lg: 8px;
$border-radius-pill: 50px;
$border-radius-circle: 50%;

// Shadows
$shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
$shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
$shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
$shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.15);
```

### Maps for Related Values
```scss
// Use maps for grouped values
$colors: (
  'primary': #3498db,
  'secondary': #2ecc71,
  'danger': #e74c3c,
  'warning': #f39c12,
  'info': #17a2b8,
  'success': #27ae60
);

$breakpoints: (
  'sm': 576px,
  'md': 768px,
  'lg': 992px,
  'xl': 1200px,
  'xxl': 1400px
);

// Access with map-get
.element {
  color: map-get($colors, 'primary');
}
```

## Mixins

### Responsive Breakpoints
```scss
@mixin respond-to($breakpoint) {
  @if map-has-key($breakpoints, $breakpoint) {
    @media (min-width: map-get($breakpoints, $breakpoint)) {
      @content;
    }
  } @else {
    @warn "Unknown breakpoint: #{$breakpoint}";
  }
}

// Usage
.element {
  width: 100%;

  @include respond-to('md') {
    width: 50%;
  }

  @include respond-to('lg') {
    width: 33.333%;
  }
}
```

### Flexbox Utilities
```scss
@mixin flex-center {
  display: flex;
  align-items: center;
  justify-content: center;
}

@mixin flex-between {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

@mixin flex-column {
  display: flex;
  flex-direction: column;
}
```

### Typography
```scss
@mixin font-size($size, $line-height: null) {
  font-size: $size;
  @if $line-height {
    line-height: $line-height;
  }
}

@mixin truncate($lines: 1) {
  @if $lines == 1 {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  } @else {
    display: -webkit-box;
    -webkit-line-clamp: $lines;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }
}
```

### Accessibility
```scss
@mixin visually-hidden {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

@mixin focus-visible {
  &:focus-visible {
    outline: 2px solid $color-primary;
    outline-offset: 2px;
  }
}
```

## BEM Naming Convention

### Structure
```scss
// Block: Standalone component
// Element: Part of block (block__element)
// Modifier: Variant (block--modifier or block__element--modifier)

.card {
  // Block styles
  background: $color-background;
  border-radius: $border-radius-md;
  box-shadow: $shadow-md;

  // Element
  &__header {
    padding: $spacing-md;
    border-bottom: 1px solid $color-border;
  }

  &__title {
    margin: 0;
    font-size: $font-size-large;
    font-weight: $font-weight-bold;
  }

  &__body {
    padding: $spacing-md;
  }

  &__footer {
    padding: $spacing-md;
    border-top: 1px solid $color-border;
  }

  // Modifier
  &--featured {
    border: 2px solid $color-primary;
  }

  &--compact {
    .card__header,
    .card__body,
    .card__footer {
      padding: $spacing-sm;
    }
  }
}
```

## Nesting Rules

### Maximum Nesting Depth
```scss
// BAD: Too deep nesting
.nav {
  .nav-list {
    .nav-item {
      .nav-link {
        .nav-icon {
          // 5 levels deep - avoid this
        }
      }
    }
  }
}

// GOOD: Keep nesting to 3 levels maximum
.nav {
  // Level 1
}

.nav__list {
  // Level 1
}

.nav__item {
  // Level 1
}

.nav__link {
  color: $color-text;

  &:hover,
  &:focus {
    // Level 2 - acceptable for states
    color: $color-primary;
  }

  &--active {
    // Level 2 - acceptable for modifiers
    color: $color-primary;
    font-weight: $font-weight-bold;
  }
}
```

### Acceptable Nesting
```scss
.component {
  // Direct child pseudo-elements
  &::before,
  &::after {
    content: '';
  }

  // State modifiers
  &:hover,
  &:focus,
  &:active {
    // State styles
  }

  // BEM modifiers
  &--variant {
    // Modifier styles
  }

  // Media queries
  @include respond-to('md') {
    // Responsive styles
  }
}
```

## Functions

### Color Functions
```scss
@function tint($color, $percentage) {
  @return mix(white, $color, $percentage);
}

@function shade($color, $percentage) {
  @return mix(black, $color, $percentage);
}

// Usage
.element {
  background: tint($color-primary, 20%);
  border-color: shade($color-primary, 10%);
}
```

### Unit Conversion
```scss
@function px-to-rem($px, $base: 16) {
  @return ($px / $base) * 1rem;
}

@function rem-to-px($rem, $base: 16) {
  @return ($rem / 1rem) * $base * 1px;
}

// Usage
.element {
  font-size: px-to-rem(18); // 1.125rem
  padding: px-to-rem(24);   // 1.5rem
}
```

### Spacing Function
```scss
@function spacing($multiplier) {
  @return $spacing-unit * $multiplier;
}

// Usage
.element {
  margin-bottom: spacing(2); // 16px
  padding: spacing(3);       // 24px
}
```

## Extend and Placeholders

### Use Placeholders Over Classes
```scss
// Define placeholder
%button-base {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: $spacing-sm $spacing-md;
  border: none;
  border-radius: $border-radius-md;
  font-family: inherit;
  font-size: $font-size-base;
  font-weight: $font-weight-bold;
  text-decoration: none;
  cursor: pointer;
  transition: all $transition-base;

  &:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
}

// Extend placeholder
.btn-primary {
  @extend %button-base;
  background: $color-primary;
  color: white;

  &:hover:not(:disabled) {
    background: darken($color-primary, 10%);
  }
}

.btn-secondary {
  @extend %button-base;
  background: transparent;
  color: $color-primary;
  border: 2px solid $color-primary;

  &:hover:not(:disabled) {
    background: $color-primary;
    color: white;
  }
}
```

## Loops and Iteration

### Generate Utility Classes
```scss
// Spacing utilities
$spacing-directions: (
  '': '',
  't': '-top',
  'r': '-right',
  'b': '-bottom',
  'l': '-left',
  'x': '-inline',
  'y': '-block'
);

@each $abbr, $direction in $spacing-directions {
  @for $i from 0 through 8 {
    .m#{$abbr}-#{$i} {
      margin#{$direction}: spacing($i);
    }
    .p#{$abbr}-#{$i} {
      padding#{$direction}: spacing($i);
    }
  }
}

// Color utilities
@each $name, $color in $colors {
  .text-#{$name} {
    color: $color;
  }
  .bg-#{$name} {
    background-color: $color;
  }
  .border-#{$name} {
    border-color: $color;
  }
}
```

## Performance Best Practices

- Avoid overly specific selectors; aim for specificity of 0-1-0 (single class)
- Never use `!important` except for utility classes
- Minimize use of `@extend` across files (can cause bloat)
- Use `@use` and `@forward` instead of `@import` (deprecated)
- Compile with source maps in development, without in production
- Use autoprefixer for vendor prefixes instead of manual prefixes

## Modern SCSS Features

### Module System
```scss
// _variables.scss
$primary: #3498db;

// _mixins.scss
@use 'variables' as vars;

@mixin themed-button {
  background: vars.$primary;
}

// main.scss
@use 'mixins';

.button {
  @include mixins.themed-button;
}
```

### Built-in Modules
```scss
@use 'sass:math';
@use 'sass:color';
@use 'sass:list';
@use 'sass:map';
@use 'sass:string';

.element {
  width: math.div(100%, 3);
  background: color.adjust($color-primary, $lightness: 10%);
}
```

## Code Style

- Use 2 spaces for indentation
- Use single quotes for strings
- Add a space after colons in declarations
- Add a space before opening braces
- Put closing braces on new lines
- Separate rule sets with blank lines
- Order properties logically (positioning, box model, typography, visual, misc)
- Comment complex calculations and non-obvious code
