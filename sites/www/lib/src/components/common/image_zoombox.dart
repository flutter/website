// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';
import 'package:site_shared/util.dart';
import 'package:universal_web/web.dart' as web;

const Set<String> _preservedImageClasses = {
  'diagram-wrap',
  'small-diagram-wrap',
};

const web.EventStreamProvider<web.Event> _dialogCloseEvent =
    web.EventStreamProvider<web.Event>('close');

/// Builds the accessible label for an expandable image trigger.
String buildZoomboxTriggerLabel({required String alt, String? caption}) {
  final description = _firstNonEmpty(alt, caption);
  return description == null ? 'Expand image' : 'Expand image: $description';
}

/// Builds the accessible label for the expanded image dialog.
String buildZoomboxDialogLabel({required String alt, String? caption}) {
  final description = _firstNonEmpty(alt, caption);
  return description == null
      ? 'Expanded image'
      : 'Expanded image: $description';
}

/// Computes the clamped scroll offset along one axis so that the clicked point
/// on an image stays centered when expanded to full size.
double computeZoomScrollOffset({
  required double clickRatio,
  required double imageOffset,
  required double imageSize,
  required double viewportSize,
  required double scrollSize,
}) {
  final maxScroll = scrollSize - viewportSize;
  if (maxScroll <= 0) return 0;

  final clampedRatio = clickRatio.clamp(0.0, 1.0);
  final targetPoint = imageOffset + clampedRatio * imageSize;
  final desired = targetPoint - viewportSize / 2;
  return desired.clamp(0.0, maxScroll);
}

/// Extracts diagram background wrapper classes to preserve inside the zoombox.
List<String> extractDiagramWrapClasses(Iterable<String> classes) => [
  for (final className in classes)
    if (_preservedImageClasses.contains(className)) className,
];

String? _firstNonEmpty(String primary, String? fallback) {
  final trimmedPrimary = primary.trim();
  if (trimmedPrimary.isNotEmpty) return trimmedPrimary;
  final trimmedFallback = fallback?.trim();
  if (trimmedFallback != null && trimmedFallback.isNotEmpty) {
    return trimmedFallback;
  }
  return null;
}

final class _ZoomboxImage {
  const _ZoomboxImage({
    required this.src,
    required this.alt,
    required this.caption,
    required this.extraClasses,
  });

  final String src;
  final String alt;
  final String? caption;
  final List<String> extraClasses;
}

/// A modal zoombox that expands blog post images to full size
/// when clicked or activated via keyboard.
///
/// Renders a native `<dialog>` element and progressively enhances eligible
/// `<img>` descendants of `.post-content` on the client, excluding images
/// inside links, buttons, author metadata, or related-post cards.
@client
final class ImageZoombox extends StatelessComponent {
  /// Creates an image zoombox for blog post content.
  const ImageZoombox({super.key});

  @override
  Component build(BuildContext _) => const Component.element(
    // Keep `<dialog>` outside the stateful child so Jaspr attribute diffing
    // doesn't strip the native `open` attribute managed by `showModal()`.
    tag: 'dialog',
    classes: 'image-zoombox',
    attributes: {'aria-label': 'Expanded image'},
    children: [
      _ImageZoomboxBody(),
    ],
  );
}

final class _ImageZoomboxBody extends StatefulComponent {
  const _ImageZoomboxBody();

  @override
  State<_ImageZoomboxBody> createState() => _ImageZoomboxBodyState();
}

final class _ImageZoomboxBodyState extends State<_ImageZoomboxBody> {
  static const String _containerSelector = '.post-content';
  static const String _triggerAttribute = 'data-zoombox-trigger';
  static const String _excludedAncestorsSelector =
      '.post-info, .blog-next-posts, .blog-card, '
      'a, button, lite-youtube, .image-zoombox, [data-no-zoombox]';
  static const String _interactiveZoomboxSelector =
      '.image-zoombox-toolbar, .image-zoombox-img, .image-zoombox-caption';
  static const double _dragThresholdPx = 4;

  final GlobalNodeKey<web.HTMLElement> _bodyKey = GlobalNodeKey();
  final GlobalNodeKey<web.HTMLElement> _stageKey = GlobalNodeKey();
  final GlobalNodeKey<web.HTMLImageElement> _imageKey = GlobalNodeKey();
  final GlobalNodeKey<web.HTMLButtonElement> _closeButtonKey = GlobalNodeKey();

  web.HTMLDialogElement? _dialog;
  _ZoomboxImage? _activeImage;
  bool _isDragging = false;
  (double, double)? _pendingScrollRatio;

