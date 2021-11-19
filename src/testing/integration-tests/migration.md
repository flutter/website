---
title: Migrating from flutter_driver
description: Learn how to migrate existing flutter_driver tests to integration_test
---

This page describes how to migrate an existing project using `flutter_driver`
to the `integration_test` package to run integration tests. 

For an introduction to the `integration_test` package, take a look at the
[Integration Tests][] guide.

## Starter example project

The following code contains a small example desktop application with this
functionality:

* On the left, there's a list of plants that the user can scroll, tap and select.
* On the right, there's a details screen that displays the plant name and species.
* On app start, when no plant is selected, a text asking the user to select a
plant is displayed
* When a plant is selected from the list, the item changes to a darker color.
* The list of plants is loaded from a local JSON file located in the assets folder.

<!-- provide screenshot here -->


<!-- should the app code be here? -->

You can find the full code example in the [Example Project][] folder.


## flutter_driver tests



<!-- project should include: scrolling, tapping, finding widgets, asserting text is visible, etc. -->


## Migrating to integration_test



<!-- Links references go at the end -->

[Integration Tests]: /testing/integration-tests
[Example Project]: {{site.repo.this}}/tree/master/examples/integration_test_migration