---
layout: page
title: Flutter 应用调试

permalink: /debugging/
---

这里有众多的工具和框架特性来帮助你 debug 你的 Flutter 应用。

* TOC Placeholder
{:toc}

## Dart 分析程序

在启动你的应用之前，使用 `flutter analyze` 命令检测你的代码。这是一个基于 `dartanalyzer` 的开发工具，它会分析你的代码，并且帮你发现可能出现的错误。如果你使用的是 [Flutter 的 IntelliJ 插件](/using-ide/)，这个工具已经内置在 [Flutter 的 IntelliJ 插件](/using-ide/)中。

Dart 分析程序会大量使用你在你的代码中写的类型注释来帮助你定位问题。尽可能多的使用类型注释(但是避免在 `var`，隐士参数，隐式的字面量 list 等地方使用)，因为这是最快捷和最轻松的定位问题的方法。

## Dart Observatory (语句级的逐步 debugger 和 分析)

如果你使用 `flutter run` 命令来启动你的应用，当应用启动后，你可以在浏览器中打开控制台中打印的 Observatory 链接（比如，`Observatory  listening on http://127.0.0.1:8100/`），来直接连接你的应用，并且语句级的逐步 debugger。如果你使用的是 IntelliJ，也可以通过编辑器内置的 debugger 方法来调试你的应用。

Observatory 也支持图表分析，堆检测等，关于 Observatory 的更多信息，查看 [Observatory 文档](https://dart-lang.github.io/observatory/)。

如果你使用 Observatory 的图表分析，你需要在使用 `flutter run` 命令时加上 `--profile` 参数，使应用在图表分析的模式下启动。否则，在你的图表分析界面只有调试断言校验框架的不变量的相关信息（查看下面的"调试模式断言"章节）。

### `debugger()` 语句

当使用 Dart Observatory (或者其他的 Dart 调试方法，比如 IntelliJ IDE 的调试方法)，你可以使用 `debugger()` 语句有计划的插入调试断点。为使 `debugger()` 语句生效，你还得在相关文件的顶部引入
 `import 'dart:developer';` 。

`debugger()` 语句有一个可选参数 `when` ，你可以指定，仅在特定条件成立时执行断点。比如：

<!-- import 'dart:developer'; -->
<!-- skip -->
```dart
void someFunction(double offset) {
  debugger(when: offset > 30.0);
  // ...
}
```

## `flutter logs` 中的 `print` 和 `debugPrint`

Dart 的 `print()` 方法会在系统控制台输出相应内容，你可以通过 `flutter logs`（在 `adb logcat` 基础上包装的方法）命令查看输出内容。

如果你一次输出太多的内容，Android 有时会忽略一些日志内容。为了避免这种情况，你可以使用 Flutter 的 `foundation` 库中的 [`debugPrint()`](https://docs.flutter.io/flutter/foundation/debugPrint.html) 方法。它基于 `print` 方法，可以调节输出长度，避免被 Android 内核忽略。

Flutter 中很多类可以使用 `toString` 方法。通常而言，这会输出一行内容，包含对象的 `runtimeType` ，通常以 ClassName(more information about this instance...) 的形式。一些在树状结构中使用的类也有 `toStringDeep` 方法，会返回关于这个树节点的全部信息。一些类有时会有特别 ~~冗余的~~ 有用的信息，你可以使用相应的 `toStringShort` 方法，这会只返回类型或者非常简短的（几个词的）关于这个对象的描述。

## 调试模式断言

在开发的时候，尽量使用 Flutter 的 "debug" 模式，也被称为 "checked" 模式。如果你是用 `flutter run` 命令会默认以调试模式启动项目。在调试模式下，可以使用 Dart 的 `assert` 申明， Flutter 框架可以利用这点预先校验一些原本在运行时校验的不变量是否被修改。

当不变量被修改时，会在控制台打印相关内容和一些上下文信息，来帮助定位问题。

可以通过使用 `flutter run --release` 命令以发布模式启动项目，停止使用调试模式。这也会关闭 Observatory debugger。还有一种介于两者之间的模式，就是 'profile 模式'，这种模式会关闭所有的调试辅助功能，除了 Observatory 以外， 可以通过 `--profile` 代替 `--release` 参数进入这种模式。

## 调试应用程序层

Flutter 框架提供了一个函数，可以把每一层的当前状态和事件输出到控制台( 使用 `debugPrint` )。

### Widget 层

可以使用 [`debugDumpApp()`](https://docs.flutter.io/flutter/widgets/debugDumpApp.html) 方法输出 Widget 库的状态。你可以在应用中随意使用这个方法，除了在组件构建阶段（比如，在 `build()` 方法中 ；只要应用构建了这个组件 （比如，在执行完 `runApp()` 之后）。

比如在下面这段代码中：

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      home: new AppHome(),
    ),
  );
}

class AppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: new FlatButton(
          onPressed: () {
            debugDumpApp();
          },
          child: new Text('Dump App'),
        ),
      ),
    );
  }
}
```

将会输出像这样一些内容（具体细节可能在不同版本下，不同设备和其他条件下有所差异）：

```
I/flutter ( 6559): WidgetsFlutterBinding - CHECKED MODE
I/flutter ( 6559): RenderObjectToWidgetAdapter<RenderBox>([GlobalObjectKey RenderView(497039273)]; renderObject: RenderView)
I/flutter ( 6559): └MaterialApp(state: _MaterialAppState(1009803148))
I/flutter ( 6559):  └ScrollConfiguration()
I/flutter ( 6559):   └AnimatedTheme(duration: 200ms; state: _AnimatedThemeState(543295893; ticker inactive; ThemeDataTween(ThemeData(Brightness.light Color(0xff2196f3) etc...) → null)))
I/flutter ( 6559):    └Theme(ThemeData(Brightness.light Color(0xff2196f3) etc...))
I/flutter ( 6559):     └WidgetsApp([GlobalObjectKey _MaterialAppState(1009803148)]; state: _WidgetsAppState(552902158))
I/flutter ( 6559):      └CheckedModeBanner()
I/flutter ( 6559):       └Banner()
I/flutter ( 6559):        └CustomPaint(renderObject: RenderCustomPaint)
I/flutter ( 6559):         └DefaultTextStyle(inherit: true; color: Color(0xd0ff0000); family: "monospace"; size: 48.0; weight: 900; decoration: double Color(0xffffff00) TextDecoration.underline)
I/flutter ( 6559):          └MediaQuery(MediaQueryData(size: Size(411.4, 683.4), devicePixelRatio: 2.625, textScaleFactor: 1.0, padding: EdgeInsets(0.0, 24.0, 0.0, 0.0)))
I/flutter ( 6559):           └LocaleQuery(null)
I/flutter ( 6559):            └Title(color: Color(0xff2196f3))
I/flutter ( 6559):             └Navigator([GlobalObjectKey<NavigatorState> _WidgetsAppState(552902158)]; state: NavigatorState(240327618; tracking 1 ticker))
I/flutter ( 6559):              └Listener(listeners: down, up, cancel; behavior: defer-to-child; renderObject: RenderPointerListener)
I/flutter ( 6559):               └AbsorbPointer(renderObject: RenderAbsorbPointer)
I/flutter ( 6559):                └Focus([GlobalKey 489139594]; state: _FocusState(739584448))
I/flutter ( 6559):                 └Semantics(container: true; renderObject: RenderSemanticsAnnotations)
I/flutter ( 6559):                  └_FocusScope(this scope has focus; focused subscope: [GlobalObjectKey MaterialPageRoute<Null>(875520219)])
I/flutter ( 6559):                   └Overlay([GlobalKey 199833992]; state: OverlayState(619367313; entries: [OverlayEntry@248818791(opaque: false; maintainState: false), OverlayEntry@837336156(opaque: false; maintainState: true)]))
I/flutter ( 6559):                    └_Theatre(renderObject: _RenderTheatre)
I/flutter ( 6559):                     └Stack(renderObject: RenderStack)
I/flutter ( 6559):                      ├_OverlayEntry([GlobalKey 612888877]; state: _OverlayEntryState(739137453))
I/flutter ( 6559):                      │└IgnorePointer(ignoring: false; renderObject: RenderIgnorePointer)
I/flutter ( 6559):                      │ └ModalBarrier()
I/flutter ( 6559):                      │  └Semantics(container: true; renderObject: RenderSemanticsAnnotations)
I/flutter ( 6559):                      │   └GestureDetector()
I/flutter ( 6559):                      │    └RawGestureDetector(state: RawGestureDetectorState(39068508; gestures: tap; behavior: opaque))
I/flutter ( 6559):                      │     └_GestureSemantics(renderObject: RenderSemanticsGestureHandler)
I/flutter ( 6559):                      │      └Listener(listeners: down; behavior: opaque; renderObject: RenderPointerListener)
I/flutter ( 6559):                      │       └ConstrainedBox(BoxConstraints(biggest); renderObject: RenderConstrainedBox)
I/flutter ( 6559):                      └_OverlayEntry([GlobalKey 727622716]; state: _OverlayEntryState(279971240))
I/flutter ( 6559):                       └_ModalScope([GlobalKey 816151164]; state: _ModalScopeState(875510645))
I/flutter ( 6559):                        └Focus([GlobalObjectKey MaterialPageRoute<Null>(875520219)]; state: _FocusState(331487674))
I/flutter ( 6559):                         └Semantics(container: true; renderObject: RenderSemanticsAnnotations)
I/flutter ( 6559):                          └_FocusScope(this scope has focus)
I/flutter ( 6559):                           └Offstage(offstage: false; renderObject: RenderOffstage)
I/flutter ( 6559):                            └IgnorePointer(ignoring: false; renderObject: RenderIgnorePointer)
I/flutter ( 6559):                             └_MountainViewPageTransition(animation: AnimationController(⏭ 1.000; paused; for MaterialPageRoute<Null>(/))➩ProxyAnimation➩Cubic(0.40, 0.00, 0.20, 1.00)➩Tween<Offset>(Offset(0.0, 1.0) → Offset(0.0, 0.0))➩Offset(0.0, 0.0); state: _AnimatedState(552160732))
I/flutter ( 6559):                              └SlideTransition(animation: AnimationController(⏭ 1.000; paused; for MaterialPageRoute<Null>(/))➩ProxyAnimation➩Cubic(0.40, 0.00, 0.20, 1.00)➩Tween<Offset>(Offset(0.0, 1.0) → Offset(0.0, 0.0))➩Offset(0.0, 0.0); state: _AnimatedState(714726495))
I/flutter ( 6559):                               └FractionalTranslation(renderObject: RenderFractionalTranslation)
I/flutter ( 6559):                                └RepaintBoundary(renderObject: RenderRepaintBoundary)
I/flutter ( 6559):                                 └PageStorage([GlobalKey 619728754])
I/flutter ( 6559):                                  └_ModalScopeStatus(active)
I/flutter ( 6559):                                   └AppHome()
I/flutter ( 6559):                                    └Material(MaterialType.canvas; elevation: 0; state: _MaterialState(780114997))
I/flutter ( 6559):                                     └AnimatedContainer(duration: 200ms; has background; state: _AnimatedContainerState(616063822; ticker inactive; has background))
I/flutter ( 6559):                                      └Container(bg: BoxDecoration())
I/flutter ( 6559):                                       └DecoratedBox(renderObject: RenderDecoratedBox)
I/flutter ( 6559):                                        └Container(bg: BoxDecoration(backgroundColor: Color(0xfffafafa)))
I/flutter ( 6559):                                         └DecoratedBox(renderObject: RenderDecoratedBox)
I/flutter ( 6559):                                          └NotificationListener<LayoutChangedNotification>()
I/flutter ( 6559):                                           └_InkFeature([GlobalKey ink renderer]; renderObject: _RenderInkFeatures)
I/flutter ( 6559):                                            └AnimatedDefaultTextStyle(duration: 200ms; inherit: false; color: Color(0xdd000000); family: "Roboto"; size: 14.0; weight: 400; baseline: alphabetic; state: _AnimatedDefaultTextStyleState(427742350; ticker inactive))
I/flutter ( 6559):                                             └DefaultTextStyle(inherit: false; color: Color(0xdd000000); family: "Roboto"; size: 14.0; weight: 400; baseline: alphabetic)
I/flutter ( 6559):                                              └Center(alignment: Alignment.center; renderObject: RenderPositionedBox)
I/flutter ( 6559):                                               └FlatButton()
I/flutter ( 6559):                                                └MaterialButton(state: _MaterialButtonState(398724090))
I/flutter ( 6559):                                                 └ConstrainedBox(BoxConstraints(88.0<=w<=Infinity, h=36.0); renderObject: RenderConstrainedBox relayoutBoundary=up1)
I/flutter ( 6559):                                                  └AnimatedDefaultTextStyle(duration: 200ms; inherit: false; color: Color(0xdd000000); family: "Roboto"; size: 14.0; weight: 500; baseline: alphabetic; state: _AnimatedDefaultTextStyleState(315134664; ticker inactive))
I/flutter ( 6559):                                                   └DefaultTextStyle(inherit: false; color: Color(0xdd000000); family: "Roboto"; size: 14.0; weight: 500; baseline: alphabetic)
I/flutter ( 6559):                                                    └IconTheme(color: Color(0xdd000000))
I/flutter ( 6559):                                                     └InkWell(state: _InkResponseState<InkResponse>(369160267))
I/flutter ( 6559):                                                      └GestureDetector()
I/flutter ( 6559):                                                       └RawGestureDetector(state: RawGestureDetectorState(175370983; gestures: tap; behavior: opaque))
I/flutter ( 6559):                                                        └_GestureSemantics(renderObject: RenderSemanticsGestureHandler relayoutBoundary=up2)
I/flutter ( 6559):                                                         └Listener(listeners: down; behavior: opaque; renderObject: RenderPointerListener relayoutBoundary=up3)
I/flutter ( 6559):                                                          └Container(padding: EdgeInsets(16.0, 0.0, 16.0, 0.0))
I/flutter ( 6559):                                                           └Padding(renderObject: RenderPadding relayoutBoundary=up4)
I/flutter ( 6559):                                                            └Center(alignment: Alignment.center; widthFactor: 1.0; renderObject: RenderPositionedBox relayoutBoundary=up5)
I/flutter ( 6559):                                                             └Text("Dump App")
I/flutter ( 6559):                                                              └RichText(renderObject: RenderParagraph relayoutBoundary=up6)
```

这是"扁平化的"组件树，包含了通过各种方法构建的放入其中的组件。（你可以在根结点调用 `toStringDeep` 方法得到这个树状结构。）你将会看到很多不存在于你应用的代码中的内容，因为他们是通过框架的组件构建方法插入其中的。比如，[`InkFeature`](https://docs.flutter.io/flutter/material/InkFeature-class.html)是
[`Material`](https://docs.flutter.io/flutter/material/Material-class.html) 组件的具体实现。

因为 `debugDumpApp()` 方法在按钮被按下和释放的时候调用，它和 [`FlatButton`](https://docs.flutter.io/flutter/material/FlatButton-class.html) 对象在调用 [`setState()`](https://docs.flutter.io/flutter/widgets/State/setState.html) 方法时很像，所以被标记为 dirty。所以当你看到输出内容时，将会看到具体对象被标记为 'dirty'。你也可以看到哪种手势监听事件被注册；在这个例子中，只有一个手势监测，它只监听"点击"手势（'tap' 是 `TapGestureDetector` 调用 `toStringShort` 方法的输出）。

如果你自己写组件，你可以通过重写 [`debugFillProperties()`](https://docs.flutter.io/flutter/widgets/Widget/debugFillProperties.html) 方法添加信息。将 [DiagnosticsProperty](https://docs.flutter.io/flutter/foundation/DiagnosticsProperty-class.html) 添加到方法参数中，然后调用超类的方法。`toString` 方法就是用这个函数来描述小组件的。

### 渲染层

如果你是在调试布局问题，那么组件层树所展示的信息可能不够详细。这时你可以使用 [`debugDumpRenderTree()`](https://docs.flutter.io/flutter/rendering/debugDumpRenderTree.html) 方法来获取渲染树的信息。和 `debugDumpApp()` 一样，你可以随时调用这个方法，除了在页面绘制阶段外。通常你可以在 [frame
callback](https://docs.flutter.io/flutter/scheduler/SchedulerBinding/addPersistentFrameCallback.html) 或者事件处理函数中调用。

在使用之前，你必须在你的文件中添加一行 `import 'package:flutter/rendering.dart';` 。

这个方法的输入如下所示：

```
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
I/flutter ( 6559):            ╎   │   MaterialPageRoute<Null>(875520219)] ← _ModalScope-[GlobalKey
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
I/flutter ( 6559):            ╎     │   Focus-[GlobalObjectKey MaterialPageRoute<Null>(875520219)] ←
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
I/flutter ( 6559):            ╎       │   Focus-[GlobalObjectKey MaterialPageRoute<Null>(875520219)] ←
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
I/flutter ( 6559):            ╎         │   MaterialPageRoute<Null>(875520219)] ← _ModalScope-[GlobalKey
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
I/flutter ( 6559):            ╎           │   MaterialPageRoute<Null>(875520219)] ← _ModalScope-[GlobalKey
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
I/flutter ( 6559):            ╎                 │ creator: _InkFeature-[GlobalKey ink renderer] ←
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
I/flutter ( 6559):            ╎                   │   _InkFeature-[GlobalKey ink renderer] ←
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
I/flutter ( 6559):            ╎                     │ creator: ConstrainedBox ← MaterialButton ← FlatButton ← Center ←
I/flutter ( 6559):            ╎                     │   DefaultTextStyle ← AnimatedDefaultTextStyle ←
I/flutter ( 6559):            ╎                     │   _InkFeature-[GlobalKey ink renderer] ←
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
I/flutter ( 6559):            ╎                       │   FlatButton ← Center ← DefaultTextStyle ← ⋯
I/flutter ( 6559):            ╎                       │ parentData: <none>
I/flutter ( 6559):            ╎                       │ constraints: BoxConstraints(88.0<=w<=411.4, h=36.0)
I/flutter ( 6559):            ╎                       │ size: Size(98.0, 36.0)
I/flutter ( 6559):            ╎                       │
I/flutter ( 6559):            ╎                       └─child: RenderPointerListener relayoutBoundary=up3
I/flutter ( 6559):            ╎                         │ creator: Listener ← _GestureSemantics ← RawGestureDetector ←
I/flutter ( 6559):            ╎                         │   GestureDetector ← InkWell ← IconTheme ← DefaultTextStyle ←
I/flutter ( 6559):            ╎                         │   AnimatedDefaultTextStyle ← ConstrainedBox ← MaterialButton ←
I/flutter ( 6559):            ╎                         │   FlatButton ← Center ← ⋯
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

输出内容是根 `RenderObject` 对象使用 `toStringDeep` 方法的结果。

当调试布局问题时，关键是 `size` 和 `constraints` 的值，约束沿着树向下传递，尺寸向上传递。

举例来说，在上面的输出中，你可以看 window 的尺寸 `Size(411.4, 683.4)` ，通过限制条件 `BoxConstraints(w=411.4, h=683.4)` ，强制使所有的 [`RenderPositionedBox`](https://docs.flutter.io/flutter/rendering/RenderPositionedBox-class.html) 一下的盒模型的尺寸和屏幕相等。约束条件为 BoxConstraints(w=411.4, h=683.4)。从RenderPositionedBox的转储中看到是由Center widget创建的（如creator字段所描述的）， 设置其孩子的约束为：BoxConstraints(0.0<=w<=411.4,0.0<=h<=683.4)。一个子widget RenderPadding 进一步插入这些约束以添加填充空间，padding值为EdgeInsets(16.0, 0.0, 16.0, 0.0)，因此 RenderConstrainedBox 具有约束 BoxConstraints(0.0<=w<=395.4, 0.0<=h<=667.4)。该 creator字段告诉我们的这个对象可能是其 [`FlatButton`](https://docs.flutter.io/flutter/material/FlatButton-class.html) 定义的一部分，它在其内容上设置最小宽度为88像素，并且设置高度为36.0像素（这是Material Design设计规范中 `FlatButton` 类的尺寸标准）。

最内部RenderPositionedBox再次松开约束，这次是将按钮中的文本居中。 在 [`RenderParagraph`](https://docs.flutter.io/flutter/rendering/RenderParagraph-class.html) 中基于它的内容来决定其大小。 如果您现在按照size链继续往下查看，您会看到文本的大小是如何影响其按钮的框的宽度的，它们都是根据孩子的尺寸自行调整大小。

另一种需要注意的是每个盒子描述的 ”relayoutSubtreeRoot” 部分，它告诉你有多少祖先以某种方式依赖于这个元素的大小。 因此，RenderParagraph 有一个 relayoutSubtreeRoot=up8，这意味着当它RenderParagraph被标及为 ”dirty” 时，它的八个祖先也必须被标记为 ”dirty”，因为它们可能受到新尺寸的影响。

如果您编写自己的渲染对象，则可以通过覆盖 [`debugFillProperties()`](https://docs.flutter.io/flutter/rendering/Layer/debugFillProperties.html) 将信息添加到转储。 将 [DiagnosticsProperty](https://docs.flutter.io/flutter/foundation/DiagnosticsProperty-class.html) 对象作为方法的参数，并调用父类方法。

### Layers

如果你调试一个复合性的问题，你可以使用 [`debugDumpLayerTree()`](https://docs.flutter.io/flutter/rendering/debugDumpLayerTree.html) 方法。

如下面的例子，可能输出：

```
I/flutter : TransformLayer
I/flutter :  │ creator: [root]
I/flutter :  │ offset: Offset(0.0, 0.0)
I/flutter :  │ transform:
I/flutter :  │   [0] 3.5,0.0,0.0,0.0
I/flutter :  │   [1] 0.0,3.5,0.0,0.0
I/flutter :  │   [2] 0.0,0.0,1.0,0.0
I/flutter :  │   [3] 0.0,0.0,0.0,1.0
I/flutter :  │
I/flutter :  ├─child 1: OffsetLayer
I/flutter :  │ │ creator: RepaintBoundary ← _FocusScope ← Semantics ← Focus-[GlobalObjectKey MaterialPageRoute(560156430)] ← _ModalScope-[GlobalKey 328026813] ← _OverlayEntry-[GlobalKey 388965355] ← Stack ← Overlay-[GlobalKey 625702218] ← Navigator-[GlobalObjectKey _MaterialAppState(859106034)] ← Title ← ⋯
I/flutter :  │ │ offset: Offset(0.0, 0.0)
I/flutter :  │ │
I/flutter :  │ └─child 1: PictureLayer
I/flutter :  │
I/flutter :  └─child 2: PictureLayer
```

这些输出内容是根 `Layer` 对象调用 `toStringDeep` 方法的输出结果。

那个根结点的 transfom 值是设备像素比的转换值，在这个例子中，这个值是 3.5 个 设备像素转化为一个逻辑像素。

`RepaintBoundary` 组件创建一个新的层在层树上，并且会在根结点创建一个`渲染重绘边界`，可以帮助减少需要重绘的部分。

### 语义

您还可以调用 [`debugDumpSemanticsTree()`](https://docs.flutter.io/flutter/rendering/debugDumpSemanticsTree.html) 获取语义树（呈现给系统可访问性API的树）的转储。 要使用此功能，必须首先启用辅助功能，例如启用系统辅助工具或 `SemanticsDebugger`（下面讨论）。

对于上面的例子，它会输出：

```
I/flutter : SemanticsNode(0; Rect.fromLTRB(0.0, 0.0, 411.4, 683.4))
I/flutter :  ├SemanticsNode(1; Rect.fromLTRB(0.0, 0.0, 411.4, 683.4))
I/flutter :  │ └SemanticsNode(2; Rect.fromLTRB(0.0, 0.0, 411.4, 683.4); canBeTapped)
I/flutter :  └SemanticsNode(3; Rect.fromLTRB(0.0, 0.0, 411.4, 683.4))
I/flutter :    └SemanticsNode(4; Rect.fromLTRB(0.0, 0.0, 82.0, 36.0); canBeTapped; "Dump App")
```

<!-- this tree is bad, see https://github.com/flutter/flutter/issues/2476 -->

### 调度

要找出相对于帧的开始/结束事件发生的位置，可以切换 [`debugPrintBeginFrameBanner`](https://docs.flutter.io/flutter/scheduler/debugPrintBeginFrameBanner.html) 和 [`debugPrintEndFrameBanner`](https://docs.flutter.io/flutter/scheduler/debugPrintEndFrameBanner.html) 布尔值以将帧的开始和结束打印到控制台。

例如:

```
I/flutter : ▄▄▄▄▄▄▄▄ Frame 12         30s 437.086ms ▄▄▄▄▄▄▄▄
I/flutter : Debug print: Am I performing this work more than once per frame?
I/flutter : Debug print: Am I performing this work more than once per frame?
I/flutter : ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
```

[`debugPrintScheduleFrameStacks`](https://docs.flutter.io/flutter/scheduler/debugPrintScheduleFrameStacks.html) 也能用于打印调用的栈导致的当前掉帧。

## 可视化调试

打开 [`debugPaintSizeEnabled`](https://docs.flutter.io/flutter/rendering/debugPaintSizeEnabled.html) 选项，你可以可视化的调试布局问题。这是一个 `rendering` 库的布尔值。可以随时打开这个值，当它的值为 true 时，会影响所有的组件绘制。最简单的方式是在你的 `void main()` 初始入口中设置它的值。

当打开它时，所有的盒子会有一个蓝绿色的边框，内边距（ `Padding` 组件的）会显示未淡蓝色，在子组件周围会有暗蓝色的块，对齐效果（ `Center` 和 `Align` 组件的）会有黄色的箭头，间隔（没有子组件的 `Container` 组件）是灰色的。

[`debugPaintBaselinesEnabled`](https://docs.flutter.io/flutter/rendering/debugPaintBaselinesEnabled.html) 方法有类似的效果，但是它描绘了对象的基线。带字母的基线是亮绿色的，表意的基线是橙色的。

[`debugPaintPointersEnabled`](https://docs.flutter.io/flutter/rendering/debugPaintPointersEnabled.html) 可以开启一种特殊的模式，当对象被点击时，会有蓝绿色的高亮。可以帮助你判断对象是否莫名其妙的未能正确的响应点击测试（比如，这个对象实际上是在它的父元素边界之外的，所以在它的位置未能出发点击测试）。

如果你试图调试变形层，比如，要决定是否加上 `RepaintBoundary` 组件以及加在哪里，你可以使用 [`debugPaintLayerBordersEnabled`](https://docs.flutter.io/flutter/rendering/debugPaintLayerBordersEnabled.html) 选项，会在组件边界处绘制橙色边线，或者使用 [`debugRepaintRainbowEnabled`](https://docs.flutter.io/flutter/rendering/debugRepaintRainbowEnabled.html) 选项，会使组件层在重绘时覆盖一层颜色遮罩层。

所有这些选项都是只在调试模式下可用。通常，Flutter 框架的任何以 "`debug...`" 开头的东西都是只在调试模式下可用。

## 调试动画

最简单的调试动画的方式就是把他们变慢。可以通过将 [`timeDilation`](https://docs.flutter.io/flutter/scheduler/timeDilation.html) 变量（在 `scheduler` 库中）设置为比 1.0 大的数字实现这种效果，比如 50.0。最好只在应用启动的时候设置一次，如果你在应用运行的时候修改这个值，特别是在动画开始后减少这个值，框架可能会检测到时间后退，这种情况同时由断言导致的，将会影响你的调试。

## 调试性能问题

排查你的应用重布局和重绘的原因，你可以分别看看 [`debugPrintMarkNeedsLayoutStacks`](https://docs.flutter.io/flutter/rendering/debugPrintMarkNeedsLayoutStacks.html)
和
[`debugPrintMarkNeedsPaintStacks`](https://docs.flutter.io/flutter/rendering/debugPrintMarkNeedsPaintStacks.html)。任何时候，当一个盒子被要求重布局和重绘时，这两个方法会在控制台记录下栈追踪。如果你需要，你可以使用 `services` 库中的 `debugPrintStack()` 方法命令行中打印你的栈追踪。

### 测量应用启动时间

你可以在 `flutter run` 命令后加上 `trace-startup` 和 `profile` 参数来收集你的应用启动的详细时间信息。

```
$ flutter run --trace-startup --profile
```

这个追踪信息会在你的 Flutter 项目下 `build` 目录下保存为 `start_up_info.json` JSON 文件。结果包含应用启动到这些事件触发的时间（以微秒为单位）：

+ 进入 Flutter 引擎代码的时间。
+ 渲染应用第一帧的时间。
+ 初始化 Flutter 框架的时间。
+ 完成 Flutter 框架初始化的时间.

如下面例子：

```
{
  "engineEnterTimestampMicros": 96025565262,
  "timeToFirstFrameMicros": 2171978,
  "timeToFrameworkInitMicros": 514585,
  "timeAfterFrameworkInitMicros": 1657393
}
```

### 追踪 Dart 代码的性能

要执行自定义性能跟踪和测量类似于将在 Android 上做用飞镖任意代码段的 wall/ CPU 时间 [systrace](https://developer.android.com/studio/profile/systrace.html) ，使用   `dart:developer` 的[时间轴](https://api.dartlang.org/stable/dart-developer/Timeline-class.html) 工具在外层包裹你想衡量的代码，像下面这样：

<!-- import 'dart:developer'; -->
<!-- skip -->
```dart
Timeline.startSync('interesting function');
// iWonderHowLongThisTakes();
Timeline.finishSync();
```

然后打开你的应用的 Observatory 时间轴页面，选中 'Dart' 记录选项，然后执行你想测量的方法。

刷新页面后会在 Chrome 的 [tracing tool](https://www.chromium.org/developers/how-tos/trace-event-profiling-tool) 里按照时间先后顺序将 timeline 展示出来。

确保在 `flutter run` 你的应用的时候，使用了 `--profile` 参数，以确保在运行的表现接近你最终产品的运行时的表现。

## 性能覆盖

将 [`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp/MaterialApp.html) 的 constructor 设置为 true，可以看到应用性能图形化的界面。[`WidgetsApp`](https://docs.flutter.io/flutter/widgets/WidgetsApp-class.html) 的 constructor 有一个类似的参数。（如果你没有使用 `MaterialApp`
或者 `WidgetsApp`，你可以将你的应用放在一个 stack 里，然后在 stack 里加上一个 [`new PerformanceOverlay.allEnabled()`](https://docs.flutter.io/flutter/widgets/PerformanceOverlay/PerformanceOverlay.allEnabled.html) 创建的组件，你也可以获得同样的效果。）

会有两个图表，上面的一个是 GPU 线程所消耗的时间，下面的那个是 CPU 线程所消耗的时间。图表中白色的线表示 16ms 内在竖轴方向的增量。如果图表始终没有超过这条线，那么你的应用刷新的频率小于 60HZ。水平轴代表帧数。图表只会在应用界面绘制的时候刷新，所以如果是静止的页面，图表也会停止刷新。

必须在 release 模式下使用性能测试，因为在 debug 模式下，性能被刻意降低了，用以进行复杂的开发断言任务，来辅助开发，所以结果会有一定的偏差。

## Material 网格

如果使用了 [Material
Design](https://www.google.com/design/spec/material-design/introduction.html) 开发应用，那么在应用上覆盖一层 [Material Design baseline
grid](https://www.google.com/design/spec/layout/metrics-keylines.html) 会有助于确认元素对齐状况。[`MaterialApp`
constructor](https://docs.flutter.io/flutter/material/MaterialApp/MaterialApp.html) 有一个 `debugShowGrid` 参数，当在 debug 模式下设置为 `true` 的时候会显示这个网格。

在不是 Material 的应用下，你也可以通过 [`GridPaper`](https://docs.flutter.io/flutter/widgets/GridPaper-class.html) 组件直接在应用上覆盖一层网格。
