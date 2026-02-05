import '../../domain/model/user_profile.dart';

// #docregion DatabaseService
class DatabaseService {
  /// Fetches the UserProfile from the database.
  /// Returns null if the user profile is not found.
  Future<UserProfile?> fetchUserProfile() async {
    // #enddocregion DatabaseService
    // Simulate a database select query
    await Future.delayed(const Duration(milliseconds: 100));
    // Return a dummy user profile
    return const UserProfile(
      name: 'John Doe (from Database)',
      photoUrl: 'https://example.com/john_doe.jpg',
    );
    // #docregion DatabaseService
  }

  /// Update UserProfile in the database.
  Future<void> updateUserProfile(UserProfile userProfile) async {
    // #enddocregion DatabaseService
    // Simulate a database update query
    await Future.delayed(const Duration(milliseconds: 100));
    // #docregion DatabaseService
  }
}

// #enddocregion DatabaseService
