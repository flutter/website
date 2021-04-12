---
title: Create a download button
description: How to implement a download button.
prev:
  title: Work with tabs
  path:  /docs/cookbook/design/tabs
next:
  title: Create a nested navigation flow
  path:  /docs/cookbook/effects/nested-nav
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

Apps are filled with buttons that execute long-running behaviors.
For example, a button might trigger a download,
which starts a download process, receives data over time,
and then provides access to the downloaded asset. 
It’s helpful to show the user the progress of a
long-running process, and the button itself is a good place
to provide this feedback. In this recipe,
you'll build a download button that transitions through
multiple visual states, based on the status of an app download.

The following animation shows the app's behavior:

![The download button cycles through its stages]({% asset cookbook/effects/DownloadButton.gif @path %}){:.site-mobile-screenshot}

## Define a new stateful widget

Your button widget needs to change its appearance over time.
Therefore, you need to implement your button with a custom
stateful widget. 

Define a new stateful widget called `DownloadButton`.

<!--skip-->
```dart
@immutable
class DownloadButton extends StatefulWidget {
 const DownloadButton({
   Key? key,
 }) : super(key: key);

 @override
 _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
 @override
 Widget build(BuildContext context) {
   // TODO:
   return SizedBox();
 }
}
```

## Define the button’s possible visual states

The download button’s visual presentation is based on a
given download status. Define the possible states of
the download, and then update `DownloadButton` to accept
a `DownloadStatus` and a `Duration` for how long the button
should take to animate from one status to another.

<!--skip-->
```dart
enum DownloadStatus {
 notDownloaded,
 fetchingDownload,
 downloading,
 downloaded,
}

@immutable
class DownloadButton extends StatefulWidget {
 const DownloadButton({
   Key? key,
   required this.status,
   this.transitionDuration = const Duration(milliseconds: 500),
 }) : super(key: key);

 final DownloadStatus status;
 final Duration transitionDuration;

 @override
 _DownloadButtonState createState() => _DownloadButtonState();
}
```

{{site.alert.note}}
  Each time you define a custom widget,
  you must decide whether all relevant 
  information is provided to that widget
  from its parent or if that widget orchestrates
  the application behavior within itself.
  For example, `DownloadButton` could receive the
  current `DownloadStatus` from its parent, 
  or the `DownloadButton` could orchestrate the
  download process itself within its `State` object.
  For most widgets, the best answer is to pass the relevant 
  information into the widget from its parent,
  rather than manage behavior within the widget.
  By passing in all the relevant information,
  you ensure greater reusability for the widget,
  easier testing, and easier changes to application 
  behavior in the future.
{{site.alert.end}}

## Display the button shape

The download button changes its shape based on the download
status. The button displays a grey, rounded rectangle during
the `notDownloaded` and `downloaded` states.
The button displays a transparent circle during the
`fetchingDownload` and `downloading` states. 

Based on the current `DownloadStatus`,
build an `AnimatedContainer` with a 
`ShapeDecoration` that displays a rounded
rectangle or a circle.

Consider defining the shape’s widget tree within a local
`_buildXXXX()` method so that the main `build()`
method remains simple, allowing for the additions 
that follow. Also, configure the shape widget tree to
accept a child widget, which you’ll use to display text
in a later step.

<!--skip-->
```dart
class _DownloadButtonState extends State<DownloadButton> {
 bool get _isDownloading => widget.status == DownloadStatus.downloading;

 bool get _isFetching => widget.status == DownloadStatus.fetchingDownload;

 bool get _isDownloaded => widget.status == DownloadStatus.downloaded;

 @override
 Widget build(BuildContext context) {
   return _buildButtonShape(
     child: SizedBox(),
   );
 }

 Widget _buildButtonShape({
   required Widget child,
 }) {
   return AnimatedContainer(
     duration: widget.transitionDuration,
     curve: Curves.ease,
     width: double.infinity,
     decoration: _isDownloading || _isFetching
         ? ShapeDecoration(
             shape: const CircleBorder(),
             color: Colors.white.withOpacity(0.0),
           )
         : const ShapeDecoration(
             shape: StadiumBorder(),
             color: CupertinoColors.lightBackgroundGray,
           ),
     child: child,
   );
 }
}
```

You might wonder why you need a `ShapeDecoration`
widget for a transparent circle, given that it’s invisible.
The purpose of the invisible circle is to orchestrate
the desired animation. The `AnimatedContainer` begins with a rounded 
rectangle. When the `DownloadStatus` changes to `fetchingDownload`,
the `AnimatedContainer` needs to animate from a rounded rectangle
to a circle, and then fade out as the animation takes place.
The only way to implement this animation is to define both
the beginning shape of a rounded rectangle and the 
ending shape of a circle. But, you don’t want the final
circle to be visible, so you make it transparent,
which causes an animated fade-out.

