import '../../domain/model/user_profile.dart';

// #docregion ApiClientService
class ApiClientService {
  /// performs GET network request to obtain a UserProfile
  Future<UserProfile> getUserProfile() async {
    // #enddocregion ApiClientService
    // Simulate a network GET request
    await Future.delayed(const Duration(seconds: 2));
    // Return a dummy user profile
    return const UserProfile(
      name: 'John Doe (from API)',
      photoUrl: 'https://example.com/john_doe.jpg',
    );
    // #docregion ApiClientService
  }

  /// performs PUT network request to update a UserProfile
  Future<void> putUserProfile(UserProfile userProfile) async {
    // #enddocregion ApiClientService
    // Simulate a network PUT request
    await Future.delayed(const Duration(seconds: 2));
    // #docregion ApiClientService
  }
}

// #enddocregion ApiClientService
