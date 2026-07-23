---
title: "Managing Flutter Application State With InheritedWidgets"
description: >-
  Everyone has heard that interactive applications can be
  decomposed into three parts: model, view, and controller.
  Anyone who has given…
publishDate: 2018-12-20
author: hansmuller
image: images/1IVBU5tVCV5TFUI3E5V4fEg.webp
category: tutorial
layout: blog
---

Everyone has heard that interactive applications can be decomposed into three parts: model, view, and controller. Anyone who has given Flutter a test drive will be familiar with its react-style support for building view/controllers with widgets and callbacks. Everyone does not seem to be so clear on how Flutter supports the “model” part of MVC.

A Flutter application’s model represents its persistent state. Widgets provide visualizations of that state and they enable the user to modify it. A widget depends on the model when its build method retrieves values from the model or when its callbacks modify model values. If a widget depends on the model, it should be rebuilt if the model changes. Exactly how one gets that to happen is this article’s subject.

This article reviews how Flutter’s StatefulWidget and InheritedWidget classes can be used to bind an application’s visual elements to its model. It concludes with a small but hopefully useful ModelBinding class that should be easy to drop into an application. If you’re eager to get started you can [download the ModelBinding class along with a tiny demo](https://gist.github.com/HansMuller/a3a6d520c6a24238bf1b1b9e3d473bf5) now.

<DashImage figure src="images/1DsbHptClIQire31aIDtF6A.webp" alt="[View the complete ModelBinding<T> example](https://gist.github.com/HansMuller/a3a6d520c6a24238bf1b1b9e3d473bf5)." caption="[View the complete `ModelBinding<T>` example](https://gist.github.com/HansMuller/a3a6d520c6a24238bf1b1b9e3d473bf5)." />

## Disclaimers, Reader Expectations

The approach for building MVC apps outlined in this article is not the one and only way to do so. There are many ways to bind Flutter to models and if you’re planning something big, you might want to survey your options, some of which I’ve listed at the end of this article. On the other hand, even if you don’t decide to adopt the little ModelBinding class presented in the final section, you may learn something new about Flutter by reading this article.

This isn’t an introductory Flutter article, I expect that readers will already have some experience with the Flutter API. For example, it’s assumed that:

* You are comfortable with writing classes in Dart and understand operator == and hashcode overloading as well as generic methods.

* You are familiar with the basic Flutter widget classes and understand how to write new ones.

## The Application’s Model

For the sake of the examples that follow we need a sample application model. For the sake of our short attention spans, I’ve kept this model as simple as possible. There’s just one value field here and the [actual class](https://gist.github.com/HansMuller/793b7a2b7fd35a2def4337315918a26d) includes operator == and hashCode overrides.

```dart
class Model {
  const Model({ this.value = 0 });
  final int value;
  // .. operator ==, hashCode
}

```

Hopefully it’s obvious how one could extend the values that the model represents.

This is an immutable model, so changing it means replacing it. The MVC approaches shown below can be used with a mutable model, it’s just a little bit more complicated that way.

## Binding to the Model with StatefulWidget

This is the simplest approach to integrating a model, perfect for an afternoon app.

A StatefulWidget is associated with a persistent State object. The State object’s build method creates the subtree contributed by the widget, just like the StatelessWidget’s build method does. The State object’s setState method causes the widget to be built again, the next time the display’s frame rate interval has elapsed. If the stateful widget’s state object owns the model, its build method configures the widgets it creates using model values and it calls setState when the model changes.

Defining the example’s ViewController stateful widget requires a little boilerplate:

```dart
class ViewController extends StatefulWidget {
  _ViewControllerState createState() => _ViewControllerState();
}

class _ViewControllerState extends State<ViewController> {
  // the widget's persistent state goes here
  @override
  Widget build(BuildContext context) {
    // return a widget based on the persistent state
  }
}

```

In this case the widget’s persistent state is a Model instance. The build method creates a button that shows the model’s current value and replaces the model when pressed. The updateModel method resets the currentModel and calls setState to trigger a rebuild. In other words, pressing the button updates the model and then rebuilds the ViewController widget.

```dart
Model currentModel = Model();

void updateModel(Model newModel) {
  if (newModel != currentModel) {
    setState(() {
      currentModel = newModel;
    });
  }
}

@override
Widget build(BuildContext context) {
  return RaisedButton(
    onPressed: () {
      updateModel(Model(value: currentModel.value + 1));
    },
    child: Text('Hello World ${currentModel.value}'),
  );
}

```

## StatefulWidget Binding Limitations

The approach outlined above is a strawman. It’s not ideal for a relatively large scale application:

* When the model changes, the ViewController and the entire tree of widgets it creates are rebuilt. Not just the widgets that depend on the model, all of them.

* If a child widget needs to lookup the model’s value, then the model must be passed to it with a constructor parameter or through a closure, as in the trivial example above.

* If a descendant widget needs to lookup the model’s value, then the model must be passed to it through a chain of constructor parameters.

* If a child widget wants to modify the model’s value, then it must be passed a callback provided by the ViewController. In the example, that would be the RaisedButton’s onPressed parameter.

Hopefully it’s clear that StatefulWidgets, while well suited for creating widgets with some internal persistent state, aren’t ideal for sharing a model in a complex application. And, as software engineers, complex is our bread and butter.

## Binding to the Model with InheritedWidget, Version 0

The InheritedWidget class has some special properties that make it well suited to sharing a model with a tree of widgets:

* Given a BuildContext, finding the nearest InheritedWidget ancestor of a particular type is cheap, just a table lookup.

* InheritedWidgets keep track of their dependents, i.e. the BuildContexts from which the InheritedWidget was accessed. When an InheritedWidget is rebuilt, all of its dependents are rebuilt as well.

You’ve probably run into the Theme inherited widget already. The static Theme.of(context) method returns the Theme’s ThemeData and records context as a Theme dependent. If the Theme is rebuilt with a new and different ThemeData value, then all of the widgets that referred to it with Theme.of() are rebuilt automatically.

It’s easy enough to use a custom InheritedWidget subclass in the same way, as a host for the application’s model. This InheritedWidget subclass is called ModelBinding because it connects the application’s widgets to the model.

```dart
class ModelBinding extends InheritedWidget {
  ModelBinding({
    Key key,
    this.model = const Model(),
    Widget child,
  }) : assert(model != null), super(key: key, child: child);

  final Model model;

  @override
  bool updateShouldNotify(ModelBinding oldWidget) => model != oldWidget.model;
}

```

The updateShouldNotify method is called when the ModelBinding is rebuilt. If it returns true, then all of the dependent widgets are rebuilt.

The BuildContext inheritFromWidgetOfExactType() method is used to lookup an inherited widget. Because it’s a little ugly, and for other reasons that will become apparent later, it’s usually wrapped in a static method. Adding the lookup method to the Model class makes it possible to retrieve the model from any descendant of ModelBinding with: Model.of(context):

Now ViewController can be stateless and its reference to the model becomes:

```dart
// Model.of(context) works from any ModelBinding descendant
Text('Hello World ${Model.of(context).value}')
```

Any descendant of ModelBinding can do the same thing, there’s no need to pass the Model downwards. If the model changes then dependent widgets like ViewController are rebuilt automatically.

The ModelBinding itself must be built by a stateful widget. To change the model, that stateful widget must be rebuilt by calling its setState method. Now the top level App widget becomes stateful and a callback that updates the model must be passed along to the ViewController.

```dart
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Model currentModel = Model();

  void updateModel(Model newModel) {
    if (newModel != currentModel) {
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ModelBinding(
        model: currentModel,
        child: Scaffold(
          body: Center(
            child: ViewController(updateModel: updateModel),
          ),
        ),
      ),
    );
  }
}

```

In this case, Model is just a simple immutable value, so replacing it is as simple as assigning a new currentModel. Replacing it could be more complicated, for example if the model contained objects that required lifetime management, replacing the model might require disposing parts of the old model.

## InheritedWidget Version 0 Limitations

On the upside, the InheritedWidget version of our model binding makes it easy for widgets to refer to the model and it automates rebuilding those “dependent” widgets when the model changes.

On the downside, it’s still necessary to plumb an updateModel callback down through the widget tree, to widgets that need to change the model.

## Binding to the Model with InheritedWidget, Version 1

This version of the InheritedWidget approach for binding widgets to a model simplifies model updates. Now any descendant of ModelBinding can get the model as well as update it, and there’s no need to pass around a model specific callback.

So, as before, any descendant of ModelBinding can get a model value with Model.of(context), and by doing so become an automatically rebuilt model dependent. Now any descendant of ModelBinding can update the model with Model.update(context, newModel). Which is nice.

To enable rebuilding the model with the static Model.update() method, it’s necessary to introduce an extra stateful widget. This gets a little complicated, so if you’re wearing a hat, hold on to it.

ModelBinding is now a stateful widget that tracks the current Model value. ModelBinding builds a private _ModelBindingScope InheritedWidget child that has a reference to the `State<ModelBinding>` — a _ModelBindingState; essentially to its stateful widget parent. To change ModelBinding’s current model value, rebuild the ModelBinding with setState(), which in turn rebuilds the inherited _ModelBindingScope widget. The static Model methods for getting the model or updating it, lookup _ModelBindingScope:

```dart
static Model of(BuildContext context) {
  _ModelBindingScope scope = context.inheritFromWidgetOfExactType(_ModelBindingScope);
  return scope.modelBindingState.currentModel;
}

static void update(BuildContext context, Model newModel) {
  _ModelBindingScope scope = context.inheritFromWidgetOfExactType(_ModelBindingScope);
  scope.modelBindingState.updateModel(newModel);
}

```

Any descendant of ModelBinding can now update or change the model using these methods. The example’s button does both:

```dart
RaisedButton(
  onPressed: () {
    Model model = Model.of(context);
    Model.update(context, Model(value: model.value + 1));
  },
  child: Text('Hello World ${Model.of(context).value}'),
);

```

## InheritedWidget Version 1 Limitations

This version is generally useful and it weighs in at well under 100 lines of code. It can be used as is, or as a starting point for a more complex model binding system.

There is one limitation that really needs to be eliminated: the Model data type has a private connection to the ModelBinding implementation. Apps should be able to define their model types any way they like, they shouldn’t need to extend the Model class defined here. To address that, we’ll add a type parameter.

## Binding to the Model with InheritedWidget, Finale

This version factors out the Model type. Now the type of the app’s model is ModelBinding’s type parameter, and ModelBinding provides the generic static functions `of<T>(context)` and `update<T>(context)`.

The implementation is a bit more complicated (again) for the type parameter, which is why it was left for the finale. On the up side, the implementation is still very small, about 64 lines of code, and using the ModelBinding widget class and its two static methods should be very straightforward.

The application creates a MyModel type ModelBinding like this:

```dart
ModelBinding<MyModel>(
  initialState: MyModel(),
  child: child,
)

```

The application’s model, MyModel, is retrieved and updated with generic versions of the of and update methods like this:

```dart
RaisedButton(
  onPressed: () {
    MyModel model = ModelBinding.of<MyModel>(context);
    ModelBinding.update<MyModel>(context, MyModel(value: model.value + 1));
  },
  child: Text('Hello World ${ModelBinding.of<MyModel>(context).value}'),
)

```

The upshot is that ModelBinding et al. can be safely factored into a tiny library, rather than being wired into the application. Only the `ModelBinding<T>` class needs to be exported.

## Summary

This article was intended to explain the basics of Flutter’s StatefulWidget and InheritedWidget classes and to show how the latter could be used to bind an application’s model to its widgets. There’s much more to share about both classes and about related classes like InheritedModel and InheritedNotifier. All of that will have to wait.

`ModelBinding<T>` is a simple class based on InheritedWidget that can be used to bind an arbitrary model type of type T to an application’s widgets. Use it by [downloading the example](https://gist.github.com/HansMuller/a3a6d520c6a24238bf1b1b9e3d473bf5), and dropping its page of code into your app. And if doesn’t work for you: change it.

<DashImage figure src="images/1IVBU5tVCV5TFUI3E5V4fEg.webp" alt="The code behind the complete ModelBinding example. Open to read." caption="[View the complete `ModelBinding<T>` example.](https://gist.github.com/HansMuller/a3a6d520c6a24238bf1b1b9e3d473bf5)" />

## Related Articles

This is just a quick sampling of recent articles about this popular topic. The Flutter project maintains a more comprehensive list on the flutter.io [State Management page](https://flutter.io/docs/development/data-and-backend/state-mgmt).

* **Redux,** [Flutter ReduxThunk, an example finally](https://medium.com/flutterpub/flutter-redux-thunk-27c2f2b80a3b)
  An architecture that factors the application into a model called the “Store” which is updated by a “Reducer” that processes “Actions” generated by the user interface.

* **Bloc,** [Architect your Flutter project using BLoC pattern](https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1)
An architecture where the model is a “Business Logic Component” (BLoC) which exposes its state with streams and enables changes via sinks. Works nicely with Flutter’s StreamBuilder widget.

* **ScopedModel,** [The ScopedModel package](https://pub.dartlang.org/packages/scoped_model)
ScopedModel has-a model and dependents are wrapped with a ScopedModelDescendant widget which rebuilds when the model changes. Rebuilding is handled by a callback with a model parameter.