  web.HTMLElement? _triggerElement;
  bool _isPointerDown = false;
  bool _didDrag = false;
  bool _suppressNextClick = false;
  double _dragStartX = 0;
  double _dragStartY = 0;
  double _dragStartScrollLeft = 0;
  double _dragStartScrollTop = 0;
  Timer? _suppressClickResetTimer;

  StreamSubscription<web.MouseEvent>? _containerClickSub;
  StreamSubscription<web.KeyboardEvent>? _containerKeyDownSub;
  StreamSubscription<web.MouseEvent>? _dialogClickSub;
  StreamSubscription<web.Event>? _dialogCloseSub;
  StreamSubscription<web.MouseEvent>? _windowMouseMoveSub;
  StreamSubscription<web.MouseEvent>? _windowMouseUpSub;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      context.binding.addPostFrameCallback(_attach);
    }
  }

  @override
  void dispose() {
    unawaited(_containerClickSub?.cancel());
    unawaited(_containerKeyDownSub?.cancel());
    unawaited(_dialogClickSub?.cancel());
    unawaited(_dialogCloseSub?.cancel());
    unawaited(_windowMouseMoveSub?.cancel());
    unawaited(_windowMouseUpSub?.cancel());
    _suppressClickResetTimer?.cancel();
    super.dispose();
  }

  void _attach() {
    if (!mounted) return;
    final dialog =
        _bodyKey.currentNode?.closest('dialog') as web.HTMLDialogElement?;
    if (dialog != null) {
      _dialog = dialog;
      _dialogClickSub = web.EventStreamProviders.clickEvent
          .forTarget(dialog)
          .listen(_onDialogClick);
      _dialogCloseSub = _dialogCloseEvent
          .forTarget(dialog)
          .listen(_onDialogClose);
    }

    final container = web.document.querySelector(_containerSelector);
    if (container == null) return;

    final images = container.querySelectorAll('img');
    for (var i = 0; i < images.length; i += 1) {
      final image = images.item(i) as web.HTMLImageElement;
      if (image.closest(_excludedAncestorsSelector) != null) continue;

      image.setAttribute(_triggerAttribute, '');
      if (!image.hasAttribute('tabindex')) {
        image.setAttribute('tabindex', '0');
      }
      image.setAttribute('role', 'button');
      image.setAttribute('aria-haspopup', 'dialog');
      if (!image.hasAttribute('aria-label')) {
        image.setAttribute(
          'aria-label',
          buildZoomboxTriggerLabel(
            alt: image.alt,
            caption: _captionForImage(image),
          ),
        );
      }
    }

    _containerClickSub = web.EventStreamProviders.clickEvent
        .forTarget(container)
        .listen(_onContainerClick);
    _containerKeyDownSub = web.EventStreamProviders.keyDownEvent
        .forTarget(container)
        .listen(_onContainerKeyDown);
  }

  String? _captionForImage(web.HTMLImageElement image) {
    final captionText = image
        .closest('figure')
        ?.querySelector('figcaption')
        ?.textContent
        ?.trim();
    if (captionText == null || captionText.isEmpty) return null;
    return captionText;
  }

  web.HTMLImageElement? _findTrigger(web.EventTarget? target) {
    final node = target as web.Node?;
    if (node == null || node.nodeType != web.Node.ELEMENT_NODE) {
      return null;
    }
    final element = (node as web.Element).closest('img[$_triggerAttribute]');
    return element as web.HTMLImageElement?;
  }

  void _onContainerClick(web.MouseEvent event) {
    if (event.button != 0 ||
        event.metaKey ||
        event.ctrlKey ||
        event.shiftKey ||
        event.altKey) {
      return;
    }
    final trigger = _findTrigger(event.target);
    if (trigger == null) return;

    var clickRatioX = 0.5;
    var clickRatioY = 0.0;
    final rect = trigger.getBoundingClientRect();
    if (rect.width > 0 && rect.height > 0) {
      clickRatioX = (event.clientX - rect.left) / rect.width;
      clickRatioY = (event.clientY - rect.top) / rect.height;
    }
    _open(trigger, clickRatioX: clickRatioX, clickRatioY: clickRatioY);
  }

  void _onContainerKeyDown(web.KeyboardEvent event) {
    if (event.key != 'Enter' && event.key != ' ') return;
    final trigger = _findTrigger(event.target);
    if (trigger == null) return;
    event.preventDefault();
    _open(trigger);
  }

  void _open(
    web.HTMLImageElement sourceImage, {
    double clickRatioX = 0.5,
    double clickRatioY = 0.0,
  }) {
    final src = sourceImage.currentSrc.isNotEmpty
        ? sourceImage.currentSrc
        : sourceImage.src;
    if (src.isEmpty) return;
    if (sourceImage.complete && sourceImage.naturalWidth == 0) return;

    final extraClasses = extractDiagramWrapClasses([
      for (var i = 0; i < sourceImage.classList.length; i += 1)
        ?sourceImage.classList.item(i),
    ]);
    final caption = _captionForImage(sourceImage);

    _dialog?.setAttribute(
      'aria-label',
      buildZoomboxDialogLabel(alt: sourceImage.alt, caption: caption),
    );
    _triggerElement = sourceImage;
    _pendingScrollRatio = (clickRatioX, clickRatioY);
    setState(() {
      _activeImage = _ZoomboxImage(
        src: src,
        alt: sourceImage.alt,
        caption: caption,
        extraClasses: extraClasses,
      );
      _isDragging = false;
    });

    context.binding.addPostFrameCallback(() {
      if (!mounted || _activeImage == null) return;
      final dialog = _dialog;
      if (dialog != null && !dialog.open) {
        dialog.showModal();
        _closeButtonKey.currentNode?.focus(
          web.FocusOptions(preventScroll: true),
        );
      }
      _applyPendingScroll();
    });
  }

  void _applyPendingScroll() {
    final pendingRatio = _pendingScrollRatio;
    final dialog = _dialog;
    final stage = _stageKey.currentNode;
    final image = _imageKey.currentNode;
    if (pendingRatio == null ||
        dialog == null ||
        !dialog.open ||
        stage == null ||
        image == null ||
        !image.complete ||
        image.naturalWidth == 0) {
      return;
    }

    _pendingScrollRatio = null;
    final (clickRatioX, clickRatioY) = pendingRatio;
    final targetLeft = computeZoomScrollOffset(
      clickRatio: clickRatioX,
      imageOffset: image.offsetLeft.toDouble(),
      imageSize: image.offsetWidth.toDouble(),
      viewportSize: stage.clientWidth.toDouble(),
      scrollSize: stage.scrollWidth.toDouble(),
    );
    final targetTop = computeZoomScrollOffset(
      clickRatio: clickRatioY,
      imageOffset: image.offsetTop.toDouble(),
      imageSize: image.offsetHeight.toDouble(),
      viewportSize: stage.clientHeight.toDouble(),
      scrollSize: stage.scrollHeight.toDouble(),
    );
    stage.scrollTo(web.ScrollToOptions(left: targetLeft, top: targetTop));
  }

  void _close() {
    final dialog = _dialog;
    if (dialog != null && dialog.open) {
      dialog.close();
    } else {
      _resetAfterClose();
    }
  }

  void _onDialogClose(web.Event _) {
    _resetAfterClose();
  }

  void _resetAfterClose() {
    _endDrag();
    _suppressClickResetTimer?.cancel();
    _suppressClickResetTimer = null;
    _suppressNextClick = false;
    _pendingScrollRatio = null;

    _dialog?.setAttribute('aria-label', 'Expanded image');

    final trigger = _triggerElement;
    _triggerElement = null;

    if (_activeImage != null) {
      setState(() {
        _activeImage = null;
      });
    }

    trigger?.focus(web.FocusOptions(preventScroll: true));
  }

  void _onDialogClick(web.MouseEvent event) {
    if (_suppressNextClick) {
      _suppressNextClick = false;
      return;
    }

    final targetNode = event.target as web.Node?;
    if (targetNode == null) return;
    final targetElement = targetNode.nodeType == web.Node.ELEMENT_NODE
        ? targetNode as web.Element
        : targetNode.parentElement;
    if (targetElement == null) return;
    if (targetElement.closest(_interactiveZoomboxSelector) != null) {
      return;
    }

    // Ignore clicks on the stage's native scrollbars.
    if (_stageKey.currentNode case final stage?) {
      final rect = stage.getBoundingClientRect();
      if (event.clientX >= rect.left + stage.clientWidth ||
          event.clientY >= rect.top + stage.clientHeight) {
        return;
      }
    }

    _close();
  }

  void _onImageClick(web.Event _) {
    if (_suppressNextClick) {
      _suppressNextClick = false;
      return;
    }
    _close();
  }

  void _onImageMouseDown(web.Event event) {
    final mouseEvent = event as web.MouseEvent;
    if (mouseEvent.button != 0) return;
    final stage = _stageKey.currentNode;
    if (stage == null) return;

    // Only enable drag-to-pan when the full-size image overflows the stage.
    if (stage.scrollWidth <= stage.clientWidth &&
        stage.scrollHeight <= stage.clientHeight) {
      return;
    }

    mouseEvent.preventDefault();
    _isPointerDown = true;
    _didDrag = false;
    _dragStartX = mouseEvent.clientX.toDouble();
    _dragStartY = mouseEvent.clientY.toDouble();
    _dragStartScrollLeft = stage.scrollLeft.toDouble();
    _dragStartScrollTop = stage.scrollTop.toDouble();

    _windowMouseMoveSub ??= web.EventStreamProviders.mouseMoveEvent
        .forTarget(web.window)
        .listen(_onWindowMouseMove);
    _windowMouseUpSub ??= web.EventStreamProviders.mouseUpEvent
        .forTarget(web.window)
        .listen((_) => _onWindowMouseUp());
  }

  void _onWindowMouseMove(web.MouseEvent event) {
    if (!_isPointerDown) return;
    final stage = _stageKey.currentNode;
    if (stage == null) return;

    final dx = event.clientX.toDouble() - _dragStartX;
    final dy = event.clientY.toDouble() - _dragStartY;

    if (!_didDrag &&
        (dx.abs() > _dragThresholdPx || dy.abs() > _dragThresholdPx)) {
      _didDrag = true;
      if (!_isDragging) {
        setState(() {
          _isDragging = true;
        });
      }
    }

    if (_didDrag) {
      stage.scrollLeft = _dragStartScrollLeft - dx;
      stage.scrollTop = _dragStartScrollTop - dy;
    }
  }

  void _onWindowMouseUp() {
    if (!_isPointerDown) return;
    final didDrag = _didDrag;
    _endDrag();
    if (didDrag) {
      _suppressNextClick = true;
      _suppressClickResetTimer?.cancel();
      _suppressClickResetTimer = Timer(Duration.zero, () {
        _suppressNextClick = false;
      });
    }
  }

  void _endDrag() {
    _isPointerDown = false;
    _didDrag = false;
    unawaited(_windowMouseMoveSub?.cancel());
    _windowMouseMoveSub = null;
    unawaited(_windowMouseUpSub?.cancel());
    _windowMouseUpSub = null;
    if (_isDragging && mounted) {
      setState(() {
        _isDragging = false;
      });
    }
  }

  @override
  Component build(BuildContext _) {
    final activeImage = _activeImage;

    return div(
      key: _bodyKey,
      classes: [
        'image-zoombox-body',
        if (_isDragging) 'dragging',
      ].toClasses,
      [
        if (activeImage != null) ...[
          _ZoomboxToolbar(
            closeButtonKey: _closeButtonKey,
            onClose: _close,
          ),
          div(
            key: _stageKey,
            classes: 'image-zoombox-stage',
            [
              _ZoomboxFigure(
                image: activeImage,
                imageKey: _imageKey,
                onImageLoad: _applyPendingScroll,
                onImageClick: _onImageClick,
                onImageMouseDown: _onImageMouseDown,
              ),
            ],
          ),
        ],
      ],
    );
  }
}

