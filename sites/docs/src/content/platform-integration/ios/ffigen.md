---
title: "Calling iOS APIs using ffigen"
description: "Learn how to use auto-generated Dart bindings to call native Objective-C iOS APIs directly from your Flutter apps."
---

## Overview

In traditional Flutter development, calling native iOS platform APIs requires mapping asynchronous message channels (using `MethodChannel`), writing Swift or Objective-C host-side listeners, and manually serializing and deserializing types.

With direct native interop using `ffigen` (Foreign Function Interface Generation), this process is simplified:
1. **Configure**: Write a generation configuration script pointing to the iOS Frameworks or headers you need.
2. **Generate**: Run the generation package to analyze native Objective-C classes and compile a type-safe Dart API bridge.
3. **Call directly**: Call Objective-C code synchronously and type-safely in your Dart code.

This tutorial guides you through building a Flutter app called `ios_calendar_demo` that interacts directly with iOS's system `EventKit` framework to fetch and create Calendar events without manually writing any Swift or Objective-C code.

---

## Step 1: Create an app and add dependencies

First, create a new Flutter app template focused on the iOS platform.

```sh
flutter create --platforms=ios ios_calendar_demo
cd ios_calendar_demo
```

Now, add the mandatory runtime bindings package (`objective_c`), the `permission_handler` package to request Calendar access, and the developer-facing generator tool (`ffigen`) as a dev dependency:

```sh
flutter pub add objective_c permission_handler
flutter pub add dev:ffigen
```

---

## Step 2: Create the generation config script

Create a configuration script that details which native classes `ffigen` needs to generate Dart models for.

Specify `tool/generate_code.dart` at the root of your app directory:

```sh
mkdir -p tool
touch tool/generate_code.dart
```

Add the following configuration code to `tool/generate_code.dart` to target the `EventKit` framework:

```dart
import 'package:ffigen/ffigen.dart';

void main() {
  final config = Config(
    output: Uri.file('lib/eventkit_bindings.dart'),
    language: Language.objc,
    name: 'EventKitWrapper',
    description: 'Bindings for iOS EventKit framework',
    headers: Headers(
      entryPoints: [
        Uri.file(
          '/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/EventKit.framework/Headers/EventKit.h',
        ),
      ],
    ),
    objcInterfaces: ObjCInterfaces(
      include: {
        'EKEventStore',
        'EKEvent',
        'EKCalendar',
        'NSArray',
        'NSDate',
      },
    ),
  );

  final library = FfiGenerator(config).generate();
  library.generateFile(config.output.toFilePath());
}
```

---

## Step 3: Generate the bindings

Run the generator script. This will parse the `EventKit` headers and generate a type-safe Dart API at `lib/eventkit_bindings.dart` along with an Objective-C wrapper file.

```sh
dart run tool/generate_code.dart
```

Because `ffigen` generates an Objective-C wrapper (`lib/eventkit_bindings.dart.m`) to safely map Objective-C blocks and initializers, you need to add it to your Xcode project. 

Update your `ios/Runner/Info.plist` to declare calendar usage:

```xml
<key>NSCalendarsFullAccessUsageDescription</key>
<string>We need calendar access to fetch and create events.</string>
```

---

## Step 4: Write the Create Event Dialog

To allow users to create events, we need a dialog. Create a new file `lib/create_event_dialog.dart` and add the following code. This code uses standard Flutter Date/Time pickers, and directly invokes the native `EKEventStore.saveEvent` API through our generated bindings!

```dart
import 'package:flutter/material.dart';
import 'package:objective_c/objective_c.dart';

import 'eventkit_bindings.dart';

class CreateEventDialog extends StatefulWidget {
  final EKEventStore eventStore;
  final VoidCallback onEventCreated;

  const CreateEventDialog({
    super.key,
    required this.eventStore,
    required this.onEventCreated,
  });

  @override
  State<CreateEventDialog> createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends State<CreateEventDialog> {
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(hours: 1));

  Future<void> _selectDateTime(BuildContext context, bool isStart) async {
    final initialDate = isStart ? _startDate : _endDate;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) return;

    if (!context.mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );
    if (pickedTime == null) return;

    final finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      if (isStart) {
        _startDate = finalDateTime;
        if (_endDate.isBefore(_startDate)) {
          _endDate = _startDate.add(const Duration(hours: 1));
        }
      } else {
        _endDate = finalDateTime;
      }
    });
  }

  void _saveEvent() {
    final event = EKEvent.eventWithEventStore(widget.eventStore);
    event.title = _titleController.text.toNSString();
    event.notes = _notesController.text.toNSString();
    event.startDate = _startDate.toNSDate();
    event.endDate = _endDate.toNSDate();

    final defaultCalendar = widget.eventStore.defaultCalendarForNewEvents;
    if (defaultCalendar != null) {
      event.calendar = defaultCalendar;
      final success = widget.eventStore.saveEvent(
        event,
        span: EKSpan.EKSpanThisEvent,
        commit: true,
      );
      if (success) {
        widget.onEventCreated();
      } else {
        debugPrint('Failed to save event');
      }
    } else {
      debugPrint('No default calendar found');
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Event'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 3,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Start Date'),
              subtitle: Text('${_startDate.year}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.day.toString().padLeft(2, '0')} ${_startDate.hour.toString().padLeft(2, '0')}:${_startDate.minute.toString().padLeft(2, '0')}'),
              onTap: () => _selectDateTime(context, true),
              trailing: const Icon(Icons.calendar_today),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('End Date'),
              subtitle: Text('${_endDate.year}-${_endDate.month.toString().padLeft(2, '0')}-${_endDate.day.toString().padLeft(2, '0')} ${_endDate.hour.toString().padLeft(2, '0')}:${_endDate.minute.toString().padLeft(2, '0')}'),
              onTap: () => _selectDateTime(context, false),
              trailing: const Icon(Icons.calendar_today),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveEvent,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
```