## Display the button text

The `DownloadButton` displays `GET` during the
`notDownloaded` phase, `OPEN` during the `downloaded`
phase, and no text in between. 

Add widgets to display text during each download phase,
and animate the text’s opacity in between. Add the text
widget tree as a child of the shape widget tree.

<!--skip-->
```dart
class _DownloadButtonState extends State<DownloadButton> {
 @override
 Widget build(BuildContext context) {
   return _buildButtonShape(
     child: _buildText(),
   );
 }

 Widget _buildText() {
   final text = _isDownloaded ? 'OPEN' : 'GET';
   final opacity = _isDownloading || _isFetching ? 0.0 : 1.0;

   return Padding(
     padding: const EdgeInsets.symmetric(vertical: 6),
     child: AnimatedOpacity(
       duration: widget.transitionDuration,
       opacity: opacity,
       curve: Curves.ease,
       child: Text(
         text,
         textAlign: TextAlign.center,
         style: Theme.of(context).textTheme.button?.copyWith(
           fontWeight: FontWeight.bold,
           color: CupertinoColors.activeBlue,
         ),
       ),
     ),
   );
 }
}
```

## Display a spinner while fetching download

During the `fetchingDownload` phase, the `DownloadButton`
displays a radial spinner. This spinner fades in from
the `notDownloaded` phase and fades out to 
the `fetchingDownload` phase. 

Implement a radial spinner that sits on top of the button
shape and fades in and out at the appropriate times.

<!--skip-->
```dart
class _DownloadButtonState extends State<DownloadButton> {
 @override
 Widget build(BuildContext context) {
   return Stack(
     children: [
       _buildButtonShape(
         child: _buildText(),
       ),
       _buildDownloadingProgress(),
     ],
   );
 }

 Widget _buildDownloadingProgress() {
   return Positioned.fill(
     child: AnimatedOpacity(
       duration: widget.transitionDuration,
       opacity: _isDownloading || _isFetching ? 1.0 : 0.0,
       curve: Curves.ease,
       child: _buildProgressIndicator(),
     ),
   );
 }

 Widget _buildProgressIndicator() {
   return AspectRatio(
     aspectRatio: 1.0,
     child: CircularProgressIndicator(
       backgroundColor: Colors.white.withOpacity(0.0),
       valueColor: AlwaysStoppedAnimation(
         CupertinoColors.lightBackgroundGray
       ),
       strokeWidth: 2.0,
       value: null,
     ),
   );
 }
}
```

## Display the progress and a stop button while downloading

After the `fetchingDownload` phase is the `downloading` phase.
During the `downloading` phase, the `DownloadButton`
replaces the radial progress spinner with a growing
radial progress bar. The `DownloadButton` also displays a stop 
button icon so that the user can cancel an in-progress download.

Add a progress property to the `DownloadButton` widget,
and then update the progress display to switch to a radial
progress bar during the `downloading` phase. 

Next, add a stop button icon at the center of the
radial progress bar.

<!--skip-->
```dart
@immutable
class DownloadButton extends StatefulWidget {
 const DownloadButton({
   Key? key,
   this.progress = 0.0,
 }) : super(key: key);

 final double progress;

 @override
 _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
 @override
 Widget build(BuildContext context) {
   return Stack(
     children: [
       _buildButtonShape(
         child: _buildText(),
       ),
       _buildDownloadingProgress(),
     ],
   );
 }

 Widget _buildDownloadingProgress() {
   return Positioned.fill(
     child: AnimatedOpacity(
       duration: widget.transitionDuration,
       opacity: _isDownloading || _isFetching ? 1.0 : 0.0,
       curve: Curves.ease,
       child: Stack(
         alignment: Alignment.center,
         children: [
           _buildProgressIndicator(),
           if (_isDownloading)
             const Icon(
               Icons.stop,
               size: 14.0,
               color: CupertinoColors.activeBlue,
             ),
         ],
       ),
     ),
   );
 }


 Widget _buildProgressIndicator() {
   return AspectRatio(
     aspectRatio: 1.0,
     child: TweenAnimationBuilder<double>(
       tween: Tween(begin: 0.0, end: widget.progress),
       duration: const Duration(milliseconds: 200),
       builder: (BuildContext context, double progress, Widget? child) {
         return CircularProgressIndicator(
           backgroundColor: _isDownloading ? CupertinoColors.lightBackgroundGray : Colors.white.withOpacity(0.0),
           valueColor:
             AlwaysStoppedAnimation(_isFetching ? CupertinoColors.lightBackgroundGray : CupertinoColors.activeBlue),
           strokeWidth: 2.0,
           value: _isFetching ? null : progress,
         );
       },
     ),
   );
 }
}
```

