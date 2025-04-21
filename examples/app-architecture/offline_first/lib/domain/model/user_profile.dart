import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

// #docregion UserProfile
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String name,
    required String photoUrl,
    @Default(false) bool synchronized,
  }) = _UserProfile;
}

// #enddocregion UserProfile
