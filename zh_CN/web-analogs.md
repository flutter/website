---
layout: page
title: HTML/CSS 模式 
permalink: /web-analogs/
---

<link rel="stylesheet" href="/css/two_column.css">

* TOC Placeholder
{:toc}

<div class="begin-examples"></div>
本页面是面向那些熟悉使用 HTML 和 CSS 编写应用UI组件的开发人员，这里介绍如何将 HTML/CSS 代码转换成等效的 Flutter/Dart 代码。

这里的示例基于以下假设：
* HTML 文档都以 HTML DOCTYPE 开头，所有元素的盒子模型都是 [border-box](https://css-tricks.com/box-sizing/) ，以便与 Flutter 模型保持一致。
{% prettify css %}<!DOCTYPE html>

   {
     box-sizing: border-box;
   }
{% endprettify %}

* 在 Flutter 中，“Lorem ipsum” 文本的默认样式由 bold24Roboto 变量定义，以保持简单的语法。
{% prettify dart %}
  TextStyle bold24Roboto = new TextStyle(
      color: Colors.white,
      fontSize: 24.0,
      fontWeight: FontWeight.w900,
  );
{% endprettify %}

## 执行基本布局操作

以下示例展示如何执行最常见的UI布局。

### 文本样式和文本对齐

CSS 可以处理的字体样式，字体大小和其他文本属性，还有颜色都在 [Text](https://docs.flutter.io/flutter/widgets/Text-class.html) 控件的子控件 [TextStyle](https://docs.flutter.io/flutter/painting/TextStyle-class.html) 中定义。

而在 HTML 和 Flutter 中，默认的子元素或控件都被固定在左上角的。

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
    Lorem ipsum
</div>

.greybox {
      background-color: #e0e0e0; /* grey 300 */
      width: 320px;
      height: 240px;
[[highlight]]      font: 900 24px Georgia;[[/highlight]]
    }
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
  var container = new Container( // grey box
    child: new Text(
      "Lorem ipsum",
      style: [[highlight]]new TextStyle(
        fontSize: 24.0
        fontWeight: FontWeight.w900,
        fontFamily: "Georgia",
      ),[[/highlight]]
    ),
    width: 320.0,
    height: 240.0,
    color: Colors.grey[300],
  );
{% endprettify %}
</div>

### 设置背景颜色
在 Flutter 中，你可以在 [Container](https://docs.flutter.io/flutter/widgets/Container-class.html) 中的 ```decoration``` 属性上设置背景颜色，如下：

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  Lorem ipsum
</div>
.greybox {
[[highlight]]      background-color: #e0e0e0; [[/highlight]] /* grey 300 */
      width: 320px;
      height: 240px;
      font: 900 24px Roboto;
    }
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
  var container = new Container( // grey box
    child: new Text(
      "Lorem ipsum",
      style: bold24Roboto,
    ),
    width: 320.0,
    height: 240.0,
[[highlight]]    color: Colors.grey[300],[[/highlight]]
  );
{% endprettify %}
</div>

### 组件居中
[Center](https://docs.flutter.io/flutter/widgets/Center-class.html) 控件能够使它的子控件保持水平和垂直居中。

如果要在 CSS 达到同样的效果，则需要使用 flex 布局或者 table-cell 样式，下面的示例则使用  flex 布局的方法。

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  Lorem ipsum
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
[[highlight]]  display: flex;
  align-items: center;
  justify-content: center; [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: [[highlight]] new Center(
    child: [[/highlight]] new Text(
      "Lorem ipsum",
      style: bold24Roboto,
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### 设置Container宽度
如果想设置 [Container](https://docs.flutter.io/flutter/widgets/Container-class.html) 的宽度，你需要设置它的 ```width``` 属性。而这里设置的是一个固定的宽度，不像CSS的max-width属性能够自动调整。如果想在Flutter中达到CSS max-width的效果，你可以在Container的 ```constraints```  属性上使用 ```minWidth``` 或 ```maxWidth``` 创建一个 [BoxConstraints](https://docs.flutter.io/flutter/rendering/BoxConstraints-class.html) 对象。
而对于嵌套的 Container ，如果父控件的宽度小于子控件的宽度，子控件会自动调整自身大小以适应父控件的尺寸。

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
[[highlight]]  width: 320px; [[/highlight]]
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]    width: 100%;
  max-width: 240px; [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: new Center(
    child: new Container( // red box
      child: new Text(
        "Lorem ipsum",
        style: bold24Roboto,
      ),
      decoration: new BoxDecoration(
        color: Colors.red[400],
      ),
      padding: new EdgeInsets.all(16.0),
[[highlight]]      width: 240.0, [[/highlight]]//max-width is 240.0
    ),
  ),
[[highlight]]  width: 320.0, [[/highlight]]
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

## 操作位置和尺寸
下面的示例展示如何在控件定位，尺寸和背景上执行更多复杂的操作。

### 设置绝对定位

默认情况下，控件是相对于父控件定位的。

如果想使用x-y坐标设置控件的绝对定位，你可以将该控件放到 [Positioned](https://docs.flutter.io/flutter/widgets/Positioned-class.html) 控件，然后再将Positioned控件放到 [Stack](https://docs.flutter.io/flutter/widgets/Stack-class.html) 中。

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
[[highlight]]  position: relative; [[/highlight]]
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  position: absolute;
  top: 24px;
  left: 24px; [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
[[highlight]]  child: new Stack(
    children: [
      new Positioned( // red box
        child: [[/highlight]] new Container(
          child: new Text(
            "Lorem ipsum",
            style: bold24Roboto,
          ),
          decoration: new BoxDecoration(
            color: Colors.red[400],
          ),
          padding: new EdgeInsets.all(16.0),
        ),
[[highlight]]        left: 24.0,
        top: 24.0,
      ),
    ],
  ), [[/highlight]]
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### 旋转组件

如果想让控件旋转，你可以将该控件放到 [Transform](https://docs.flutter.io/flutter/widgets/Transform-class.html) 控件中，并设置Transorm控件的 ```alignment``` 或 ```origin``` 属性，以相对（自身宽高）或者绝对（设置top，left）的方式去定义变换的原点。

对于一个简单的2D旋转，控件是围绕Z轴使用弧度控制旋转的：
(旋转角度 × π / 180)

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  transform: rotate(15deg); [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = new Container( // gray box
  child: new Center(
    child: [[highlight]] new Transform(
      child: [[/highlight]] new Container( // red box
        child: new Text(
          "Lorem ipsum",
          style: bold24Roboto,
          textAlign: TextAlign.center,
        ),
        decoration: new BoxDecoration(
          color: Colors.red[400],
        ),
        padding: new EdgeInsets.all(16.0),
      ),
[[highlight]]      alignment: Alignment.center,
      transform: new Matrix4.identity()
        ..rotateZ(15 * 3.1415927 / 180),
    ), [[/highlight]]
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### 缩放组件

让一个控件能够放大缩小，同样可以将该控件放到 [Transform](https://docs.flutter.io/flutter/widgets/Transform-class.html) 中。

对于一个简单的基于X轴的缩放操作，可以创建一个 [Matrix4](https://docs.flutter.io/flutter/vector_math_64/Matrix4-class.html) 对象并使用它的scale()方法去定义缩放系数。

当你缩放一个控件时，它的所有子控件也会随着比例一起缩放。

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  transform: scale(1.5); [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = new Container( // gray box
  child: new Center(
    child: [[highlight]] new Transform(
      child: [[/highlight]] new Container( // red box
        child: new Text(
          "Lorem ipsum",
          style: bold24Roboto,
          textAlign: TextAlign.center,
        ),
        decoration: new BoxDecoration(
          color: Colors.red[400],
        ),
        padding: new EdgeInsets.all(16.0),
      ),
[[highlight]]      alignment: Alignment.center,
      transform: new Matrix4.identity()
        ..scale(1.5),
     ), [[/highlight]]
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### 应用线性渐变

如果想在控件的背景使用线性渐变，可以将该控件放到 [Container](https://docs.flutter.io/flutter/widgets/Container-class.html) 控件中，然后在Container的 ```decoration``` 属性上创建一个 [BoxDecoration](https://docs.flutter.io/flutter/painting/BoxDecoration-class.html) 对象，再设置BoxDecoration的 ```gradient``` 属性就可以改变背景颜色填充。

而渐变的角度取决于 Aligment(x,y) 的值:
* 如果开始和结束的x值是相等的，那么渐变角度是垂直的。
* 如果开始和结束的y值是相等的，那么渐变角度是水平的。

PS: 这里可以看作开始和结束两点连成直线的角度和方向就是渐变的角度和方向

#### 垂直渐变
<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  padding: 16px;
  color: #ffffff;
[[highlight]]  background: linear-gradient(180deg, #ef5350, rgba(0, 0, 0, 0) 80%); [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: new Center(
    child: new Container( // red box
      child: new Text(
        "Lorem ipsum",
        style: bold24Roboto,
      ),
[[highlight]]      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: const Alignment(0.0, -1.0),
          end: const Alignment(0.0, 0.6),
          colors: <Color>[
            const Color(0xffef5350),
            const Color(0x00ef5350)
          ],
        ),
      ), [[/highlight]]
      padding: new EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

#### 水平渐变
<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  padding: 16px;
  color: #ffffff;
[[highlight]]  background: linear-gradient(90deg, #ef5350, rgba(0, 0, 0, 0) 80%); [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: new Center(
    child: new Container( // red box
      child: new Text(
        "Lorem ipsum",
        style: bold24Roboto,
      ),
[[highlight]]      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: const Alignment(-1.0, 0.0),
          end: const Alignment(0.6, 0.0),
          colors: <Color>[
            const Color(0xffef5350),
            const Color(0x00ef5350)
          ],
        ),
      ), [[/highlight]]
      padding: new EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

## 改变形状

下面的示例展示如何制作和自定义不同的形状。

### 圆角
如果想让一个矩形四个角都变成圆角，那么可以在 [BoxDecoration](https://docs.flutter.io/flutter/painting/BoxDecoration-class.html) 的 ```borderRadius``` 属性上，创建一个 [BorderRadius](https://docs.flutter.io/flutter/painting/BorderRadius-class.html) 对象，就可以在该对象上为指定圆角的半径。

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* gray 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  border-radius: 8px; [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: new Center(
    child: new Container( // red circle
      child: new Text(
        "Lorem ipsum",
        style: bold24Roboto,
      ),
      decoration: new BoxDecoration(
        color: Colors.red[400],
[[highlight]]        borderRadius: new BorderRadius.all(
          const Radius.circular(8.0),
        ), [[/highlight]]
      ),
      padding: new EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### 添加阴影效果
在 CSS 中，你可以用简写的方式在box-shadow属性上去定义阴影的偏移和模糊，下面的例子展示了两种阴影效果和它们的属性：
*  ```xOffset: 0px, yOffset: 2px, blur: 4px, color: black @80% alpha```
*  ```xOffset: 0px, yOffset: 06x, blur: 20px, color: black @50% alpha```.

而在 Flutter 中，每个属性和值都需要分别去指定。在 BoxDecoration 的 ```boxShadow``` 上创建一个 [BoxShadow](https://docs.flutter.io/flutter/painting/BoxShadow-class.html) 控件列表，这些控件可以叠加来定制阴影的深度，颜色等等

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.8),
              0 6px 20px rgba(0, 0, 0, 0.5);[[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: new Center(
    child: new Container( // red box
      child: new Text(
        "Lorem ipsum",
        style: bold24Roboto,
      ),
      decoration: new BoxDecoration(
        color: Colors.red[400],
[[highlight]]        boxShadow: <BoxShadow>[
          new BoxShadow (
            color: const Color(0xcc000000),
            offset: new Offset(0.0, 2.0),
            blurRadius: 4.0,
          ),
          new BoxShadow (
            color: const Color(0x80000000),
            offset: new Offset(0.0, 6.0),
            blurRadius: 20.0,
          ),
        ], [[/highlight]]
      ),
      padding: new EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  decoration: new BoxDecoration(
    color: Colors.grey[300],
  ),
  margin: new EdgeInsets.only(bottom: 16.0),
);
{% endprettify %}
</div>

### 制作圆形和椭圆形

在CSS中制作一个圆形，只需要使用border-radius属性设置为50%即可。

这种方式也被 [BoxDecoration](https://docs.flutter.io/flutter/painting/BoxDecoration-class.html) 的 ```borderRadius``` 属性所支持，而Flutter也提供一个可以指定为 [BoxShape enum](https://docs.flutter.io/flutter/painting/BoxShape-class.html) 的  ```shape``` 属性来实现这种效果。

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redcircle">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* gray 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redcircle {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  text-align: center;
  width: 160px;
  height: 160px;
  border-radius: 50%; [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: new Center(
    child: new Container( // red circle
      child: new Text(
        "Lorem ipsum",
        style: bold24Roboto,
[[highlight]]        textAlign: TextAlign.center, [[/highlight]]
      ),
      decoration: new BoxDecoration(
        color: Colors.red[400],
[[highlight]]        shape: BoxShape.circle, [[/highlight]]
      ),
      padding: new EdgeInsets.all(16.0),
[[highlight]]      width: 160.0,
      height: 160.0, [[/highlight]]
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

## 操作文本
下面的示例展示如何定义字体和其他文本属性，它们同样会展示如何变换字符串，自定义间距和创建摘录。

### 调整文本间距
在 CSS 中你可以使用 letter-spacing 和 word-spacing 属性设置一个长度值，从而指定每个字符或者每个单词间的间距，而这些属性中使用长度的单位可以是px, pt, cm, em等等。

在 Flutter 中，你可以使用逻辑像素（logical pixels）在 [TextStyle](https://docs.flutter.io/flutter/painting/TextStyle-class.html) 的 ```letterSpacing``` 和 ```wordSpacing``` 属性上来定义间距（负值也是允许的）。

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  letter-spacing: 4px; [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: new Center(
    child: new Container( // red box
      child: new Text(
        "Lorem ipsum",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
[[highlight]]          letterSpacing: 4.0, [[/highlight]]
        ),
      ),
      decoration: new BoxDecoration(
        color: Colors.red[400],
      ),
      padding: new EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### 变换文本
在 HTML/CSS 中，你可以使用 text-transform 属性执行简单的变换。

在 Flutter 中，你可以使用 [String class](https://docs.flutter.io/flutter/dart-core/String-class.html) 的方法和操作符来变换 Text 控件的内容。
<div class="lefthighlight">
{% prettify css%}
<div class="greybox">
  <div class="redbox">
[[highlight]]    Lorem ipsum [[/highlight]]
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  text-transform: uppercase; [[/highlight]]
}
{% endprettify %}
</div>

<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: new Center(
    child: new Container( // red box
      child: new Text(
[[highlight]]        "Lorem ipsum".toUpperCase(), [[/highlight]]
        style: bold24Roboto,
      ),
      decoration: new BoxDecoration(
        color: Colors.red[400],
      ),
      padding: new EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### 修改行内文本格式
一个 [Text](https://docs.flutter.io/flutter/widgets/Text-class.html) 控件能够显示相同格式的文本，如果希望能够以不同的样式来显示文本，那么可以使用 [RichText](https://docs.flutter.io/flutter/widgets/RichText-class.html) 控件。该控件的 ```text``` 属性能够定义一个或者多个能够自定义样式的 [TextSpan](https://docs.flutter.io/flutter/painting/TextSpan-class.html) 控件。

在下面的示例中，"Lorem" 是一个继承默认文本样式的 TestSpan 控件，而 "ipsum" 则是一个自定义样式的TextSpan控件。

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
[[highlight]]    Lorem <em>ipsum</em> [[/highlight]]
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
[[highlight]]  font: 900 24px Roboto; [[/highlight]]
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
}
[[highlight]] .redbox em {
  font: 300 48px Roboto;
  font-style: italic;
} [[/highlight]]
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: new Center(
    child: new Container( // red box
      child: [[highlight]] new RichText(
        text: new TextSpan(
          style: bold24Roboto,
          children: <TextSpan>[
            new TextSpan(text: "Lorem "),
            new TextSpan(
              text: "ipsum",
              style: new TextStyle(
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                fontSize: 48.0,
              ),
            ),
          ],
        ),
      ), [[/highlight]]
      decoration: new BoxDecoration(
        backgroundColor: Colors.red[400],
      ),
      padding: new EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>

### 创建文本摘录
一段摘录一般显示段落中文本的初始行，并且通常使用省略号来处理溢出文本。在 HTML/CSS 中，摘录不可以超过一行，如果需要截断成多行则需要利用 JavaScript 代码操作。

在 Flutter 中，可以使用 [Text](https://docs.flutter.io/flutter/widgets/Text-class.html) 控件的 ```maxLines``` 属性去定义摘录的行数，然后使用 ```overflow``` 属性去处理文本溢出。

<div class="lefthighlight">
{% prettify css %}
<div class="greybox">
  <div class="redbox">
    Lorem ipsum dolor sit amet, consec etur
  </div>
</div>

.greybox {
  background-color: #e0e0e0; /* grey 300 */
  width: 320px;
  height: 240px;
  font: 900 24px Roboto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.redbox {
  background-color: #ef5350; /* red 400 */
  padding: 16px;
  color: #ffffff;
[[highlight]]  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap; [[/highlight]]
}
{% endprettify %}
</div>
<div class="righthighlight">
{% prettify dart %}
var container = new Container( // grey box
  child: new Center(
    child: new Container( // red box
      child: new Text(
        "Lorem ipsum dolor sit amet, consec etur",
        style: bold24Roboto,
[[highlight]]        overflow: TextOverflow.ellipsis,
        maxLines: 1, [[/highlight]]
      ),
      decoration: new BoxDecoration(
        backgroundColor: Colors.red[400],
      ),
      padding: new EdgeInsets.all(16.0),
    ),
  ),
  width: 320.0,
  height: 240.0,
  color: Colors.grey[300],
);
{% endprettify %}
</div>
<div class="end-examples"></div>