---

## Step 5: Write the Main App

Now, wire everything together in `lib/main.dart`. We'll request permissions on launch, and provide buttons to Retrieve and Create Events.

```dart
import 'package:flutter/material.dart';
import 'package:objective_c/objective_c.dart';
import 'package:permission_handler/permission_handler.dart';

import 'create_event_dialog.dart';
import 'eventkit_bindings.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CalendarHomePage());
  }
}

class CalendarHomePage extends StatefulWidget {
  const CalendarHomePage({super.key});

  @override
  State<CalendarHomePage> createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  bool _hasCalendarPermission = false;
  List<Map<String, String>> _events = [];
  late final EKEventStore _eventStore;

  @override
  void initState() {
    super.initState();
    _eventStore = EKEventStore();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.calendarFullAccess.status;
    setState(() {
      _hasCalendarPermission = status.isGranted;
    });
  }

  Future<void> _requestPermission() async {
    await Permission.calendarFullAccess
        .onGrantedCallback(() {
          debugPrint('Granted');
          setState(() {
            _hasCalendarPermission = true;
          });
        })
        .onDeniedCallback(() {
          debugPrint('denied');
        })
        .request();
  }

  void _retrieveEvents() {
    final startDate = NSDate.date();
    final endDate = NSDate.dateWithTimeIntervalSinceNow(30.0 * 24 * 60 * 60);

    final calendars = _eventStore.calendars;
    final predicate = _eventStore.predicateForEventsWithStartDate(
      startDate,
      endDate: endDate,
      calendars: calendars,
    );

    final NSArray eventsArray = _eventStore.eventsMatchingPredicate(predicate);

    final count = eventsArray.count;
    List<EKEvent> fetchedEvents = [];
    for (int i = 0; i < count; i++) {
      final obj = eventsArray.objectAtIndex(i);
      final event = EKEvent.as(obj);
      fetchedEvents.add(event);
    }

    fetchedEvents.sort((a, b) {
      return a.startDate.compare(b.startDate).value;
    });

    setState(() {
      _events = fetchedEvents.map((e) {
        final title = e.title.toDartString();
        final dt = e.startDate.toDateTime();
        return {
          'title': title,
          'date': '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}',
          'time': '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}',
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EventKit Native Interop Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _hasCalendarPermission ? null : _requestPermission,
              child: Text(
                _hasCalendarPermission
                    ? 'Calendar Access Granted'
                    : 'Request Calendar Permission',
              ),
            ),
            const Divider(height: 32),
            ElevatedButton(
              onPressed: _hasCalendarPermission
                  ? () => showDialog(
                      context: context,
                      builder: (context) => CreateEventDialog(
                        eventStore: _eventStore,
                        onEventCreated: _retrieveEvents,
                      ),
                    )
                  : null,
              child: const Text('Create Event'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _hasCalendarPermission ? _retrieveEvents : null,
              child: const Text('Retrieve Events'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Events',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _events.isEmpty
                  ? const Center(child: Text('No events to display.'))
                  : SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Title')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Time')),
                        ],
                        rows: _events
                            .map(
                              (event) => DataRow(
                                cells: [
                                  DataCell(Text(event['title'] ?? '')),
                                  DataCell(Text(event['date'] ?? '')),
                                  DataCell(Text(event['time'] ?? '')),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Conclusion

You have successfully built a Flutter application that interacts directly with iOS APIs! By using `ffigen` and `objective_c`, you can skip writing manual message channels and focus on building high quality Dart code.
