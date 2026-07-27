# Blog Redirects

This directory contains the Firebase Hosting configuration used to redirect
legacy Medium blog URLs (previously hosted at `blog.flutter.dev`) to the
official Flutter blog on `flutter.dev/blog`.

## Overview

- **`firebase.json`**:
  Contains the redirect rules mapping specific legacy Medium URL patterns
  and hash-suffixes to their corresponding paths under `flutter.dev/blog`.
- **`public/index.html`**:
  A fallback page that redirects users to `flutter.dev/blog` via a meta refresh.
