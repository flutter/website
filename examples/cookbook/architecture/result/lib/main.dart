import 'package:flutter/material.dart';

import 'result.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

class UserProfile {
  final String name;
  final String email;

  UserProfile(this.name, this.email);
}

class UserProfileRepository {
  final ApiClientService _apiClientService;
  final DatabaseService _databaseService;

  UserProfileRepository(
    this._apiClientService,
    this._databaseService,
  );

  Future<Result<UserProfile>> getUserProfile() async {
    final apiResult = await _apiClientService.getUserProfile();
    if (apiResult is Ok) {
      return apiResult;
    }

    final databaseResult = await _databaseService.createTemporalUser();
    if (databaseResult is Ok) {
      return databaseResult;
    }

    return Result.error(Exception('Failed to get user profile'));
  }
}

class ApiClientService {
  Future<Result<UserProfile>> getUserProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    return Result.ok(UserProfile('John Doe', 'john@example.com'));
  }
}

class DatabaseService {
  Future<Result<UserProfile>> createTemporalUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return Result.ok(UserProfile('John Doe', 'john@example.com'));
  }
}
