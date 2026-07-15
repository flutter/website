---
title: "Beautiful, animated charts for Flutter"
description: "We are super excited to announce a fully-featured, animated charting library for Flutter!"
publishDate: 2018-03-23
author: mit-mit
image: images/1CB1OU6uH4SsgJUB2j962dg.webp
category: announcements
layout: blog
---

*Flutter enables developers to craft high-quality mobile app user interfaces for iOS and Android. Many of the Flutter apps being created internally at Google present large amounts of data. Doing that efficiently requires not just regular UI widgets, but lots of elegant charts. Back when we set out to create a Flutter charting library we quickly discovered that [it was no easy feat](https://medium.com/flutter-io/zero-to-one-with-flutter-43b13fd7b354). So it is with much joy that we are now able to announce the ‘Charts for Flutter’-library [as open source](https://github.com/google/charts), available for all Flutter apps. Checkout [`charts_flutter`](https://pub.dartlang.org/packages/charts_flutter)!*

## The need for animation

One of the core complexities we discovered early was that great charts don’t just display data statically. For them to be engaging they need to be “alive”. For example, to establish page transitions they need to animate in, and when new data is loaded they need to gradually animate to the new state so it’s clear to the user what the changes are:

<DashImage figure src="images/1GM0z7Rbgpig7gKVB7WCNeg.webp" alt="Using animation to gradually bring in changes to the dataset" caption="Using animation to gradually bring in changes to the dataset" />


Building animated charts is not as simple as it may seem. For a “behind the curtain” tale, check out Mikkel’s great post on the engineering challenge our team tackled when [we built the initial library](https://medium.com/flutter-io/zero-to-one-with-flutter-43b13fd7b354).

## Supported chart types

Charts for Flutter supports three chart types, each with several configuration options:

* **Bar** charts, incl. support for stacking several data series, showing target lines, and rendering the bars horizontally

* **Line** charts, including support for time series

* **Pie** and ‘**donut**’ charts

Here are a few sample charts created with Charts for Flutter:

<DashImage figure src="images/1CB1OU6uH4SsgJUB2j962dg.webp" alt="Bar chart with three grouped series" caption="Bar chart with three grouped series" />


<DashImage figure src="images/1CMgf7ecD3j4TDGYFcYEJpg.webp" alt="Bar chart with grouped and stacked bars" caption="Bar chart with grouped and stacked bars" />


<DashImage figure src="images/1G5QWXo1DV1g_hy_Yj9gQGA.webp" alt="Donut chart" caption="Donut chart" />


<DashImage figure src="images/1Ja5by3uzTNwQNKp3x-2gog.webp" alt="Line chart with custom dash-line patterns" caption="Line chart with custom dash-line patterns" />


<DashImage figure src="images/1vGoaoEKT4ugjEJm2OvzvBQ.webp" alt="Bar chart with custom legend using symbols" caption="Bar chart with custom legend using symbols" />


For more details, see the Charts Gallery app located inside the `/example/` folder of the repo, and in the [online gallery](https://google.github.io/charts/flutter/gallery).

## Getting started with Charts for Flutter

It’s pretty easy to use Charts for Flutter! We’ll start by [creating](https://flutter.io/get-started/test-drive/) a new Flutter app, and then add a bar chart to that to visualize the number of clicks: two bars visualizing the past number of clicks (fixed values), and one bar for the current year (tied to the current state of the `_counter` variable):

<DashImage figure src="images/136hoBmockzA11GwUI9bvHQ.webp" alt="The Flutter counter app extended with a bar chart" caption="The Flutter counter app extended with a bar chart" />


Start by declaring a dependency on the package: Open the `pubspec.yaml` file, and add an entry for `charts_flutter` in the dependencies section.

```yaml
dependencies:
  flutter:
    sdk: flutter
  charts_flutter: ^0.2.0
```


Now run your IDE’s function to get packages, or run `flutter packages get`from the terminal.

Next, define a data type to hold the data for each bar column. Since we want years on the x-axis and counts on the y-axis, we create a class with a `String` and an `int` field:

```dart
class ClicksPerYear {
  final String year;
  final int clicks;

  ClicksPerYear(this.year, this.clicks);
}
```

Then, to support specifying a color for each year, we add a charts `color` field, which we convert from Flutter’s corresponding `Color` type:

```dart
class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
```

Next, we will update the `build()` method of `_MyHomePageState`to create the chart data set, using the `_counter` variable:

```dart
var data = [
  new ClicksPerYear('2016', 12, Colors.red),
  new ClicksPerYear('2017', 42, Colors.yellow),
  new ClicksPerYear('2018', _counter, Colors.green),
];
```

Next, we need to wrap data in a Series. Let’s review a few core charting concepts first:

* **Domain**: The thing being measured; for example, *‘type of vehicle’*

* **Measure:** The numerical value observed; for example, *‘number of wheels’*

* **Data point**: A measure for a domain; for example, *(‘car’, 4).* Sometimes referred to as a *datum*.

* **Series**: A sequenced collection of individual data points; for example *[(‘car’, 4), (‘bicycle’, 2)]*

* **Id**: A unique identifier for a single series; used for charts that render several series; for example ‘*Typical number of wheels’,* and *‘Maximum number of wheels’*

With that we can create our data series, setting the `year` component of our data class to the domain, the `clicks` component to the measure:

```dart
var series = [
  new charts.Series(
    id: 'Clicks',
    domainFn: (ClicksPerYear clickData, _) => clickData.year,
    measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
    colorFn: (ClicksPerYear clickData, _) => clickData.color,
    data: data,
  ),
];
```

And then we are ready to create the chart; to control its padding and size we wrap it in `Padding` and `SizedBox`:

```dart
var chart = new charts.BarChart<ClicksPerYear>(
  series,
  animate: true,
);
var chartWidget = new Padding(
  padding: new EdgeInsets.all(32.0),
  child: new SizedBox(
    height: 200.0,
    child: chart,
  ),
);
```

And then finally we can add the chart below the two text labels:

```dart
child: new Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    new Text(
      'You have pushed the button this many times:',
    ),
    new Text(
      '$_counter',
      style: Theme.of(context).textTheme.display1,
    ),
    chartWidget,
  ],
),
```

Presto, a nice bar chart!

The [complete code](https://gist.github.com/mit-mit/08168a773a56bb58c7abfd9b8e82f467) is also available for review.

We look forward to seeing what you might build with [Charts for Flutter](https://pub.dartlang.org/packages/charts_flutter). Should you have any suggestions, or find any bugs, please [file an issue](https://github.com/google/charts/issues) in our tracker! Should Charts for Flutter not match your requirements, you may also want to take a look at some of the other charting packages in [Pub](https://pub.dartlang.org/flutter/packages?q=chart), such as [flutter_circular_chart](https://pub.dartlang.org/packages/flutter_circular_chart), [flutter_charts](https://pub.dartlang.org/packages/flutter_charts), and [flutter_sparkline](https://pub.dartlang.org/packages/flutter_sparkline).