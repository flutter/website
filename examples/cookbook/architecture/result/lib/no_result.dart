// ignore_for_file: unused_catch_clause, unused_field

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String email;

  UserProfile(this.name, this.email);

  static UserProfile fromJson(_) {
    return UserProfile('John Doe', 'email@example.com');
  }
}

// #docregion ApiClientService
class ApiClientService {
  // #enddocregion ApiClientService
  final HttpClient client = HttpClient();
  final String _host = 'api.example.com';
  final int _port = 443;
  // #docregion ApiClientService

  Future<UserProfile> getUserProfile() async {
    try {
      final request = await client.get(_host, _port, '/user');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return UserProfile.fromJson(jsonDecode(stringData));
      } else {
        throw const HttpException('Invalid response');
      }
    } finally {
      client.close();
    }
  }
}
// #enddocregion ApiClientService

// #docregion UserProfileRepository
class UserProfileRepository {
  // #enddocregion UserProfileRepository
  final ApiClientService _apiClientService = ApiClientService();
  // #docregion UserProfileRepository

  Future<UserProfile> getUserProfile() async {
    return await _apiClientService.getUserProfile();
  }
}
// #enddocregion UserProfileRepository

// #docregion UserProfileViewModel
class UserProfileViewModel extends ChangeNotifier {
  // #enddocregion UserProfileViewModel
  final UserProfileRepository userProfileRepository = UserProfileRepository();
  UserProfile? _userProfile;
  // #docregion UserProfileViewModel

  Future<void> load() async {
    try {
      _userProfile = await userProfileRepository.getUserProfile();
      notifyListeners();
    } on Exception catch (exception) {
      // handle exception
    }
  }
}
// #enddocregion UserProfileViewModel

// #docregion UserProfileViewModelNoTryCatch
class UserProfileViewModelNoTryCatch extends ChangeNotifier {
  // #enddocregion UserProfileViewModelNoTryCatch
  final UserProfileRepository userProfileRepository = UserProfileRepository();
  UserProfile? _userProfile;
  // #docregion UserProfileViewModelNoTryCatch

  Future<void> load() async {
    _userProfile = await userProfileRepository.getUserProfile();
    notifyListeners();
  }
}
// #enddocregion UserProfileViewModelNoTryCatch