final class _ZoomboxToolbar extends StatelessComponent {
  const _ZoomboxToolbar({
    required this.closeButtonKey,
    required this.onClose,
  });

  final GlobalNodeKey<web.HTMLButtonElement> closeButtonKey;
  final void Function() onClose;

  @override
  Component build(BuildContext _) => div(classes: 'image-zoombox-toolbar', [
    button(
      key: closeButtonKey,
      type: .button,
      classes: 'image-zoombox-button',
      attributes: const {
        'aria-label': 'Close expanded image',
        'title': 'Close (Esc)',
      },
      onClick: onClose,
      const [MaterialIcon('close')],
    ),
  ]);
}

final class _ZoomboxFigure extends StatelessComponent {
  const _ZoomboxFigure({
    required this.image,
    required this.imageKey,
    required this.onImageLoad,
    required this.onImageClick,
    required this.onImageMouseDown,
  });

  final _ZoomboxImage image;
  final GlobalNodeKey<web.HTMLImageElement> imageKey;
  final void Function() onImageLoad;
  final void Function(web.Event) onImageClick;
  final void Function(web.Event) onImageMouseDown;

  @override
  Component build(BuildContext _) {
    final caption = image.caption;

    return figure(
      classes: 'image-zoombox-figure',
      [
        img(
          key: imageKey,
          src: image.src,
          alt: image.alt,
          classes: [
            'image-zoombox-img',
            ...image.extraClasses,
          ].toClasses,
          attributes: const {'draggable': 'false'},
          events: {
            'load': (_) => onImageLoad(),
            'click': onImageClick,
            'mousedown': onImageMouseDown,
          },
        ),
        if (caption != null)
          figcaption(classes: 'image-zoombox-caption', [.text(caption)]),
      ],
    );
  }
}