## Add button tap callbacks

The last detail that your `DownloadButton` needs is the
button behavior. The button must do things when the user taps it. 

Add widget properties for callbacks to start a download,
cancel a download, and open a download. 

Finally, wrap `DownloadButton`’s existing widget tree
with a `GestureDetector` widget, and forward the
tap event to the corresponding callback property.

<!--skip-->
```dart
@immutable
class DownloadButton extends StatefulWidget {
 const DownloadButton({
   Key? key,
   required this.onDownload,
   required this.onCancel,
   required this.onOpen,
 }) : super(key: key);

 final VoidCallback onDownload;
 final VoidCallback onCancel;
 final VoidCallback onOpen;

 @override
 _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
 void _onPressed() {
   switch (widget.status) {
     case DownloadStatus.notDownloaded:
       widget.onDownload();
       break;
     case DownloadStatus.fetchingDownload:
       // do nothing.
       break;
     case DownloadStatus.downloading:
       widget.onCancel();
       break;
     case DownloadStatus.downloaded:
       widget.onOpen();
       break;
   }
 }

 @override
 Widget build(BuildContext context) {
   return GestureDetector(
     onTap: _onPressed,
     child: Stack(
       children: [
         _buildButtonShape(
           child: _buildText(),
         ),
         _buildDownloadingProgress(),
       ],
     ),
   );
 }
}
```

Congratulations! You have a button that changes its display
depending on which phase the button is in: not downloaded,
fetching download, downloading, and downloaded.
Now, the user can tap to start a download, tap to cancel an 
in-progress download, and tap to open a completed download.

## Interactive example

Run the app:

* Click the **GET** button to kick off a
  simulated download.
* The button changes to a progress indicator
  to simulate an in-progress download.
* When the simulated download is complete, the
  button transitions to **OPEN**, to indicate
  that the app is ready for the user
  to open the downloaded asset.

<!--skip-->
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const ExampleCupertinoDownloadButton(),
    debugShowCheckedModeBanner: false,
  ));
}

@immutable
class ExampleCupertinoDownloadButton extends StatefulWidget {
  const ExampleCupertinoDownloadButton({Key? key}) : super(key: key);

  @override
  _ExampleCupertinoDownloadButtonState createState() =>
      _ExampleCupertinoDownloadButtonState();
}

class _ExampleCupertinoDownloadButtonState
    extends State<ExampleCupertinoDownloadButton> {
  late final List<DownloadController> _downloadControllers;

  @override
  void initState() {
    super.initState();
    _downloadControllers = List<DownloadController>.generate(
      20,
      (index) => SimulatedDownloadController(onOpenDownload: () {
        _openDownload(index);
      }),
    );
  }

  void _openDownload(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Open App ${index + 1}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apps')),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      itemCount: _downloadControllers.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final downloadController = _downloadControllers[index];
    return ListTile(
      leading: const DemoAppIcon(),
      title: Text(
        'App ${index + 1}',
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.headline6,
      ),
      subtitle: Text(
        'Lorem ipsum dolor #${index + 1}',
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.caption,
      ),
      trailing: SizedBox(
        width: 96.0,
        child: AnimatedBuilder(
          animation: downloadController,
          builder: (context, child) {
            return DownloadButton(
              status: downloadController.downloadStatus,
              downloadProgress: downloadController.progress,
              onDownload: downloadController.startDownload,
              onCancel: downloadController.stopDownload,
              onOpen: downloadController.openDownload,
            );
          },
        ),
      ),
    );
  }
}

