// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  totalXp: (json['totalXp'] as num?)?.toInt() ?? 0,
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
  totalCompletions: (json['totalCompletions'] as num?)?.toInt() ?? 0,
  lastCompletionDate: json['lastCompletionDate'] == null
      ? null
      : DateTime.parse(json['lastCompletionDate'] as String),
  unlockedBadgeIds:
      (json['unlockedBadgeIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  freezesUsedThisWeek: (json['freezesUsedThisWeek'] as num?)?.toInt() ?? 0,
  lastFreezeReset: json['lastFreezeReset'] == null
      ? null
      : DateTime.parse(json['lastFreezeReset'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'totalXp': instance.totalXp,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'totalCompletions': instance.totalCompletions,
      'lastCompletionDate': instance.lastCompletionDate?.toIso8601String(),
      'unlockedBadgeIds': instance.unlockedBadgeIds,
      'freezesUsedThisWeek': instance.freezesUsedThisWeek,
      'lastFreezeReset': instance.lastFreezeReset?.toIso8601String(),
    };
