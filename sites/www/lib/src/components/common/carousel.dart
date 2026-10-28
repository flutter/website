// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/utils/component_ref.dart';
import 'package:universal_web/web.dart' as web;

import 'icon.dart';

@client
class Carousel extends StatelessComponent {
  const Carousel(this.items, {this.prevBtn, this.nextBtn});

  final ComponentRef items;
  final ComponentRef? prevBtn;
  final ComponentRef? nextBtn;

  @override
  Component build(BuildContext context) {
    return CarouselBase(items, prevBtn: prevBtn, nextBtn: nextBtn);
  }
}

class CarouselBase extends StatefulComponent {
  const CarouselBase(this.items, {this.prevBtn, this.nextBtn});

  final Component items;
  final Component? prevBtn;
  final Component? nextBtn;

  @override
  State<CarouselBase> createState() => _CarouselState();
}

class _CarouselState extends State<CarouselBase> {
  double _progress = 0;
  int _maxScroll = 0;
  int _totalCards = 0;
  int _cardWidth = 0;
  int _currentIndex = 0;

  final GlobalNodeKey<web.HTMLElement> _sliderKey = GlobalNodeKey();
  StreamSubscription<web.Event>? _resizeSub;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _resizeSub = web.EventStreamProviders.resizeEvent
          .forTarget(web.window)
          .listen((event) {
            _onResize();
          });

      _initCards();
    }
  }

  @override
  void didUpdateComponent(covariant CarouselBase oldComponent) {
    _initCards();
    super.didUpdateComponent(oldComponent);
  }

  void _initCards() {
    context.binding.addPostFrameCallback(() {
      final slider = _sliderKey.currentNode;
      if (slider == null) {
        return;
      }

      _totalCards = slider.children.length;
      if (_totalCards == 0) {
        return;
      }

      _setMaxScroll();

      final firstCard = slider.firstElementChild! as web.HTMLElement;
      final style = web.window.getComputedStyle(firstCard);
      _cardWidth =
          firstCard.offsetWidth +
          int.parse(RegExp(r'\d+').firstMatch(style.marginRight)!.group(0)!);

      _onScroll();
    });
  }

  void _onResize() {
    if (_totalCards == 0) {
      return;
    }
    _setMaxScroll();
    _onScroll();
  }

  void _onScroll() {
    final currentScroll = _getRemainingScroll();

    setState(() {
      _progress = ((currentScroll - _maxScroll).abs() / _maxScroll) * 100;
      if (_maxScroll <= 0 || _progress.isNaN) {
        _progress = 100;
      }
    });
  }

  int _getRemainingScroll() {
    final slider = _sliderKey.currentNode;
    if (slider == null) return 0;
    final offsetLeft = slider.offsetLeft;
    final scrollWidth = slider.scrollWidth;
    final scrollLeft = slider.scrollLeft.floor();
    final rect = slider.getBoundingClientRect();
    final rectRight = rect.right.ceil();
    return scrollWidth - scrollLeft + offsetLeft - rectRight;
  }

  void _setMaxScroll() {
    final slider = _sliderKey.currentNode;
    if (slider == null) {
      return;
    }
    _maxScroll = slider.scrollWidth - slider.offsetWidth;
  }

  void _navigate(bool forward) {
    final slider = _sliderKey.currentNode;
    if (slider == null) {
      return;
    }

    var idx = _currentIndex;

    // Has been scrolled manually, need to get correct idx before proceeding
    if (slider.scrollLeft > 0) {
      final proposedIdx = (slider.scrollLeft.ceil() / _cardWidth).floor();
      if (idx != proposedIdx) {
        _currentIndex = idx = proposedIdx;
      }
    }

    if (forward) {
      _currentIndex = idx == _totalCards - 1 ? idx : idx + 1;
      var nextScrollLeft = _currentIndex * _cardWidth;
      if (_maxScroll - nextScrollLeft < _cardWidth) {
        nextScrollLeft = _maxScroll;
      }
      slider.scrollLeft = nextScrollLeft;
    } else {
      _currentIndex = idx == 0 ? 0 : idx - 1;
      var nextScrollLeft = _currentIndex * _cardWidth;
      if (nextScrollLeft < 0) {
        nextScrollLeft = 0;
      }
      slider.scrollLeft = nextScrollLeft;
    }
  }

  @override
  void dispose() {
    if (_resizeSub case final resizeSub?) {
      unawaited(resizeSub.cancel());
    }
    super.dispose();
  }

  bool get _prevDisabled => _maxScroll <= 0 || _progress < 1;
  bool get _nextDisabled => _maxScroll <= 0 || _progress >= 100;

  @override
  Component build(BuildContext context) {
    return div(classes: 'carousel', [
      div(
        key: _sliderKey,
        classes: 'carousel-slider',
        events: {'scroll': (_) => _onScroll()},
        [component.items],
      ),
      div(classes: 'carousel-progress container', [
        div(classes: 'carousel-track', [
          div(
            classes: 'carousel-completed',
            styles: Styles(width: _progress.percent),
            const [],
          ),
        ]),
        div(classes: 'carousel-nav', [
          a(
            href: '#',
            classes: _prevDisabled ? 'disabled' : null,
            events: {
              'click': (e) {
                e.preventDefault();
                if (!_prevDisabled) {
                  _navigate(false);
                }
              },
            },
            [
              component.prevBtn ??
                  const Icon(
                    symbol: 'arrow_circle_left',
                    size: .lg,
                  ),
            ],
          ),
          a(
            href: '#',
            classes: _nextDisabled ? 'disabled' : null,
            events: {
              'click': (e) {
                e.preventDefault();
                if (!_nextDisabled) {
                  _navigate(true);
                }
              },
            },
            [
              component.nextBtn ??
                  const Icon(
                    symbol: 'arrow_circle_right',
                    size: .lg,
                  ),
            ],
          ),
        ]),
      ]),
    ]);
  }
}
