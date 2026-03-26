// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Completion _$CompletionFromJson(Map<String, dynamic> json) => _Completion(
  id: json['id'] as String,
  habitId: json['habitId'] as String,
  completedAt: DateTime.parse(json['completedAt'] as String),
  xpEarned: (json['xpEarned'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CompletionToJson(_Completion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'habitId': instance.habitId,
      'completedAt': instance.completedAt.toIso8601String(),
      'xpEarned': instance.xpEarned,
    };
