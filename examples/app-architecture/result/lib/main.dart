import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'result.dart';

class UserProfile {
  final String name;
  final String email;

  UserProfile(this.name, this.email);

  static UserProfile fromJson(_) {
    return UserProfile('John Doe', 'email@example.com');
  }
}

// #docregion UserProfileViewModel
class UserProfileViewModel extends ChangeNotifier {
  // #enddocregion UserProfileViewModel
  final UserProfileRepository userProfileRepository = UserProfileRepository(
    ApiClientService(),
    DatabaseService(),
  );
  // #docregion UserProfileViewModel

  UserProfile? userProfile;

  Exception? error;

  Future<void> load() async {
    final result = await userProfileRepository.getUserProfile();
    switch (result) {
      case Ok<UserProfile>():
        userProfile = result.value;
      case Error<UserProfile>():
        error = result.error;
    }
    notifyListeners();
  }
}
// #enddocregion UserProfileViewModel

class UserProfileRepository {
  final ApiClientService _apiClientService;
  final DatabaseService _databaseService;

  UserProfileRepository(this._apiClientService, this._databaseService);

  // #docregion getUserProfile1
  Future<Result<UserProfile>> getUserProfile1() async {
    return await _apiClientService.getUserProfile();
  }
  // #enddocregion getUserProfile1

  // #docregion getUserProfile
  Future<Result<UserProfile>> getUserProfile() async {
    final apiResult = await _apiClientService.getUserProfile();
    if (apiResult is Ok) {
      return apiResult;
    }

    final databaseResult = await _databaseService.createTemporaryUser();
    if (databaseResult is Ok) {
      return databaseResult;
    }

    return Result.error(Exception('Failed to get user profile'));
  }

  // #enddocregion getUserProfile
}

// #docregion ApiClientService1
// #docregion ApiClientService2
class ApiClientService {
  // #enddocregion ApiClientService1
  // #enddocregion ApiClientService2
  final HttpClient client = HttpClient();
  final String _host = 'api.example.com';
  final int _port = 443;
  // #docregion ApiClientService1
  // #docregion ApiClientService2

  Future<Result<UserProfile>> getUserProfile() async {
    // #enddocregion ApiClientService1
    try {
      final request = await client.get(_host, _port, '/user');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return Result.ok(UserProfile.fromJson(jsonDecode(stringData)));
      } else {
        return const Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (exception) {
      return Result.error(exception);
    } finally {
      client.close();
    }
    // #docregion ApiClientService1
  }
}
// #enddocregion ApiClientService1
// #enddocregion ApiClientService2

class DatabaseService {
  Future<Result<UserProfile>> createTemporaryUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return Result.ok(UserProfile('John Doe', 'john@example.com'));
  }
}
