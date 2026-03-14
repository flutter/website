---
name: convert-dot-shorthand
description: Auto-converts standard enums and statics (like Colors.red, EdgeInsets.all) to Dart 3.10 dot shorthands. Use when updating Flutter code samples to modern syntax.
---

# Convert to Dot Shorthand

Use this skill when you need to migrate an existing Flutter example or Dart file to use the new Dart 3.10 dot shorthand feature. 

This skill enforces a hybrid approach to ensure maximum safety and readability: a script first replaces all possible candidates, and then YOU (the AI) must manually evaluate each change using rules defined below.

## Workflow Instructions

1.  **Execute the brute-force script:**
    Run `scripts/apply_all.sh <target_directory>`. 
    This script will unconditionally search and replace all known safe classes (e.g., `Colors`, `EdgeInsets`, `Alignment`) with their dot shorthand equivalents.

2.  **Evaluate the Diff (The Human/AI check):**
    Run `git diff` to view all changes the script just made. You must evaluate every single substitution against the [Readability Heuristics](#readability-heuristics) below. 

3.  **Revert bad candidates:**
    If a change is deemed "bad" based on the heuristics, you must manually undo that specific change (e.g., by checking out that line or manually re-typing the class name).

4.  **Generate a Concise Rejection Report:**
    Before finishing, you must print a short terminal/agent output report to the user summarizing ONLY the items you rejected. Format it like this:
    ```
    Reverted Changes Report:
    example_file.dart:L42 - Kept `FontWeight.w600`
    Reason: Numeric font weights lose context without the class name.
    
    example_file.dart:L80 - Kept `MainAxisSize.min`
    Reason: The property name does not provide enough context for `.min`.
    ```

5.  **Finalize:**
    Format the remaining code with `dart format <target_directory>`, run `dart analyze`, and run `flutter test` (if tests exist) to ensure the good shorthands don't break anything.

## Readability Heuristics

When evaluating a diff, ask yourself if the removed class name hurts readability. We are trying to find the heuristic balance.

**Known "Good" Shorthands (Usually Keep):**
*   `Colors.*` -> `.*` (It's almost always obvious a color is a color).
*   `EdgeInsets.all` / `EdgeInsets.symmetric` -> `.all` / `.symmetric` (Context is extremely strong inside a `padding` or `margin` property).
*   `Alignment.*` -> `.*` (Very clear inside an `alignment` property).

**Known "Bad" Shorthands (Always Revert):**
*   *Please document rules here as we discover them during manual evaluation.*
