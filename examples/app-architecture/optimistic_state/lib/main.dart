// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // #docregion SubscribeButton
          child: SubscribeButton(
            viewModel: SubscribeButtonViewModel(
              subscriptionRepository: SubscriptionRepository(),
            ),
          ),
          // #enddocregion SubscribeButton
        ),
      ),
    );
  }
}

/// A button that simulates a subscription action.
/// For example, subscribing to a newsletter or a streaming channel.
// #docregion Widget
class SubscribeButton extends StatefulWidget {
  const SubscribeButton({super.key, required this.viewModel});

  /// Subscribe button view model.
  final SubscribeButtonViewModel viewModel;

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}
// #enddocregion Widget

class _SubscribeButtonState extends State<SubscribeButton> {
  // #docregion listener1
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChange);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChange);
    super.dispose();
  }
  // #enddocregion listener1

  // #docregion build
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return FilledButton(
          onPressed: widget.viewModel.subscribe,
          style: widget.viewModel.subscribed
              ? SubscribeButtonStyle.subscribed
              : SubscribeButtonStyle.unsubscribed,
          child: widget.viewModel.subscribed
              ? const Text('Subscribed')
              : const Text('Subscribe'),
        );
      },
    );
  }
  // #enddocregion build

  // #docregion listener2
  /// Listen to ViewModel changes.
  void _onViewModelChange() {
    // If the subscription action has failed
    if (widget.viewModel.error) {
      // Reset the error state
      widget.viewModel.error = false;
      // Show an error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to subscribe')));
    }
  }

  // #enddocregion listener2
}

// #docregion style
class SubscribeButtonStyle {
  static const unsubscribed = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.red),
  );

  static const subscribed = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.green),
  );
}
// #enddocregion style

// #docregion ViewModelFull
/// Subscribe button View Model.
/// Handles the subscribe action and exposes the state to the subscription.
// #docregion ViewModelStart
class SubscribeButtonViewModel extends ChangeNotifier {
  SubscribeButtonViewModel({required this.subscriptionRepository});

  final SubscriptionRepository subscriptionRepository;
  // #enddocregion ViewModelStart

  // #docregion States
  // Whether the user is subscribed
  bool subscribed = false;

  // Whether the subscription action has failed
  bool error = false;
  // #enddocregion States

  // #docregion subscribe
  // Subscription action
  Future<void> subscribe() async {
    // Ignore taps when subscribed
    if (subscribed) {
      return;
    }

    // Optimistic state.
    // It will be reverted if the subscription fails.
    subscribed = true;
    // Notify listeners to update the UI
    notifyListeners();

    try {
      await subscriptionRepository.subscribe();
    } catch (e) {
      print('Failed to subscribe: $e');
      // Revert to the previous state
      subscribed = false;
      // Set the error state
      error = true;
    } finally {
      notifyListeners();
    }
  }

  // #enddocregion subscribe
}
// #enddocregion ViewModelFull

/// Repository of subscriptions.
// #docregion SubscriptionRepository
class SubscriptionRepository {
  /// Simulates a network request and then fails.
  Future<void> subscribe() async {
    // Simulate a network request
    await Future.delayed(const Duration(seconds: 1));
    // Fail after one second
    throw Exception('Failed to subscribe');
  }
}

// #enddocregion SubscriptionRepository
