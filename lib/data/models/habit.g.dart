// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Habit _$HabitFromJson(Map<String, dynamic> json) => _Habit(
  id: json['id'] as String,
  name: json['name'] as String,
  iconCodePoint: (json['iconCodePoint'] as num).toInt(),
  colorValue: (json['colorValue'] as num).toInt(),
  order: (json['order'] as num?)?.toInt() ?? 0,
  isActive: json['isActive'] as bool? ?? true,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$HabitToJson(_Habit instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'iconCodePoint': instance.iconCodePoint,
  'colorValue': instance.colorValue,
  'order': instance.order,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
};
