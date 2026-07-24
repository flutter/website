---
title: "Animation Management with Flutter and Flux/Redux"
description: >-
  The Flux and Redux application architectures work well with
  reactive view frameworks like Flutter
publishDate: 2018-01-19
author: amir_h
image: images/10gdFpYTSo_TTCqd-XVcvYw.webp
category: tutorial
layout: blog
---

The [Flux](https://facebook.github.io/flux/) and [Redux](https://redux.js.org/) application architectures work well with reactive view frameworks like Flutter. Both architectures share two powerful notions: creating a unidirectional data flow in an application, and a clean separation between business and presentation logic.

It’s not always clear where to fit animation state management within these architectures. This is a proposal for a simple way to incorporate animation logic within Redux or Flux applications.

This is an expanded version of a lightning talk I gave at DartConf 2018: [Animation Management with Flutter and Redux (YouTube)](https://www.youtube.com/watch?v=9ZkLtr0Fbgk&index=22&list=PLOU2XLYxmsIIJr3vjxggY7yGcGO7i9BK5).

<DashImage figure src="images/10gdFpYTSo_TTCqd-XVcvYw.webp" alt="An animation conflict resolved with a “jump cut” effect." caption="An animation conflict resolved with a “jump cut” effect." />

## The 2048 game

For purposes of this discussion, I’m going to explain the approach by walking through an example implementation of the 2048 game using [Flutter](https://flutter.io/) and a Redux architecture.

(In case you’re not familiar with the game, [try this web based version](https://gabrielecirulli.github.io/2048/).)

## Building 2048 with Flutter and Redux (no animations)

The example uses a typical Redux data flow:

<DashImage figure src="images/1K_NpCWpLtmotANb-PihiaA.webp" />

The data flows as follows:

1. The view responds to user events by dispatching actions to the Redux store.

1. The store computes new application states in response to actions, and publishes the states.

1. The published states are consumed by the view logic, which updates the screen.

The game state is defined with a 4x4 integer matrix (a list of lists in [Dart](https://www.dartlang.org/)). Zeros represent empty cells, and integer values represent each tile:

```plaintext
[0, 0, 0, 2],
[0, 0, 0, 4],
[0, 0, 0, 0],
[0, 0, 0, 0],
```

Represents:

<DashImage figure src="images/1znPAjWvnhngSihYnlzQmgA.webp" />

The game state supports four operations: moveLeft, moveRight, moveUp, and moveDown.

Here’s an example unit test for the moveRight operation:

```dart
 test('move right', () {
   BoardState state = new BoardState([
     [0, 2, 0, 0],
     [0, 2, 0, 2],
     [8, 0, 4, 4],
     [2, 2, 0, 2],
   ]);

   expect(state.moveRight().tiles, [
     [0, 0, 0, 2],
     [0, 0, 0, 4],
     [0, 0, 8, 8],
     [0, 0, 2, 4],
   ]);
 });
```

The user moves the tiles with a drag gesture. The UI code sets up a gesture detector and responds to drag events by dispatching actions to the store. The gesture detector is defined as follows:

```dart
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragEnd: (DragEndDetails d) {
        if (d.primaryVelocity > 0) {
          GameRedux.dispatch(context, moveRight());
        } else {
          GameRedux.dispatch(context, moveLeft());
        }
      },
      //...
```

Finally, the UI must update the screen each time the game state changes. Without introducing animations, this is straightforward — the UI subscribes to store updates, and rebuilds the Flutter Widget tree every time the store publishes a new state.

So far we have maintained a clear separation of UI logic (mapping an application state to a Widget tree, and event handlers that dispatch actions), and business logic (the store).

## Adding transition animations

The 2048 game is not the same without animations, and we want to add them:

<DashImage figure src="images/1yvV7vhMImTkHfS-g-638IA.gif" />

It is not always clear where to keep animation logic within a Redux architecture. So far, our sample game has a clear separation of business logic and UI logic, but where to put the animation code?

One possible approach tracks the intermediate position of each tile as part of the application state in the store. This essentially makes it part of the business logic.

Another approach, and the one I prefer in this case, places this animation (as well as all “cosmetic” animations) in the presentation layer. This simplifies the state graph and our business logic.

### “Cosmetic” and “real” transition states

We make a distinction between 2 kinds of transition states:

* **Real** **transition state**
The application waits for an external event (other than an animation tick). For example, a file loads, or the camera lens moves into position. While transitioning (the file is loading, camera lens is moving), the application must wait, so the user must also wait.

* **Cosmetic transition state**
The application synthetically makes something appear to take longer than it really does. For example, animating the sliding tiles is a cosmetic transition — nothing prevents the application from immediately processing the next event as if the transition was already completed. Cosmetic transitions are typically used to make the user experience smoother.

A few more notes about cosmetic transitions:

* They are typically short, as we want our application to feel responsive, and we don’t want to introduce unnecessary (or annoying) long delays.

* They are commonly used in mobile apps and, in our experience, can result in bugs due to transition conflicts (more on this below).

* Their purpose is to create a more delightful UX, so we prefer to keep them out of the business logic layer.

### “Fire-and-forget” animations

In order to run an animation, its state (progress) must be tracked somewhere. We often use fire-and-forget abstractions with animations, basically delegating the animation state management to other code. A downside of “fire-and-forget” is that we limit the visibility and control that we have over the animation progress (and thus limit the flexibility of what can be done while the animation is running). The upside is that it keeps the calling code simpler (no need to manage the animation state), and delegating animation state management makes it possible for frameworks to optimize performance. For example, on Android some fire-and-forget animations are executed on the RenderThread.

### Figuring out whether/which transition to show

Our example keeps the animation logic in the UI layer, which rebuilds the widget tree in response to state updates.

The first problem we encounter is that the store update which only includes the last state is not enough information for figuring out which transition to show.

For example when the UI receives a store update with the following state:

```plaintext
[0, 0, 0, 2],
[0, 0, 0, 4],
[0, 0, 0, 0],
[0, 0, 0, 0]
```

Given only this information, it’s possible to show any of the following transitions:

<DashImage figure src="images/18rAC3V333Gf0okK8dZ7T0g.webp" />

<DashImage figure src="images/1FQAuiQXKSnCRxGLnAIK40g.webp" />

<DashImage figure src="images/1nx_Zc1SySvxMP5k8mR_a-g.webp" />

To deal with this ambiguity, we provide more information with our store updates: In addition to the new state, our store update includes the previous state, and the action that triggered the update. This triplet is enough to figure which transition we should trigger (*):

<DashImage figure src="images/1ph2_G0FsgvpK8nUxwQpxgA.webp" />

<DashImage figure src="images/17qStCx_t14Hw6EQcazYcKg.webp" />

* With the assumption that we are starting from a non transitioning state; see more on this below.

### Transition conflicts

One thing we need to take into account is that the user might trigger events while an animation is in progress. For example, while the tiles are sliding to the right, the user might swipe up, interrupting the first animation.

Transition conflicts are a common cause of application bugs. Sometimes, animations conflict (even when they are presumably unrelated to each other), leaving the UI in an inconsistent state. These bugs can be a pain to diagnose: a user reports that the UI is in an inconsistent state, and he’s not sure how to reproduce it (which usually ends up being something like “tap button A and quickly tap button B”).

Sometimes these bugs are not easy to fix and developers resort to a quick-and-dirty solution, such as “disable button A while the animation is running”, which can introduce more subtle bugs. One example of such a bug that was made public is the [iPhone’s calculator “1+2+3” bug](https://qz.com/1114019/if-you-type-123-into-your-apple-iphones-calculator-on-ios-11-you-probably-wont-get-6-aapl/). (Have you ever dealt with an animation conflict bug that you can publicly share? I’d love to hear about it in the comments section!)

#### Dealing with transition conflicts

The animations in the 2048 game are “cosmetic” transitions — they are short, and shouldn’t delay the user from performing the next action. Also, the business logic layer does not know about these transitions. At any given point, the UI can trigger an action (moveLeft/moveRight/…) and the store publishes a new state to the UI.

This is how the UI code responds to state updates:

1. Terminate any ongoing transitions.

1. Compute the next transition based on the (previousState, action, state) triplet published with the store update.

1. “Fire-and-forget” the transition animation. (*)

Let’s see what happens when a transition conflict occurs. In the following screen recording I swipe to the left and, while the tiles are sliding to the left, I swipe down (the white circles are tap indicators):

<DashImage figure src="images/10GLFE1-zEg0xX0OnOXhcuw.webp" />

This results in a [jump cut](https://en.wikipedia.org/wiki/Jump_cut) effect: the moveLeft animation immediately completes, and the moveDown animation starts.

While not always the ideal way to resolve animation conflicts, I argue that in this case and many other cases of cosmetic transition conflicts, the jump cut is an acceptable solution. Cosmetic transition animations are typically short (the animation has been artificially slowed in the previous recording), which make the jump cut feel natural and responsive.

We get this default conflict resolution “for free” as long as we make sure that our UI keeps this contract: *Given that the last store update was (stateA, action, stateB) the UI is either showing stateB or showing a transition to stateB.* If you’re using Flutter, this is probably what your UI is already doing.

Note that our UI code is performing minimal and simple state management — it just maintains the ability to terminate an ongoing transition.

* Not exactly “fire-and-forget”, as we need to provide a way to terminate the animation.

#### A more graceful animation conflict resolution

For components where the jump cut effect isn’t sufficient, you can manage more of the animation state in the UI layer, and provide custom handling for transition conflicts. This approach doesn’t help with custom animation conflict resolution, but neither does it make it harder. The upside of this approach is that you use custom handling where you want it, and other conflicts default to the jump cut effect.

## Summary

In this article, we implemented the 2048 game with a simple Redux architecture, keeping a clean separation between business and presentation logic. We kept state management for cosmetic transitions out of the business logic. Finally, we managed to keep minimal state management in the UI layer, and we resolved animation conflict in a simple and reasonable way.

You can find the (not polished!) [2048 example code](https://github.com/amirh/indux/tree/master/examples/2048) on GitHub.
