# DevTools 2.18.0 release notes

Dart & Flutter DevTools - A Suite of Performance Tools for Dart and Flutter

# Inspector updates
- Auto scrolling behavior improved when snapping to a widget into focus.
- Fix issue where widget inspector wouldn't load when connecting to a paused app.
- Improve widget inspector hover cards to show progress while waiting for data.

# Performance updates
- Fix issue where scrollbar would go out of sync with the frame content.
- Add offline support for raster stats.
- Add 'Rendering time' column to Raster Metrics tab.

# CPU profiler updates
- Fix crash when an empty frame is filtered.
- Fix bugs in CPU profile trees.
- UI Cleanup

# Memory updates
- UI cleanup.
- Allocation tracing on multiple isolates is now supported.
- Clear button added to allocation tracing tab.
- Fix sorting column not being correctly updated.
- Add Profile and Allocation Tracing sub-tabs.
- Implement snapshot visualization.
- Implement comparing memory profiles.
- Remove settings for displaying units.
- Advanced memory behavior is now always on and no longer controlled by settings.
- Remove android button from chart control pane. It can be turned on/off in settings.
- Add Call Tree view.
- Persist profile sort order.

# Debugger updates
- Fix bug for file opener and search
- Fix the codeview's scrollable area.
- Allow syntax highlighting on nested captures in parser.

# Network profiler updates
- When on the Network tab, network recordings now continue working after the app hot restarts.

# Logging updates
- Log messages from non-stdout sources are now shown.

# VM tool updates
- Add support for inspecting objects in an isolate's object store.
- Enable object inspector / program explore view.
- Add "Code Preview" section to Object Inspector views
- UI polish.

## Changelog
More details about changes and fixes are available in the DevTools
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md).
