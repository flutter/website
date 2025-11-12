import 'package:flutter/material.dart';
import '../../data/repositories/user_profile_repository.dart';
import '../../domain/model/user_profile.dart';

// #docregion UserProfileViewModel
class UserProfileViewModel extends ChangeNotifier {
  // #enddocregion UserProfileViewModel
  UserProfileViewModel({required UserProfileRepository userProfileRepository})
    : _userProfileRepository = userProfileRepository {
    load();
  }

  // #docregion UserProfileViewModel
  final UserProfileRepository _userProfileRepository;

  UserProfile? get userProfile => _userProfile;
  // #enddocregion UserProfileViewModel

  UserProfile? _userProfile;

  // #docregion UserProfileViewModel

  /// Load the user profile from the database or the network
  // #docregion load
  Future<void> load() async {
    // #enddocregion UserProfileViewModel
    await _userProfileRepository
        .getUserProfile()
        .listen(
          (userProfile) {
            _userProfile = userProfile;
            notifyListeners();
          },
          onError: (error) {
            // handle error
          },
        )
        .asFuture<void>();
    // #docregion UserProfileViewModel
  }
  // #enddocregion load

  /// Save the user profile with the new name
  Future<void> save(String newName) async {
    // #enddocregion UserProfileViewModel
    assert(_userProfile != null);
    final newUserProfile = _userProfile!.copyWith(name: newName);
    try {
      await _userProfileRepository.updateUserProfileOnline(newUserProfile);
      _userProfile = newUserProfile;
    } catch (e) {
      // handle error
    } finally {
      notifyListeners();
    }
    // #docregion UserProfileViewModel
  }
}

// #enddocregion UserProfileViewModel
