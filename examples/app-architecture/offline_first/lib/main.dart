import 'package:flutter/material.dart';
import 'package:offline_first/data/repositories/user_profile_repository.dart';
import 'package:offline_first/data/services/api_client_service.dart';
import 'package:offline_first/data/services/database_service.dart';
import 'package:offline_first/ui/user_profile/user_profile_viewmodel.dart';

import 'ui/user_profile/user_profile_screen.dart';

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
        useMaterial3: true,
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
