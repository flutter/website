import 'package:flutter/material.dart';

import 'data/repositories/user_profile_repository.dart';
import 'data/services/api_client_service.dart';
import 'data/services/database_service.dart';
import 'ui/user_profile/user_profile_screen.dart';
import 'ui/user_profile/user_profile_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: UserProfileScreen(
        viewModel: UserProfileViewModel(
          userProfileRepository: UserProfileRepository(
            apiClientService: ApiClientService(),
            databaseService: DatabaseService(),
          ),
        ),
      ),
    );
  }
}
