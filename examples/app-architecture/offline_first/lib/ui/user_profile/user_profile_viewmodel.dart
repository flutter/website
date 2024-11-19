import 'package:flutter/material.dart';
import 'package:offline_first/data/repositories/user_profile_repository.dart';
import 'package:offline_first/domain/model/user_profile.dart';

class UserProfileViewModel extends ChangeNotifier {
  UserProfileViewModel({
    required UserProfileRepository userProfileRepository,
  }) : _userProfileRepository = userProfileRepository {
    load();
  }

  final UserProfileRepository _userProfileRepository;

  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  Future<void> load() async {
    await _userProfileRepository.getUserProfile().listen((userProfile) {
      _userProfile = userProfile;
      notifyListeners();
    }, onError: (error) {
      // handle error
    }).asFuture();
  }

  Future<void> save(String newName) async {
    assert(_userProfile != null);
    final newUserProfile = _userProfile!.copyWith(name: newName);
    try {
      _userProfileRepository.updateUserProfileOnline(newUserProfile);
      _userProfile = newUserProfile;
    } catch (e) {
      // handle error
    } finally {
      notifyListeners();
    }
  }
}
