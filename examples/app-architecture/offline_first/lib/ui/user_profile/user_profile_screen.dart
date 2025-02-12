import 'package:flutter/material.dart';

import 'user_profile_viewmodel.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, required this.viewModel});

  final UserProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('User Profile'),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return Center(child: Text(viewModel.userProfile?.name ?? 'Loading'));
        },
      ),
    );
  }
}
