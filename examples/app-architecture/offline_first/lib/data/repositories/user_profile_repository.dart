import 'dart:async';

import '../../domain/model/user_profile.dart';
import '../services/api_client_service.dart';
import '../services/database_service.dart';

class UserProfileRepository {
  UserProfileRepository({
    required ApiClientService apiClientService,
    required DatabaseService databaseService,
  }) : _apiClientService = apiClientService,
       _databaseService = databaseService {
    // #docregion Timer
    Timer.periodic(const Duration(minutes: 5), (timer) => sync());
    // #enddocregion Timer
  }

  final ApiClientService _apiClientService;
  final DatabaseService _databaseService;

  // #docregion getUserProfile
  Stream<UserProfile> getUserProfile() async* {
    // Fetch the user profile from the database
    final userProfile = await _databaseService.fetchUserProfile();
    // Returns the database result if it exists
    if (userProfile != null) {
      yield userProfile;
    }

    // Fetch the user profile from the API
    try {
      final apiUserProfile = await _apiClientService.getUserProfile();
      //Update the database with the API result
      await _databaseService.updateUserProfile(apiUserProfile);
      // Return the API result
      yield apiUserProfile;
    } catch (e) {
      // Handle the error
    }
  }
  // #enddocregion getUserProfile

  // #docregion getUserProfileFallback
  Future<UserProfile> getUserProfileFallback() async {
    try {
      // Fetch the user profile from the API
      final apiUserProfile = await _apiClientService.getUserProfile();
      //Update the database with the API result
      await _databaseService.updateUserProfile(apiUserProfile);

      return apiUserProfile;
    } catch (e) {
      // If the network call failed,
      // fetch the user profile from the database
      final databaseUserProfile = await _databaseService.fetchUserProfile();

      // If the user profile was never fetched from the API
      // it will be null, so throw an  error
      if (databaseUserProfile != null) {
        return databaseUserProfile;
      } else {
        // Handle the error
        throw Exception('User profile not found');
      }
    }
  }
  // #enddocregion getUserProfileFallback

  // #docregion getUserProfileLocal
  Future<UserProfile> getUserProfileLocal() async {
    // Fetch the user profile from the database
    final userProfile = await _databaseService.fetchUserProfile();

    // Return the database result if it exists
    if (userProfile == null) {
      throw Exception('Data not found');
    }

    return userProfile;
  }

  Future<void> syncRead() async {
    try {
      // Fetch the user profile from the API
      final userProfile = await _apiClientService.getUserProfile();

      // Update the database with the API result
      await _databaseService.updateUserProfile(userProfile);
    } catch (e) {
      // Try again later
    }
  }
  // #enddocregion getUserProfileLocal

  // #docregion updateUserProfileOnline
  Future<void> updateUserProfileOnline(UserProfile userProfile) async {
    try {
      // Update the API with the user profile
      await _apiClientService.putUserProfile(userProfile);

      // Only if the API call was successful
      // update the database with the user profile
      await _databaseService.updateUserProfile(userProfile);
    } catch (e) {
      // Handle the error
    }
  }
  // #enddocregion updateUserProfileOnline

  // #docregion updateUserProfileOffline
  Future<void> updateUserProfileOffline(UserProfile userProfile) async {
    // Update the database with the user profile
    await _databaseService.updateUserProfile(userProfile);

    try {
      // Update the API with the user profile
      await _apiClientService.putUserProfile(userProfile);
    } catch (e) {
      // Handle the error
    }
  }
  // #enddocregion updateUserProfileOffline

  // #docregion sync
  Future<void> sync() async {
    try {
      // Fetch the user profile from the database
      final userProfile = await _databaseService.fetchUserProfile();

      // Check if the user profile requires synchronization
      if (userProfile == null || userProfile.synchronized) {
        return;
      }

      // Update the API with the user profile
      await _apiClientService.putUserProfile(userProfile);

      // Set the user profile as synchronized
      await _databaseService.updateUserProfile(
        userProfile.copyWith(synchronized: true),
      );
    } catch (e) {
      // Try again later
    }
  }

  // #enddocregion sync
}
