---
title: Testing each layer
short-title: Testing
description: >
  How to test an app that follows the recommended architecture.
prev: 
  title: Data layer
  path: /app-architecture/case-study/dependency-injection
---



## Testing {#testing}


### Testing the UI layer {#testing-the-ui-layer}

One way to determine whether your architecture is sound is considering how easy (or difficult) the application is to test. Because ViewModels and views have well defined inputs, their dependencies can easily be mocked, and unit tests are easily written.


#### ViewModel unit tests {#viewmodel-unit-tests}

To test UI logic of the ViewModel, you should write unit tests that don’t rely on Flutter libraries or testing frameworks.

Repositories are a ViewModel’s only dependencies (unless you’re implementing [use-cases](http://prevpage)), and writing `mocks` or `fakes` of the repository is the only setup you need to do. In this example test, a fake called `FakeBookingRepository` is used.

The `[FakeBookingRepository](http://github)` class implements `[BookingRepository](http://github)`. In the data layer section of this guide, the `BookingRepository` class will be explained thoroughly. For now, you can see the complete code on [Github](http://github).

:::note

If you’re using this architecture with [use-cases](http://prevpage), these would similarly need to be mocked.

:::


#### View widget tests {#view-widget-tests}

Once you’ve written tests for your ViewModel, you’ve already created the mocks you need to write widget tests as well. The following example shows how the `HomeScreen` widget tests are set up using the `HomeViewModel` and needed repositories:

This setup creates the two fake repositories needed, and passes them into a `HomeViewModel` object. This class does not need to be mocked.

:::note

The code also defines a MockGoRouter. The router is mocked using the `Mocktail` library. You can read more about the mocktail library on the [pub.dev](https://pub.dev/packages/mocktail) page, and general widget testing in the [Flutter documentation](https://docs.flutter.dev/testing/overview).

:::

After the ViewModel and its dependencies are defined, the Widget tree that will be tested needs to be created. In the tests for the `HomeScreen`, a `loadWidget` method is defined.

This method turns around and calls `testApp`, a generalized method used for all widget tests in the compass app. It looks like this:

This method’s only job is to create a widget tree that can be tested.

The `loadWidget` method passes in the unique parts of a widget tree for testing. In this case, that includes the `HomeScreen` and its ViewModel, as well as some additional faked repositories that are higher in the widget tree.

The take-away here is that view and ViewModel tests only require mocking repositories.


### Testing the Data Layer {#testing-the-data-layer}

Similar to the UI layer, the components of the data layer have well defined inputs and outputs, making both sides mockable. To write unit tests for any given repository, mock the services that it depends on. The following example shows a unit test for the BookingRepository.

Writing mocks and fakes is outside the scope of this guide, but if you’re interested in learning more, you can see examples in the [Compass App testing directory](http://github.com/flutter/samples) or read [Flutter’s testing documentation](https://docs.flutter.dev/testing/overview).
