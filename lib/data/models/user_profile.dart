import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
sealed class UserProfile with _$UserProfile {
  const factory UserProfile({
    @Default(0) int totalXp,
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    @Default(0) int totalCompletions,
    DateTime? lastCompletionDate,
    @Default([]) List<String> unlockedBadgeIds,
    @Default(0) int freezesUsedThisWeek,
    DateTime? lastFreezeReset,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
