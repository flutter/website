import 'dart:math' as math;

import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:material_ui/material_ui.dart';

// #docregion photo
class Photo extends StatelessWidget {
  const Photo({super.key, required this.photo, this.onTap});

  final String photo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      // Slightly opaque color appears where the image has transparency.
      color: Theme.of(context).primaryColor.withValues(alpha: 0.25),
      child: InkWell(
        onTap: onTap,
        child: Image.asset(photo, fit: BoxFit.contain),
      ),
    );
  }
}
// #enddocregion photo

// #docregion radial-expansion
class RadialExpansion extends StatelessWidget {
  const RadialExpansion({super.key, required this.maxRadius, this.child})
    : clipRectSize = 2 * (maxRadius / math.sqrt2);

  final double maxRadius;
  final double clipRectSize;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child, // Photo
          ),
        ),
      ),
    );
  }
}
// #enddocregion radial-expansion

class RadialExpansionDemo extends StatelessWidget {
  const RadialExpansionDemo({super.key});

  static const double kMinRadius = 32;
  static const double kMaxRadius = 128;
  static const Interval opacityCurve = Interval(
    0,
    0.75,
    curve: Curves.fastOutSlowIn,
  );

  // #docregion create-rect-tween
  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }
  // #enddocregion create-rect-tween

  static Widget _buildPage(
    BuildContext context,
    String imageName,
    String description,
  ) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxRadius * 2,
                height: kMaxRadius * 2,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: RadialExpansion(
                    maxRadius: kMaxRadius,
                    child: Photo(
                      photo: imageName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(
    BuildContext context,
    String imageName,
    String description,
  ) {
    return SizedBox(
      width: kMinRadius * 2,
      height: kMinRadius * 2,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion(
          maxRadius: kMaxRadius,
          child: Photo(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: opacityCurve.transform(animation.value),
                          child: child,
                        );
                      },
                      child: _buildPage(context, imageName, description),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radial Transition Demo')),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: FractionalOffset.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, 'images/chair.png', 'Chair'),
            _buildHero(context, 'images/binoculars.png', 'Binoculars'),
            _buildHero(context, 'images/beachball.png', 'Beach ball'),
          ],
        ),
      ),
    );
  }
}

void main() {
  timeDilation = 5; // 1 is normal animation speed.
  runApp(const MaterialApp(home: RadialExpansionDemo()));
}
