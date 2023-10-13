```nocode
I/flutter ( 6559): RenderView
I/flutter ( 6559):  │ debug mode enabled - android
I/flutter ( 6559):  │ window size: Size(1080.0, 1794.0) (in physical pixels)
I/flutter ( 6559):  │ device pixel ratio: 2.625 (physical pixels per logical pixel)
I/flutter ( 6559):  │ configuration: Size(411.4, 683.4) at 2.625x (in logical pixels)
I/flutter ( 6559):  │
I/flutter ( 6559):  └─child: RenderCustomPaint
I/flutter ( 6559):    │ creator: CustomPaint ← Banner ← CheckedModeBanner ←
I/flutter ( 6559):    │   WidgetsApp-[GlobalObjectKey _MaterialAppState(1009803148)] ←
I/flutter ( 6559):    │   Theme ← AnimatedTheme ← ScrollConfiguration ← MaterialApp ←
I/flutter ( 6559):    │   [root]
I/flutter ( 6559):    │ parentData: <none>
I/flutter ( 6559):    │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):    │ size: Size(411.4, 683.4)
I/flutter ( 6559):    │
I/flutter ( 6559):    └─child: RenderPointerListener
I/flutter ( 6559):      │ creator: Listener ← Navigator-[GlobalObjectKey<NavigatorState>
I/flutter ( 6559):      │   _WidgetsAppState(552902158)] ← Title ← LocaleQuery ← MediaQuery
I/flutter ( 6559):      │   ← DefaultTextStyle ← CustomPaint ← Banner ← CheckedModeBanner ←
I/flutter ( 6559):      │   WidgetsApp-[GlobalObjectKey _MaterialAppState(1009803148)] ←
I/flutter ( 6559):      │   Theme ← AnimatedTheme ← ⋯
I/flutter ( 6559):      │ parentData: <none>
I/flutter ( 6559):      │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):      │ size: Size(411.4, 683.4)
I/flutter ( 6559):      │ behavior: defer-to-child
I/flutter ( 6559):      │ listeners: down, up, cancel
I/flutter ( 6559):      │
I/flutter ( 6559):      └─child: RenderAbsorbPointer
I/flutter ( 6559):        │ creator: AbsorbPointer ← Listener ←
I/flutter ( 6559):        │   Navigator-[GlobalObjectKey<NavigatorState>
I/flutter ( 6559):        │   _WidgetsAppState(552902158)] ← Title ← LocaleQuery ← MediaQuery
I/flutter ( 6559):        │   ← DefaultTextStyle ← CustomPaint ← Banner ← CheckedModeBanner ←
I/flutter ( 6559):        │   WidgetsApp-[GlobalObjectKey _MaterialAppState(1009803148)] ←
I/flutter ( 6559):        │   Theme ← ⋯
I/flutter ( 6559):        │ parentData: <none>
I/flutter ( 6559):        │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):        │ size: Size(411.4, 683.4)
I/flutter ( 6559):        │ absorbing: false
I/flutter ( 6559):        │
I/flutter ( 6559):        └─child: RenderSemanticsAnnotations
I/flutter ( 6559):          │ creator: Semantics ← Focus-[GlobalKey 489139594] ← AbsorbPointer
I/flutter ( 6559):          │   ← Listener ← Navigator-[GlobalObjectKey<NavigatorState>
I/flutter ( 6559):          │   _WidgetsAppState(552902158)] ← Title ← LocaleQuery ← MediaQuery
I/flutter ( 6559):          │   ← DefaultTextStyle ← CustomPaint ← Banner ← CheckedModeBanner ←
I/flutter ( 6559):          │   ⋯
I/flutter ( 6559):          │ parentData: <none>
I/flutter ( 6559):          │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):          │ size: Size(411.4, 683.4)
I/flutter ( 6559):          │
I/flutter ( 6559):          └─child: _RenderTheatre
I/flutter ( 6559):            │ creator: _Theatre ← Overlay-[GlobalKey 199833992] ← _FocusScope ←
I/flutter ( 6559):            │   Semantics ← Focus-[GlobalKey 489139594] ← AbsorbPointer ←
I/flutter ( 6559):            │   Listener ← Navigator-[GlobalObjectKey<NavigatorState>
I/flutter ( 6559):            │   _WidgetsAppState(552902158)] ← Title ← LocaleQuery ← MediaQuery
I/flutter ( 6559):            │   ← DefaultTextStyle ← ⋯
I/flutter ( 6559):            │ parentData: <none>
I/flutter ( 6559):            │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            │ size: Size(411.4, 683.4)
I/flutter ( 6559):            │
I/flutter ( 6559):            ├─onstage: RenderStack
I/flutter ( 6559):            ╎ │ creator: Stack ← _Theatre ← Overlay-[GlobalKey 199833992] ←
I/flutter ( 6559):            ╎ │   _FocusScope ← Semantics ← Focus-[GlobalKey 489139594] ←
I/flutter ( 6559):            ╎ │   AbsorbPointer ← Listener ←
I/flutter ( 6559):            ╎ │   Navigator-[GlobalObjectKey<NavigatorState>
I/flutter ( 6559):            ╎ │   _WidgetsAppState(552902158)] ← Title ← LocaleQuery ← MediaQuery
I/flutter ( 6559):            ╎ │   ← ⋯
I/flutter ( 6559):            ╎ │ parentData: not positioned; offset=Offset(0.0, 0.0)
I/flutter ( 6559):            ╎ │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎ │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎ │
I/flutter ( 6559):            ╎ ├─child 1: RenderIgnorePointer
I/flutter ( 6559):            ╎ │ │ creator: IgnorePointer ← _OverlayEntry-[GlobalKey 612888877] ←
I/flutter ( 6559):            ╎ │ │   Stack ← _Theatre ← Overlay-[GlobalKey 199833992] ← _FocusScope
I/flutter ( 6559):            ╎ │ │   ← Semantics ← Focus-[GlobalKey 489139594] ← AbsorbPointer ←
I/flutter ( 6559):            ╎ │ │   Listener ← Navigator-[GlobalObjectKey<NavigatorState>
I/flutter ( 6559):            ╎ │ │   _WidgetsAppState(552902158)] ← Title ← ⋯
I/flutter ( 6559):            ╎ │ │ parentData: not positioned; offset=Offset(0.0, 0.0)
I/flutter ( 6559):            ╎ │ │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎ │ │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎ │ │ ignoring: false
I/flutter ( 6559):            ╎ │ │ ignoringSemantics: implicitly false
I/flutter ( 6559):            ╎ │ │
I/flutter ( 6559):            ╎ │ └─child: RenderSemanticsAnnotations
I/flutter ( 6559):            ╎ │   │ creator: Semantics ← ModalBarrier ← IgnorePointer ←
I/flutter ( 6559):            ╎ │   │   _OverlayEntry-[GlobalKey 612888877] ← Stack ← _Theatre ←
I/flutter ( 6559):            ╎ │   │   Overlay-[GlobalKey 199833992] ← _FocusScope ← Semantics ←
I/flutter ( 6559):            ╎ │   │   Focus-[GlobalKey 489139594] ← AbsorbPointer ← Listener ← ⋯
I/flutter ( 6559):            ╎ │   │ parentData: <none>
I/flutter ( 6559):            ╎ │   │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎ │   │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎ │   │
I/flutter ( 6559):            ╎ │   └─child: RenderSemanticsGestureHandler
I/flutter ( 6559):            ╎ │     │ creator: _GestureSemantics ← RawGestureDetector ← GestureDetector
I/flutter ( 6559):            ╎ │     │   ← Semantics ← ModalBarrier ← IgnorePointer ←
I/flutter ( 6559):            ╎ │     │   _OverlayEntry-[GlobalKey 612888877] ← Stack ← _Theatre ←
I/flutter ( 6559):            ╎ │     │   Overlay-[GlobalKey 199833992] ← _FocusScope ← Semantics ← ⋯
I/flutter ( 6559):            ╎ │     │ parentData: <none>
I/flutter ( 6559):            ╎ │     │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎ │     │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎ │     │
I/flutter ( 6559):            ╎ │     └─child: RenderPointerListener
I/flutter ( 6559):            ╎ │       │ creator: Listener ← _GestureSemantics ← RawGestureDetector ←
I/flutter ( 6559):            ╎ │       │   GestureDetector ← Semantics ← ModalBarrier ← IgnorePointer ←
I/flutter ( 6559):            ╎ │       │   _OverlayEntry-[GlobalKey 612888877] ← Stack ← _Theatre ←
I/flutter ( 6559):            ╎ │       │   Overlay-[GlobalKey 199833992] ← _FocusScope ← ⋯
I/flutter ( 6559):            ╎ │       │ parentData: <none>
I/flutter ( 6559):            ╎ │       │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎ │       │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎ │       │ behavior: opaque
I/flutter ( 6559):            ╎ │       │ listeners: down
I/flutter ( 6559):            ╎ │       │
I/flutter ( 6559):            ╎ │       └─child: RenderConstrainedBox
I/flutter ( 6559):            ╎ │           creator: ConstrainedBox ← Listener ← _GestureSemantics ←
I/flutter ( 6559):            ╎ │             RawGestureDetector ← GestureDetector ← Semantics ← ModalBarrier
I/flutter ( 6559):            ╎ │             ← IgnorePointer ← _OverlayEntry-[GlobalKey 612888877] ← Stack ←
I/flutter ( 6559):            ╎ │             _Theatre ← Overlay-[GlobalKey 199833992] ← ⋯
I/flutter ( 6559):            ╎ │           parentData: <none>
I/flutter ( 6559):            ╎ │           constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎ │           size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎ │           additionalConstraints: BoxConstraints(biggest)
I/flutter ( 6559):            ╎ │
I/flutter ( 6559):            ╎ └─child 2: RenderSemanticsAnnotations
I/flutter ( 6559):            ╎   │ creator: Semantics ← Focus-[GlobalObjectKey
I/flutter ( 6559):            ╎   │   MaterialPageRoute<void>(875520219)] ← _ModalScope-[GlobalKey
I/flutter ( 6559):            ╎   │   816151164] ← _OverlayEntry-[GlobalKey 727622716] ← Stack ←
I/flutter ( 6559):            ╎   │   _Theatre ← Overlay-[GlobalKey 199833992] ← _FocusScope ←
I/flutter ( 6559):            ╎   │   Semantics ← Focus-[GlobalKey 489139594] ← AbsorbPointer ←
I/flutter ( 6559):            ╎   │   Listener ← ⋯
I/flutter ( 6559):            ╎   │ parentData: not positioned; offset=Offset(0.0, 0.0)
I/flutter ( 6559):            ╎   │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎   │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎   │
I/flutter ( 6559):            ╎   └─child: RenderOffstage
I/flutter ( 6559):            ╎     │ creator: Offstage ← _FocusScope ← Semantics ←
I/flutter ( 6559):            ╎     │   Focus-[GlobalObjectKey MaterialPageRoute<void>(875520219)] ←
I/flutter ( 6559):            ╎     │   _ModalScope-[GlobalKey 816151164] ← _OverlayEntry-[GlobalKey
I/flutter ( 6559):            ╎     │   727622716] ← Stack ← _Theatre ← Overlay-[GlobalKey 199833992] ←
I/flutter ( 6559):            ╎     │   _FocusScope ← Semantics ← Focus-[GlobalKey 489139594] ← ⋯
I/flutter ( 6559):            ╎     │ parentData: <none>
I/flutter ( 6559):            ╎     │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎     │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎     │ offstage: false
I/flutter ( 6559):            ╎     │
I/flutter ( 6559):            ╎     └─child: RenderIgnorePointer
I/flutter ( 6559):            ╎       │ creator: IgnorePointer ← Offstage ← _FocusScope ← Semantics ←
I/flutter ( 6559):            ╎       │   Focus-[GlobalObjectKey MaterialPageRoute<void>(875520219)] ←
I/flutter ( 6559):            ╎       │   _ModalScope-[GlobalKey 816151164] ← _OverlayEntry-[GlobalKey
I/flutter ( 6559):            ╎       │   727622716] ← Stack ← _Theatre ← Overlay-[GlobalKey 199833992] ←
I/flutter ( 6559):            ╎       │   _FocusScope ← Semantics ← ⋯
I/flutter ( 6559):            ╎       │ parentData: <none>
I/flutter ( 6559):            ╎       │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎       │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎       │ ignoring: false
I/flutter ( 6559):            ╎       │ ignoringSemantics: implicitly false
I/flutter ( 6559):            ╎       │
I/flutter ( 6559):            ╎       └─child: RenderFractionalTranslation
I/flutter ( 6559):            ╎         │ creator: FractionalTranslation ← SlideTransition ←
I/flutter ( 6559):            ╎         │   _MountainViewPageTransition ← IgnorePointer ← Offstage ←
I/flutter ( 6559):            ╎         │   _FocusScope ← Semantics ← Focus-[GlobalObjectKey
I/flutter ( 6559):            ╎         │   MaterialPageRoute<void>(875520219)] ← _ModalScope-[GlobalKey
I/flutter ( 6559):            ╎         │   816151164] ← _OverlayEntry-[GlobalKey 727622716] ← Stack ←
I/flutter ( 6559):            ╎         │   _Theatre ← ⋯
I/flutter ( 6559):            ╎         │ parentData: <none>
I/flutter ( 6559):            ╎         │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎         │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎         │ translation: Offset(0.0, 0.0)
I/flutter ( 6559):            ╎         │ transformHitTests: true
I/flutter ( 6559):            ╎         │
I/flutter ( 6559):            ╎         └─child: RenderRepaintBoundary
I/flutter ( 6559):            ╎           │ creator: RepaintBoundary ← FractionalTranslation ←
I/flutter ( 6559):            ╎           │   SlideTransition ← _MountainViewPageTransition ← IgnorePointer ←
I/flutter ( 6559):            ╎           │   Offstage ← _FocusScope ← Semantics ← Focus-[GlobalObjectKey
I/flutter ( 6559):            ╎           │   MaterialPageRoute<void>(875520219)] ← _ModalScope-[GlobalKey
I/flutter ( 6559):            ╎           │   816151164] ← _OverlayEntry-[GlobalKey 727622716] ← Stack ← ⋯
I/flutter ( 6559):            ╎           │ parentData: <none>
I/flutter ( 6559):            ╎           │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎           │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎           │ metrics: 83.3% useful (1 bad vs 5 good)
I/flutter ( 6559):            ╎           │ diagnosis: this is a useful repaint boundary and should be kept
I/flutter ( 6559):            ╎           │
I/flutter ( 6559):            ╎           └─child: RenderDecoratedBox
I/flutter ( 6559):            ╎             │ creator: DecoratedBox ← Container ← AnimatedContainer ← Material
I/flutter ( 6559):            ╎             │   ← AppHome ← _ModalScopeStatus ← PageStorage-[GlobalKey
I/flutter ( 6559):            ╎             │   619728754] ← RepaintBoundary ← FractionalTranslation ←
I/flutter ( 6559):            ╎             │   SlideTransition ← _MountainViewPageTransition ← IgnorePointer ←
I/flutter ( 6559):            ╎             │   ⋯
I/flutter ( 6559):            ╎             │ parentData: <none>
I/flutter ( 6559):            ╎             │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎             │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎             │ decoration:
I/flutter ( 6559):            ╎             │   <no decorations specified>
I/flutter ( 6559):            ╎             │ configuration: ImageConfiguration(bundle:
I/flutter ( 6559):            ╎             │   PlatformAssetBundle@367106502(), devicePixelRatio: 2.625,
I/flutter ( 6559):            ╎             │   platform: android)
I/flutter ( 6559):            ╎             │
I/flutter ( 6559):            ╎             └─child: RenderDecoratedBox
I/flutter ( 6559):            ╎               │ creator: DecoratedBox ← Container ← DecoratedBox ← Container ←
I/flutter ( 6559):            ╎               │   AnimatedContainer ← Material ← AppHome ← _ModalScopeStatus ←
I/flutter ( 6559):            ╎               │   PageStorage-[GlobalKey 619728754] ← RepaintBoundary ←
I/flutter ( 6559):            ╎               │   FractionalTranslation ← SlideTransition ← ⋯
I/flutter ( 6559):            ╎               │ parentData: <none>
I/flutter ( 6559):            ╎               │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎               │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎               │ decoration:
I/flutter ( 6559):            ╎               │   backgroundColor: Color(0xfffafafa)
I/flutter ( 6559):            ╎               │ configuration: ImageConfiguration(bundle:
I/flutter ( 6559):            ╎               │   PlatformAssetBundle@367106502(), devicePixelRatio: 2.625,
I/flutter ( 6559):            ╎               │   platform: android)
I/flutter ( 6559):            ╎               │
I/flutter ( 6559):            ╎               └─child: _RenderInkFeatures
I/flutter ( 6559):            ╎                 │ creator: _InkFeatures-[GlobalKey ink renderer] ←
I/flutter ( 6559):            ╎                 │   NotificationListener<LayoutChangedNotification> ← DecoratedBox
I/flutter ( 6559):            ╎                 │   ← Container ← DecoratedBox ← Container ← AnimatedContainer ←
I/flutter ( 6559):            ╎                 │   Material ← AppHome ← _ModalScopeStatus ← PageStorage-[GlobalKey
I/flutter ( 6559):            ╎                 │   619728754] ← RepaintBoundary ← ⋯
I/flutter ( 6559):            ╎                 │ parentData: <none>
I/flutter ( 6559):            ╎                 │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎                 │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎                 │
I/flutter ( 6559):            ╎                 └─child: RenderPositionedBox
I/flutter ( 6559):            ╎                   │ creator: Center ← DefaultTextStyle ← AnimatedDefaultTextStyle ←
I/flutter ( 6559):            ╎                   │   _InkFeatures-[GlobalKey ink renderer] ←
I/flutter ( 6559):            ╎                   │   NotificationListener<LayoutChangedNotification> ← DecoratedBox
I/flutter ( 6559):            ╎                   │   ← Container ← DecoratedBox ← Container ← AnimatedContainer ←
I/flutter ( 6559):            ╎                   │   Material ← AppHome ← ⋯
I/flutter ( 6559):            ╎                   │ parentData: <none>
I/flutter ( 6559):            ╎                   │ constraints: BoxConstraints(w=411.4, h=683.4)
I/flutter ( 6559):            ╎                   │ size: Size(411.4, 683.4)
I/flutter ( 6559):            ╎                   │ alignment: Alignment.center
I/flutter ( 6559):            ╎                   │ widthFactor: expand
I/flutter ( 6559):            ╎                   │ heightFactor: expand
I/flutter ( 6559):            ╎                   │
I/flutter ( 6559):            ╎                   └─child: RenderConstrainedBox relayoutBoundary=up1
I/flutter ( 6559):            ╎                     │ creator: ConstrainedBox ← MaterialButton ← TextButton ← Center ←
I/flutter ( 6559):            ╎                     │   DefaultTextStyle ← AnimatedDefaultTextStyle ←
I/flutter ( 6559):            ╎                     │   _InkFeatures-[GlobalKey ink renderer] ←
I/flutter ( 6559):            ╎                     │   NotificationListener<LayoutChangedNotification> ← DecoratedBox
I/flutter ( 6559):            ╎                     │   ← Container ← DecoratedBox ← Container ← ⋯
I/flutter ( 6559):            ╎                     │ parentData: offset=Offset(156.7, 323.7)
I/flutter ( 6559):            ╎                     │ constraints: BoxConstraints(0.0<=w<=411.4, 0.0<=h<=683.4)
I/flutter ( 6559):            ╎                     │ size: Size(98.0, 36.0)
I/flutter ( 6559):            ╎                     │ additionalConstraints: BoxConstraints(88.0<=w<=Infinity, h=36.0)
I/flutter ( 6559):            ╎                     │
I/flutter ( 6559):            ╎                     └─child: RenderSemanticsGestureHandler relayoutBoundary=up2
I/flutter ( 6559):            ╎                       │ creator: _GestureSemantics ← RawGestureDetector ← GestureDetector
I/flutter ( 6559):            ╎                       │   ← InkWell ← IconTheme ← DefaultTextStyle ←
I/flutter ( 6559):            ╎                       │   AnimatedDefaultTextStyle ← ConstrainedBox ← MaterialButton ←
I/flutter ( 6559):            ╎                       │   TextButton ← Center ← DefaultTextStyle ← ⋯
I/flutter ( 6559):            ╎                       │ parentData: <none>
I/flutter ( 6559):            ╎                       │ constraints: BoxConstraints(88.0<=w<=411.4, h=36.0)
I/flutter ( 6559):            ╎                       │ size: Size(98.0, 36.0)
I/flutter ( 6559):            ╎                       │
I/flutter ( 6559):            ╎                       └─child: RenderPointerListener relayoutBoundary=up3
I/flutter ( 6559):            ╎                         │ creator: Listener ← _GestureSemantics ← RawGestureDetector ←
I/flutter ( 6559):            ╎                         │   GestureDetector ← InkWell ← IconTheme ← DefaultTextStyle ←
I/flutter ( 6559):            ╎                         │   AnimatedDefaultTextStyle ← ConstrainedBox ← MaterialButton ←
I/flutter ( 6559):            ╎                         │   TextButton ← Center ← ⋯
I/flutter ( 6559):            ╎                         │ parentData: <none>
I/flutter ( 6559):            ╎                         │ constraints: BoxConstraints(88.0<=w<=411.4, h=36.0)
I/flutter ( 6559):            ╎                         │ size: Size(98.0, 36.0)
I/flutter ( 6559):            ╎                         │ behavior: opaque
I/flutter ( 6559):            ╎                         │ listeners: down
I/flutter ( 6559):            ╎                         │
I/flutter ( 6559):            ╎                         └─child: RenderPadding relayoutBoundary=up4
I/flutter ( 6559):            ╎                           │ creator: Padding ← Container ← Listener ← _GestureSemantics ←
I/flutter ( 6559):            ╎                           │   RawGestureDetector ← GestureDetector ← InkWell ← IconTheme ←
I/flutter ( 6559):            ╎                           │   DefaultTextStyle ← AnimatedDefaultTextStyle ← ConstrainedBox ←
I/flutter ( 6559):            ╎                           │   MaterialButton ← ⋯
I/flutter ( 6559):            ╎                           │ parentData: <none>
I/flutter ( 6559):            ╎                           │ constraints: BoxConstraints(88.0<=w<=411.4, h=36.0)
I/flutter ( 6559):            ╎                           │ size: Size(98.0, 36.0)
I/flutter ( 6559):            ╎                           │ padding: EdgeInsets(16.0, 0.0, 16.0, 0.0)
I/flutter ( 6559):            ╎                           │
I/flutter ( 6559):            ╎                           └─child: RenderPositionedBox relayoutBoundary=up5
I/flutter ( 6559):            ╎                             │ creator: Center ← Padding ← Container ← Listener ←
I/flutter ( 6559):            ╎                             │   _GestureSemantics ← RawGestureDetector ← GestureDetector ←
I/flutter ( 6559):            ╎                             │   InkWell ← IconTheme ← DefaultTextStyle ←
I/flutter ( 6559):            ╎                             │   AnimatedDefaultTextStyle ← ConstrainedBox ← ⋯
I/flutter ( 6559):            ╎                             │ parentData: offset=Offset(16.0, 0.0)
I/flutter ( 6559):            ╎                             │ constraints: BoxConstraints(56.0<=w<=379.4, h=36.0)
I/flutter ( 6559):            ╎                             │ size: Size(66.0, 36.0)
I/flutter ( 6559):            ╎                             │ alignment: Alignment.center
I/flutter ( 6559):            ╎                             │ widthFactor: 1.0
I/flutter ( 6559):            ╎                             │ heightFactor: expand
I/flutter ( 6559):            ╎                             │
I/flutter ( 6559):            ╎                             └─child: RenderParagraph relayoutBoundary=up6
I/flutter ( 6559):            ╎                               │ creator: RichText ← Text ← Center ← Padding ← Container ←
I/flutter ( 6559):            ╎                               │   Listener ← _GestureSemantics ← RawGestureDetector ←
I/flutter ( 6559):            ╎                               │   GestureDetector ← InkWell ← IconTheme ← DefaultTextStyle ← ⋯
I/flutter ( 6559):            ╎                               │ parentData: offset=Offset(0.0, 10.0)
I/flutter ( 6559):            ╎                               │ constraints: BoxConstraints(0.0<=w<=379.4, 0.0<=h<=36.0)
I/flutter ( 6559):            ╎                               │ size: Size(66.0, 16.0)
I/flutter ( 6559):            ╎                               ╘═╦══ text ═══
I/flutter ( 6559):            ╎                                 ║ TextSpan:
I/flutter ( 6559):            ╎                                 ║   inherit: false
I/flutter ( 6559):            ╎                                 ║   color: Color(0xdd000000)
I/flutter ( 6559):            ╎                                 ║   family: "Roboto"
I/flutter ( 6559):            ╎                                 ║   size: 14.0
I/flutter ( 6559):            ╎                                 ║   weight: 500
I/flutter ( 6559):            ╎                                 ║   baseline: alphabetic
I/flutter ( 6559):            ╎                                 ║   "Dump App"
I/flutter ( 6559):            ╎                                 ╚═══════════
I/flutter ( 6559):            ╎
I/flutter ( 6559):            └╌no offstage children
```
