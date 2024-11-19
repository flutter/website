import 'package:offline_first/domain/model/user_profile.dart';

class ApiClientService {
  Future<UserProfile> getUserProfile() async {
    // Simulate a network GET request
    await Future.delayed(Duration(seconds: 2));
    // Return a dummy user profile
    return UserProfile(
      name: 'John Doe (from API)',
      photoUrl: 'https://example.com/john_doe.jpg',
    );
  }

  Future<void> putUserProfile(UserProfile userProfile) async {
    // Simulate a network PUT request
    await Future.delayed(Duration(seconds: 2));
  }
}