@immutable
class DemoAppIcon extends StatelessWidget {
  const DemoAppIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1.0,
      child: FittedBox(
        child: SizedBox(
          width: 80.0,
          height: 80.0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.blue],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Center(
              child: Icon(
                Icons.ac_unit,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum DownloadStatus {
  notDownloaded,
  fetchingDownload,
  downloading,
  downloaded,
}

abstract class DownloadController implements ChangeNotifier {
  DownloadStatus get downloadStatus;
  double get progress;

  void startDownload();
  void stopDownload();
  void openDownload();
}

class SimulatedDownloadController extends DownloadController
    with ChangeNotifier {
  SimulatedDownloadController({
    DownloadStatus downloadStatus = DownloadStatus.notDownloaded,
    double progress = 0.0,
    required VoidCallback onOpenDownload,
  })   : _downloadStatus = downloadStatus,
        _progress = progress,
        _onOpenDownload = onOpenDownload;

  DownloadStatus _downloadStatus;
  @override
  DownloadStatus get downloadStatus => _downloadStatus;

  double _progress;
  @override
  double get progress => _progress;

  final VoidCallback _onOpenDownload;

  bool _isDownloading = false;

  @override
  void startDownload() {
    if (downloadStatus == DownloadStatus.notDownloaded) {
      _doSimulatedDownload();
    }
  }

  @override
  void stopDownload() {
    if (_isDownloading) {
      _isDownloading = false;
      _downloadStatus = DownloadStatus.notDownloaded;
      _progress = 0.0;
      notifyListeners();
    }
  }

  @override
  void openDownload() {
    if (downloadStatus == DownloadStatus.downloaded) {
      _onOpenDownload();
    }
  }

  Future<void> _doSimulatedDownload() async {
    _isDownloading = true;
    _downloadStatus = DownloadStatus.fetchingDownload;
    notifyListeners();

    // Wait a second to simulate fetch time.
    await Future<void>.delayed(const Duration(seconds: 1));

    // If the user chose to cancel the download, stop the simulation.
    if (!_isDownloading) {
      return;
    }

    // Shift to the downloading phase.
    _downloadStatus = DownloadStatus.downloading;
    notifyListeners();

    const downloadProgressStops = [0.0, 0.15, 0.45, 0.80, 1.0];
    for (final stop in downloadProgressStops) {
      // Wait a second to simulate varying download speeds.
      await Future<void>.delayed(const Duration(seconds: 1));

      // If the user chose to cancel the download, stop the simulation.
      if (!_isDownloading) {
        return;
      }

      // Update the download progress.
      _progress = stop;
      notifyListeners();
    }

    // Wait a second to simulate a final delay.
    await Future<void>.delayed(const Duration(seconds: 1));

    // If the user chose to cancel the download, stop the simulation.
    if (!_isDownloading) {
      return;
    }

    // Shift to the downloaded state, completing the simulation.
    _downloadStatus = DownloadStatus.downloaded;
    _isDownloading = false;
    notifyListeners();
  }
}

@immutable
class DownloadButton extends StatelessWidget {
  const DownloadButton({
    Key? key,
    required this.status,
    this.downloadProgress = 0.0,
    required this.onDownload,
    required this.onCancel,
    required this.onOpen,
    this.transitionDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  final DownloadStatus status;
  final double downloadProgress;
  final VoidCallback onDownload;
  final VoidCallback onCancel;
  final VoidCallback onOpen;
  final Duration transitionDuration;

  bool get _isDownloading => status == DownloadStatus.downloading;

  bool get _isFetching => status == DownloadStatus.fetchingDownload;

  bool get _isDownloaded => status == DownloadStatus.downloaded;

  void _onPressed() {
    switch (status) {
      case DownloadStatus.notDownloaded:
        onDownload();
        break;
      case DownloadStatus.fetchingDownload:
        // do nothing.
        break;
      case DownloadStatus.downloading:
        onCancel();
        break;
      case DownloadStatus.downloaded:
        onOpen();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Stack(
        children: [
          _buildButtonShape(
            child: _buildText(context),
          ),
          _buildDownloadingProgress(),
        ],
      ),
    );
  }

  Widget _buildButtonShape({
    required Widget child,
  }) {
    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.ease,
      width: double.infinity,
      decoration: _isDownloading || _isFetching
          ? ShapeDecoration(
              shape: const CircleBorder(),
              color: Colors.white.withOpacity(0.0),
            )
          : const ShapeDecoration(
              shape: StadiumBorder(),
              color: CupertinoColors.lightBackgroundGray,
            ),
      child: child,
    );
  }

  Widget _buildText(BuildContext context) {
    final text = _isDownloaded ? 'OPEN' : 'GET';
    final opacity = _isDownloading || _isFetching ? 0.0 : 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedOpacity(
        duration: transitionDuration,
        opacity: opacity,
        curve: Curves.ease,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button?.copyWith(
                fontWeight: FontWeight.bold,
                color: CupertinoColors.activeBlue,
              ),
        ),
      ),
    );
  }

  Widget _buildDownloadingProgress() {
    return Positioned.fill(
      child: AnimatedOpacity(
        duration: transitionDuration,
        opacity: _isDownloading || _isFetching ? 1.0 : 0.0,
        curve: Curves.ease,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildProgressIndicator(),
            if (_isDownloading)
              const Icon(
                Icons.stop,
                size: 14.0,
                color: CupertinoColors.activeBlue,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: downloadProgress),
        duration: const Duration(milliseconds: 200),
        builder: (context, progress, child) {
          return CircularProgressIndicator(
            backgroundColor: _isDownloading
                ? CupertinoColors.lightBackgroundGray
                : Colors.white.withOpacity(0.0),
            valueColor: AlwaysStoppedAnimation(_isFetching
                ? CupertinoColors.lightBackgroundGray
                : CupertinoColors.activeBlue),
            strokeWidth: 2.0,
            value: _isFetching ? null : progress,
          );
        },
      ),
    );
  }
}
```
